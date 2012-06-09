package cn.loosoft.stuwork.backmanage.service.batch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.backmanage.dao.batch.BatchDao;
import cn.loosoft.stuwork.backmanage.entity.batch.Batch;

/**
 * 
 * 批次的管理类.
 * 
 * @author shanru.wu
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class BatchManager extends EntityManager<Batch, Long>
{

    private BatchDao batchDao;

    @Override
    protected HibernateDao<Batch, Long> getEntityDao()
    {
        return batchDao;
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
        batchDao.deleteBatchs(ids);
    }

    /**
     * 取得当前批次
     * 
     * @since 2011-2-24
     * @author shanru.wu
     * @return
     */
    public Batch getCurrentBatch()
    {

        return batchDao.getCurrentBatch();

    }

    /**
     * 根据ID取得批次
     * 
     * @since 2011-2-24
     * @author shanru.wu
     * @return
     */
    public Batch getBatch(Long id)
    {
        return batchDao.getBatch(id);
    }

    /**
     * 根据批次年份和批次季节取得批次
     * 
     * @since 2011-3-24
     * @author shanru.wu
     * @return
     */
    public Batch getBatchByCondition(String year, String season)
    {
        return batchDao.getBatchByCondition(year, season);
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
        batchDao.setCurrent(false);
    }

    @Autowired
    public void setBatchDao(BatchDao batchDao)
    {
        this.batchDao = batchDao;
    }
}
