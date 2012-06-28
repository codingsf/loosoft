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
package cn.loosoft.stuwork.selfhelp.web.news;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import cn.loosoft.data.webservice.api.news.NewsWebService;
import cn.loosoft.data.webservice.api.news.dto.NewsDTO;
import cn.loosoft.springside.web.CrudActionSupport;

/**
 * 
 * 新闻管理Action
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-4-15
 */
@Namespace("/news")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "news.action", type = "redirect"),
        @Result(name = "detail", location = "news-detail.jsp") })
public class NewsAction extends CrudActionSupport<NewsDTO>
{
    /**
     * serialVersionUID long
     */
    private static final long                      serialVersionUID = 1L;

    private NewsWebService                         newsWebService;

    // -- 页面属性 --//

    private Long                                   id;

    private NewsDTO                                entity;

    private List<NewsDTO>                          dtoLists;

    private final cn.loosoft.stuwork.selfhelp.Page commonPage       = new cn.loosoft.stuwork.selfhelp.Page();

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        commonPage.setTotalCount(newsWebService.getAllNewsCount());
        dtoLists = newsWebService.getAllNews(commonPage.getPageNo());
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public String detail()
    {
        this.entity = newsWebService.get(id);
        // 每次访问都会加1次访问次数
        entity.setClickscount(newsWebService.get(id).getClickscount() + 1);
        newsWebService.save(entity);
        return "detail";

    }

    public NewsDTO getModel()
    {
        // TODO Auto-generated method stub
        return entity;
    }

    @Autowired
    public void setNewsWebService(NewsWebService newsWebService)
    {
        this.newsWebService = newsWebService;
    }

    public List<NewsDTO> getDtoLists()
    {
        return dtoLists;
    }

    public NewsDTO getEntity()
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

    public cn.loosoft.stuwork.selfhelp.Page getCommonPage()
    {
        return commonPage;
    }

}
