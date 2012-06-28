package cn.loosoft.stuwork.welnew.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.item.DevolveItemDao;
import cn.loosoft.stuwork.welnew.entity.item.DevolveItem;

/**
 * 
 * 转移项目设置的管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class DevolveItemManager extends EntityManager<DevolveItem, Long>
{
    private DevolveItemDao devolveItemDao;

    /**
     * 根据ID删除转移项目设置
     * 
     * @param devolveType
     */
    public void deleteDevolveItem(List<Long> ids)
    {
        devolveItemDao.deletes(ids);
    }

    /**
     * 判断转移项目是否已存在
     */
    public boolean isDevolveItemUnique(String newValue, String oldValue)
    {
        return devolveItemDao.isPropertyUnique("name", newValue, oldValue);
    }

    @Autowired
    public void setDevolveItemDao(DevolveItemDao devolveItemDao)
    {
        this.devolveItemDao = devolveItemDao;
    }

    @Override
    protected HibernateDao<DevolveItem, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return devolveItemDao;
    }
}
