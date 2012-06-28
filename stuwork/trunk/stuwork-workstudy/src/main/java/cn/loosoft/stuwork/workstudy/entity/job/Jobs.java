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
package cn.loosoft.stuwork.workstudy.entity.job;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.loosoft.stuwork.common.entity.IdEntity;
import cn.loosoft.stuwork.common.entity.user.SecurityUser;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.company.Company;

/**
 * 
 * 岗位
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-25
 */
@Entity
@Table(name = "stujob_jobs")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Jobs extends IdEntity
{

    private String  postName;    // 岗位名称

    private String  sexLimit;    // 性别限制

    private String  address;     // 地点

    private String  content;     // 勤工内容

    private String  requireMents; //勤工要求

    private Company company;      // 所属单位
    
    private Date    createdate;   // 创建日期

    private Date    pubdate;     // 正式发布日期

    private Date    stopdate;    // 报名截止时间

    private int     reqCount;    // 招聘人数

    private int     exisitCount; // 已招聘人数

    private String  postStatus;  // 招聘状态

    private String  nopassreason; //审核未过原因

    private String  auditStatus; // 审核状态

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

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "companyID")
    public Company getCompany()
    {
        return company;
    }

    public void setCompany(Company company)
    {
        this.company = company;
    }
    
    @Column(name="createdate")
    public Date getCreateDate() {
		return createdate;
	}

	public void setCreateDate(Date createdate) {
		this.createdate = createdate;
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

    public String getNopassreason()
    {
        return nopassreason;
    }

    public void setNopassreason(String nopassreason)
    {
        this.nopassreason = nopassreason;
    }

    @Transient
    public String getAuditDesc()
    {
        if (this.auditStatus.equals(Constant.SHZ))
        {
            return "等待审核";
        }
        if (this.auditStatus.equals(Constant.SHTG))
        {
            return "审核通过";
        }
        if (this.auditStatus.equals(Constant.SHWTG))
        {
            return "审核未通过";
        }
        return "";
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

    @Transient
    public String getSexLimitDesc()
    {
        if (sexLimit.equals(""))
        {
            return sexLimit = " ";
        }
        else
        {
            return sexLimit.equals("m") ? "男" : "女";
        }

    }

    public void setSexLimit(String sexLimit)
    {
        this.sexLimit = sexLimit;
    }

    public String getRequireMents()
    {
        return requireMents;
    }

    public void setRequireMents(String requireMents)
    {
        this.requireMents = requireMents;
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

    public String getAuditStatus()
    {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus)
    {
        this.auditStatus = auditStatus;
    }

    @Transient
    public String getPostStatusDesc()
    {
        if (this.postStatus.equals(Constant.ZPZ))
        {
            return "招聘中";
        }else if (this.postStatus.equals(Constant.ZPTZ))
        {
            return "招聘停止";
        }
        return "";
    }

    /**
     * 是否当前用户的发布的岗位
     * 
     * @return
     */
    @Transient
    public boolean isCurUser()
    {
        SecurityUser user = (SecurityUser) SpringSecurityUtils.getCurrentUser();
        if (user != null
                && user.getDepartName().equals(this.company.getCompanyName()))
        {
            return true;
        }
        return false;
    }

    @Override
    public boolean equals(Object obj)
    {
        if (null == obj || !(obj instanceof Jobs))
        {
            return false;
        }

        Jobs jobs = (Jobs) obj;

        if (jobs.getId().equals(this.id))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
