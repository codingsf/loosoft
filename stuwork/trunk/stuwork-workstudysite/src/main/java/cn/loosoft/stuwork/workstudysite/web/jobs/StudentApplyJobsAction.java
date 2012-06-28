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
package cn.loosoft.stuwork.workstudysite.web.jobs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.data.webservice.api.user.dto.UserDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudysite.Constant;
import cn.loosoft.stuwork.workstudysite.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudysite.service.account.AccountManager;
import cn.loosoft.stuwork.workstudysite.service.job.StudentjobsManager;

/**
 * 
 * 学生申请岗位Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-13
 */
@Namespace("/jobs")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "student-apply-jobs.action", type = "redirect"),
        @Result(name = "applydetail", location = "student-apply-detail.jsp") })
public class StudentApplyJobsAction extends CrudActionSupport<Object>
{

    /**
     * serialVersionUID long
     */
    private static final long  serialVersionUID = 1L;

    private StudentjobsManager studentjobsManager;

    private AccountManager     accountManager;

    private List<StudentJobs>  studentJobs;

    private Page<StudentJobs>  page             = new Page<StudentJobs>(
                                                        Constant.PAGE_SIZE);

    private Long               id;

    private StudentJobs        entity;

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        HttpServletRequest request = Struts2Utils.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);

        UserDTO userDTO = accountManager.getUserDTO(SpringSecurityUtils
                .getCurrentUserName());
        // 如果是空，说明不是勤工系统的用户
        if (userDTO != null)
        {
            if (userDTO.getLoginName() != null)
            {
                String examineeNo = userDTO.getLoginName();
                filters.add(new PropertyFilter("EQS_studentNo", examineeNo));
            }
        }
        page = studentjobsManager.search(page, filters);
        return SUCCESS;
    }

    public String detail()
    {
        this.entity = studentjobsManager.get(id);
        return "applydetail";
    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    public void setId(Long id)
    {
        this.id = id;
    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public Object getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    public List<StudentJobs> getStudentJobs()
    {
        return studentJobs;
    }

    public void setStudentJobs(List<StudentJobs> studentJobs)
    {
        this.studentJobs = studentJobs;
    }

    public Page<StudentJobs> getPage()
    {
        return page;
    }

    public void setPage(Page<StudentJobs> page)
    {
        this.page = page;
    }

    public StudentJobs getEntity()
    {
        return entity;
    }

    public void setEntity(StudentJobs entity)
    {
        this.entity = entity;
    }

    @Autowired
    public void setStudentjobsManager(StudentjobsManager studentjobsManager)
    {
        this.studentjobsManager = studentjobsManager;
    }

    @Autowired
    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }

}
