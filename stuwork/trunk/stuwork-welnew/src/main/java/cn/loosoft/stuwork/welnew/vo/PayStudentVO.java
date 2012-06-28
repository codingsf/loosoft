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
package cn.loosoft.stuwork.welnew.vo;

import java.util.Date;

/**
 * 
 * 学生缴费VO
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-12-29
 */

public class PayStudentVO
{
    private String  itemId;    // 费用编号

    private String  type;      // 费用类别

    private double  money;     // 费用标准

    private boolean cost;      // 是否缴费

    private double  debtMoney; // 缓缴金额

    private double  payedMoney; // 已缴金额

    private boolean need;      // 是否必缴

    private Date    debtDate;  // 缓缴时间

    /**
     * @return the payedMoney
     */
    public double getPayedMoney()
    {
        return payedMoney;
    }

    /**
     * @param payedMoney
     *            the payedMoney to set
     */
    public void setPayedMoney(double payedMoney)
    {
        this.payedMoney = payedMoney;
    }

    /**
     * @return the itemId
     */
    public String getItemId()
    {
        return itemId;
    }

    /**
     * @param itemId
     *            the itemId to set
     */
    public void setItemId(String itemId)
    {
        this.itemId = itemId;
    }

    /**
     * @return the cost
     */
    public boolean isCost()
    {
        return cost;
    }

    /**
     * @param cost
     *            the cost to set
     */
    public void setCost(boolean cost)
    {
        this.cost = cost;
    }

    /**
     * @return the type
     */
    public String getType()
    {
        return type;
    }

    /**
     * @param type
     *            the type to set
     */
    public void setType(String type)
    {
        this.type = type;
    }

    /**
     * @return the money
     */
    public double getMoney()
    {
        return money;
    }

    /**
     * @param money
     *            the money to set
     */
    public void setMoney(double money)
    {
        this.money = money;
    }

    /**
     * @return the debtMoney
     */
    public double getDebtMoney()
    {
        return debtMoney;
    }

    /**
     * @param debtMoney
     *            the debtMoney to set
     */
    public void setDebtMoney(double debtMoney)
    {
        this.debtMoney = debtMoney;
    }

    public boolean isNeed()
    {
        return need;
    }

    public void setNeed(boolean need)
    {
        this.need = need;
    }

    public Date getDebtDate()
    {
        return debtDate;
    }

    public void setDebtDate(Date debtDate)
    {
        this.debtDate = debtDate;
    }

}
