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

import java.util.Date;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * Web Service传输Archives学生档案信息的DTO.
 * 
 * @author shanru.wu
 * @since 2011-4-17
 * @version 1.0
 * 
 *          分离entity类与web service接口间的耦合，隔绝entity类的修改对接口的影响. 使用JAXB
 *          2.0的annotation标注JAVA-XML映射，尽量使用默认约定.
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Archives")
public class ArchivesDTO
{
    public ArchivesDTO()
    {

    }

    public ArchivesDTO(String stuId, String name, String examineeNo,
            String archivesInfo, Date storageTime, String storeInfo,
            String recipient, String transfer, String reason, String operater,
            String status)
    {
        this.stuId = stuId;
        this.name = name;
        this.examineeNo = examineeNo;
        this.archivesInfo = archivesInfo;
        this.storageTime = storageTime;
        this.storeInfo = storeInfo;
        this.recipient = recipient;
        this.transfer = transfer;
        this.reason = reason;
        this.operater = operater;
        this.status = status;
    }

    /**
     * 学号
     */
    private String stuId;

    /**
     * 姓名
     */
    private String name;

    /**
     * 考生号
     */
    private String examineeNo;

    /**
     * 档案信息
     */
    private String archivesInfo;

    /**
     * 入库时间
     */
    private Date   storageTime;

    /**
     * 库位信息
     */
    private String storeInfo;

    /**
     * 接收人
     */
    private String recipient;

    /**
     * 移交人
     */
    private String transfer;

    /**
     * 入库理由
     */
    private String reason;

    /**
     * 操作人
     */
    private String operater;

    /**
     * 状态(在库、调阅、调出、缺档)
     */
    private String status;

    private String lendOrganization; // 调阅组织

    private Date   lendDate;        // 调阅时间

    private Date   lendPlanDate;    // 计划归还时间

    private Date   lendReturnDate;  // 实际归还时间

    private String lendFileName;    // 扫描文件名

    private String outOrganization; // 调出单位

    private Date   outDate;         // 调出时间

    private String outFileName;     // 调出扫描件

    private String outLocation;     // 调出函位置

    private String outType;         // 调档方式

    private String outIsbn;         // 调档存根

    private String outAddress;      // 调出地址

    private String lendOperater;    // 经办人

    private String lendRemark;      // 备注

    private String outOperater;     // 经办人

    private String outRemark;       // 备注

    private Date   returnDate;      // 备注

    public String getStuId()
    {
        return stuId;
    }

    public void setStuId(String stuId)
    {
        this.stuId = stuId;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public String getArchivesInfo()
    {
        return archivesInfo;
    }

    public void setArchivesInfo(String archivesInfo)
    {
        this.archivesInfo = archivesInfo;
    }

    public Date getStorageTime()
    {
        return storageTime;
    }

    public void setStorageTime(Date storageTime)
    {
        this.storageTime = storageTime;
    }

    public String getStoreInfo()
    {
        return storeInfo;
    }

    public void setStoreInfo(String storeInfo)
    {
        this.storeInfo = storeInfo;
    }

    public String getRecipient()
    {
        return recipient;
    }

    public void setRecipient(String recipient)
    {
        this.recipient = recipient;
    }

    public String getTransfer()
    {
        return transfer;
    }

    public void setTransfer(String transfer)
    {
        this.transfer = transfer;
    }

    public String getReason()
    {
        return reason;
    }

    public void setReason(String reason)
    {
        this.reason = reason;
    }

    public String getOperater()
    {
        return operater;
    }

    public void setOperater(String operater)
    {
        this.operater = operater;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getLendOrganization()
    {
        return lendOrganization;
    }

    public void setLendOrganization(String lendOrganization)
    {
        this.lendOrganization = lendOrganization;
    }

    public Date getLendDate()
    {
        return lendDate;
    }

    public void setLendDate(Date lendDate)
    {
        this.lendDate = lendDate;
    }

    public Date getLendPlanDate()
    {
        return lendPlanDate;
    }

    public void setLendPlanDate(Date lendPlanDate)
    {
        this.lendPlanDate = lendPlanDate;
    }

    public Date getLendReturnDate()
    {
        return lendReturnDate;
    }

    public void setLendReturnDate(Date lendReturnDate)
    {
        this.lendReturnDate = lendReturnDate;
    }

    public String getLendFileName()
    {
        return lendFileName;
    }

    public void setLendFileName(String lendFileName)
    {
        this.lendFileName = lendFileName;
    }

    public String getOutOrganization()
    {
        return outOrganization;
    }

    public void setOutOrganization(String outOrganization)
    {
        this.outOrganization = outOrganization;
    }

    public Date getOutDate()
    {
        return outDate;
    }

    public void setOutDate(Date outDate)
    {
        this.outDate = outDate;
    }

    public String getOutFileName()
    {
        return outFileName;
    }

    public void setOutFileName(String outFileName)
    {
        this.outFileName = outFileName;
    }

    public String getOutLocation()
    {
        return outLocation;
    }

    public void setOutLocation(String outLocation)
    {
        this.outLocation = outLocation;
    }

    public String getOutType()
    {
        return outType;
    }

    public void setOutType(String outType)
    {
        this.outType = outType;
    }

    public String getOutIsbn()
    {
        return outIsbn;
    }

    public void setOutIsbn(String outIsbn)
    {
        this.outIsbn = outIsbn;
    }

    public String getOutAddress()
    {
        return outAddress;
    }

    public void setOutAddress(String outAddress)
    {
        this.outAddress = outAddress;
    }

    public String getLendOperater()
    {
        return lendOperater;
    }

    public void setLendOperater(String lendOperater)
    {
        this.lendOperater = lendOperater;
    }

    public String getLendRemark()
    {
        return lendRemark;
    }

    public void setLendRemark(String lendRemark)
    {
        this.lendRemark = lendRemark;
    }

    public String getOutOperater()
    {
        return outOperater;
    }

    public void setOutOperater(String outOperater)
    {
        this.outOperater = outOperater;
    }

    public String getOutRemark()
    {
        return outRemark;
    }

    public void setOutRemark(String outRemark)
    {
        this.outRemark = outRemark;
    }

    public Date getReturnDate()
    {
        return returnDate;
    }

    public void setReturnDate(Date returnDate)
    {
        this.returnDate = returnDate;
    }
}