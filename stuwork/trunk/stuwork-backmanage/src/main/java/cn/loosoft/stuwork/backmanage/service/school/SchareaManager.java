package cn.loosoft.stuwork.backmanage.service.school;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.backmanage.dao.school.SchareaDao;
import cn.loosoft.stuwork.backmanage.entity.school.Scharea;

/**
 * 校区实体的管理类.
 * 
 * @author houbing.qian
 */
//Spring Bean的标识.
@Component
//默认将类中的所有函数纳入事务管理.
@Transactional
public class SchareaManager extends EntityManager<Scharea, Long> {

    //private static Logger logger = LoggerFactory.getLogger(SchareaManager.class);

    @Autowired
    private SchareaDao schoolAreaDao;

    @Override
    protected HibernateDao<Scharea, Long> getEntityDao() {
        return schoolAreaDao;
    }

    /**
     * 
     * 批量删除校区
     * @since  2010-8-20
     * @author houbing.qian
     * @param ids
     */
    public void deleteSchareas(List<Long> ids) {
        schoolAreaDao.deleteSchareas(ids);   
    }
}
