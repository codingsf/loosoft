package cn.loosoft.stuwork.welnew.service.bankRecord;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.bankRecord.BankRecordDao;
import cn.loosoft.stuwork.welnew.entity.bankRecord.BankRecord;

/**
 * 
 * 缴费明细的管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class BankRecordManager extends EntityManager<BankRecord, Long>
{
    @Autowired
    private BankRecordDao dao;

    /**
     * 根据条件查询银行记录
     * 
     * @param page
     * @param flag
     * @return
     */
    public Page<BankRecord> search(Page<BankRecord> page, BankRecord bankRecord)
    {
        return dao.search(page, bankRecord);
    }

    /**
     * 保存/修改银行数据
     * 
     * @param bankRecord
     */
    public void saveBankRecord(BankRecord bankRecord)
    {
        dao.save(bankRecord);
    }

    @Override
    protected HibernateDao<BankRecord, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return dao;
    }
}
