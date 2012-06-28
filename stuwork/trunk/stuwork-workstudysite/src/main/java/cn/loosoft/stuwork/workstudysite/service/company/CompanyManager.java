package cn.loosoft.stuwork.workstudysite.service.company;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.workstudysite.dao.company.CompanyDao;
import cn.loosoft.stuwork.workstudysite.entity.company.Company;

/**
 * 
 * 单位管理类.
 * 
 * @author bing.hu
 * @since 2011-2-28
 */

// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class CompanyManager extends EntityManager<Company, Long>
{

    private CompanyDao companyDao;

    @Override
    protected HibernateDao<Company, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return companyDao;
    }

    /**
     * 
     * 批量删除职位.
     * 
     * @since 2011-2-28
     * @author bing.hu
     * @param ids
     */
    public void deletes(List<Long> ids)
    {
        companyDao.deletes(ids);
    }

    public CompanyDao getCompanydao()
    {
        return companyDao;
    }

    @Autowired
    public void setCompanydao(CompanyDao companydao)
    {
        this.companyDao = companydao;
    }

}
