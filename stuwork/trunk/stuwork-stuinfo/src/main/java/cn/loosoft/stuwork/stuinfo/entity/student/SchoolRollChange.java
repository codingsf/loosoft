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

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * schoolrollchange(学籍异动) entity class
 * 
 * @author fangyong
 * @version 1.0
 * @since 2011-10-19
 */
@Entity
@Table(name = "schoolrollchange")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SchoolRollChange extends IdEntity
{

    private String studentNo;      // 学号

    private String name;           // 姓名

    private String batchname;      // 批次

    private String collegeName;    // 原院系

    private String majorName;      // 原专业

    private String className;      // 原班级

    private String newcollegeName; // 现学院

    private String newmajorName;   // 现专业

    private String newclassName;   // 现班级

    private Date   changeDateTime; // 异动时间

    private String username;       // 操作人

    private String collegeCode;    // 原学院编号

    private String classCode;      // 原班级编号

    private String majorCode;      // 原专业编号

    private String newcollegeCode; // 现学院编号

    private String newclassCode;   // 现班级编号

    private String newmajorCode;   // 现专业编号

    private String operateUsername; // 操作人

    public String getOperateUsername()
    {
        return operateUsername;
    }

    public void setOperateUsername(String operateUsername)
    {
        this.operateUsername = operateUsername;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
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

    public String getNewcollegeCode()
    {
        return newcollegeCode;
    }

    public void setNewcollegeCode(String newcollegeCode)
    {
        this.newcollegeCode = newcollegeCode;
    }

    public String getNewclassCode()
    {
        return newclassCode;
    }

    public void setNewclassCode(String newclassCode)
    {
        this.newclassCode = newclassCode;
    }

    public String getNewmajorCode()
    {
        return newmajorCode;
    }

    public void setNewmajorCode(String newmajorCode)
    {
        this.newmajorCode = newmajorCode;
    }

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

    public String getBatchname()
    {
        return batchname;
    }

    public void setBatchname(String batchname)
    {
        this.batchname = batchname;
    }

    public String getCollegeName()
    {
        return collegeName;
    }

    public void setCollegeName(String collegeName)
    {
        this.collegeName = collegeName;
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

    public String getNewcollegeName()
    {
        return newcollegeName;
    }

    public void setNewcollegeName(String newcollegeName)
    {
        this.newcollegeName = newcollegeName;
    }

    public String getNewmajorName()
    {
        return newmajorName;
    }

    public void setNewmajorName(String newmajorName)
    {
        this.newmajorName = newmajorName;
    }

    public String getNewclassName()
    {
        return newclassName;
    }

    public void setNewclassName(String newclassName)
    {
        this.newclassName = newclassName;
    }

    public Date getChangeDateTime()
    {
        return changeDateTime;
    }

    public void setChangeDateTime(Date changeDateTime)
    {
        this.changeDateTime = changeDateTime;
    }

    public String getUsername()
    {
        return username;
    }

    public void setUsername(String username)
    {
        this.username = username;
    }

}
