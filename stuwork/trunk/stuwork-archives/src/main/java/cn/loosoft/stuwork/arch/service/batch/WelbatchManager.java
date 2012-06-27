package cn.loosoft.stuwork.arch.service.batch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.arch.dao.batch.WelbatchDao;
import cn.loosoft.stuwork.arch.entity.batch.Welbatch;

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

    // private static Logger logger =
    // LoggerFactory.getLogger(SchareaManager.class);
    private static Welbatch currentBatch = null;

    @Autowired
    private WelbatchDao     welbatchDao;

    /**
     * 
     * 批量删除批次.
     * 
     * @since 2010-8-20
     * @author houbing.qian
     * @param ids
     */
    public void deleteBatchs(List<Long> ids)
    {
        welbatchDao.deleteBatchs(ids);
    }

    /**
     * 取得当前学生批次 Description of this Method
     * 
     * @since 2010-8-22
     * @author houbing.qian
     * @return
     */
    public Welbatch getCurrentBatch()
    {
        if (currentBatch != null)
        {
            return currentBatch;
        }
        List<Welbatch> list = welbatchDao.getAll();
        for (Welbatch batch : list)
        {
            if (batch.isCurrent())
            {
                currentBatch = batch;
                return batch;
            }
        }
        return null;
    }

    @Override
    protected HibernateDao<Welbatch, Long> getEntityDao()
    {
        return welbatchDao;
    }
}
