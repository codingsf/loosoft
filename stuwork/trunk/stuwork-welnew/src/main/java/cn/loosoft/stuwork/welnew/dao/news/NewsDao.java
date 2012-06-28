package cn.loosoft.stuwork.welnew.dao.news;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.news.News;

/**
 * 
 * 迎新辞管理DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-26
 */
@Component
public class NewsDao extends HibernateDao<News, Long>
{
    private static final String DELETE_RESIDENCES = "delete from News where id in(:ids)";
    /**
     * 批量删除户籍登记.
     */
    public void deletes(List<Long> ids) {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_RESIDENCES, map);
    }
}
