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
package cn.loosoft.stuwork.arch.vo;

import java.util.Date;

import javax.persistence.Transient;

/**
 * 学生+档案VO
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-20
 */
public class ArchivesVO
{
    private String stuId;       // 学号

    private String name;        // 姓名

    private String examineeNo;  // 考生号

    private String collegeCode; // 学院代码

    private String collegeName; // 学院名称

    private String majorCode;   // 专业代码

    private String majorName;   // 专业名称

    private String classCode;   // 班级代码

    private String className;   // 班级名称

    private String sex;         // 性别

    private Date   birthday;    // 出生年月

    private String IDcard;      // 省份证号

    private Date   storageTime; // 入库时间

    private Date   inDate;      // 入学时间

    private String archivesInfo; // 档案信息

    private String storeInfo;   // 库位信息

    private String recipient;    // 接收人

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

    private String transfer;   // 移交人

    private String status;    // 档案状态

    private int    ClassCount; // 班级人数

    private int    inNum;     // 学生档案在库人数

    private int    outNum;    // 学生档案调出人数

    private int    noNum;     // 学生档案缺档人数

    private int    lookNum;   // 学生档案调阅人数

    private int    totalNum;  // 总人数

    public int getTotalNum()
    {
        return totalNum;
    }

    public void setTotalNum(int totalNum)
    {
        this.totalNum = totalNum;
    }

    public int getInNum()
    {
        return inNum;
    }

    public void setInNum(int inNum)
    {
        this.inNum = inNum;
    }

    public int getOutNum()
    {
        return outNum;
    }

    public void setOutNum(int outNum)
    {
        this.outNum = outNum;
    }

    public int getNoNum()
    {
        return noNum;
    }

    public void setNoNum(int noNum)
    {
        this.noNum = noNum;
    }

    public int getLookNum()
    {
        return lookNum;
    }

    public void setLookNum(int lookNum)
    {
        this.lookNum = lookNum;
    }

    public int getClassCount()
    {
        return ClassCount;
    }

    public void setClassCount(int classCount)
    {
        ClassCount = classCount;
    }

    public String getStuId()
    {
        return stuId;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
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

    public String getClassCode()
    {
        return classCode;
    }

    public void setClassCode(String classCode)
    {
        this.classCode = classCode;
    }

    public String getClassName()
    {
        return className;
    }

    public void setClassName(String className)
    {
        this.className = className;
    }

    public String getSex()
    {
        return sex;
    }

    public void setSex(String sex)
    {
        this.sex = sex;
    }

    public Date getBirthday()
    {
        return birthday;
    }

    public void setBirthday(Date birthday)
    {
        this.birthday = birthday;
    }

    public String getIDcard()
    {
        return IDcard;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

    public Date getInDate()
    {
        return inDate;
    }

    public void setInDate(Date inDate)
    {
        this.inDate = inDate;
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

    public Date getStorageTime()
    {
        return storageTime;
    }

    public void setStorageTime(Date storageTime)
    {
        this.storageTime = storageTime;
    }

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    @Transient
    public String getSexDesc()
    {
        return sex.equals("f") ? "女" : "男";
    }

}
