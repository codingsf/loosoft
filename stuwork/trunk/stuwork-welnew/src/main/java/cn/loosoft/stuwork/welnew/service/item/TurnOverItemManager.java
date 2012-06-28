package cn.loosoft.stuwork.welnew.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.item.TurnOverItemDao;
import cn.loosoft.stuwork.welnew.entity.item.TurnOverItem;

/**
 * 
 * 上缴项目设置的管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class TurnOverItemManager extends EntityManager<TurnOverItem, Long>
{

    private TurnOverItemDao turnOverItemDao;

    @Autowired
    public void setTurnOverItemDao(TurnOverItemDao turnOverItemDao)
    {
        this.turnOverItemDao = turnOverItemDao;
    }

    @Override
    protected HibernateDao<TurnOverItem, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return turnOverItemDao;
    }

    /**
     * 
     * 批量删除上缴项目
     * 
     * @since 2010-12-12
     * @author jie.yang
     * @param ids
     */

    public void deleteTurnOverItem(List<Long> ids)
    {
        turnOverItemDao.deletes(ids);
    }

    /**
     * 判断上缴项目是否已存在
     */
    public boolean isTurnOverItemUnique(String newValue, String oldValue)
    {
        return turnOverItemDao.isPropertyUnique("name", newValue, oldValue);
    }

}
