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
package cn.loosoft.stuwork.workstudy.service.news;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.workstudy.dao.news.NewsDao;
import cn.loosoft.stuwork.workstudy.entity.news.News;

/**
 * 
 * 新闻管理类.
 * 
 * @author bing.hu
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class NewsManager extends EntityManager<News, Long>
{

    NewsDao newsDao;

    @Override
    protected HibernateDao<News, Long> getEntityDao()
    {
        return newsDao;
    }

    /**
     * 
     * 批量删除新闻.
     * 
     * @since 2011-2-25
     * @author bing.hu
     * @param ids
     */
    public void deletes(List<Long> ids)
    {
        newsDao.deletes(ids);
    }

    /**
     * 
     * 根据ID查询新闻(用于提供webservice通过ID查询新闻)
     * 
     * 
     * @since 2011-3-13
     * @author shanru.wu
     * @param id
     * @return
     */
    public News getNews(Long id)
    {
        return newsDao.getNews(id);
    }

    public List<News> getAllNews(int pageNo)
    {
        return newsDao.getAllNews(pageNo);
    }

    @Autowired
    public void setNewsDao(NewsDao newsDao)
    {
        this.newsDao = newsDao;
    }

}
