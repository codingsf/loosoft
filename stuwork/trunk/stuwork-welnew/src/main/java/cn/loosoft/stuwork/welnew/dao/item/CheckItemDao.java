package cn.loosoft.stuwork.welnew.dao.item;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.item.CheckItem;

/**
 * 
 * 审查项目设置DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Component
public class CheckItemDao extends HibernateDao<CheckItem, Long>
{
    private static final String DELETE_STUDENT   = "delete from CheckItem where id in(:ids)";

    private static final String SELECT_CHECKITEM = "from CheckItem where id in(:ids)";

    /**
     * 批量删除审查项目设置
     */
    public void deletes(List<Long> ids)
    {

        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_STUDENT, map);
    }

    public List<CheckItem> getCheckItemByIds(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        return super.find(SELECT_CHECKITEM, map);
    }
}
