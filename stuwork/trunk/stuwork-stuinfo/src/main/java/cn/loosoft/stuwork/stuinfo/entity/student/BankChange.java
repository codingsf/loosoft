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
package cn.loosoft.stuwork.stuinfo.entity.student;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * schoolrollchange(银行账号异动) entity class
 * 
 * @author fangyong
 * @version 1.0
 * @since 2011-10-19
 */
@Entity
@Table(name = "bankchange")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class BankChange extends IdEntity
{

    public static final String DEFAULTPWD = "123456";

    private String             bankName;             // 原银行名称

    private String             bankAcount;           // 原银行账号

    private String             newBankName;          // 新银行名称

    private String             newBankAcount;        // 新银行账号

    private String             operateUsername;      // 操作人

    private Date               operateDateTime;      // 操作时间

    private String             studentNo;            // 学号

    private String             name;                 // 姓名

    private String             batch;                // 批次

    @Column(name = "studentno")
    public String getStudentNo()
    {
        return studentNo;
    }

    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getBatch()
    {
        return batch;
    }

    public void setBatch(String batch)
    {
        this.batch = batch;
    }

    public String getBankName()
    {
        return bankName;
    }

    public void setBankName(String bankName)
    {
        this.bankName = bankName;
    }

    public String getBankAcount()
    {
        return bankAcount;
    }

    public void setBankAcount(String bankAcount)
    {
        this.bankAcount = bankAcount;
    }

    public String getNewBankName()
    {
        return newBankName;
    }

    public void setNewBankName(String newBankName)
    {
        this.newBankName = newBankName;
    }

    public String getNewBankAcount()
    {
        return newBankAcount;
    }

    public void setNewBankAcount(String newBankAcount)
    {
        this.newBankAcount = newBankAcount;
    }

    public String getOperateUsername()
    {
        return operateUsername;
    }

    public void setOperateUsername(String operateUsername)
    {
        this.operateUsername = operateUsername;
    }

    public Date getOperateDateTime()
    {
        return operateDateTime;
    }

    public void setOperateDateTime(Date operateDateTime)
    {
        this.operateDateTime = operateDateTime;
    }

}
