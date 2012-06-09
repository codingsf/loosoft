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
package cn.loosoft.stuwork.backmanage.webservice.batch;

import java.util.List;

import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import cn.loosoft.data.webservice.api.batch.BatchWebService;
import cn.loosoft.data.webservice.api.batch.dto.BatchDTO;
import cn.loosoft.stuwork.backmanage.entity.batch.Batch;
import cn.loosoft.stuwork.backmanage.service.batch.BatchManager;

import com.google.common.collect.Lists;

/**
 * 批次的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-21
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.batch.BatchWebService")
public class BatchWebServiceImpl implements BatchWebService
{
    private BatchManager batchManager;

    /**
     * {@inheritDoc}
     * 
     * @since 2011-3-21
     * @see cn.loosoft.data.webservice.api.batch.BatchWebService#getCurrenBatch
     */
    public BatchDTO getCurrentBatch()
    {

        Batch batch = batchManager.getCurrentBatch();
        return this.convertToDTO(batch);

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-3-21
     * @see cn.loosoft.data.webservice.api.batch.BatchWebService#getAll
     */
    public List<BatchDTO> getAllBatch()
    {
        List<Batch> batchs = batchManager.getAll();
        return this.convertToDTO(batchs);
    }

    /**
     * 
     * 将Batch对象转成BatchDTO对象
     * 
     * @since 2011-3-21
     * @author shanru.wu
     * @param batch
     * @return
     */
    @Transactional(readOnly = true)
    public BatchDTO convertToDTO(Batch batch)
    {
        if (batch == null)
        {
            return null;
        }
        BatchDTO batchDTO = new BatchDTO(batch.getId(), batch.getYear(), batch
                .getSeason(), batch.getStartdate(), batch.getEnddate(), batch
                .isCurrent());
        return batchDTO;
    }

    /**
     * 
     * 将Batchs集合转成BatchDTOs集合
     * 
     * @since 2011-3-21
     * @author shanru.wu
     * @param batch
     * @return
     */
    @Transactional(readOnly = true)
    public List<BatchDTO> convertToDTO(List<Batch> batchs)
    {
        List<BatchDTO> batchDTOs = Lists.newArrayList();
        if (batchs == null)
        {
            return null;
        }
        for (Batch batch : batchs)
        {
            BatchDTO batchDTO = new BatchDTO(batch.getId(), batch.getYear(),
                    batch.getSeason(), batch.getStartdate(),
                    batch.getEnddate(), batch.isCurrent());
            batchDTOs.add(batchDTO);
        }

        return batchDTOs;
    }

    @Autowired
    public void setBatchManager(BatchManager batchManager)
    {
        this.batchManager = batchManager;
    }

}
