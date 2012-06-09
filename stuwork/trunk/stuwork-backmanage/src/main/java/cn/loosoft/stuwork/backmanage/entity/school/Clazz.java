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
package cn.loosoft.stuwork.backmanage.entity.school;

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

import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * class(班级) entity class
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-21
 */
@Entity
@Table(name = "bm_class")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Clazz extends IdEntity
{
    private String    code;         // 班级代码

    private String    name;         // 班级名称

    private String    year;         // 所属入学年份

    private String    season;       // 所属入学季节

    private String    leader;       // 辅导员

    private String    leaderTelnum; // 辅导员电话

    private String    room;         // 班级教室

    private Specialty specialty;    // 所在专业

    private String    type;         // 班级类别 统招，定向，专升本

    private String    teacher;      // 班主任

    private String    teacherTelnum; // 班主任电话

    @Column(nullable = false, unique = true)
    public String getCode()
    {
        return code;
    }

    public void setCode(String code)
    {
        this.code = code;
    }

    @Column(nullable = false)
    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    @Column(nullable = false)
    public String getYear()
    {
        return year;
    }

    public void setYear(String year)
    {
        this.year = year;
    }

    @Column(nullable = false)
    public String getSeason()
    {
        return season;
    }

    public void setSeason(String season)
    {
        this.season = season;
    }

    public String getLeader()
    {
        return leader;
    }

    public void setLeader(String leader)
    {
        this.leader = leader;
    }

    @Column(name = "leader_telnum")
    public String getLeaderTelnum()
    {
        return leaderTelnum;
    }

    public void setLeaderTelnum(String leaderTelnum)
    {
        this.leaderTelnum = leaderTelnum;
    }

    public String getRoom()
    {
        return room;
    }

    public void setRoom(String room)
    {
        this.room = room;
    }

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "specialtyID")
    public Specialty getSpecialty()
    {
        return specialty;
    }

    public void setSpecialty(Specialty specialty)
    {
        this.specialty = specialty;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getTeacher()
    {
        return teacher;
    }

    public void setTeacher(String teacher)
    {
        this.teacher = teacher;
    }

    @Column(name = "teacher_telnum")
    public String getTeacherTelnum()
    {
        return teacherTelnum;
    }

    @Transient
    public String getTypeDesc()
    {
        return StudentType.getDesc(this.type);
    }

    public void setTeacherTelnum(String teacherTelnum)
    {
        this.teacherTelnum = teacherTelnum;
    }

}
