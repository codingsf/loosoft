package cn.loosoft.stuwork.welnew.dao.bankRecord;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.bankRecord.BankRecord;

/**
 * 
 * 银行数据DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-26
 */
@Component
public class BankRecordDao extends HibernateDao<BankRecord, Long>
{

    /**
     * 根据条件查询银行记录
     * 
     * @param page
     * @param flag
     * @return
     */
    public Page<BankRecord> search(Page<BankRecord> page, BankRecord bankRecord)
    {
        StringBuffer hql = new StringBuffer("from BankRecord where 1=1");
        Map<String, Object> values = new HashMap<String, Object>();
        // if (bankRecord.getStudentId() != "")
        // {
        // hql.append(" and studentId='" + bankRecord.getStudentId() + "'");
        // }
        hql.append(" order by ").append(page.getOrderBy()).append(" ").append(
                page.getOrder());
        return super.findPage(page, hql.toString(), values);
    }

}
