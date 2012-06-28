//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: zzHe
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
package cn.loosoft.stuwork.welnew.web.count;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import cn.loosoft.stuwork.welnew.dao.log.PaymentLogDao;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.item.CostItemManager;
import cn.loosoft.stuwork.welnew.service.log.PaymentLogManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.TuitionVO;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 统计学费Action.
 * 
 * @author zzhe
 * @version 1.0
 * @since 2011-9-1
 */
@Namespace("/count")
public class TuitionAction extends ActionSupport
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    @Autowired
    private CostItemManager   costItemManager;                        // 缴费明细管理

    @Autowired
    private PaymentLogManager paymentLogManager;                      // 缴费记录管理

    @Autowired
    private StudentManager    studentManager;

    @Autowired
    private WelbatchManager   welbatchManager;

    private double            mustCostPrices;                         // 应收必缴费用

    private double            selectCostPrices;                       // 应收选缴费用

    private double            realityMustCostPrices;                  // 实收必缴费用

    private double            realityGreenMustCostPrices;             // 实收选缴费用

    private double            realitySelectCostPrices;                // 实收必缴绿色费用

    private double            realityGreenSelectCostPrices;           // 实收选缴绿色费用

    private List<TuitionVO>   tuitions         = Lists.newArrayList(); // 各学院缴费情况

    /**
     * 统计学费
     * 
     * @since 2011-9-1
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String execute() throws Exception
    {
        Welbatch welbatch = this.welbatchManager.getCurrentBatch();

        long countStudent = studentManager.countStudent(welbatch, true);

        double mustPrices = costItemManager.getCostPrices(true);

        double selectPrices = costItemManager.getCostPrices(false);

        mustCostPrices = countStudent * mustPrices;

        selectCostPrices = countStudent * selectPrices;

        realityMustCostPrices = paymentLogManager.getRealityCostPrices(
                PaymentLogDao.PAYEDMONEY, true, welbatch);

        realityGreenMustCostPrices = paymentLogManager.getRealityCostPrices(
                PaymentLogDao.DEBTMONEY, true, welbatch);

        realitySelectCostPrices = paymentLogManager.getRealityCostPrices(
                PaymentLogDao.PAYEDMONEY, false, welbatch);

        realityGreenSelectCostPrices = paymentLogManager.getRealityCostPrices(
                PaymentLogDao.DEBTMONEY, false, welbatch);

        tuitions = paymentLogManager.getTuitions(welbatch, mustPrices,
                selectPrices);

        return SUCCESS;
    }

    public double getMustCostPrices()
    {
        return mustCostPrices;
    }

    public void setMustCostPrices(double mustCostPrices)
    {
        this.mustCostPrices = mustCostPrices;
    }

    public static long getSerialversionuid()
    {
        return serialVersionUID;
    }

    public double getSelectCostPrices()
    {
        return selectCostPrices;
    }

    public double getRealityMustCostPrices()
    {
        return realityMustCostPrices;
    }

    public double getRealitySelectCostPrices()
    {
        return realitySelectCostPrices;
    }

    public double getRealityGreenMustCostPrices()
    {
        return realityGreenMustCostPrices;
    }

    public double getRealityGreenSelectCostPrices()
    {
        return realityGreenSelectCostPrices;
    }

    public List<TuitionVO> getTuitions()
    {
        return tuitions;
    }
}