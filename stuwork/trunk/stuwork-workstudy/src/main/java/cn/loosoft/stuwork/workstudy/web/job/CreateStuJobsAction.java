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

import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.account.User;
import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudy.service.account.AccountManager;
import cn.loosoft.stuwork.workstudy.service.job.StuManager;

@Namespace("/job")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "create-stu-jobs.action", type = "redirect"),
        @Result(name = "createSalary", location = "../salary/create-salary.jsp") })
public class CreateStuJobsAction extends CrudActionSupport<StudentJobs>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private StuManager        stuManager;

    private AccountManager    accountManager;

    private StudentJobs       entity;

    // -- 页面属性 --//
    private Long              id;

    private Page<StudentJobs> page             = new Page<StudentJobs>(
                                                       Constant.PAGE_SIZE);

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("choseDate");
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        // 根据当前登录用户的id，找到其所在单位。
        // filters.add(new PropertyFilter("EQL_company.id", "5"));
        // 只对用工单位确定用工的学生进行工资单的生成

        // 根据当前登录用户的id，找到其所在单位。没有的话，就显示全部
        User user = accountManager.getUser(SpringSecurityUtils
                .getCurrentUserName());
        // 如果是空，说明不是勤工系统的用户
        if (user != null)
        {
            if (user.getCompanyID() != null)
            {
                String compID = user.getCompanyID().toString();
                filters.add(new PropertyFilter("EQL_companyID", compID));
            }
        }
        ParamPropertyUtils.replacePropertyRule(filters);
        filters.add(new PropertyFilter("EQS_chose", "apply"));
        page = stuManager.search(page, filters);
        return "createSalary";
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = stuManager.get(id);
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

    public StudentJobs getEntity()
    {
        return entity;
    }

    public void setEntity(StudentJobs entity)
    {
        this.entity = entity;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public StudentJobs getModel()
    {
        return entity;
    }

    @Autowired
    public void setStuManager(StuManager stuManager)
    {
        this.stuManager = stuManager;
    }

    public Page<StudentJobs> getPage()
    {
        return page;
    }

    public void setPage(Page<StudentJobs> page)
    {
        this.page = page;
    }

    @Autowired
    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }

}
