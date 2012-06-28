package cn.loosoft.stuwork.welnew.dao.item;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.item.DevolveItem;

/**
 * 
 * 转移项目设置DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-26
 */
@Component
public class DevolveItemDao extends HibernateDao<DevolveItem, Long>
{
    private static final String DELETE_STUDENT = "delete from DevolveItem where id in(:ids)";

    /**
     * 批量删除转移项目设置
     */
    public void deletes(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_STUDENT, map);
    }
}
