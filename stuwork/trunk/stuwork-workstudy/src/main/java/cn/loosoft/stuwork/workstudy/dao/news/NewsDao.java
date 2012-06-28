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
package cn.loosoft.stuwork.workstudy.dao.news;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.workstudy.entity.news.News;
import cn.loosoft.stuwork.workstudy.util.JdbcUtil;

/**
 * 
 * 新闻的泛型DAO.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-25
 */
@Component
public class NewsDao extends HibernateDao<News, Long>
{
    private static final String DELETE_SCHAREAS = "delete from News where id in(:ids)";

    private static final String QUERYNEWSBY_ID  = "from News where id=?";

    /**
     * 批量删除新闻.
     */
    public void deletes(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_SCHAREAS, map);

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
        return super.findUnique(QUERYNEWSBY_ID, id);
    }

    /**
     * 得到所有新闻信息,并分页 Description of this Method
     * 
     * @since 2011-4-18
     * @author bing.hu
     * @param pageNo
     * @return
     */
    public List<News> getAllNews(int pageNo)
    {
        String sql = "select * from stujob_news  order by pubdate desc limit " + ((pageNo * 20) - 20)
                + "," + 20;
        List<News> list = new ArrayList<News>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try
        {
            conn = JdbcUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {
                News news = new News();
                news.setId(rs.getLong("id"));
                news.setTitle(rs.getString("title"));
                news.setContent(rs.getString("content"));
                news.setPubuser(rs.getString("pubuser"));
                news.setPubdate(rs.getDate("pubdate"));
                news.setClickscount(rs.getInt("clickscount"));
                list.add(news);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            JdbcUtil.release(rs, stmt, conn);
        }

        return list;

    }
}
