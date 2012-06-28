//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: Administrator
//
//-------------------------------------------------------------------------
// LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
// THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
// LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
// MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
// THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
// CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
// PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
// NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
// SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
// SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
// PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
// SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
// HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------
package cn.loosoft.stuwork.workstudy.web.salary;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.common.lib.vo.LabelValue;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.account.User;
import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudy.entity.salary.Salary;
import cn.loosoft.stuwork.workstudy.service.account.AccountManager;
import cn.loosoft.stuwork.workstudy.service.company.CompanyManager;
import cn.loosoft.stuwork.workstudy.service.job.JobsManager;
import cn.loosoft.stuwork.workstudy.service.job.StuManager;
import cn.loosoft.stuwork.workstudy.service.salary.SalaryManager;
import cn.loosoft.stuwork.workstudy.vo.StuJobsVO;

/**
 * 
 * 创建工资Action.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-3-4
 */
@Namespace("/salary")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "create-salary.action", type = "redirect"),
        @Result(name = "create-stu-jobs", location = "../job/create-stu-jobs.action", type = "redirect"),
        @Result(name = "create", location = "create.jsp"),
        @Result(name = "modifyList", location = "modifyList.jsp"),
        @Result(name = "modifySalary", location = "modifySalary.jsp") })
public class CreateSalaryAction extends CrudActionSupport<Salary>
{
    /**
     * serialVersionUID long
     */
    private static final long                       serialVersionUID = 1L;

    private StudentWebService                       studentWebService;

    private StuManager                              stuManager;

    private JobsManager                             jobsManager;

    private CompanyManager                          companyManager;

    private SalaryManager                           salaryManager;

    private AccountManager                          accountManager;

    private Salary                                  entity;

    // 页面属性
    private Long                                    id;

    private List<StuJobsVO>                         studentVOs;

    private Long                                    stuJobsId;

    private StuJobsVO                               allInfo;

    private List<LabelValue>                        statusList;

    private Page<Salary>                            page             = new Page<Salary>(
                                                                             Constant.PAGE_SIZE);

    private final cn.loosoft.stuwork.workstudy.Page commonPage       = new cn.loosoft.stuwork.workstudy.Page();

    private String                                  startWorkStartTime;

    private String                                  endWorkStartTime;

    private String                                  startWorkStopTime;

    private String                                  endWorkStopTime;

    /**
     * 
     * 显示当前单位的，所有已经生成的工资单
     * 
     * @since 2011-3-4
     * @author yong.geng
     * @return
     * @throws Exception
     */
    public String modifyList() throws Exception
    {

        if (!page.isOrderBySetted())
        {
            page.setOrderBy("createDate");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        // 必须判断是否为null，因为空值传进参数，会报错
        if (startWorkStartTime != null && endWorkStartTime != null)
        {
            if (startWorkStartTime.length() != 0
                    && endWorkStartTime.length() != 0)
            {
                // 还有判断空值
                filters.add(new PropertyFilter("GED_workStartTime",
                        startWorkStartTime));
                filters.add(new PropertyFilter("LED_workStartTime",
                        endWorkStartTime));
            }
        }
        if (startWorkStopTime != null && endWorkStopTime != null)
        {
            if (startWorkStopTime.length() != 0
                    && endWorkStopTime.length() != 0)
            {
                // 还有判断空值
                filters.add(new PropertyFilter("GED_workStopTime",
                        startWorkStopTime));
                filters.add(new PropertyFilter("LED_workStopTime",
                        endWorkStopTime));
            }
        }
        // 根据当前登录用户的id，找到其所在单位。根据单位id去查询。。。。。。暂时没写，等单位搞好后，再写进来。

        // 根据当前登录用户的id，找到其所在单位。没有的话，就显示全部
        User user = accountManager.getUser(SpringSecurityUtils
                .getCurrentUserName());
        // 如果是空，说明不是勤工系统的用户
        if (user != null)
        {
            if (user.getCompanyID() != null)
            {
                String compID = user.getCompanyID().toString();
                filters.add(new PropertyFilter("EQL_companyId", compID));
            }
        }
        ParamPropertyUtils.replacePropertyRule(filters);
        page = salaryManager.search(page, filters);
        return "modifyList";
    }

    public String modify() throws Exception
    {
        this.entity = salaryManager.get(id);
        return "modifySalary";
    }

    /**
     * 
     * 创建工资单
     * 
     * @since 2011-3-4
     * @author Administrator
     * @return
     * @throws Exception
     */
    public String createSalary() throws Exception
    {
        StudentJobs stuJobs = stuManager.get(stuJobsId);
        allInfo = new StuJobsVO();

        // 设置单位id,名称
        long compId = stuJobs.getCompanyID();
        allInfo.setCompanyid(compId);
        allInfo.setCompanyName(companyManager.get(compId).getCompanyName());

        // 设置岗位id,名称
        long postId = stuJobs.getJobsID();
        allInfo.setPostId(postId);
        allInfo.setPostname(jobsManager.get(postId).getPostName());

        // 设置学生考试号，名称
        String studentNo = stuJobs.getStudentNo();
        StudentDTO studentDTO = null;
        studentDTO = studentWebService.getStudentByStudentNo(studentNo);
        if (studentDTO != null)
        {
            allInfo.setStuId(studentNo);
            allInfo.setName(studentDTO.getName());
            allInfo.setCollegeCode(studentDTO.getCollegeCode());
            allInfo.setCollegeName(studentDTO.getCollegeName());

            // 设置银行信息
            allInfo.setBankName(studentDTO.getBankName());
            allInfo.setBankAccount(studentDTO.getBankAccount());
        }

        return "create";
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * 已经工作的学生和岗位列表。 1，先到岗位-学生表，根据用工单位id，取出postId和examineeNo。
     * 2，根据postId和examineeNo，通过webservice接口，得到岗位名称和学生姓名。 3，把岗位名称和学生姓名插入到VO。
     * 4，页面循环显示VOlist。
     * 
     * @since 2011-3-4
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        // 根据单位id，得到StudentJobs列表，取出postId和examineeNo
        User user = accountManager.getUser(SpringSecurityUtils
                .getCurrentUserName());
        int compId = 0;
        List<StudentJobs> stuJobsList = null;
        StuJobsVO studentVO = null;
        StudentDTO studentDTO = null;
        studentVOs = new ArrayList<StuJobsVO>();
        // 如果是空，说明不是勤工系统的用户.可能是超户，或者助学中心，那么就取出所有的。
        if (user != null)
        {
            if (user.getCompanyID() != null)
            {
                compId = Integer.parseInt(user.getCompanyID().toString());
                stuJobsList = stuManager.findByCompId(compId);
            }
        }
        else
        {
            stuJobsList = stuManager.find();
        }

        // 参数compId，在Dao里面暂时没有用到，等权限做好了，再把Dao里面的改掉
        if (stuJobsList != null)
        {
            commonPage.setPageSize(15);
            commonPage.setTotalCount(stuJobsList.size());
            for (int i = 0; i < stuJobsList.size(); i++)
            {
                studentVO = new StuJobsVO();
                long stuJobId = stuJobsList.get(i).getId();
                studentVO.setStuJobsId(stuJobId);

                long postId = stuJobsList.get(i).getJobsID();
                studentVO.setPostname(jobsManager.get(postId).getPostName());

                String studentNo = stuJobsList.get(i).getStudentNo();
                studentDTO = studentWebService.getStudentByStudentNo(studentNo);
                studentVO.setName(studentDTO.getName());

                studentVOs.add(studentVO);
            }
        }

        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = salaryManager.get(id);
        }
        else
        {
            entity = new Salary();
        }

    }

