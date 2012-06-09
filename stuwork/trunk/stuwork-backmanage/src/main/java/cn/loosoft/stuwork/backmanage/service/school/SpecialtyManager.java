package cn.loosoft.stuwork.backmanage.service.school;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.backmanage.dao.school.InstituteDao;
import cn.loosoft.stuwork.backmanage.dao.school.SpecialtyDao;
import cn.loosoft.stuwork.backmanage.entity.school.Institute;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;

/**
 * 专业实体的管理类.
 * 
 * @author houbing.qian
 */
//Spring Bean的标识.
@Component
//默认将类中的所有函数纳入事务管理.
@Transactional
public class SpecialtyManager extends EntityManager<Specialty, Long> {

    //private static Logger logger = LoggerFactory.getLogger(SchareaManager.class);

    @Autowired
    private SpecialtyDao specialtyDao;

    @Autowired
    private InstituteDao instituteDao;

    @Override
    protected HibernateDao<Specialty, Long> getEntityDao() {
        return specialtyDao;
    }

    /**
     * 
     * 批量删除系
     * @since  2010-8-20
     * @author houbing.qian
     * @param ids
     */
    public void deleteSpecialtys(List<Long> ids) {
        specialtyDao.deleteSpecialtys(ids);   
    }
    /**
     * 
     * 根据code key取得专业
     * @since  2010-8-21
     * @author houbing.qian
     * @param code
     * @return
     */
    public Specialty getByCode(String code){
        return specialtyDao.getByCode(code);
    }

    /**
     * 
     * 取得系下的专业
     * @since  2010-8-22
     * @author houbing.qian
     * @param collegeCode
     * @return
     */
    public List<Specialty> getSpecialtysByCollege(String collegeCode){
        Institute institute = instituteDao.get(collegeCode);
        return specialtyDao.getSpecialtysByCollege(institute);
    }

    /**
     * 
     * 取得系下的专业
     * @since  2010-8-22
     * @author houbing.qian
     * @param departmentCode
     * @return
     */
    public List<Specialty> getSpecialtysByDepartment(String departmentCode){
        return specialtyDao.getSpecialtysByDepartment(departmentCode);
    }
}
