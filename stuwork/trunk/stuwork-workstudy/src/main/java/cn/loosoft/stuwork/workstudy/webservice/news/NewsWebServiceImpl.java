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
package cn.loosoft.stuwork.workstudy.webservice.news;

import java.util.List;

import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.loosoft.data.webservice.api.news.NewsWebService;
import cn.loosoft.data.webservice.api.news.dto.NewsDTO;
import cn.loosoft.stuwork.workstudy.entity.news.News;
import cn.loosoft.stuwork.workstudy.service.news.NewsManager;

import com.google.common.collect.Lists;

/**
 * 
 * 新闻的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-4-15
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.news.NewsWebService")
public class NewsWebServiceImpl implements NewsWebService
{
    @Autowired
    private NewsManager newsManager;

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-15
     * @see cn.loosoft.data.webservice.api.news.NewsWebService#getAllNews()
     */
    public List<NewsDTO> getAllNews(int pageNo)
    {
        List<News> newsList = newsManager.getAllNews(pageNo);
        return this.convertToDTO(newsList);
    }

    /**
     * 把News对象转换成NewsDTO对象 并返回list<NewsDTO>
     * 
     * @since 2011-4-15
     * @author bing.hu
     * @param newsList
     * @return list<NewsDTO>
     */
    public List<NewsDTO> convertToDTO(List<News> newsList)
    {
        NewsDTO newsDTO = null;
        List<NewsDTO> dtoList = Lists.newArrayList();
        for (int i = 0; i < newsList.size(); i++)
        {
            newsDTO = new NewsDTO();
            newsDTO.setId(newsList.get(i).getId());
            newsDTO.setTitle(newsList.get(i).getTitle());
            newsDTO.setContent(newsList.get(i).getContent());
            newsDTO.setPubdate(newsList.get(i).getPubdate());
            newsDTO.setPubuser(newsList.get(i).getPubuser());
            newsDTO.setClickscount(newsList.get(i).getClickscount());
            dtoList.add(newsDTO);
        }
        return dtoList;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-18
     * @see cn.loosoft.data.webservice.api.news.NewsWebService#get(java.lang.Long)
     */
    public NewsDTO get(Long id)
    {
        NewsDTO newsDTO = null;
        if (id != null)
        {
            News news = newsManager.getNews(id);
            if (news != null)
            {
                newsDTO = new NewsDTO(news.getId(), news.getTitle(), news
                        .getContent(), news.getPubdate(), news.getPubuser(),
                        news.getClickscount());
                return newsDTO;
            }
        }

        return newsDTO;
    }

    /**
     * 获取总行数 {@inheritDoc}
     * 
     * @since 2011-4-18
     * @see cn.loosoft.data.webservice.api.news.NewsWebService#getAllNewsCount()
     */
    public int getAllNewsCount()
    {
        // TODO Auto-generated method stub
        return newsManager.getAll().size();
    }

    /**
     * 添加访问次数 {@inheritDoc}
     * 
     * @since 2011-4-18
     * @see cn.loosoft.data.webservice.api.news.NewsWebService#save(cn.loosoft.data.webservice.api.news.dto.NewsDTO)
     */
    public void save(NewsDTO newsDTO)
    {
        News news = newsManager.getNews(newsDTO.getId());
        news.setClickscount(newsDTO.getClickscount());
        newsManager.save(news);
    }
}
