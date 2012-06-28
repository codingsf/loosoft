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
package cn.loosoft.stuwork.selfhelp.web.jobs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.data.webservice.api.jobs.JobsWebService;
import cn.loosoft.data.webservice.api.jobs.dto.CommitmentDTO;
import cn.loosoft.data.webservice.api.jobs.dto.JobsDTO;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 学生申请岗位
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-4-17
 */
@Namespace("/jobs")
@Results( { @Result(name = "jobsdetail", location = "jobs-detail.jsp"),
        @Result(name = "applyreason", location = "jobs-reason.jsp"),
        @Result(name = "commitment", location = "jobs-commitment.jsp") })
public class JobsAction extends ActionSupport
{
    /**
     * serialVersionUID long
     */
    private static final long                      serialVersionUID = 1L;

    private final HttpServletRequest               request          = Struts2Utils
                                                                            .getRequest();

    @Autowired
    private JobsWebService                         jobsWebService;

    private List<JobsDTO>                          dtoLists;

    private JobsDTO                                jobsDTO;

    private long                                   id;

    private long                                   jobsId;

    private CommitmentDTO                          commitmentDTO;

    private final cn.loosoft.stuwork.selfhelp.Page commonPage       = new cn.loosoft.stuwork.selfhelp.Page();

    @Override
    public String execute() throws Exception
    {
        commonPage.setTotalCount(jobsWebService.getAllJobsCount());
        dtoLists = jobsWebService.getAllJobs(commonPage.getPageNo());
        return SUCCESS;
    }

    /**
     * 
     * 查看岗位详细信息
     * 
     * @since 2011-4-18
     * @author yong.geng
     * @return
     */
    public String detail()
    {
        jobsDTO = jobsWebService.getJobById(id);
        return "jobsdetail";
    }

    /**
     * 
     * 弹出承诺书页面
     * 
     * @since 2011-4-18
     * @author yong.geng
     * @return
     */
    public String agreeCommitment()
    {
        commitmentDTO = jobsWebService.getCommitment();
        jobsId = id;
        return "commitment";
    }

    /**
     * 
     * 填写申请原因
     * 
     * @since 2011-4-18
     * @author yong.geng
     * @return
     */
    public String toApplyReason()
    {
        jobsDTO = jobsWebService.getJobById(id);
        return "applyreason";
    }

    /**
     * 
     * 保存
     * 
     * @since 2011-4-18
     * @author yong.geng
     * @return
     */
    public String save()
    {
        String applyReason = ParamUtils.getParameter(request, "applyReason"); // 申请原因
        String loginName = SpringSecurityUtils.getCurrentUserName();

        jobsWebService.saveStuJobs(loginName, id, applyReason);

        commonPage.setTotalCount(jobsWebService.getAllJobsCount());
        dtoLists = jobsWebService.getAllJobs(commonPage.getPageNo());
        addActionMessage("恭喜您,申请成功");
        return SUCCESS;
    }

    public List<JobsDTO> getDtoLists()
    {
        return dtoLists;
    }

    public cn.loosoft.stuwork.selfhelp.Page getCommonPage()
    {
        return commonPage;
    }

    public JobsDTO getJobsDTO()
    {
        return jobsDTO;
    }

    public long getId()
    {
        return id;
    }

    public void setId(long id)
    {
        this.id = id;
    }

    public CommitmentDTO getCommitmentDTO()
    {
        return commitmentDTO;
    }

    public long getJobsId()
    {
        return jobsId;
    }

    public void setJobsId(long jobsId)
    {
        this.jobsId = jobsId;
    }

}
