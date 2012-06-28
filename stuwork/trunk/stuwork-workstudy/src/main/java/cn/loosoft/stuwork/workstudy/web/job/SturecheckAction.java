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
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;
import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudy.service.job.JobsManager;
import cn.loosoft.stuwork.workstudy.service.job.StudentjobsManager;
import cn.loosoft.stuwork.workstudy.vo.StuJobsVO;

/**
 * 
 * 申请复审Action.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-28
 */
/**
 * Description of the class
 * 
 * @author Administrator
 * @version 1.0
 * @since 2011-3-14
 */
@Namespace("/job")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "sturecheck.action", type = "redirect"),
        @Result(name = "stuInfo", location = "stuInfo.jsp"),
        @Result(name = "jobs-detail", location = "jobs-detail.jsp"),
        @Result(name = "nopassrecheck", location = "nopassrecheck.jsp"),
        @Result(name = "nopassrecheck-detail", location = "nopassrecheck-detail.jsp") })
public class SturecheckAction extends CrudActionSupport<StudentJobs>
{

    /**
     * 
     */
    private static final long                       serialVersionUID = 1L;

    private StudentjobsManager                      studentjobsManager;

    private JobsManager                             jobsManager;

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

    private Long                                    jobID;

    private String                                  startApply;                                                // 开始时间

    private String                                  endApply;                                                  // 结束时间

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

    public Long getJobID()
    {
        return jobID;
    }

    public void setJobID(Long jobID)
    {
        this.jobID = jobID;
    }

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("applyDate");
            page.setOrder(Page.ASC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        // 必须判断是否为null，因为空值传进参数，会报错
        if (startApply != null && endApply != null)
        {
            if (startApply.length() != 0 && endApply.length() != 0)
            {
                // 还有判断空值
                filters.add(new PropertyFilter("GED_applyDate", startApply));
                filters.add(new PropertyFilter("LED_applyDate", endApply));
            }

        }

        filters.add(new PropertyFilter("EQS_chose", "chosing"));
        filters.add(new PropertyFilter("EQS_groupStatus", "shtg"));
        page = studentjobsManager.search(page, filters);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
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
        jobs.setPostName(jobsManager.get(jobID).getPostName());
        jobs.setSexLimit(jobsManager.get(jobID).getSexLimit());
        jobs.setAddress(jobsManager.get(jobID).getAddress());
        jobs.setContent(jobsManager.get(jobID).getContent());
        jobs.setRequireMents(jobsManager.get(jobID).getRequireMents());
        jobs.setCompany(jobsManager.get(jobID).getCompany());
        jobs.setPubdate(jobsManager.get(jobID).getPubdate());
        jobs.setStopdate(jobsManager.get(jobID).getStopdate());
        jobs.setReqCount(jobsManager.get(jobID).getReqCount());
        jobs.setExisitCount(jobsManager.get(jobID).getExisitCount());
        jobs.setPostStatus(jobsManager.get(jobID).getPostStatus());
        jobs.setAuditStatus(jobsManager.get(jobID).getAuditStatus());
        return "jobs-detail";

    }

    /**
     * 审核通过
     */
    public String pass()
    {
        this.entity = studentjobsManager.get(id);
        entity.setCenterStatus(Constant.SHTG);
        entity.setCenterNoPassReason("");
        studentjobsManager.save(entity);
        return RELOAD;
    }

    /**
     * 审核未通过
     */
    public String nopass()
    {
        this.entity = studentjobsManager.get(id);
        entity.setCenterNoPassReason(centernopassreason);
        entity.setCenterStatus(Constant.SHWTG);
        studentjobsManager.save(entity);
        return RELOAD;
    }

    /**
     * 跳转页面并传id
     */
    public String unpass()
    {
        this.entity = studentjobsManager.get(id);
        return "nopassrecheck";
    }

    /**
     * 查看未过原因 Description of this Method
     * 
     * @since 2011-3-17
     * @author bing.hu
     * @return
     */
    public String nopassrecheckDetail()
    {
        this.entity = studentjobsManager.get(id);
        return "nopassrecheck-detail";

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

}
