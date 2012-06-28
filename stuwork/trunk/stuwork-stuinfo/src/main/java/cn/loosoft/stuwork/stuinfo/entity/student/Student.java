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

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.Degree;
import cn.loosoft.stuwork.common.Education;
import cn.loosoft.stuwork.common.Grade;
import cn.loosoft.stuwork.common.Marriage;
import cn.loosoft.stuwork.common.Nation;
import cn.loosoft.stuwork.common.PoliticsFace;
import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * student(学生) entity class
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-12
 */
@Entity
@Table(name = "student")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Student extends IdEntity
{

    public static final String DEFAULTPWD = "123456";

    private String             studentNo;            // 学号

    private String             name;                 // 姓名

    private String             sex;                  // 性别

    private String             examineeNo;           // 考生号

    private String             pinyin;               // 姓名拼音

    private Date               birthday;             // 出生年月

    private String             former;               // 曾用名

    private String             IDcard;               // 省份证号

    private String             account;              // 入学前户口

    private String             collegeCode;          // 院系代码

    private String             collegeName;          // 院系名称

    private String             majorCode;            // 专业代码

    private String             majorName;            // 专业名称

    private String             classCode;            // 班级代码

    private String             className;            // 班级名称

    private String             roombed;              // 寝室信息

    private String             nation;               // 民族

    private String             birthPlace;           // 籍贯

    private String             politicsFace;         // 政治面貌

    private String             length;               // 学制

    private String             type;                 // 学生类别 统招，定向，专升本

    private String             education;            // 学历

    private String             degree;               // 学位

    private Date               inDate;               // 入学时间

    private Date               finishDate;           // 毕业时间

    private String             hierophant;           // 研究方向导师

    private String             phone;                // 联系电话

    private String             cardNum;              // 一卡通号

    private String             edudirection;         // 教育方向

    private String             testaddr;             // 生源地

    private String             fatherName;           // 父亲姓名

    private String             motherName;           // 母亲姓名

    private String             address;              // 家庭地址

    private String             familyCode;           // 家庭邮编

    private String             homePhone;            // 家庭电话

    private String             blood;                // 血型

    private String             healthInfo;           // 健康状况

    private String             marryInfo;            // 婚姻状况

    private String             psyInfo;              // 心理状况

    private String             country;              // 国别

    private String             religion;             // 宗教信仰

    private String             bankName;             // 银行名称

    private String             bankAccount;          // 银行账户

    private String             onlineWeb;            // 个人主页

    private String             email;                // 邮箱

    private String             specialty;            // 特长

    private String             remarks;              // 备注

    private boolean            autonomy;             // 是否属于港澳台

    private String             period;               // 届数

    private String             graduateSchool;       // 毕业中学

    private boolean            graduated;            // 是否已毕业

    private boolean            inSchool;             // 是否在校

    private String             notSchoolReason;      // 非在校原因

    private boolean            reged;                // 是否注册

    private String             counselor;            // 辅导员

    private String             counselorPhone;       // 辅导员电话

    private String             headTeacher;          // 班主任

    private String             headTeacherPhone;     // 班主任电话

    private boolean            deleted;              // 是否删除

    private String             img;                  // 照片

    private String             year;                 // 批次年份

    private String             season;               // 批次季节

    private String             password;             // 登陆密码

    private int                grade;                // 年级

    public int getGrade()
    {
        return grade;
    }

    public void setGrade(int grade)
    {
        this.grade = grade;
    }

    public String getImg()
    {
        return img;
    }

    public void setImg(String img)
    {
        this.img = img;
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

    public String getSex()
    {
        return sex;
    }

    public void setSex(String sex)
    {
        this.sex = sex;
    }

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public String getPinyin()
    {
        return pinyin;
    }

    public void setPinyin(String pinyin)
    {
        this.pinyin = pinyin;
    }

    public String getFormer()
    {
        return former;
    }

    public void setFormer(String former)
    {
        this.former = former;
    }

    public String getIDcard()
    {
        return IDcard;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

    public String getAccount()
    {
        return account;
    }

    public void setAccount(String account)
    {
        this.account = account;
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

    public String getRoombed()
    {
        return roombed;
    }

    public void setRoombed(String roombed)
    {
        this.roombed = roombed;
    }

    public String getNation()
    {
        return nation;
    }

    public void setNation(String nation)
    {
        this.nation = nation;
    }

    public String getBirthPlace()
    {
        return birthPlace;
    }

    public void setBirthPlace(String birthPlace)
    {
        this.birthPlace = birthPlace;
    }

    public String getPoliticsFace()
    {
        return politicsFace;
    }

    public void setPoliticsFace(String politicsFace)
    {
        this.politicsFace = politicsFace;
    }

    public String getLength()
    {
        return length;
    }

    public void setLength(String length)
    {
        this.length = length;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getEducation()
    {
        return education;
    }

    public void setEducation(String education)
    {
        this.education = education;
    }

    public String getDegree()
    {
        return degree;
    }

    public void setDegree(String degree)
    {
        this.degree = degree;
    }

    public Date getInDate()
    {
        return inDate;
    }

    public void setInDate(Date inDate)
    {
        this.inDate = inDate;
    }

    public Date getFinishDate()
    {
        return finishDate;
    }

    public void setFinishDate(Date finishDate)
    {
        this.finishDate = finishDate;
    }

    public String getHierophant()
    {
        return hierophant;
    }

    public void setHierophant(String hierophant)
    {
        this.hierophant = hierophant;
    }

    public String getPhone()
    {
        return phone;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public String getCardNum()
    {
        return cardNum;
    }

    public void setCardNum(String cardNum)
    {
        this.cardNum = cardNum;
    }

    public String getEdudirection()
    {
        return edudirection;
    }

    public void setEdudirection(String edudirection)
    {
        this.edudirection = edudirection;
    }

    public String getTestaddr()
    {
        return testaddr;
    }

    public void setTestaddr(String testaddr)
    {
        this.testaddr = testaddr;
    }

    public String getFatherName()
    {
        return fatherName;
    }

    public void setFatherName(String fatherName)
    {
        this.fatherName = fatherName;
    }

    public String getMotherName()
    {
        return motherName;
    }

    public void setMotherName(String motherName)
    {
        this.motherName = motherName;
    }

    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public String getFamilyCode()
    {
        return familyCode;
    }

    public void setFamilyCode(String familyCode)
    {
        this.familyCode = familyCode;
    }

    public String getHomePhone()
    {
        return homePhone;
    }

    public void setHomePhone(String homePhone)
    {
        this.homePhone = homePhone;
    }

    public String getBlood()
    {
        return blood;
    }

    public void setBlood(String blood)
    {
        this.blood = blood;
    }

    public String getHealthInfo()
    {
        return healthInfo;
    }

    public void setHealthInfo(String healthInfo)
    {
        this.healthInfo = healthInfo;
    }

    public String getMarryInfo()
    {
        return marryInfo;
    }

    public void setMarryInfo(String marryInfo)
    {
        this.marryInfo = marryInfo;
    }

    public String getPsyInfo()
    {
        return psyInfo;
    }

    public void setPsyInfo(String psyInfo)
    {
        this.psyInfo = psyInfo;
    }

    public String getCountry()
    {
        return country;
    }

    public void setCountry(String country)
    {
        this.country = country;
    }

    public String getReligion()
    {
        return religion;
    }

    public void setReligion(String religion)
    {
        this.religion = religion;
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

    public String getOnlineWeb()
    {
        return onlineWeb;
    }

    public void setOnlineWeb(String onlineWeb)
    {
        this.onlineWeb = onlineWeb;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getSpecialty()
    {
        return specialty;
    }

    public void setSpecialty(String specialty)
    {
        this.specialty = specialty;
    }

    public String getRemarks()
    {
        return remarks;
    }

    public void setRemarks(String remarks)
    {
        this.remarks = remarks;
    }

    @Column(name = "isAutonomy")
    public boolean isAutonomy()
    {
        return autonomy;
    }

    public void setAutonomy(boolean autonomy)
    {
        this.autonomy = autonomy;
    }

    @Transient
    public String getTypeAutonomy()
    {
        return autonomy ? "是" : "否";
    }

    @Transient
    public String getSexDesc()
    {
        return sex.equals("m") ? "男" : "女";
    }

    @Transient
    public String getNationDesc()
    {
        return Nation.getDesc(nation);
    }

    @Transient
    public String getPoliticsFaceDesc()
    {
        return PoliticsFace.getDesc(politicsFace);
    }

    public Date getBirthday()
    {
        return birthday;
    }

    public void setBirthday(Date birthday)
    {
        this.birthday = birthday;
    }

    public String getPeriod()
    {
        return period;
    }

    public void setPeriod(String period)
    {
        this.period = period;
    }

    public String getGraduateSchool()
    {
        return graduateSchool;
    }

    public void setGraduateSchool(String graduateSchool)
    {
        this.graduateSchool = graduateSchool;
    }

    @Column(name = "isGraduated")
    public boolean isGraduated()
    {
        return graduated;
    }

    public void setGraduated(boolean graduated)
    {
        this.graduated = graduated;
    }

    @Column(name = "isInSchool")
    public boolean isInSchool()
    {
        return inSchool;
    }

    public void setInSchool(boolean inSchool)
    {
        this.inSchool = inSchool;
    }

    @Column(name = "isReged")
    public boolean isReged()
    {
        return reged;
    }

    public void setReged(boolean reged)
    {
        this.reged = reged;
    }

    public String getCounselor()
    {
        return counselor;
    }

    public void setCounselor(String counselor)
    {
        this.counselor = counselor;
    }

    public String getCounselorPhone()
    {
        return counselorPhone;
    }

    public void setCounselorPhone(String counselorPhone)
    {
        this.counselorPhone = counselorPhone;
    }

    public String getHeadTeacher()
    {
        return headTeacher;
    }

    public void setHeadTeacher(String headTeacher)
    {
        this.headTeacher = headTeacher;
    }

    public String getHeadTeacherPhone()
    {
        return headTeacherPhone;
    }

    public void setHeadTeacherPhone(String headTeacherPhone)
    {
        this.headTeacherPhone = headTeacherPhone;
    }

    @Column(name = "isDeleted")
    public boolean isDeleted()
    {
        return deleted;
    }

    public void setDeleted(boolean deleted)
    {
        this.deleted = deleted;
    }

    public String getYear()
    {
        return year;
    }

    public void setYear(String year)
    {
        this.year = year;
    }

    public String getSeason()
    {
        return season;
    }

    public void setSeason(String season)
    {
        this.season = season;
    }

    @Transient
    public String getEducationDesc()
    {

        return Education.getDesc(this.education);

    }

    @Transient
    public String getDegreeDesc()
    {

        return Degree.getDesc(this.degree);

    }

    public String getNotSchoolReason()
    {
        return notSchoolReason;
    }

    public void setNotSchoolReason(String notSchoolReason)
    {
        this.notSchoolReason = notSchoolReason;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword(String password)
    {
        this.password = password;
    }

    /**
     * 
     * 取得批次的组合名称奶年度+"-"+季节
     * 
     * @since 2010-8-22
     * @author houbing.qian
     * @return
     */
    @Transient
    public String getComname()
    {
        return this.year + "-" + this.season;
    }

    @Transient
    public String getPhoto()
    {
        return this.year + "/" + this.img;
    }

    @Transient
    // 培养方式说明
    public String getCultureWay()
    {
        return StudentType.getDesc(this.type);
    }

    // 学位
    @Transient
    public String getCulDegree()
    {
        return Degree.getDesc(this.degree);
    }

    @Transient
    // 年级
    public String getCulGrade()
    {
        return Grade.getGrade(this.grade);
    }

    // 婚姻状况
    @Transient
    public String getCulMarriage()
    {
        return Marriage.getDesc(this.marryInfo);
    }

}
