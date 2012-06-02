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
package cn.loosoft.data.webservice.api.batch;

import java.util.List;

import javax.jws.WebService;

import cn.loosoft.data.webservice.api.batch.dto.BatchDTO;

/**
 * 批次webservice接口.
 * <p>
 * 使用@WebService将接口中的所有方法输出为Web Service.
 * </p>
 * <p>
 * 可用annotation对设置方法、参数和返回值在WSDL中的定义.
 * </p>
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-21
 */
@WebService
public interface BatchWebService
{
    /**
     * 
     * 取得当前批次
     * 
     * @since 2011-3-21
     * @author shanru.wu
     * @return
     */
    BatchDTO getCurrentBatch();

    /**
     * 
     * 获取所有的批次
     * 
     * @since 2011-3-21
     * @author shanru.wu
     * @return
     */
    List<BatchDTO> getAllBatch();
}
