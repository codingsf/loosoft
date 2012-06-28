package cn.loosoft.stuwork.welnew.service.batch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.batch.WelbatchDao;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;

/**
 * 
 * 批次的管理类.
 * 
 * @author houbing.qian
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class WelbatchManager extends EntityManager<Welbatch, Long>
{

    private WelbatchDao welbatchDao;

    @Override
    protected HibernateDao<Welbatch, Long> getEntityDao()
    {
        return welbatchDao;
    }

    /**
     * 
     * 批量删除批次.
     * 
     * @since 2011-2-24
     * @author shanru.wu
     * @param ids
     */
    public void deleteBatchs(List<Long> ids)
    {
        welbatchDao.deleteBatchs(ids);
    }

    /**
     * 取得当前批次
     * 
     * @since 2011-2-24
     * @author shanru.wu
     * @return
     */
    public Welbatch getCurrentBatch()
    {
        return welbatchDao.getCurrentBatch();
    }

    /**
     * 根据ID取得批次
     * 
     * @since 2011-2-24
     * @author shanru.wu
     * @return
     */
    public Welbatch getBatch(Long id)
    {
        return welbatchDao.getBatch(id);
    }

    /**
     * 
     * 关闭所有记录的当前状态
     * 
     * @since 2011-2-24
     * @author shanru.wu
     */
    public void disabledCurrent()
    {
        welbatchDao.setCurrent(false);
    }

    @Autowired
    public void setBatchDao(WelbatchDao welbatchDao)
    {
        this.welbatchDao = welbatchDao;
    }
}
