//-------------------------------------------------------------------------
// Copyright (c) 2009-2012 Loosoft. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Loosoft
//
// Original author: houbing.qian
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

package cn.loosoft.stuwork.welnew.dao.batch;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;

/**
 * 
 * 批次的泛型DAO.
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-19
 */
@Component
public class WelbatchDao extends HibernateDao<Welbatch, Long>
{
    private static final String DELETE_BATCHS      = "delete from Welbatch where id in(:ids)";

    private static final String DISABLED_BATCHS    = "update Welbatch set current=?";

    private static final String SELECT_BATCHS      = "from Welbatch where current=true";

    private static final String SELECT_BATCHS_BYID = "from Welbatch where id=?";

    /**
     * 批量删除批次.
     */
    public void deleteBatchs(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_BATCHS, map);
    }

    public Welbatch getBatch(Long id)
    {
        return super.findUnique(SELECT_BATCHS_BYID, id);
    }

    /**
     * 
     * 设置所有记录是否当前状态
     * 
     * @since 2010-8-28
     * @author shanru.wu
     * @param isCurrent
     */
    public void setCurrent(boolean current)
    {
        batchExecute(DISABLED_BATCHS, current);
    }

    public Welbatch getCurrentBatch()
    {
        return super.findUnique(SELECT_BATCHS);
    }
}
