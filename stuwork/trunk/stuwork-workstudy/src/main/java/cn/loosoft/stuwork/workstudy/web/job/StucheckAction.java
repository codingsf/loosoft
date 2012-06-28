package cn.loosoft.stuwork.workstudy.web.job;

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
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.account.User;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;
import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudy.service.account.AccountManager;
import cn.loosoft.stuwork.workstudy.service.job.JobsManager;
import cn.loosoft.stuwork.workstudy.service.job.StudentjobsManager;
import cn.loosoft.stuwork.workstudy.vo.StuJobsVO;

import com.google.common.collect.Lists;

/**
 * 
 * 申请审核Action.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-28
 */
@Namespace("/job")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "stucheck.action", type = "redirect"),
        @Result(name = "stuInfo", location = "stuInfo.jsp"),
        @Result(name = "jobs-detail", location = "jobs-detail.jsp"),
        @Result(name = "nopasscheck", location = "nopasscheck.jsp"),
        @Result(name = "apply-detail", location = "apply-detail.jsp"),
        @Result(name = "nopasscheck-detail", location = "nopasscheck-detail.jsp") })
public class StucheckAction extends CrudActionSupport<StudentJobs>
{

    /**
     * 
     */
    private static final long                       serialVersionUID = 1L;

    private StudentjobsManager                      studentjobsManager;

    private JobsManager                             jobsManager;

    private AccountManager                          accountManager;

    private StudentWebService                       studentWebService;

    // -- 页面属性 --//
    private Long                                    id;

    private StudentJobs                             entity;

    private Page<StudentJobs>                       page             = new Page<StudentJobs>(
                                                                             Constant.PAGE_SIZE);

    private final cn.loosoft.stuwork.workstudy.Page commonPage       = new cn.loosoft.stuwork.workstudy.Page();

    // 从stu.jsp页面传过来的学生考试号，用来查询学生
    private String                                  examineeNo;

    // 在stuInfo页面，显示学生信息对象
    private StuJobsVO                               stuInfo;

    // 在岗位页面显示所有岗位信息
    private Jobs                                    jobs;

    private String                                  centernopassreason;

    private Long                                    jobsID;

    private String                                  startApply;                                                // 开始时间

    private String                                  endApply;                                                  // 结束时间

    private List<Jobs>                              jobList          = Lists
                                                                             .newArrayList();

    public Long getJobsID()
    {
        return jobsID;
    }

