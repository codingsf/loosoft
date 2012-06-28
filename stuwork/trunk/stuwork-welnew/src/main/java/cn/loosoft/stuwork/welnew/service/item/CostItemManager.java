package cn.loosoft.stuwork.welnew.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.item.CostItemDao;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;

/**
 * 
 * 缴费项目设置管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class CostItemManager extends EntityManager<CostItem, Long>
{

    private CostItemDao costItemDao;

    /**
     * 批量删除缴费明细
     * 
     * @param ids
     */
    public void deleteCost(List<Long> ids)
    {
        costItemDao.deletes(ids);
    }

    /**
     * 分页获取发放项目
     */
    public Page<CostItem> searchExtendItem(Page<CostItem> page)
    {
        return costItemDao.searchExtendItem(page);
    }

    /**
     * 获取发放项目，和缴费项目用同一个实体
     */
    public List<CostItem> getExtendItems()
    {
        return costItemDao.getExtendItems();
    }

    /**
     * 判断缴费项目是否已存在
     */
    public boolean isCostItemUnique(String newValue, String oldValue)
    {
        return costItemDao.isPropertyUnique("project", newValue, oldValue);
    }

    /**
     * 获取退还项目
     * 
     * @since 2011-1-24
     * @author shanru.wu
     * @return
     */
    public List<CostItem> getReturnItems()
    {
        return costItemDao.getReturnItems();
    }

    /**
     * 批量更新缴费明细
     * 
     * @param ids
     */
    public void updateCost(List<Long> ids)
    {
        costItemDao.updateCost(ids);
    }

    /**
     * 
     * 获取发放项目数量
     * 
     * @since 2011-1-20
     * @author shanru.wu
     * @return
     */
    public long countExtendItems()
    {
        return costItemDao.countExtendItems();
    }

    /**
     * 
     * 获取必缴项目
     * 
     * @since 2011-9-1
     * @author zzHe
     * @return
     */
    public List<CostItem> getCostItems(boolean need)
    {
        return costItemDao.getCostItems(need);
    }

    /**
     * 
     * 获取必缴/选缴项目
     * 
     * @since 2011-9-1
     * @author zzHe
     * @return
     */
    public double getCostPrices(boolean need)
    {
        return costItemDao.getCostPrices(need);
    }

    @Autowired
    public void setCostItemDao(CostItemDao costItemDao)
    {
        this.costItemDao = costItemDao;
    }

    @Override
    protected HibernateDao<CostItem, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return costItemDao;
    }
}
