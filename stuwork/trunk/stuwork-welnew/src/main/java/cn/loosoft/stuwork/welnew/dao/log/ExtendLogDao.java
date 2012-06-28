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

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.log.ExtendLog;

/**
 * 
 * 发放记录DAO.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-1-21
 */
@Component
public class ExtendLogDao extends HibernateDao<ExtendLog, Long>
{
    private static final String EXTENDLOG_QUERY      = "from ExtendLog where examineeNo=? and extendItemId=?";

    private static final String EXTENDLOG_DELETE     = "delete from ExtendLog where examineeNo=? and extendItemId=?";

    // 根据批次和项目编号查询当前批次下的项目已发人数
    private static final String COUNTMUSTGIVE        = "select count(*) from ExtendLog where examineeNo in (select examineeNo from Student where welbatch=?) and extendItemId=?";

    // 根据批次和项目编号查询当前批次下的项目已发人数
    private static final String COUNTCOLLEGEMUSTGIVE = "select count(*) from ExtendLog where examineeNo in (select examineeNo from Student where collegeName=? and welbatch=?) and extendItemId=?";

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
        return super.findUnique(EXTENDLOG_QUERY, examineeNo, extendItemId);
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
        batchExecute(EXTENDLOG_DELETE, examineeNo, extendItemId);
    }

    /**
     * 
     * 根据批次和项目编号查询当前批次下的项目已发人数
     * 
     * @since 2011-9-1
     * @author fangyong
     * @param welbatch
     * @param costItemId
     * @return
     */
    public long countAlreadyGive(Welbatch welbatch, String collegeName,
            Long costItemId)
    {
        if (StringUtils.isBlank(collegeName))
        {

            return super.countHqlResult(COUNTMUSTGIVE, welbatch, costItemId);
        }
        else
        {
            return super.countHqlResult(COUNTCOLLEGEMUSTGIVE, collegeName,
                    welbatch, costItemId);
        }
    }
}
