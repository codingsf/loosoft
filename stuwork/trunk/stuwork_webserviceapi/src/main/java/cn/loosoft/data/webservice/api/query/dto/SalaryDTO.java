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
package cn.loosoft.data.webservice.api.query.dto;

import java.util.Date;

import javax.persistence.Transient;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * Web Service传输学生工资信息的DTO. Description of the class
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-4-17
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Salary")
public class SalaryDTO
{
    private Long   id;

    private String postName;          // 岗位名称

    private String companyName;       // 单位名称

    private String studentNo;         // 学号

    private String studentName;       // 学生姓名

    private String standard;          // 工资标准

    private Date   workStartTime;     // 工作开始时间

    private Date   workStopTime;      // 工作结束时间

    private Date   createDate;        // 制单日期

    private String workTime;          // 工作时长

    private String amount;            // 金额

    private String groupStatus;       // 小组审核

    private String centerStatus;      // 中心审核

    private String groupNoPassReason; // 小组未通过原因

    private String centerNoPassReason; // 中心未通过原因

    private String comments;          // 单位评价

    private String bankName;          // 银行名称

    private String bankAccount;       // 银行帐号

    private String remark;            // 备注

    public SalaryDTO()
    {

    }

    public SalaryDTO(Long id, String postName, String companyName,
            String studentNo, String studentName, String standard,
            Date workStartTime, Date workStopTime, Date createDate,
            String workTime, String amount, String groupStatus,
            String centerStatus, String groupNoPassReason,
            String centerNoPassReason, String bankName, String bankAccount,
            String comments, String remark)
    {
        this.id = id;
        this.postName = postName;
        this.companyName = companyName;
        this.studentNo = studentNo;
        this.studentName = studentName;
        this.standard = standard;
        this.workStartTime = workStartTime;
        this.workStopTime = workStopTime;
        this.workTime = workTime;
        this.createDate = createDate;
        this.amount = amount;
        this.groupStatus = groupStatus;
        this.centerStatus = centerStatus;
        this.groupNoPassReason = groupNoPassReason;
        this.centerNoPassReason = centerNoPassReason;
        this.bankName = bankName;
        this.bankAccount = bankAccount;
        this.comments = comments;
        this.remark = remark;

    }

    public String getPostName()
    {
        return postName;
    }

    public void setPostName(String postName)
    {
        this.postName = postName;
    }

    public String getCompanyName()
    {
        return companyName;
    }

    public void setCompanyName(String companyName)
    {
        this.companyName = companyName;
    }

    public String getStudentNo() {
		return studentNo;
	}

	public void setStudentNo(String studentNo) {
		this.studentNo = studentNo;
	}

	public String getStudentName()
    {
        return studentName;
    }

    public void setStudentName(String studentName)
    {
        this.studentName = studentName;
    }

    public String getStandard()
    {
        return standard;
    }

    public void setStandard(String standard)
    {
        this.standard = standard;
    }

    public Date getWorkStartTime()
    {
        return workStartTime;
    }

    public void setWorkStartTime(Date workStartTime)
    {
        this.workStartTime = workStartTime;
    }

    public Date getWorkStopTime()
    {
        return workStopTime;
    }

    public void setWorkStopTime(Date workStopTime)
    {
        this.workStopTime = workStopTime;
    }

    public Date getCreateDate()
    {
        return createDate;
    }

    public void setCreateDate(Date createDate)
    {
        this.createDate = createDate;
    }

    public String getWorkTime()
    {
        return workTime;
    }

    public void setWorkTime(String workTime)
    {
        this.workTime = workTime;
    }

    public String getAmount()
    {
        return amount;
    }

    public void setAmount(String amount)
    {
        this.amount = amount;
    }

    public String getGroupStatus()
    {
        return groupStatus;
    }

    public void setGroupStatus(String groupStatus)
    {
        this.groupStatus = groupStatus;
    }

    public String getCenterStatus()
    {
        return centerStatus;
    }

    public void setCenterStatus(String centerStatus)
    {
        this.centerStatus = centerStatus;
    }

    public String getGroupNoPassReason()
    {
        return groupNoPassReason;
    }

    @Transient
    public String getGroupStatusDesc()
    {
        if (this.groupStatus.equals("shz"))
        {
            return "审核中";
        }
        if (this.groupStatus.equals("shtg"))
        {
            return "审核通过";
        }
        if (this.groupStatus.equals("shwtg"))
        {
            return "审核未通过";
        }
        return "";
    }

    @Transient
    public String getCenterStatusDesc()
    {
        if (this.centerStatus.equals("shz"))
        {
            return "审核中";
        }
        if (this.centerStatus.equals("shtg"))
        {
            return "审核通过";
        }
        if (this.centerStatus.equals("shwtg"))
        {
            return "审核未通过";
        }
        return "";
    }

    public void setGroupNoPassReason(String groupNoPassReason)
    {
        this.groupNoPassReason = groupNoPassReason;
    }

    public String getCenterNoPassReason()
    {
        return centerNoPassReason;
    }

    public void setCenterNoPassReason(String centerNoPassReason)
    {
        this.centerNoPassReason = centerNoPassReason;
    }

    public String getComments()
    {
        return comments;
    }

    public void setComments(String comments)
    {
        this.comments = comments;
    }

    public String getBankName()
    {
        return bankName;
    }

    public void setBankName(String bankName)
    {
        this.bankName = bankName;
    }

    public String getBankAccount()
    {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount)
    {
        this.bankAccount = bankAccount;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
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