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
package cn.loosoft.stuwork.workstudy.web.job;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Page;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;
import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudy.service.job.JobsManager;
import cn.loosoft.stuwork.workstudy.service.job.StuManager;
import cn.loosoft.stuwork.workstudy.vo.StuJobsVO;

/**
 * 
 * 选择学生Action.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-2-24
 */
@Namespace("/job")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "stu.action", type = "redirect"),
        @Result(name = "stuInfo", location = "stuInfo.jsp") })
public class StuAction extends CrudActionSupport<StudentJobs>
{

    /**
     * serialVersionUID long
     */
    private static final long                       serialVersionUID = 1L;

    private StuManager                              stuManager;

    private StudentWebService                       studentWebService;

    private JobsManager                             jobsManager;

    // -- 页面属性 --//
    private Long                                    postId;

    private Long                                    stuJobsId;

    private String                                  postName;

    private StudentJobs                             entity;

    private List<StuJobsVO>                         studentVOs;

    // 从stu.jsp页面传过来的学号，用来查询学生
    private String                                  studentNo;

    // 在stuInfo页面，显示学生信息对象
    private StuJobsVO                               stuInfo;

    // 作用：当点击“选择”或“取消选择”的时候，要重新刷新stu.jsp页面，此时会执行list方法，但是list方法里面需要一个postId，
    // 此时postId通过请求参数传来过来，但是到chose方法里面，参数周期就结束了，postId就是空值了。
    // 这时，在chose方法里面给这个static变量复制，就记住了postId，这样，在list方法里面调用的时候，就有值了
    private static int                              ppId;

    private final cn.loosoft.stuwork.workstudy.Page commonPage       = new cn.loosoft.stuwork.workstudy.Page();

