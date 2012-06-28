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

package cn.loosoft.stuwork.backmanage.dao.batch;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.backmanage.entity.batch.Batch;

/**
 * 
 * 批次的泛型DAO.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-2-24
 */
@Component
public class BatchDao extends HibernateDao<Batch, Long>
{
    private static final String DELETE_BATCHS           = "delete from Batch where id in(:ids)";

    private static final String DISABLED_BATCHS         = "update Batch set current=?";

    private static final String SELECT_BATCH            = "from Batch where current=true";

    private static final String SELECT_BATCH_BYID       = "from Batch where id=?";

    private static final String SELECT_BATCH_BYCODITION = "from Batch where year=? and season=?";

    /**
     * 批量删除批次.
     */
    public void deleteBatchs(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_BATCHS, map);
    }

    public Batch getBatch(Long id)
    {
        return super.findUnique(SELECT_BATCH_BYID, id);
    }

    /**
     * 根据批次年份和批次季节取得批次
     * 
     * @since 2011-3-24
     * @author shanru.wu
     * @return
     */
    public Batch getBatchByCondition(String year, String season)
    {
        return super.findUnique(SELECT_BATCH_BYCODITION, year, season);
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

    public Batch getCurrentBatch()
    {
        return super.findUnique(SELECT_BATCH);
    }
}