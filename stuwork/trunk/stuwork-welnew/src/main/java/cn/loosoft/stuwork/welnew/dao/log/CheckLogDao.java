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

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.log.CheckLog;

import com.google.common.collect.Lists;

/**
 * 
 * 审查记录DAO.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-1-27
 */
@Component
public class CheckLogDao extends HibernateDao<CheckLog, Long>
{
    private static final String CHECKLOG_QUERY  = "from CheckLog where examineeNo=? and checkItemId=?";

    private static final String CHECKLOG_SELECT = "from CheckLog where error=true";

    /**
     * 
     * 根据考生号以及审查项目编号查询
     * 
     * @since 2011-1-21
     * @author shanru.wu
     * @param studentNo
     * @param checkItemId
     * @return
     */
    public CheckLog getCheckLog(String examineeNo, int checkItemId)
    {
        return super.findUnique(CHECKLOG_QUERY, examineeNo, checkItemId);
    }

    /**
     * 
     * 查询审查未通过的审查项目ID
     * 
     * @since 2011-1-21
     * @author shanru.wu
     * @param studentNo
     * @param checkItemId
     * @return
     */
    public List<Long> getNoPassCheckItemIds()
    {
        List<Long> list = Lists.newArrayList();
        List<CheckLog> checkLogs = super.find(CHECKLOG_SELECT);
        if (null != checkLogs)
        {
            for (CheckLog checkLog : checkLogs)
            {
                list.add(Long.parseLong(String.valueOf(checkLog
                        .getCheckItemId())));
            }
        }

        return list;
    }

    public long countNoCheckStudent(String collegeCode, Welbatch welbatch)
    {
        Assert.notNull(welbatch);
        String hql = "";
        if (StringUtils.isEmpty(collegeCode))
        {
            hql = "from Student where welbatch = ? and reged = true and examineeNo not in (select examineeNo from CheckLog )";
            return countHqlResult(hql, welbatch);
        }
        else
        {
            hql = "from Student where collegeCode = ? and welbatch = ? and reged = true and examineeNo not in (select examineeNo from CheckLog )";
            return countHqlResult(hql, collegeCode, welbatch);
        }
    }
}
