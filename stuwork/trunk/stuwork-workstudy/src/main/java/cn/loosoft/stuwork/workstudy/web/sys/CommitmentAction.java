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
package cn.loosoft.stuwork.workstudy.web.sys;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.sys.Commitment;
import cn.loosoft.stuwork.workstudy.service.sys.CommitmentManager;

/**
 * 
 * 承诺书管理Action.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-3-27
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "commitment.action", type = "redirect") })
public class CommitmentAction extends CrudActionSupport<Commitment>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private CommitmentManager commitmentManager;

    // -- 页面属性 --//
    private Long              id;

    private Commitment        entity;

    private Page<Commitment>  page             = new Page<Commitment>(
                                                       Constant.PAGE_SIZE);

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
            page.setOrderBy("name");
            page.setOrder(Page.DESC);
        }
        page = commitmentManager.search(page);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = commitmentManager.get(id);
        }
        else
        {
            entity = new Commitment();
        }
    }

    @Override
    public String save() throws Exception
    {
        commitmentManager.save(entity);
        addActionMessage("保存承诺书成功");
        return RELOAD;
    }

    public Commitment getModel()
    {
        return entity;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Commitment getEntity()
    {
        return entity;
    }

    public void setEntity(Commitment entity)
    {
        this.entity = entity;
    }

    @Autowired
    public void setCommitmentManager(CommitmentManager commitmentManager)
    {
        this.commitmentManager = commitmentManager;
    }

    /**
     * list页面分页显示所有新闻类型列表.
     */
    public Page<Commitment> getPage()
    {
        return page;
    }

}
