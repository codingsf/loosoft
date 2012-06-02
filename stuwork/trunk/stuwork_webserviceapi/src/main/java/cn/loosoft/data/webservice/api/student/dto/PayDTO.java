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
package cn.loosoft.data.webservice.api.student.dto;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * Web Service传输pay学生缴费信息的DTO.
 * 
 * @author shanru.wu
 * @since 2011-4-27
 * @version 1.0
 * 
 *          分离entity类与web service接口间的耦合，隔绝entity类的修改对接口的影响. 使用JAXB
 *          2.0的annotation标注JAVA-XML映射，尽量使用默认约定.
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Pay")
public class PayDTO
{
    private String  type;      // 费用类别

    private double  money;     // 费用标准

    private boolean cost;      // 是否缴费

    private double  debtMoney; // 缓缴金额

    private double  payedMoney; // 已缴金额

    public PayDTO()
    {
    }

    public PayDTO(String type, double money, boolean cost, double debtMoney,
            double payedMoney)
    {
        this.type = type;
        this.money = money;
        this.cost = cost;
        this.debtMoney = debtMoney;
        this.payedMoney = payedMoney;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public double getMoney()
    {
        return money;
    }

    public void setMoney(double money)
    {
        this.money = money;
    }

    public boolean isCost()
    {
        return cost;
    }

    public void setCost(boolean cost)
    {
        this.cost = cost;
    }

    public double getDebtMoney()
    {
        return debtMoney;
    }

    public void setDebtMoney(double debtMoney)
    {
        this.debtMoney = debtMoney;
    }

    public double getPayedMoney()
    {
        return payedMoney;
    }

    public void setPayedMoney(double payedMoney)
    {
        this.payedMoney = payedMoney;
    }
}
