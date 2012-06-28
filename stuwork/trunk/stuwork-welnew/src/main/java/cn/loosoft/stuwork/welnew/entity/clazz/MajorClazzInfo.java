//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Loosoft. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Loosoft
//
// Original author: houbing.qian
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
package cn.loosoft.stuwork.welnew.entity.clazz;

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

import cn.loosoft.stuwork.common.entity.IdEntity;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;

/**
 * 
 * 专业分班信息实体
 *
 * @author            houbing.qian
 * @author            shanru.wu
 * @version           1.0
 * @since             2010-8-25
 */
@Entity
@Table(name = "wel_majorclazzinfo")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class MajorClazzInfo extends IdEntity {

    private Welbatch welbatch;         //入学批次

    private String   collegeCode;      // 录取学院代码

    private String   collegeName;      //所在学院名称

    private String   majorCode;        // 录取专业代码

    private String   majorName;        //专业名

    private String   departCode;       // 录取系代码

    private String   departName;       //所在系名称

    private String type;               //专业学生类别 统招，定向，专升本

    private boolean assigned;          //是否分班

    private Date assignDate;           //分班日期 


    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "welbatchID")
    public Welbatch getWelbatch()
    {
        return welbatch;
    }

    public void setWelbatch(Welbatch welbatch)
    {
        this.welbatch = welbatch;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public String getCollegeName()
    {
        return collegeName;
    }

    public void setCollegeName(String collegeName)
    {
        this.collegeName = collegeName;
    }

    public String getMajorCode()
    {
        return majorCode;
    }

    public void setMajorCode(String majorCode)
    {
        this.majorCode = majorCode;
    }

    public String getMajorName()
    {
        return majorName;
    }

    public void setMajorName(String majorName)
    {
        this.majorName = majorName;
    }

    public String getDepartCode()
    {
        return departCode;
    }

    public void setDepartCode(String departCode)
    {
        this.departCode = departCode;
    }

    public String getDepartName()
    {
        return departName;
    }

    public void setDepartName(String departName)
    {
        this.departName = departName;
    }

    @Column(name="isAssigned")
    public boolean isAssigned()
    {
        return assigned;
    }

    public void setAssigned(boolean assigned)
    {
        this.assigned = assigned;
    }

    public Date getAssignDate()
    {
        return assignDate;
    }

    public void setAssignDate(Date assignDate)
    {
        this.assignDate = assignDate;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    /**
     * 
     * 组合院系的名称
     * @since  2010-8-23
     * @author houbing.qian
     * @return
     */
    @Transient
    public String getColdepartdesc(){
        return (this.getCollegeName()==null?"":this.getCollegeName())+(this.getDepartName()==null?"":this.getDepartName());
    }
}
