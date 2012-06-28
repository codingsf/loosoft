package cn.loosoft.stuwork.workstudysite.web.jobs;

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
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.date.DateUtils;
import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.security.springsecurity.user.User;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.data.webservice.api.user.dto.UserDTO;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudysite.Constant;
import cn.loosoft.stuwork.workstudysite.entity.job.Jobs;
import cn.loosoft.stuwork.workstudysite.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudysite.entity.sys.Commitment;
import cn.loosoft.stuwork.workstudysite.service.account.AccountManager;
import cn.loosoft.stuwork.workstudysite.service.job.JobsManager;
import cn.loosoft.stuwork.workstudysite.service.job.StudentjobsManager;
import cn.loosoft.stuwork.workstudysite.service.sys.CommitmentManager;

/**
 * 
 * 岗位申请Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-9
 */
@Namespace("/jobs")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "jobs-apply.action", type = "redirect"),
        @Result(name = "jobsdetail", location = "jobs-apply-detail.jsp"),
        @Result(name = "applyreason", location = "jobs-apply-reason.jsp"),
        @Result(name = "commitment", location = "jobs-apply-commitment.jsp") })
public class JobsApplyAction extends CrudActionSupport<Object>
{
    HttpServletRequest         request          = Struts2Utils.getRequest();

    private JobsManager        jobsManager;

    private StudentjobsManager studentjobsManager;

    @Autowired
    private StudentWebService  studentWebService;

    private AccountManager     accountManager;

    private CommitmentManager  commitmentManager;

    private Page<Jobs>         page             = new Page<Jobs>(
                                                        Constant.PAGE_SIZE);

    private Jobs               entity;

    private StudentJobs        studentJobs;

    private Long               id;

    private String             startPub;                                    // 开始时间

    private String             endPub;                                      // 结束时间

    private String             name;

    private String             content;

    private Long               jobId;

    /**
     * serialVersionUID long
     */
    private static final long  serialVersionUID = 1L;

    public String toApplyReason()
    {
        this.entity = jobsManager.get(id);
        return "applyreason";
    }

    public String detail()
    {
        this.entity = jobsManager.get(id);
        return "jobsdetail";
    }

    public String agreeCommitment()
    {
        Commitment c = commitmentManager.getAll().get(0);
        name = c.getName();
        content = c.getContent();
        jobId = id;
        return "commitment";
    }

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String list() throws Exception
    {
        try
        {

            if (!page.isOrderBySetted())
            {
                page.setOrderBy("pubdate");
                page.setOrder(Page.ASC);
            }

            HttpServletRequest request = ServletActionContext.getRequest();
            List<PropertyFilter> filters = HibernateUtils
                    .buildPropertyFilters(request);

            // 这里是学生使用的，所以肯定是到backmanage去取
            UserDTO userDTO = accountManager.getUserDTO(SpringSecurityUtils
                    .getCurrentUserName());
            filters.add(new PropertyFilter("EQS_postStatus", Constant.ZPZ));
            filters.add(new PropertyFilter("GTD_stopdate", DateUtils.getDateFromDateTime(new Date(), "yyyy-MM-dd")));
            if (userDTO != null)
            {
                // 登录名就是考试号
                String examineeNo = userDTO.getLoginName();
                if (examineeNo.length() == 14)
                {
                    ParamPropertyUtils.replacePropertyRule(filters);
                    // filters.add(new PropertyFilter("EQS_auditStatus",
                    // "shtg"));
                    page = jobsManager.findJobsByExamNO(page, examineeNo);
                    // page = jobsManager.search(page, filters);
                }
                else
                {
                    ParamPropertyUtils.replacePropertyRule(filters);
                    filters.add(new PropertyFilter("EQS_auditStatus", "shtg"));
                    page = jobsManager.search(page, filters);
                }
            }
            else
            {

                ParamPropertyUtils.replacePropertyRule(filters);
                filters.add(new PropertyFilter("EQS_auditStatus", "shtg"));
                page = jobsManager.search(page, filters);
            }

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }

        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {

    }

    @Override
    public String save() throws Exception
    {
        String applyReason = ParamUtils.getParameter(request, "applyReason"); // 申请原因

        // 这里是学生使用的
        User user = (User) SpringSecurityUtils.getCurrentUser();

        StudentDTO studentDTO = studentWebService.getStudentByStudentNo(user
                .getUsername());
        // 
        String studentNo = studentDTO.getStudentNo();
        String studentName = studentDTO.getName();
        String collegeCode = studentDTO.getCollegeCode();

        Jobs jobs = jobsManager.get(id);
        studentJobs = new StudentJobs();
        studentJobs.setJobsID(Integer.parseInt(id.toString()));
        studentJobs.setJobsName(jobs.getPostName());
        studentJobs.setStudentNo(studentNo);
        studentJobs.setStudentName(studentName);
        studentJobs.setCenterStatus(Constant.SHZ);
        studentJobs.setApplyReason(applyReason);
        studentJobs.setChose(Constant.CHOSING);
        studentJobs.setApplyDate(DateUtils.getNowTimestamp());
        studentJobs.setGroupStatus(Constant.SHZ);
        studentJobs.setCompanyID(Integer.parseInt(jobs.getCompany().getId()
                .toString()));
        studentJobs.setCollegeCode(collegeCode);
        studentjobsManager.save(studentJobs);
        addActionMessage("恭喜您,申请成功");
        return RELOAD;
    }

    public Object getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    @Autowired
    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }

    @Autowired
    public void setJobsManager(JobsManager jobsManager)
    {
        this.jobsManager = jobsManager;
    }

    @Autowired
    public void setStudentjobsManager(StudentjobsManager studentjobsManager)
    {
        this.studentjobsManager = studentjobsManager;
    }

    public Jobs getEntity()
    {
        return entity;
    }

    public void setEntity(Jobs entity)
    {
        this.entity = entity;
    }

    public Page<Jobs> getPage()
    {
        return page;
    }

    public HttpServletRequest getRequest()
    {
        return request;
    }

    public void setRequest(HttpServletRequest request)
    {
        this.request = request;
    }

    public StudentJobs getStudentJobs()
    {
        return studentJobs;
    }

    public void setStudentJobs(StudentJobs studentJobs)
    {
        this.studentJobs = studentJobs;
    }

    public String getStartPub()
    {
        return startPub;
    }

    public void setStartPub(String startPub)
    {
        this.startPub = startPub;
    }

    public String getEndPub()
    {
        return endPub;
    }

    public void setEndPub(String endPub)
    {
        this.endPub = endPub;
    }

    @Autowired
    public void setCommitmentManager(CommitmentManager commitmentManager)
    {
        this.commitmentManager = commitmentManager;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public Long getJobId()
    {
        return jobId;
    }

    public void setJobId(Long jobId)
    {
        this.jobId = jobId;
    }

}
