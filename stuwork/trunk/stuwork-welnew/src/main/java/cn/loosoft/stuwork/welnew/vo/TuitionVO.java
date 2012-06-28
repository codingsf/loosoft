//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Loosoft. All Rights Reserved.
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
package cn.loosoft.stuwork.welnew.vo;

import java.io.Serializable;

/**
 * 学生缴费VO
 * 
 * @author zzhe
 * @version 1.0
 * @since 2011-09-01
 */

public class TuitionVO implements Serializable
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 992382978706271488L;

    private String            name;                                  // 学院名称

    private double            mustCostPrices;                        // 应收必缴费用

    private double            selectCostPrices;                      // 应收选缴费用

    private double            realityMustCostPrices;                 // 实收必缴费用

    private double            realityGreenMustCostPrices;            // 实收选缴费用

    private double            realitySelectCostPrices;               // 实收必缴绿色费用

    private double            realityGreenSelectCostPrices;          // 实收选缴绿色费用

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public double getMustCostPrices()
    {
        return mustCostPrices;
    }

    public void setMustCostPrices(double mustCostPrices)
    {
        this.mustCostPrices = mustCostPrices;
    }

    public double getSelectCostPrices()
    {
        return selectCostPrices;
    }

    public void setSelectCostPrices(double selectCostPrices)
    {
        this.selectCostPrices = selectCostPrices;
    }

    public double getRealityMustCostPrices()
    {
        return realityMustCostPrices;
    }

    public void setRealityMustCostPrices(double realityMustCostPrices)
    {
        this.realityMustCostPrices = realityMustCostPrices;
    }

    public double getRealityGreenMustCostPrices()
    {
        return realityGreenMustCostPrices;
    }

    public void setRealityGreenMustCostPrices(double realityGreenMustCostPrices)
    {
        this.realityGreenMustCostPrices = realityGreenMustCostPrices;
    }

    public double getRealitySelectCostPrices()
    {
        return realitySelectCostPrices;
    }

    public void setRealitySelectCostPrices(double realitySelectCostPrices)
    {
        this.realitySelectCostPrices = realitySelectCostPrices;
    }

    public double getRealityGreenSelectCostPrices()
    {
        return realityGreenSelectCostPrices;
    }

    public void setRealityGreenSelectCostPrices(
            double realityGreenSelectCostPrices)
    {
        this.realityGreenSelectCostPrices = realityGreenSelectCostPrices;
    }
}