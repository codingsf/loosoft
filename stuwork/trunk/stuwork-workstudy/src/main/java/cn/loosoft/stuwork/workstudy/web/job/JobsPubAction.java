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
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.account.User;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;
import cn.loosoft.stuwork.workstudy.service.account.AccountManager;
import cn.loosoft.stuwork.workstudy.service.job.JobsManager;

/**
 * 
 * 岗位发布Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-3
 */
@Namespace("/job")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "jobs-pub.action", type = "redirect"),
        @Result(name = "detail", location = "jobs-pub-detail.jsp"),
        @Result(name = "reason", location = "jobs-pub-reason.jsp") })
public class JobsPubAction extends CrudActionSupport<Jobs>
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private JobsManager       jobsManager;
    @Autowired
    private AccountManager accountManager;
    // -- 页面属性 --//
    private Long              id;

    private Jobs              entity;

    private Page<Jobs>        page             = new Page<Jobs>(
                                                       Constant.PAGE_SIZE);

    // -- ModelDriven 与 Preparable函数 --//
    public Jobs getModel()
    {
        return entity;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = jobsManager.get(id);
        }
        else
        {
            entity = new Jobs();
        }
    }

    // -- CRUD Action 函数 --//
    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("pubdate");
            page.setOrder(Page.DESC);
        }

        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        User user = accountManager.getUser(SpringSecurityUtils.getCurrentUserName());
        if(user!=null){
        	filters.add(new PropertyFilter("LIKES_auditStatus", "tg"));
           	filters.add(new PropertyFilter("EQL_company.id", String.valueOf(user.getCompanyID())));        	
        }
        //
        page = jobsManager.search(page, filters);
        return SUCCESS;
    }

    /**
     * 岗位审核通过
     */
    public String pass()
    {
        this.entity = jobsManager.get(id);
        entity.setAuditStatus(Constant.SHTG);
        jobsManager.save(entity);
        // addActionMessage("通过");
        // 因为直接输出内容而不经过jsp,因此返回null.
        Struts2Utils.renderText("操作成功,岗位已发布");
        return null;
    }

    /**
     * 跳转到填写未过原因页面
     */
    public String toReason()
    {
        return "reason";
    }

    public String detail()
    {
        this.entity = jobsManager.get(id);
        return "detail";
    }

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String save() throws Exception
    {
        entity.setAuditStatus(Constant.SHWTG);
        jobsManager.save(entity);
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        return null;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面分页显示所有新闻类型列表.
     */
    public Page<Jobs> getPage()
    {
        return page;
    }

    public Jobs getEntity()
    {
        return entity;
    }

    // -- 其他 Action 函数--//

    public Long getId()
    {
        return id;
    }

    @Autowired
    public void setJobsManager(JobsManager jobsManager)
    {
        this.jobsManager = jobsManager;
    }

}