    @Override
    public String save() throws Exception
    {
        this.entity.setCreateDate(new Date());
        this.entity.setGroupStatus(Constant.SHZ);
        this.entity.setCenterStatus(Constant.SHZ);
        if (this.entity.getId() == null)
        {
            salaryManager.save(entity);
            addActionMessage("创建工资单成功!");
            return "create-stu-jobs";
        }
        salaryManager.save(entity);
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("createDate");
            page.setOrder(Page.DESC);
        }
        page = salaryManager.search(page);
        addActionMessage("修改工资单成功!");
        return "modifyList";

    }

    public String modifySave() throws Exception
    {
        this.entity = salaryManager.get(id);
        this.entity.setCreateDate(new Date());
        this.entity.setGroupStatus(Constant.SHZ);
        this.entity.setCenterStatus(Constant.SHZ);
        salaryManager.save(entity);
        addActionMessage("修改工资单成功!");
        return "modifyList";

    }

    public Salary getModel()
    {
        return entity;
    }

    @Autowired
    public void setStuManager(StuManager stuManager)
    {
        this.stuManager = stuManager;
    }

    @Autowired
    public void setJobsManager(JobsManager jobsManager)
    {
        this.jobsManager = jobsManager;
    }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }

    @Autowired
    public void setCompanyManager(CompanyManager companyManager)
    {
        this.companyManager = companyManager;
    }

    @Autowired
    public void setSalaryManager(SalaryManager salaryManager)
    {
        this.salaryManager = salaryManager;
    }

    public List<StuJobsVO> getStudentVOs()
    {
        return studentVOs;
    }

    public void setStudentVOs(List<StuJobsVO> studentVOs)
    {
        this.studentVOs = studentVOs;
    }

    public cn.loosoft.stuwork.workstudy.Page getCommonPage()
    {
        return commonPage;
    }

    public Long getStuJobsId()
    {
        return stuJobsId;
    }

    public void setStuJobsId(Long stuJobsId)
    {
        this.stuJobsId = stuJobsId;
    }

    public StuJobsVO getAllInfo()
    {
        return allInfo;
    }

    public void setAllInfo(StuJobsVO allInfo)
    {
        this.allInfo = allInfo;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Page<Salary> getPage()
    {
        return page;
    }

    public void setPage(Page<Salary> page)
    {
        this.page = page;
    }

    public Salary getEntity()
    {
        return entity;
    }

    public void setEntity(Salary entity)
    {
        this.entity = entity;
    }

    public List<LabelValue> getStatusList()
    {
        return statusList = new Constant().getStatusList();
    }

    public String getStartWorkStartTime()
    {
        return startWorkStartTime;
    }

    public void setStartWorkStartTime(String startWorkStartTime)
    {
        this.startWorkStartTime = startWorkStartTime;
    }

    public String getEndWorkStartTime()
    {
        return endWorkStartTime;
    }

    public void setEndWorkStartTime(String endWorkStartTime)
    {
        this.endWorkStartTime = endWorkStartTime;
    }

    public String getStartWorkStopTime()
    {
        return startWorkStopTime;
    }

    public void setStartWorkStopTime(String startWorkStopTime)
    {
        this.startWorkStopTime = startWorkStopTime;
    }

    public String getEndWorkStopTime()
    {
        return endWorkStopTime;
    }

    public void setEndWorkStopTime(String endWorkStopTime)
    {
        this.endWorkStopTime = endWorkStopTime;
    }

    @Autowired
    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }

}
