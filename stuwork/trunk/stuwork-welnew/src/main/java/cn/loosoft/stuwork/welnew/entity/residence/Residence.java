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
package cn.loosoft.stuwork.welnew.entity.residence;

import java.util.Date;

import javax.persistence.CascadeType;
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
import cn.loosoft.stuwork.welnew.entity.student.Student;

/**
 * 
 * Residence(学生户籍迁移信息) entity class
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-20
 */
@Entity
@Table(name = "wel_residence")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Residence extends IdEntity
{
    private Student student;     //迁移的学生

    private String idCardNo;     //身份证号号

    private String migrateNo;    //迁移证号

    private String origAddress;  //原户籍所在地

    private String curAddress;   //现户籍所在地

    private Date migrateDate;    //迁移日期

    private String classCode;    //班级代码

    private String majorCode;    //专业代码

    private String departCode;   //系代码

    private String collegeCode;  //学院代码

    private Welbatch welbatch;   //入学批次

    private String   collegeName;      //所在学院名称

    private String   departName;       //所在系名称

    private String   majorName;        //专业名称

    private String   className;        //班级名称

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "studentID")
    public Student getStudent()
    {
        return student;
    }
    public void setStudent(Student student)
    {
        this.student = student;
    }
    public String getIdCardNo()
    {
        return idCardNo;
    }
    public void setIdCardNo(String idCardNo)
    {
        this.idCardNo = idCardNo;
    }
    public String getMigrateNo()
    {
        return migrateNo;
    }
    public void setMigrateNo(String migrateNo)
    {
        this.migrateNo = migrateNo;
    }
    public String getOrigAddress()
    {
        return origAddress;
    }
    public void setOrigAddress(String origAddress)
    {
        this.origAddress = origAddress;
    }
    public String getCurAddress()
    {
        return curAddress;
    }
    public void setCurAddress(String curAddress)
    {
        this.curAddress = curAddress;
    }
    public Date getMigrateDate()
    {
        return migrateDate;
    }
    public void setMigrateDate(Date migrateDate)
    {
        this.migrateDate = migrateDate;
    }
    public String getClassCode()
    {
        return classCode;
    }
    public void setClassCode(String classCode)
    {
        this.classCode = classCode;
    }
    public String getMajorCode()
    {
        return majorCode;
    }
    public void setMajorCode(String majorCode)
    {
        this.majorCode = majorCode;
    }
    public String getDepartCode()
    {
        return departCode;
    }
    public void setDepartCode(String departCode)
    {
        this.departCode = departCode;
    }
    public String getCollegeCode()
    {
        return collegeCode;
    }
    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }
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
    public String getCollegeName()
    {
        return collegeName;
    }
    public void setCollegeName(String collegeName)
    {
        this.collegeName = collegeName;
    }
    public String getDepartName()
    {
        return departName;
    }
    public void setDepartName(String departName)
    {
        this.departName = departName;
    }
    public String getMajorName()
    {
        return majorName;
    }
    public void setMajorName(String majorName)
    {
        this.majorName = majorName;
    }
    public String getClassName()
    {
        return className;
    }
    public void setClassName(String className)
    {
        this.className = className;
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
        return this.getCollegeName()==null?"":this.getCollegeName()+this.getDepartName()==null?"":this.getDepartName();
    }
}
