package cn.loosoft.stuwork.backmanage.service.school;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.backmanage.dao.school.DepartmentDao;
import cn.loosoft.stuwork.backmanage.dao.school.InstituteDao;
import cn.loosoft.stuwork.backmanage.entity.school.Department;
import cn.loosoft.stuwork.backmanage.entity.school.Institute;

/**
 * 系实体的管理类.
 * 
 * @author houbing.qian
 */
//Spring Bean的标识.
@Component
//默认将类中的所有函数纳入事务管理.
@Transactional
public class DepartmentManager extends EntityManager<Department, Long> {

    //private static Logger logger = LoggerFactory.getLogger(SchareaManager.class);

    @Autowired
    private DepartmentDao departmentDao;
    @Autowired
    private InstituteDao  instituteDao;

    @Override
    protected HibernateDao<Department, Long> getEntityDao() {
        return departmentDao;
    }

    /**
     * 
     * 批量删除系
     * @since  2010-8-20
     * @author houbing.qian
     * @param ids
     */
    public void deleteDepartments(List<Long> ids) {
        departmentDao.deleteDepartments(ids);   
    }

    /**
     * 
     * 根据代码取得系
     * @since  2010-8-22
     * @author houbing.qian
     * @param code
     * @return
     */
    public Department getByCode(String code){
        if(code == null)
        {
            return null;
        }
        List<Department> departments = this.getAll();
        for(Department department:departments){
            if(department.getCode().equals(code))
            {
                return department;
            }
        }
        return null;
    }

    /**
     * 
     * 取得学院下面的系
     * @since  2010-8-22
     * @author houbing.qian
     * @return
     */
    public List<Department> getDepartmentsByInstitute(String instituteCode){
    	Institute institute=instituteDao.findUniqueBy("code", instituteCode);
        return departmentDao.getDepartmentsByInstitute(institute);
    }
}
