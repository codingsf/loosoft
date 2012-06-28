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
package cn.loosoft.stuwork.workstudysite.web.news;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springside.modules.orm.Page;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudysite.Constant;
import cn.loosoft.stuwork.workstudysite.entity.news.News;
import cn.loosoft.stuwork.workstudysite.service.news.NewsManager;

/**
 * 
 * 新闻查询Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-13
 */
@Namespace("/news")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "news.action", type = "redirect"),
        @Result(name = "newsdetail", location = "news-detail.jsp") })
public class NewsAction extends CrudActionSupport<News>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private NewsManager       newsManager;

    private List<News>        news;

    private Long              id;

    private News              entity;

    private Page<News>        page             = new Page<News>(
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
            page.setOrderBy("pubdate");
            page.setOrder(Page.DESC);
        }
        page = newsManager.search(page);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = newsManager.get(id);
        }
        else
        {
            entity = new News();
        }
    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public String detail()
    {
        this.entity = newsManager.get(id);
        this.entity.setClickscount(this.entity.getClickscount()+1);
        newsManager.save(entity);
        return "newsdetail";
    }

    // -- ModelDriven 与 Preparable函数 --//
    public News getModel()
    {
        return entity;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public News getEntity()
    {
        return entity;
    }

    public void setEntity(News entity)
    {
        this.entity = entity;
    }

    public void setNewsManager(NewsManager newsManager)
    {
        this.newsManager = newsManager;
    }

    public void setNews(List<News> news)
    {
        this.news = news;
    }

    public List<News> getNews()
    {
        return news;
    }

    /**
     * list页面分页显示所有新闻类型列表.
     */
    public Page<News> getPage()
    {
        return page;
    }

    public void setPage(Page<News> page)
    {
        this.page = page;
    }

}
