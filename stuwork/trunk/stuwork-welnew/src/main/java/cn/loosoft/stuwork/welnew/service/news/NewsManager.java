package cn.loosoft.stuwork.welnew.service.news;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.news.NewsDao;
import cn.loosoft.stuwork.welnew.entity.news.News;

/**
 * 
 * 新闻管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class NewsManager extends EntityManager<News, Long>
{
    private NewsDao newsDao;

    /**
     * 批量删除新闻
     * 
     * @param ids
     */
    public void DeleteNews(List<Long> ids)
    {
        newsDao.deletes(ids);
    }

    @Override
    protected HibernateDao<News, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return newsDao;
    }

    @Autowired
    public void setNewsDao(NewsDao newsDao)
    {
        this.newsDao = newsDao;
    }

}
