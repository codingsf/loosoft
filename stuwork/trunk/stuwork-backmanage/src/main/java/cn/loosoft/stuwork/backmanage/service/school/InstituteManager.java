package cn.loosoft.stuwork.backmanage.service.school;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.backmanage.dao.school.InstituteDao;
import cn.loosoft.stuwork.backmanage.entity.school.Institute;

/**
 * 学院实体的管理类.
 * 
 * @author houbing.qian
 */
//Spring Bean的标识.
@Component
//默认将类中的所有函数纳入事务管理.
@Transactional
public class InstituteManager extends EntityManager<Institute, Long> {

    //private static Logger logger = LoggerFactory.getLogger(SchareaManager.class);

    @Autowired
    private InstituteDao instituteDao;

    @Override
    protected HibernateDao<Institute, Long> getEntityDao() {
        return instituteDao;
    }

    /**
     * 
     * 批量删除学院
     * @since  2010-8-20
     * @author houbing.qian
     * @param ids
     */
    public void deleteInstitutes(List<Long> ids) {
        instituteDao.deleteInstitutes(ids);   
    }
    
    /**
     * 
     * 根据学院代码获取学院对象
     * @since  2010-8-20
     * @author houbing.qian
     * @param ids
     */
    public Institute getByCode(String code){
        if(code == null)
        {
            return null;
        }
        List<Institute> Institutes = this.getAll();
        for(Institute institute:Institutes){
            if(institute.getCode().equals(code))
            {
                return institute;
            }
        }
        return null;
    }
}
