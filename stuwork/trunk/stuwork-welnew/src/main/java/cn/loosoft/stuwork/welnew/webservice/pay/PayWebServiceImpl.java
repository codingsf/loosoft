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
package cn.loosoft.stuwork.welnew.webservice.pay;

import java.util.List;

import javax.jws.WebService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.loosoft.data.webservice.api.student.PayWebService;
import cn.loosoft.data.webservice.api.student.dto.PayDTO;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;
import cn.loosoft.stuwork.welnew.entity.log.PaymentLog;
import cn.loosoft.stuwork.welnew.service.item.CostItemManager;
import cn.loosoft.stuwork.welnew.service.log.PaymentLogManager;

import com.google.common.collect.Lists;

/**
 * 学生缴费的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-4-27
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.student.PayWebService")
public class PayWebServiceImpl implements PayWebService
{

    CostItemManager   costItemManager;  // 缴费项目管理

    PaymentLogManager paymentLogManager; // 缴费记录管理

    public List<PayDTO> getPayInfo(String examineeNo)
    {
        List<PayDTO> payDTOs = Lists.newArrayList();

        if (StringUtils.isEmpty(examineeNo))
        {
            return null;
        }

        List<CostItem> costItems = costItemManager.getAll();
        if (null != costItems && costItems.size() > 0)
        {
            for (CostItem costItem : costItems)
            {
                PayDTO payDTO = new PayDTO();
                payDTO.setType(costItem.getProject());
                payDTO.setMoney(costItem.getPrice());
                PaymentLog paymentLog = paymentLogManager.getPaymentLog(
                        examineeNo, costItem.getId());
                if (null != paymentLog)
                {
                    payDTO.setPayedMoney(paymentLog.getPayedMoney());
                    payDTO.setDebtMoney(paymentLog.getDebtMoney());
                }
                else
                {
                    payDTO.setPayedMoney(0.0);
                    payDTO.setDebtMoney(0.0);
                }
                payDTOs.add(payDTO);
            }
        }
        return payDTOs;
    }

    @Autowired
    public void setCostItemManager(CostItemManager costItemManager)
    {
        this.costItemManager = costItemManager;
    }

    @Autowired
    public void setPaymentLogManager(PaymentLogManager paymentLogManager)
    {
        this.paymentLogManager = paymentLogManager;
    }

}
