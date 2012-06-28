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

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.date.DateUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.sys.NewsType;
import cn.loosoft.stuwork.workstudy.service.sys.NewsTypeManager;

/**
 * 
 * 新闻类型管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-2-15
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "news-type.action", type = "redirect") })
public class NewsTypeAction extends CrudActionSupport<NewsType>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    @Autowired
    private NewsTypeManager   newsTypeManager;

    // -- 页面属性 --//
    private Long              id;

    private NewsType          entity;

    private List<NewsType>    dataList;                                    // 列表页面显示数据

    private Page<NewsType>    page             = new Page<NewsType>(
                                                       Constant.PAGE_SIZE);

    private List<Long>        ids;                                         // 批量id

    // -- ModelDriven 与 Preparable函数 --//
    public NewsType getModel()
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
            entity = newsTypeManager.get(id);
        }
        else
        {
            entity = new NewsType();
        }
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    // -- CRUD Action 函数 --//
    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("time");
            page.setOrder(Page.DESC);
        }
        page = newsTypeManager.search(page);
        return SUCCESS;
    }

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String save() throws Exception
    {

        if (newsTypeManager.isUnique(entity.getType()))
        {
            entity.setOperator(SpringSecurityUtils.getCurrentUserName());
            entity.setTime(DateUtils.getNowTimestamp());
            // 保存用户并放入成功信息.
            newsTypeManager.save(entity);
            addActionMessage("保存新闻类型成功");
        }
        else
        {
            addActionMessage("操作失败,相同新闻类型已存在");
        }

        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        newsTypeManager.delete(id);
        Struts2Utils.renderText("删除新闻类型成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    /**
     * 
     * 删除多笔记录
     * 
     * @since 2011-2-15
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    public String deletes() throws Exception
    {
        if (null != ids && ids.size() > 0)
        {
            newsTypeManager.deletes(ids);
            addActionMessage("批量删除新闻类型成功");
        }
        else
        {
            addActionMessage("没有可删除记录,请勾选");
        }

        return RELOAD;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示所有学区列表.
     */
    public List<NewsType> getDataList()
    {
        return this.dataList;
    }

    /**
     * list页面分页显示所有新闻类型列表.
     */
    public Page<NewsType> getPage()
    {
        return page;
    }

}
