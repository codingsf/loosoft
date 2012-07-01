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
package cn.loosoft.stuwork.workstudysite.web.query;

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

import cn.common.lib.vo.LabelValue;
import cn.loosoft.data.webservice.api.user.dto.UserDTO;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudysite.Constant;
import cn.loosoft.stuwork.workstudysite.entity.job.Jobs;
import cn.loosoft.stuwork.workstudysite.service.account.AccountManager;
import cn.loosoft.stuwork.workstudysite.service.job.JobsManager;

/**
 * 
 * 岗位查询Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-13
 */
@Namespace("/query")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "jobs-query.action", type = "redirect"),
        @Result(name = "jobsquerydetail", location = "jobs-query-detail.jsp") })
public class JobsQueryAction extends CrudActionSupport<Object>
{

    JobsManager               jobsManager;

    private AccountManager    accountManager;

    private Jobs              entity;

    private Long              id;

    private Page<Jobs>        page             = new Page<Jobs>(
                                                       Constant.PAGE_SIZE);

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

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
            page.setOrderBy("pubdate");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = Struts2Utils.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);

        // 根据当前登录用户的id，找到其所在单位。没有的话，就显示全部
        UserDTO userDTO = accountManager.getUserDTO(SpringSecurityUtils
                .getCurrentUserName());
        // 如果是空，说明不是勤工系统的用户
        if (userDTO != null)
        {
            if (userDTO.getCompanyID() != null)
            {
                String compID = userDTO.getCompanyID().toString();
                filters.add(new PropertyFilter("EQL_company.id", compID));
            }
        }

        ParamPropertyUtils.replacePropertyRule(filters);
        filters.add(new PropertyFilter("EQS_auditStatus", "shtg"));
        page = jobsManager.search(page, filters);
        return SUCCESS;
    }

    public List<LabelValue> getStatusList()
    {

        return Constant.getStatusList();
    }

    public String detail()
    {
        this.entity = jobsManager.get(id);
        return "jobsquerydetail";
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

    @Autowired
    public void setJobsManager(JobsManager jobsManager)
    {
        this.jobsManager = jobsManager;
    }

    public Jobs getEntity()
    {
        return entity;
    }

    public Page<Jobs> getPage()
    {
        return page;
    }

    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }

}