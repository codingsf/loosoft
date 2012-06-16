package cn.loosoft.stuwork.leave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;
import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.leave.dao.ManagerDao;
import cn.loosoft.stuwork.leave.entity.Manager;

/**
 * 管理员权限相关的业务类	
 * @author bochins
 * @since 2012-6-9
 */
//表示是一个组件 能被spring 管理 自动织入
@Component
//默认将类中的所有函数纳入事务管理.
@Transactional
public class ManagerService extends EntityManager<Manager, Long>{    
    private ManagerDao managerDao;
    
    @Autowired
    public void setBatchDao(ManagerDao managerDao)
    {
        this.managerDao = managerDao;
    }

    @Override
    protected HibernateDao<Manager, Long> getEntityDao()
    {
        return managerDao;
    }
    
    public Page<Manager> search(Page<Manager> page)
    {
    	
    	return page;
    }
    
}