    /**
     * 
     * 查看单个学生信息
     * 
     * @since 2011-2-28
     * @author yong.geng
     * @return
     * @throws Exception
     */
    public String findStu() throws Exception
    {
        StudentDTO studentDTO = studentWebService
                .getStudentByStudentNo(studentNo);
        stuInfo = new StuJobsVO();
        stuInfo.setStuId(studentDTO.getStudentNo());
        stuInfo.setExamineeNo(studentDTO.getExamineeNo());
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
     * 确定用工,对应岗位的已招聘人数+1
     * 
     * @since 2011-2-25
     * @author yonggeng
     * @return
     * @throws Exception
     */
    public String chose() throws Exception
    {
        this.entity = stuManager.get(stuJobsId);
        this.entity.setChose("apply");
        this.entity.setChoseDate(new Date());
        stuManager.save(entity);
        // 给此岗位的已招聘人数+1
        Jobs job = jobsManager.get(postId);
        int exisitCount = job.getExisitCount();
        if ((exisitCount + 1) == job.getReqCount())
        {
            job.setPostStatus("zptz");
        }
        job.setExisitCount(job.getExisitCount() + 1);
        jobsManager.save(job);

        // 给页面刷新时候，执行list方法里面，需要的岗位id赋值。
        ppId = Integer.parseInt(postId.toString());
        return RELOAD;
    }

    /**
     * 
     * 淘汰用工
     * 
     * @since 2011-2-25
     * @author yong.geng
     * @return
     * @throws Exception
     */
    public String unchose() throws Exception
    {
        this.entity = stuManager.get(stuJobsId);
        this.entity.setChose("pass");
        stuManager.save(entity);
        // 给页面刷新时候，执行list方法里面，需要的岗位id赋值。
        ppId = Integer.parseInt(postId.toString());
        return RELOAD;
    }

    @Override
    public String input() throws Exception
    {
        return null;
    }

    @Override
    public String list() throws Exception
    {
        int pId = 0;
        if (ppId == 0)
        {
            pId = Integer.parseInt(postId.toString());
        }
        else
        {
            pId = ppId;
        }
        studentVOs = convertToStudentJobList(pId);
        ppId = 0;

        return SUCCESS;
    }

    /**
     * 根据岗位id，查询应聘此岗位的所有学生。 1，首先到岗位-学生表，查询此岗位的所有学生的examineeNo
     * 2，根据考试号，通过webservice去查询学生的信息。3，只能显示学院小组审核通过的学生申请信息。
     * 
     * @since 2011-2-27
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    private List<StuJobsVO> convertToStudentJobList(int pId)
    {
        List<StudentJobs> list = stuManager.findByPostId(pId, commonPage
                .getPageNo());
        StuJobsVO studentVO = null;
        StudentJobs stuJobs = null;
        Jobs jobs = null;
        StudentDTO studentDTO = null;
        List<StuJobsVO> stuList = new ArrayList<StuJobsVO>();
        commonPage.setTotalCount(stuManager.findCountByPostId(pId));
        for (int i = 0; i < list.size(); i++)
        {
            // 得到学生信息，并设置到VO里面
            String studentNo = list.get(i).getStudentNo();
            try
            {
                studentDTO = studentWebService.getStudentByStudentNo(studentNo);
            }
            catch (Exception e)
            {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            studentVO = new StuJobsVO();
            if (studentDTO != null)
            {
                studentVO.setStuId(studentDTO.getStudentNo());
                studentVO.setName(studentDTO.getName());
                studentVO.setCollegeName(studentDTO.getCollegeName());
                studentVO.setSexdesc(studentDTO.getSexDesc());
                studentVO.setMajorName(studentDTO.getMajorName());
                studentVO.setBirthday(studentDTO.getBirthday());
                studentVO.setClassName(studentDTO.getClassName());
                studentVO.setIDcard(studentDTO.getIDcard());
                studentVO.setNation(studentDTO.getNation());
                studentVO.setPhone(studentDTO.getPhone());
                studentVO.setIDcard(studentDTO.getIDcard());
                studentVO.setBankName(studentDTO.getBankName());
                studentVO.setBankAccount(studentDTO.getBankAccount());
            }

            // 得到岗位信息，并设置到VO里面
            jobs = jobsManager.get((long) pId);
            if (jobs != null)
            {
                studentVO.setPostname(jobs.getPostName());
                studentVO.setPostId((long) pId);
                studentVO.setExisitcount(jobs.getExisitCount());
                studentVO.setReqcount(jobs.getReqCount());
            }

            // 得到学生岗位信息，并设置到VO里面
            List<StudentJobs> studentJobs = stuManager.findByPostIdAndStudentNO(
                    pId, studentDTO.getStudentNo());
            if (studentJobs != null && studentJobs.size() > 0)
            {
                stuJobs = studentJobs.get(0);
                studentVO.setChose(stuJobs.getChose());
                studentVO.setStuJobsId(stuJobs.getId());
            }

            stuList.add(studentVO);
        }
        return stuList;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (postId != null)
        {
            entity = stuManager.get(postId);
        }
        else
        {
            entity = new StudentJobs();
        }
    }

    @Override
    public String save() throws Exception
    {
        return null;
    }

    public StudentJobs getModel()
    {
        return entity;
    }

    public Long getPostId()
    {
        return postId;
    }

    public void setPostId(Long postId)
    {
        this.postId = postId;
    }

    @Autowired
    public void setStuManager(StuManager stuManager)
    {
        this.stuManager = stuManager;
    }

    public JobsManager getJobsManager()
    {
        return jobsManager;
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

    public StudentWebService getStudentWebService()
    {
        return studentWebService;
    }

    public StudentJobs getEntity()
    {
        return entity;
    }

    public String getPostName()
    {
        return postName;
    }

    public void setPostName(String postName)
    {
        this.postName = postName;
    }

    public StuJobsVO getStuInfo()
    {
        return stuInfo;
    }

    public void setStuInfo(StuJobsVO stuInfo)
    {
        this.stuInfo = stuInfo;
    }

    public String getStudentNo() {
		return studentNo;
	}

	public void setStudentNo(String studentNo) {
		this.studentNo = studentNo;
	}

	public List<StuJobsVO> getStudentVOs()
    {
        return studentVOs;
    }

    public void setStudentVOs(List<StuJobsVO> studentVOs)
    {
        this.studentVOs = studentVOs;
    }

    public Long getStuJobsId()
    {
        return stuJobsId;
    }

    public void setStuJobsId(Long stuJobsId)
    {
        this.stuJobsId = stuJobsId;
    }

    public Page getCommonPage()
    {
        return commonPage;
    }

}
