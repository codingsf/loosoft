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
package cn.loosoft.stuwork.welnew.entity.log;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import cn.loosoft.stuwork.common.entity.IdEntity;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;
import cn.loosoft.stuwork.welnew.entity.student.Student;

/**
 * 
 * 缴费记录设置实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Entity
@Table(name = "wel_paymentlog")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class PaymentLog extends IdEntity
{
    private Student  student;   // 考生号

    private CostItem costItem;  // 缴费项目编号

    private double   payedMoney; // 已缴费金额

    private double   debtMoney; // 缓缴金额

    private Date     payDate;   // 缴费时间

    private boolean  finished;  // 是否缴纳完成

    private boolean  received;  // 是否领取

    private String   remark;    // 备注

    private Date     debtDate;  // 缓缴时间

    private String   operater;  // 操作人

    public double getDebtMoney()
    {
        return debtMoney;
    }

    public void setDebtMoney(double debtMoney)
    {
        this.debtMoney = debtMoney;
    }

    public Date getPayDate()
    {
        return payDate;
    }

    public void setPayDate(Date payDate)
    {
        this.payDate = payDate;
    }

    @Column(name = "isFinished")
    public boolean isFinished()
    {
        return finished;
    }

    public void setFinished(boolean finished)
    {
        this.finished = finished;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public double getPayedMoney()
    {
        return payedMoney;
    }

    public void setPayedMoney(double payedMoney)
    {
        this.payedMoney = payedMoney;
    }

    public Date getDebtDate()
    {
        return debtDate;
    }

    public void setDebtDate(Date debtDate)
    {
        this.debtDate = debtDate;
    }

    public String getOperater()
    {
        return operater;
    }

    public void setOperater(String operater)
    {
        this.operater = operater;
    }

    @Column(name = "isReceived")
    public boolean isReceived()
    {
        return received;
    }

    public void setReceived(boolean received)
    {
        this.received = received;
    }

    @OneToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "examineeNo", referencedColumnName = "examineeNo", unique = true)
    public Student getStudent()
    {
        return student;
    }

    public void setStudent(Student student)
    {
        this.student = student;
    }

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "costItemId")
    public CostItem getCostItem()
    {
        return costItem;
    }

    public void setCostItem(CostItem costItem)
    {
        this.costItem = costItem;
    }

}
