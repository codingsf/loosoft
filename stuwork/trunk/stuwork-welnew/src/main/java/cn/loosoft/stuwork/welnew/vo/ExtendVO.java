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

/**
 * 发放VO
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-1-20
 */
public class ExtendVO
{
    private Long    id;          // 发放项目编号

    private String  project;     // 发放项目

    private double  price;       // 费用标准

    private double  payedMoney;  // 已缴金额

    private double  debtMoney;   // 缓交金额

    private boolean received;    // 是否领取

    private double  unPayedMoney; // 欠费金额

    public ExtendVO(){


    }

    public ExtendVO(Long id ,String project,boolean received){
        this.id =id;
        this.project=project;
        this.received=received;
    }

    public double getUnPayedMoney()
    {
        return unPayedMoney;
    }

    public void setUnPayedMoney(double unPayedMoney)
    {
        this.unPayedMoney = unPayedMoney;
    }

    public String getProject()
    {
        return project;
    }

    public void setProject(String project)
    {
        this.project = project;
    }

    public double getPrice()
    {
        return price;
    }

    public void setPrice(double price)
    {
        this.price = price;
    }

    public double getPayedMoney()
    {
        return payedMoney;
    }

    public void setPayedMoney(double payedMoney)
    {
        this.payedMoney = payedMoney;
    }

    public double getDebtMoney()
    {
        return debtMoney;
    }

    public void setDebtMoney(double debtMoney)
    {
        this.debtMoney = debtMoney;
    }

    public boolean isReceived()
    {
        return received;
    }

    public void setReceived(boolean received)
    {
        this.received = received;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

}
