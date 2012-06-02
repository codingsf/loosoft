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
package cn.loosoft.data.webservice.api.jobs.dto;

import java.util.Date;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * Web Service传输News新闻信息的DTO.
 * 
 * 分离entity类与web service接口间的耦合，隔绝entity类的修改对接口的影响. 使用JAXB
 * 2.0的annotation标注JAVA-XML映射，尽量使用默认约定.
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Jobs")
public class JobsDTO
{
    private long   id;

    private String postName;    // 岗位名称

    private String sexLimit;    // 性别限制

    private String address;     // 地点

    private String content;     // 勤工内容

    private String requireMents; // 勤工要求

    private String companyName; // 所属单位

    private Date   pubdate;     // 发布时间

    private Date   stopdate;    // 报名截止时间

    private int    reqCount;    // 招聘人数

    private int    exisitCount; // 已招聘人数

    private String postStatus;  // 招聘状态

    private String nopassreason; // 审核未过原因

    private String auditStatus; // 审核状态

    public JobsDTO()
    {
    }

    public long getId()
    {
        return id;
    }

    public void setId(long id)
    {
        this.id = id;
    }

    public String getPostName()
    {
        return postName;
    }

    public void setPostName(String postName)
    {
        this.postName = postName;
    }

    public String getSexLimit()
    {
        return sexLimit;
    }

    public void setSexLimit(String sexLimit)
    {
        this.sexLimit = sexLimit;
    }

    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public String getRequireMents()
    {
        return requireMents;
    }

    public void setRequireMents(String requireMents)
    {
        this.requireMents = requireMents;
    }

    public String getCompanyName()
    {
        return companyName;
    }

    public void setCompanyName(String companyName)
    {
        this.companyName = companyName;
    }

    public Date getPubdate()
    {
        return pubdate;
    }

    public void setPubdate(Date pubdate)
    {
        this.pubdate = pubdate;
    }

    public Date getStopdate()
    {
        return stopdate;
    }

    public void setStopdate(Date stopdate)
    {
        this.stopdate = stopdate;
    }

    public int getReqCount()
    {
        return reqCount;
    }

    public void setReqCount(int reqCount)
    {
        this.reqCount = reqCount;
    }

    public int getExisitCount()
    {
        return exisitCount;
    }

    public void setExisitCount(int exisitCount)
    {
        this.exisitCount = exisitCount;
    }

    public String getPostStatus()
    {
        return postStatus;
    }

    public void setPostStatus(String postStatus)
    {
        this.postStatus = postStatus;
    }

    public String getNopassreason()
    {
        return nopassreason;
    }

    public void setNopassreason(String nopassreason)
    {
        this.nopassreason = nopassreason;
    }

    public String getAuditStatus()
    {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus)
    {
        this.auditStatus = auditStatus;
    }

}
