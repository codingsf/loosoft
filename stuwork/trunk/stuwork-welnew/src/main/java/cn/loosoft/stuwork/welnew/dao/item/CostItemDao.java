package cn.loosoft.stuwork.welnew.dao.item;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.item.CostItem;

/**
 * 
 * 缴费项目设置DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Component
public class CostItemDao extends HibernateDao<CostItem, Long>
{
    private static final String DELETE_COST        = "delete from CostItem where id in(:ids)";

    private static final String UPDATE_COST        = "update CostItem set give=false where id in(:ids)";

    private static final String SELECT_COST        = "from  CostItem where give=true";

    private static final String SELECT_RETURN_COST = "from CostItem where give=true and returned=true";

    private static final String SELECT_MUST_COST   = "from CostItem where need = ?";

    private static final String SELECT_MUST_PRICE  = "select sum(price) from CostItem where need = ?";

    /**
     * 批量删除缴费明细.
     */
    public void deletes(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_COST, map);
    }

    /**
     * 批量删除发放项目
     */
    public void updateCost(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(UPDATE_COST, map);
    }

    /**
     * 
     * 获取发放项目
     * 
     * @since 2011-1-20
     * @author shanru.wu
     * @return
     */
    public List<CostItem> getExtendItems()
    {
        return super.find(SELECT_COST);
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
        return super.find(SELECT_RETURN_COST);
    }

    /**
     * 
     * 分页获取发放项目
     * 
     * @since 2011-1-20
     * @author shanru.wu
     * @return
     */
    public Page<CostItem> searchExtendItem(Page<CostItem> page)
    {
        return super.findPage(page, SELECT_COST);
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
        return super.countHqlResult(SELECT_COST);
    }

    /**
     * 
     * 获取必缴/选缴项目
     * 
     * @since 2011-9-1
     * @author zzHe
     * @return
     */
    public List<CostItem> getCostItems(boolean need)
    {
        return super.find(SELECT_MUST_COST, need);
    }

    public double getCostPrices(boolean need)
    {
        Query query = super.createQuery(SELECT_MUST_PRICE, need);
        if (query.uniqueResult() == null)
        {
            return 0;
        }
        return ((Double) query.uniqueResult()).doubleValue();
    }
}
