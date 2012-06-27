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
package cn.loosoft.stuwork.arch.entity.archives;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * stuarchives(学生档案) entity class
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-18
 */
@Entity
@Table(name = "archives")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Archives extends IdEntity
{
    private String stuId;       // 学号

    private String name;        // 姓名

    private String examineeNo;  // 考生号

    private String archivesInfo; // 档案信息

    private Date   storageTime; // 入库时间

    private String storeInfo;   // 库位信息

    private String recipient;   // 接收人

    private String transfer;    // 移交人

    private String reason;      // 入库理由

    private String operater;    // 操作人

    private String status;      // 状态 (入库、调阅、调出)

    private String outRecord;   // 回执录入

    /**
     * @return the outRecord
     */
    public String getOutRecord()
    {
        return outRecord;
    }

    /**
     * @param outRecord
     *            the outRecord to set
     */
    public void setOutRecord(String outRecord)
    {
        this.outRecord = outRecord;
    }

    public String getOperater()
    {
        return operater;
    }

    public void setOperater(String operater)
    {
        this.operater = operater;
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

    public String getStuId()
    {
        return stuId;
    }

    public void setStuId(String stuId)
    {
        this.stuId = stuId;
    }

    public String getArchivesInfo()
    {
        return archivesInfo;
    }

    public void setArchivesInfo(String archivesInfo)
    {
        this.archivesInfo = archivesInfo;
    }

    public String getStoreInfo()
    {
        return storeInfo;
    }

    public void setStoreInfo(String storeInfo)
    {
        this.storeInfo = storeInfo;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Date getStorageTime()
    {
        return storageTime;
    }

    public void setStorageTime(Date storageTime)
    {
        this.storageTime = storageTime;
    }

    public String getReason()
    {
        return reason;
    }

    public void setReason(String reason)
    {
        this.reason = reason;
    }

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    @Transient
    public String getStoreInfoDesc()
    {
        String[] temp = this.storeInfo.split("-");
        String areaText = temp[0];
        String rankText = temp[1];
        String rowText = temp[2];
        String columnText = temp[3];

        String store = areaText + "区-" + rankText + "排-" + rowText + "行-"
                + columnText + "列";

        return store;
    }

}