    public void setJobsID(Long jobsID)
    {
        this.jobsID = jobsID;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    @Override
    public String list() throws Exception
    {
        // TODO Auto-generated method stub
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("groupStatus");
            page.setOrder(Page.ASC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);

        // 根据当前登录用户的id，找到其所在学院小组。没有的话，就显示全部
        User user = accountManager.getUser(SpringSecurityUtils
                .getCurrentUserName());
        // 如果是空，说明不是勤工系统的用户
        if (user != null)
        {
            if (user.getCompanyID() != null)
            {
                filters.add(new PropertyFilter("EQL_companyID", String.valueOf(user.getCompanyID())));
            }
        }
        //filters.add(new PropertyFilter("EQS_chose", Constant.CHOSING));
        // filters.add(new PropertyFilter("LIKES_centerStatus", Constant.SHTG));
        page = studentjobsManager.search(page, filters);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub
        if (id != null)
        {
            entity = studentjobsManager.get(id);
        }
        else
        {
            entity = new StudentJobs();
        }
    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String delete() throws Exception
    {
        studentjobsManager.delete(id);
        Struts2Utils.renderText("删除审查成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    /**
     * 
     * 查看单个学生信息
     * 
     * @since 2011-3-1
     * @author bing.hu
     * @return
     * @throws Exception
     */
    public String findStu() throws Exception
    {
        StudentDTO studentDTO = studentWebService
                .getStudentByExamineeNo(examineeNo);
        stuInfo = new StuJobsVO();
        stuInfo.setStuId(studentDTO.getStudentNo());
        stuInfo.setName(studentDTO.getName());
        stuInfo.setCollegeName(studentDTO.getCollegeName());
        stuInfo.setSexdesc(studentDTO.getSexDesc());
        stuInfo.setMajorName(studentDTO.getMajorName());
        stuInfo.setBirthday(studentDTO.getBirthday());
        stuInfo.setClassName(studentDTO.getClassName());
        stuInfo.setIDcard(studentDTO.getIDcard());
        stuInfo.setNation(studentDTO.getNation());
        stuInfo.setPhone(studentDTO.getPhone());
        stuInfo.setIDcard(studentDTO.getIDcard());
        stuInfo.setBankName(studentDTO.getBankName());
        stuInfo.setBankAccount(studentDTO.getBankAccount());
        return "stuInfo";
    }

    /**
     * 
     * 查看单个岗位信息
     * 
     * @since 2011-3-1
     * @author bing.hu
     * @return
     * @throws Exception
     */
    public String findJob() throws Exception
    {
        jobs = new Jobs();
        // jobs.setId(jobsManager.get(jobsID).getId());
        jobs.setPostName(jobsManager.get(jobsID).getPostName());
        jobs.setSexLimit(jobsManager.get(jobsID).getSexLimit());
        jobs.setAddress(jobsManager.get(jobsID).getAddress());
        jobs.setContent(jobsManager.get(jobsID).getContent());
        jobs.setRequireMents(jobsManager.get(jobsID).getRequireMents());
        jobs.setCompany(jobsManager.get(jobsID).getCompany());
        jobs.setPubdate(jobsManager.get(jobsID).getPubdate());
        jobs.setStopdate(jobsManager.get(jobsID).getStopdate());
        jobs.setReqCount(jobsManager.get(jobsID).getReqCount());
        jobs.setExisitCount(jobsManager.get(jobsID).getExisitCount());
        jobs.setPostStatus(jobsManager.get(jobsID).getPostStatus());
        jobs.setAuditStatus(jobsManager.get(jobsID).getAuditStatus());
        return "jobs-detail";

    }

    /**
     * 审核通过
     */
    public String pass()
    {
        this.entity = studentjobsManager.get(id);
        entity.setGroupStatus(Constant.SHTG);
        entity.setGroupNoPassReason("");
        studentjobsManager.save(entity);
        return RELOAD;
    }

    /**
     * 审核未通过
     */
    public String nopass()
    {
        this.entity = studentjobsManager.get(id);
        entity.setGroupStatus(Constant.SHWTG);
        entity.setCenterStatus(Constant.SHZ);
        entity.setGroupNoPassReason(centernopassreason);
        studentjobsManager.save(entity);
        return RELOAD;
    }

    /**
     * 跳转页面并传id
     */
    public String unpass()
    {
        this.entity = studentjobsManager.get(id);
        return "nopasscheck";
    }

    /**
     * 跳转页面并传id
     */
    public String regulateshow()
    {
        User user = accountManager.getUser(SpringSecurityUtils
                .getCurrentUserName());
        this.entity = studentjobsManager.get(id);
        System.out.println(entity.getJobsID());

        jobList = jobsManager.findByCompanyIdAndExcludeJob(user.getCompanyID(),
                entity.getJobsID());

        return "regulateshow";
    }

    /**
     * 跳转页面并传id
     */
    public String regulate()
    {
        this.entity = studentjobsManager.get(ParamUtils.getLongParameter(
                Struts2Utils.getRequest(), "entityId", 0));
        String oldName = entity.getJobsName();
        Long jobId = ParamUtils.getLongParameter(Struts2Utils.getRequest(),
                "jobId", 0);

        entity.setJobsID(jobId);
        entity.setJobsName(jobsManager.get(jobId).getPostName());
        entity.setGroupStatus(Constant.SHTG);
        entity.setRegulate("用工单位将\"" + entity.getStudentName() + "\"由\""
                + oldName + "\"调剂至\"" + entity.getJobsName() + "\"！");
        studentjobsManager.save(entity);
        return RELOAD;
    }

    /**
     * 查看申请原因 Description of this Method
     * 
     * @since 2011-3-16
     * @author bing.hu
     * @return
     */
    public String applyDetail()
    {
        this.entity = studentjobsManager.get(id);
        return "apply-detail";

    }

    /**
     * 查看未过原因 Description of this Method
     * 
     * @since 2011-3-16
     * @author bing.hu
     * @return
     */
    public String nopassDetail()
    {
        this.entity = studentjobsManager.get(id);
        return "nopasscheck-detail";

    }

    public StudentJobs getModel()
    {
        // TODO Auto-generated method stub
        return entity;
    }

    public StudentJobs getEntity()
    {
        return entity;
    }

    public Page<StudentJobs> getPage()
    {
        return page;
    }

    @Autowired
    public void setStudentjobsmanager(StudentjobsManager studentjobsmanager)
    {
        this.studentjobsManager = studentjobsmanager;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }

    public void setStuInfo(StuJobsVO stuInfo)
    {
        this.stuInfo = stuInfo;
    }

    public StuJobsVO getStuInfo()
    {
        return stuInfo;
    }

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public StudentWebService getStudentWebService()
    {
        return studentWebService;
    }

    @Autowired
    public void setJobsManager(JobsManager jobsManager)
    {
        this.jobsManager = jobsManager;
    }

    public Jobs getJobs()
    {
        return jobs;
    }

    public void setJobs(Jobs jobs)
    {
        this.jobs = jobs;
    }

    public String getCenternopassreason()
    {
        return centernopassreason;
    }

    public void setCenternopassreason(String centernopassreason)
    {
        this.centernopassreason = centernopassreason;
    }

    public cn.loosoft.stuwork.workstudy.Page getCommonPage()
    {
        return commonPage;
    }

    public Long getId()
    {
        return id;
    }

    public String getStartApply()
    {
        return startApply;
    }

    public void setStartApply(String startApply)
    {
        this.startApply = startApply;
    }

    public String getEndApply()
    {
        return endApply;
    }

    public void setEndApply(String endApply)
    {
        this.endApply = endApply;
    }

    @Autowired
    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }

    public List<Jobs> getJobList()
    {
        return jobList;
    }

    public void setJobList(List<Jobs> jobList)
    {
        this.jobList = jobList;
    }
}
