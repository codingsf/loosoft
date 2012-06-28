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
package cn.loosoft.stuwork.welnew.entity.welnewlocale;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import cn.loosoft.stuwork.common.entity.IdEntity;
import cn.loosoft.stuwork.welnew.entity.student.Student;

/**
 * 
 * 学院报道实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Entity
@Table(name = "wel_schoolnotice")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SchoolNotice extends IdEntity implements Serializable
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;


    private Student           student;              // 考生

    private String            sex;                  // 性别

    private Date              noticeTime;           // 报到时间

    private String            noticeType;           // 报到类型


    /**
     * @return the noticeTime
     */
    public Date getNoticeTime()
    {
        return noticeTime;
    }

    /**
     * @param noticeTime
     *            the noticeTime to set
     */
    public void setNoticeTime(Date noticeTime)
    {
        this.noticeTime = noticeTime;
    }

    /**
     * @return the noticeType
     */
    public String getNoticeType()
    {
        return noticeType;
    }

    /**
     * @param noticeType
     *            the noticeType to set
     */
    public void setNoticeType(String noticeType)
    {
        this.noticeType = noticeType;
    }

    public String getSex()
    {
        return sex;
    }

    public void setSex(String sex)
    {
        this.sex = sex;
    }

    @Transient
    public String getSexdesc()
    {
        return this.student.getSexdesc();
    }

    @OneToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "examineeNo", referencedColumnName = "examineeNo")
    public Student getStudent()
    {
        return student;
    }

    public void setStudent(Student student)
    {
        this.student = student;
    }

}
