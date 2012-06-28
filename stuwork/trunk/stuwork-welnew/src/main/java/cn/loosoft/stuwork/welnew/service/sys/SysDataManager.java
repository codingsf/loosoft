package cn.loosoft.stuwork.welnew.service.sys;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.sys.SysDataDao;
import cn.loosoft.stuwork.welnew.entity.sys.SysData;

/**
 * 
 * 基础数据管理类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-26
 */
@Component
public class SysDataManager extends EntityManager<SysData, Long>
{

    private SysDataDao sysDataDao;

    /**
     * 批量删除新闻
     * 
     * @param ids
     */
    public void deleteSysData(List<Long> ids)
    {
        sysDataDao.deletes(ids);
    }

    /**
     * 根据类型查询
     * 
     * @param ids
     */
    public Page<SysData> search(Page<SysData> page, String type)
    {
        return sysDataDao.search(page, type);
    }

    /**
     * 
     * 根据类型查询
     * 
     * @since 2010-12-12
     * @author jie.yang
     * @param type
     *            类型
     * @return SysData
     */
    public SysData getSysData(String type)
    {
        return sysDataDao.findUniqueBy("type", type);
    }

    @Override
    protected HibernateDao<SysData, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return sysDataDao;
    }

    @Autowired
    public void setSysDataDao(SysDataDao sysDataDao)
    {
        this.sysDataDao = sysDataDao;
    }

}
