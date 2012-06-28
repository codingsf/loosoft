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
package cn.loosoft.stuwork.welnew.service.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.log.ExtendLogDao;
import cn.loosoft.stuwork.welnew.entity.log.ExtendLog;

/**
 * 
 * 发放记录的管理类.
 * 
 * @author shanru.wu
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class ExtendLogManager extends EntityManager<ExtendLog, Long>
{
    ExtendLogDao extendLogDao;

    /**
     * 
     * 根据考生号以及发放项目编号查询
     * 
     * @since 2010-1-21
     * @author shanru.wu
     * @param studentNo
     * @param extendItemId
     * @return
     */
    public ExtendLog getExtendLog(String examineeNo, int extendItemId)
    {
        return extendLogDao.getExtendLog(examineeNo, extendItemId);
    }

    /**
     * 
     * 根据考生号以及发放项目编号删除
     * 
     * @since 2010-1-24
     * @author shanru.wu
     * @param studentNo
     * @param extendItemId
     * @return
     */
    public void deleteExtendLog(String examineeNo, int extendItemId)
    {
        extendLogDao.deleteExtendLog(examineeNo, extendItemId);
    }

    @Override
    protected HibernateDao<ExtendLog, Long> getEntityDao()
    {
        return extendLogDao;
    }

    @Autowired
    public void setExtendLogDao(ExtendLogDao extendLogDao)
    {
        this.extendLogDao = extendLogDao;
    }

}
