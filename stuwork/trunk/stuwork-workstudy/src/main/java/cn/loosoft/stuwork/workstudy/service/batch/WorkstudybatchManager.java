package cn.loosoft.stuwork.workstudy.service.batch;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.workstudy.dao.batch.WorkstudybatchDao;
import cn.loosoft.stuwork.workstudy.entity.batch.Workstudybatch;

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
public class WorkstudybatchManager extends EntityManager<Workstudybatch, Long>
{

    // private static Logger logger =
    // LoggerFactory.getLogger(SchareaManager.class);
    private static Long       currentBatchId = null;

    @Autowired
    private WorkstudybatchDao workstudybatchDao;

    @Override
    protected HibernateDao<Workstudybatch, Long> getEntityDao()
    {
        return workstudybatchDao;
    }

    /**
     * 
     * 保存批次，并将原来的当前批次取消
     * 
     * @since 2011-2-24
     * @author shanru.wu
     * @param stubatch
     * @param oStubatch
     */
    public void save(Workstudybatch workstudyBatch,
            Workstudybatch oWorkstudybatch)
    {
        if (workstudyBatch.isCurrent())
        {
            if (oWorkstudybatch != null)
            {
                // 将原来的当前批次置为false
                oWorkstudybatch.setCurrent(false);
                workstudybatchDao.save(oWorkstudybatch);
            }
        }
        else
        {
            if (this.getAll().isEmpty())
            {
                workstudyBatch.setCurrent(true);
            }
        }
        //
        workstudybatchDao.save(workstudyBatch);
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
        workstudybatchDao.deleteBatchs(ids);
    }

    /**
     * 取得当前学生批次
     * 
     * @since 2011-2-24
     * @author shanru.wu
     * @return
     */
    public Workstudybatch getCurrentBatch()
    {
        if (currentBatchId != null)
        {
            return this.get(currentBatchId);
        }
        List<Workstudybatch> list = workstudybatchDao.getAll();
        for (Workstudybatch batch : list)
        {
            if (batch.isCurrent())
            {
                currentBatchId = batch.getId();
                return batch;
            }
        }
        return null;
    }

    /**
     * 
     * 获得当前学生批次所在的时间段
     * 
     * @since 2011-2-24
     * @author shanru.wu
     * @return
     */
    public List<Date> getTrainingRank()
    {
        Workstudybatch batch = this.getCurrentBatch();
        List<Date> dates = new ArrayList<Date>();
        for (Date d = batch.getStartdate(); d.before(batch.getEnddate()); d = new Date(
                d.getTime() + 1000 * 60 * 60 * 24))
        {
            dates.add(d);
        }
        dates.add(batch.getEnddate());
        return dates;
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
        workstudybatchDao.setCurrent(false);
    }
}
