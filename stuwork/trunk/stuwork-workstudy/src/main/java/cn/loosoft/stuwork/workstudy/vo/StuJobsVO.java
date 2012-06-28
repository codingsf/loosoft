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
package cn.loosoft.stuwork.workstudy.vo;

import java.util.Date;

/**
 * 
 * 学生+岗位VO
 * 
 * @author yonggen
 * @version 1.0
 * @since 2011-2-27
 */
public class StuJobsVO
{

    private String stuId;             // 学号

    private String name;              // 姓名

    private String studentNo;         // 学号
    
    private String examineeNo;        // 考生号    

    private String collegeCode;       // 学院代码

    private String collegeName;       // 学院名称

    private String majorCode;         // 专业代码

    private String majorName;         // 专业名称

    private String classCode;         // 班级代码

    private String className;         // 班级名称

    private String sexdesc;           // 性别

    private Date   birthday;          // 出生年月

    private String nation;            // 籍贯

    private String phone;             // 电话

    private String IDcard;            // 身份证号

    private Date   storageTime;       // 入库时间

    private Date   inDate;            // 入学时间

    private String bankName;          // 银行名称

    private String bankAccount;       // 银行帐号

    // 岗位信息
    private Long   postId;            // 岗位id

    private String postname;          // 岗位名称

    private String sexlimit;          // 性别限制

    private String address;           // 地点

    private String content;           // 勤工内容

    private String requirements;      // 勤工要求

    private Long   companyid;         // 所属单位

    private Date   pubdate;           // 发布时间

    private Date   stopdate;          // 报名截止时间

    private int    reqcount;          // 招聘人数

    private int    exisitcount;       // 已招聘人数

    private String poststatus;        // 招聘状态

    private String auditstatus;       // 审核状态

    // 岗位-学生信息
    private Long   stuJobsId;         // 岗位-学生信息表id

    private String chose;             // 选择状态

    private Long   jobsID;            // 岗位ID

    private Date   replyDate;         // 申请时间

    private String groupstate;        // 小组审核状态

    private String groupnopassreason; // 小组审核未过原因

    private String centerstate;       // 中心审核状态

    private String centernopassreason; // 中心审核未过原因

    // 单位信息

    private String companyName;       // 单位名称

    public String getCompanyName()
    {
        return companyName;
    }

    public void setCompanyName(String companyName)
    {
        this.companyName = companyName;
    }

    public String getChose()
    {
        return chose;
    }

    public void setChose(String chose)
    {
        this.chose = chose;
    }

    public String getPostname()
    {
        return postname;
    }

    public void setPostname(String postname)
    {
        this.postname = postname;
    }

    public String getSexlimit()
    {
        return sexlimit;
    }

    public void setSexlimit(String sexlimit)
    {
        this.sexlimit = sexlimit;
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

    public String getRequirements()
    {
        return requirements;
    }

    public void setRequirements(String requirements)
    {
        this.requirements = requirements;
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

    public int getReqcount()
    {
        return reqcount;
    }

    public void setReqcount(int reqcount)
    {
        this.reqcount = reqcount;
    }

    public int getExisitcount()
    {
        return exisitcount;
    }

    public void setExisitcount(int exisitcount)
    {
        this.exisitcount = exisitcount;
    }

    public String getPoststatus()
    {
        return poststatus;
    }

    public void setPoststatus(String poststatus)
    {
        this.poststatus = poststatus;
    }

    public String getAuditstatus()
    {
        return auditstatus;
    }

    public void setAuditstatus(String auditstatus)
    {

        this.auditstatus = auditstatus;
    }

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

    public String getExamineeNo() {
		return examineeNo;
	}

	public void setExamineeNo(String examineeNo) {
		this.examineeNo = examineeNo;
	}

	public String getStudentNo() {
		return studentNo;
	}

	public void setStudentNo(String studentNo) {
		this.studentNo = studentNo;
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

    public String getSexdesc()
    {
        return sexdesc;
    }

    public void setSexdesc(String sexdesc)
    {
        this.sexdesc = sexdesc;
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

    public void setIDcard(String dcard)
    {
        IDcard = dcard;
    }

    public Date getStorageTime()
    {
        return storageTime;
    }

    public void setStorageTime(Date storageTime)
    {
        this.storageTime = storageTime;
    }

    public Date getInDate()
    {
        return inDate;
    }

    public void setInDate(Date inDate)
    {
        this.inDate = inDate;
    }

    public String getBankName()
    {
        return bankName;
    }

    public void setBankName(String bankName)
    {
        this.bankName = bankName;
    }

    public String getBankAccount()
    {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount)
    {
        this.bankAccount = bankAccount;
    }

    public String getNation()
    {
        return nation;
    }

    public void setNation(String nation)
    {
        this.nation = nation;
    }

    public String getPhone()
    {
        return phone;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public Long getPostId()
    {
        return postId;
    }

    public void setPostId(Long postId)
    {
        this.postId = postId;
    }

    public Long getCompanyid()
    {
        return companyid;
    }

    public void setCompanyid(Long companyid)
    {
        this.companyid = companyid;
    }

    public Long getStuJobsId()
    {
        return stuJobsId;
    }

    public void setStuJobsId(Long stuJobsId)
    {
        this.stuJobsId = stuJobsId;
    }

    public Long getJobsID()
    {
        return jobsID;
    }

    public void setJobsID(Long jobsID)
    {
        this.jobsID = jobsID;
    }

    public Date getReplyDate()
    {
        return replyDate;
    }

    public void setReplyDate(Date replyDate)
    {
        this.replyDate = replyDate;
    }

    public String getCenterstate()
    {
        return centerstate;
    }

    public void setCenterstate(String centerstate)
    {
        this.centerstate = centerstate;
    }

    public String getCenternopassreason()
    {
        return centernopassreason;
    }

    public void setCenternopassreason(String centernopassreason)
    {
        this.centernopassreason = centernopassreason;
    }

    public String getGroupstate()
    {
        return groupstate;
    }

    public void setGroupstate(String groupstate)
    {
        this.groupstate = groupstate;
    }

    public String getGroupnopassreason()
    {
        return groupnopassreason;
    }

    public void setGroupnopassreason(String groupnopassreason)
    {
        this.groupnopassreason = groupnopassreason;
    }

}
