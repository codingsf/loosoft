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
package cn.loosoft.stuwork.arch.dao.lendlog;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.arch.entity.lendlog.LendLog;

/**
 * 
 * 档案调阅对象的泛型DAO.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-18
 */
@Component
public class LendLogDao extends HibernateDao<LendLog, Long>
{
    private static final String DELETE_LENDLOG = "delete from LendLog where id in (:ids)";

    private static final String LENDLOG_QUERY  = "from LendLog where stuId=? order by lendDate desc";

    /**
     * 
     * 批量删除调阅信息.
     * 
     * @since 2010-12-21
     * @author shanru.wu
     * @param ids
     */
    public void deletes(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_LENDLOG, map);
    }

    /**
     * 
     * 查询最近一次学生档案的调阅情况.
     * 
     * @since 2010-12-24
     * @author shanru.wu
     * @param stuId
     */
    public LendLog getRecentLendLog(String stuId)
    {
        List<LendLog> lendLogs = super.find(LENDLOG_QUERY, stuId);
        if (null != lendLogs && lendLogs.size() > 0)
        {
            return lendLogs.get(0);
        }
        else
        {
            return null;
        }
    }
}
