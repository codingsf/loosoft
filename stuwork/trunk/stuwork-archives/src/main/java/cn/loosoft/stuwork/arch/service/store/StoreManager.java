//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: Administrator
//
//-------------------------------------------------------------------------
// LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
// THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
// LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
// MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
// THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
// CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
// PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
// NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
// SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
// SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
// PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
// SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
// HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------
package cn.loosoft.stuwork.arch.service.store;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.arch.dao.store.StoreDao;
import cn.loosoft.stuwork.arch.entity.store.Store;

/**
 * 
 * 档案柜管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class StoreManager extends EntityManager<Store, Long>
{

    private StoreDao storeDao;

    /**
     * 批量删除档案柜.
     */
    public void deletes(List<Long> ids)
    {
        storeDao.deletes(ids);
    }

    /**
     * 根据区域排查找档案柜.
     */
    public Store findRank(String area, int rank)
    {
        return storeDao.findRank(area, rank);
    }

    @Override
    public List<Store> getAll()
    {

        return storeDao.getAllArea();
    }

    /**
     * 根据区域排行查找档案柜.
     */
    public List<Store> getAll(String area, int rank, int row)
    {
        return storeDao.getAll(area, rank, row);
    }

    @Autowired
    public void setStoreDao(StoreDao storeDao)
    {
        this.storeDao = storeDao;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.service.EntityManager#getEntityDao()
     */
    @Override
    protected HibernateDao<Store, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return storeDao;
    }

}
