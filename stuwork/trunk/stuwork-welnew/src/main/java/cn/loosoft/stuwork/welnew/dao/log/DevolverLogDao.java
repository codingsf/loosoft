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
package cn.loosoft.stuwork.welnew.dao.log;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.log.DevolverLog;

/**
 * 
 * 转移记录管理DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-12-2
 */
@Component
public class DevolverLogDao extends HibernateDao<DevolverLog, Long>
{
    private static final String COUNTQX      = "select count(*) ,i.name  from DevolverLog  l , DevolveItem i  where l.devolverId =  i.id  and l.studentNo  in (select examineeNo  from Student s where s.welbatch = ?)  group by l.devolverId ";

    private static final String COUNTCOLLEGE = "select count(*) ,i.name  from DevolverLog  l , DevolveItem i  where l.devolverId =  i.id  and l.studentNo  in (select examineeNo  from Student s where s.welbatch = ? and s.collegeName = ?)  group by l.devolverId ";

    /**
     * 
     * 根据学号查询所有转移记录
     * 
     * @since 2010-12-29
     * @author jie.yang
     * @param studentNo
     * @return
     */
    public DevolverLog getStudentLog(String studentNo, int devolverId)
    {
        String hql = "from DevolverLog where studentNo='" + studentNo
                + "' and devolverId=" + devolverId;
        if (super.find(hql).size() > 0)
        {
            return (DevolverLog) super.find(hql).get(0);
        }
        else
        {
            return null;
        }
    }

    /**
     * 
     * 按转移项目统计
     * 
     * @since 2011-9-2
     * @author qingang
     * @param welbatch
     *            批次
     * @return
     */
    public List getCountQX(Welbatch welbatch)
    {
        return super.createQuery(COUNTQX, welbatch).list();
    }

    /**
     * 
     * 按转移项目和学院统计
     * 
     * @since 2011-9-2
     * @author qingang
     * @param welbatch
     * @param collegeName
     * @return
     */
    public List getCountByCollege(Welbatch welbatch, String collegeName)
    {
        return super.createQuery(COUNTCOLLEGE, welbatch, collegeName).list();
    }

}
