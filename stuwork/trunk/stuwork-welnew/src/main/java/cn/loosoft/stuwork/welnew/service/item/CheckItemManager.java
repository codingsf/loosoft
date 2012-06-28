package cn.loosoft.stuwork.welnew.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.item.CheckItemDao;
import cn.loosoft.stuwork.welnew.entity.item.CheckItem;

/**
 * 
 * 审查项目设置的管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class CheckItemManager extends EntityManager<CheckItem, Long>
{
    private CheckItemDao checkItemDao;

    /**
     * 根据ID删除审查项目设置
     * 
     * @param checkUp
     */
    public void deleteCheckItem(List<Long> ids)
    {
        checkItemDao.deletes(ids);
    }

    public List<CheckItem> getCheckItemByIds(List<Long> ids)
    {
        return checkItemDao.getCheckItemByIds(ids);
    }

    /**
     * 判断审查项目是否已存在
     */
    public boolean isCheckItemUnique(String newValue, String oldValue)
    {
        return checkItemDao.isPropertyUnique("project", newValue, oldValue);
    }

    @Autowired
    public void setCheckItemDao(CheckItemDao checkItemDao)
    {
        this.checkItemDao = checkItemDao;
    }

    @Override
    protected HibernateDao<CheckItem, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return checkItemDao;
    }

}
