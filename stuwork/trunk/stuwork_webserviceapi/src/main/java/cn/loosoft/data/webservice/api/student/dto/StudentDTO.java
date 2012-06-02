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
package cn.loosoft.data.webservice.api.student.dto;

import java.util.Date;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

import cn.loosoft.stuwork.common.Education;
import cn.loosoft.stuwork.common.Grade;
import cn.loosoft.stuwork.common.Marriage;
import cn.loosoft.stuwork.common.Nation;
import cn.loosoft.stuwork.common.PoliticsFace;

/**
 * Web Service传输Student学生信息的DTO.
 * 
 * @author shanru.wu
 * @since 2010-12-12
 * @version 1.0
 * 
 *          分离entity类与web service接口间的耦合，隔绝entity类的修改对接口的影响. 使用JAXB
 *          2.0的annotation标注JAVA-XML映射，尽量使用默认约定.
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Student")
public class StudentDTO
{
    public StudentDTO()
    {
    }

    public StudentDTO(Long id, String studentNo, String name, String sex,
            String examineeNo, String pinyin, String former, String iDcard,
            String account, String collegeCode, String collegeName,
            String majorCode, String majorName, String classCode,
            String className, String roombed, String nation, String birthPlace,
            String politicsFace, String length, String cultureWay,
            String education, String degree, Date inDate, Date finishDate,
            String hierophant, String phone, String cardNum,
            String edudirection, String testaddr, String fatherName,
            String motherName, String address, String familyCode,
            String homePhone, String blood, String healthInfo,
            String marryInfo, String psyInfo, String country, String religion,
            String bankName, String bankAccount, String onlineWeb,
            String email, String specialty, String remarks, boolean autonomy,
            Date birthday, String period, String img, String counselor,
            String counselorPhone, String headTeacher, String headTeacherPhone,
            String year, String season, String graduateSchool, String password,
            String type, boolean graduated, boolean inSchool,
            String notSchoolReason, boolean reged, boolean deleted, int grade)
    {
        this.id = id;
        this.studentNo = studentNo;
        this.name = name;
        this.sex = sex;
        this.examineeNo = examineeNo;
        this.pinyin = pinyin;
        this.former = former;
        this.IDcard = iDcard;
        this.account = account;
        this.collegeCode = collegeCode;
        this.collegeName = collegeName;
        this.majorCode = majorCode;
        this.majorName = majorName;
        this.classCode = classCode;
        this.className = className;
        this.roombed = roombed;
        this.nation = nation;
        this.birthPlace = birthPlace;
        this.politicsFace = politicsFace;
        this.length = length;
        this.cultureWay = cultureWay;
        this.education = education;
        this.degree = degree;
        this.inDate = inDate;
        this.finishDate = finishDate;
        this.hierophant = hierophant;
        this.phone = phone;
        this.cardNum = cardNum;
        this.edudirection = edudirection;
        this.testaddr = testaddr;
        this.fatherName = fatherName;
        this.motherName = motherName;
        this.address = address;
        this.familyCode = familyCode;
        this.homePhone = homePhone;
        this.blood = blood;
        this.healthInfo = healthInfo;
        this.marryInfo = marryInfo;
        this.psyInfo = psyInfo;
        this.country = country;
        this.religion = religion;
        this.bankName = bankName;
        this.bankAccount = bankAccount;
        this.onlineWeb = onlineWeb;
        this.email = email;
        this.specialty = specialty;
        this.remarks = remarks;
        this.autonomy = autonomy;
        this.birthday = birthday;
        this.period = period;
        this.img = img;
        this.counselor = counselor;
        this.counselorPhone = counselorPhone;
        this.headTeacher = headTeacher;
        this.headTeacherPhone = headTeacherPhone;
        this.year = year;
        this.season = season;
        this.graduateSchool = graduateSchool;
        this.password = password;
        this.type = type;
        this.graduated = graduated;
        this.inSchool = inSchool;
        this.notSchoolReason = notSchoolReason;
        this.reged = reged;
        this.deleted = deleted;
        this.grade = grade;
    }

    private Long    id;

    /**
     * 学号
     */
    private String  studentNo;

    /**
     * 姓名
     */
    private String  name;

    /**
     * 出生年月
     */
    private Date    birthday;

    /**
     * 性别
     */
    private String  sex;

    /**
     * 考生号
     */
    private String  examineeNo;

    /**
     * 姓名拼音
     */
    private String  pinyin;

    /**
     * 曾用名
     */
    private String  former;

    /**
     * 身份证号
     */
    private String  IDcard;

    /**
     * 入学前户口
     */
    private String  account;

    /**
     * 院系代码
     */
    private String  collegeCode;

    /**
     * 院系名称
     */
    private String  collegeName;

    /**
     * 专业代码
     */
    private String  majorCode;

    /**
     * 专业名称
     */
    private String  majorName;

    /**
     * 班级代码
     */
    private String  classCode;

    /**
     * 班级名称
     */
    private String  className;

    /**
     * 寝室信息
     */
    private String  roombed;

    /**
     * 民族
     */
    private String  nation;

    /**
     * 籍贯
     */
    private String  birthPlace;

    /**
     * 政治面貌
     */
    private String  politicsFace;

    /**
     * 学制
     */
    private String  length;

    /**
     * 培养方式
     */
    private String  cultureWay;

    /**
     * 学历
     */
    private String  education;

    /**
     * 学位
     */
    private String  degree;

    /**
     * 入学时间
     */
    private Date    inDate;

    /**
     * 毕业时间
     */
    private Date    finishDate;

    /**
     * 研究方向导师
     */
    private String  hierophant;

    /**
     * 联系电话
     */
    private String  phone;

    /**
     * 一卡通号
     */
    private String  cardNum;

    /**
     * 教育方向
     */
    private String  edudirection;

    /**
     * 生源地
     */
    private String  testaddr;

    /**
     * 父亲姓名
     */
    private String  fatherName;

    /**
     * 母亲姓名
     */
    private String  motherName;

    /**
     * 家庭地址
     */
    private String  address;

    /**
     * 家庭邮编
     */
    private String  familyCode;

    /**
     * 家庭电话
     */
    private String  homePhone;

    /**
     * 血型
     */
    private String  blood;

    /**
     * 健康状况
     */
    private String  healthInfo;

    /**
     * 婚姻状况
     */
    private String  marryInfo;

    /**
     * 心理状况
     */
    private String  psyInfo;

    /**
     * 国别
     */
    private String  country;

    /**
     * 宗教信仰
     */
    private String  religion;

    /**
     * 银行名称
     */
    private String  bankName;

    /**
     * 银行账户
     */
    private String  bankAccount;

    /**
     * 个人主页
     */
    private String  onlineWeb;

    /**
     * 邮箱
     */
    private String  email;

    /**
     * 特长
     */
    private String  specialty;

    /**
     * 备注
     */
    private String  remarks;

    /**
     * 是否属于港澳台
     */
    private boolean autonomy;

    /**
     * 届数
     */
    private String  period;

    /**
     *辅导员
     */
    private String  counselor;

    /**
     * 辅导员电话
     */
    private String  counselorPhone;

    /**
     * 班主任
     */
    private String  headTeacher;

    /**
     * 班主任电话
     */
    private String  headTeacherPhone;

    /**
     * 照片
     */
    private String  img;

    /**
     *批次年份
     */
    private String  year;

    /**
     *批次季节
     */
    private String  season;

    /**
     *毕业中学
     */
    private String  graduateSchool;

    /**
     *登陆密码
     */
    private String  password;

    private String  type;            // 学生类别 统招，定向，专升本

    private boolean graduated;       // 是否已毕业

    private boolean inSchool;        // 是否在校

    private String  notSchoolReason; // 非在校原因

    private boolean reged;           // 是否注册

    private boolean deleted;         // 是否删除

    private int     grade;           // 年级

    private String  culGrade;

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

    public String getImg()
    {
        return img;
    }

    public void setImg(String img)
    {
        this.img = img;
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

    public String getCultureWay()
    {
        return cultureWay;
    }

    public void setCultureWay(String cultureWay)
    {
        this.cultureWay = cultureWay;
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
        return Marriage.getDesc(this.marryInfo);
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

    public boolean isAutonomy()
    {
        return autonomy;
    }

    public void setAutonomy(boolean autonomy)
    {
        this.autonomy = autonomy;
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

    public String getEducationDesc()
    {

        return Education.getDesc(this.education);

    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getSexDesc()
    {
        return sex.equals("f") ? "女" : "男";
    }

    public String getTypeAutonomy()
    {
        return autonomy ? "是" : "否";
    }

    public String getNationDesc()
    {
        return Nation.getDesc(nation);
    }

    public String getMarryInfoDesc()
    {
        return Marriage.getDesc(marryInfo);
    }

    public String getPoliticsFaceDesc()
    {
        return PoliticsFace.getDesc(politicsFace);
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public boolean isGraduated()
    {
        return graduated;
    }

    public void setGraduated(boolean graduated)
    {
        this.graduated = graduated;
    }

    public boolean isInSchool()
    {
        return inSchool;
    }

    public void setInSchool(boolean inSchool)
    {
        this.inSchool = inSchool;
    }

    public String getNotSchoolReason()
    {
        return notSchoolReason;
    }

    public void setNotSchoolReason(String notSchoolReason)
    {
        this.notSchoolReason = notSchoolReason;
    }

    public boolean isReged()
    {
        return reged;
    }

    public void setReged(boolean reged)
    {
        this.reged = reged;
    }

    public boolean isDeleted()
    {
        return deleted;
    }

    public void setDeleted(boolean deleted)
    {
        this.deleted = deleted;
    }

    public int getGrade()
    {
        return grade;
    }

    public void setGrade(int grade)
    {
        this.grade = grade;
    }

    /**
     * 
     * 取得批次的组合名称奶年度+"-"+季节
     * 
     * @since 2010-8-22
     * @author houbing.qian
     * @return
     */
    public String getComname()
    {
        return this.year + "-" + this.season;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword(String password)
    {
        this.password = password;
    }

    public String getCulGrade()
    {
        return Grade.getGrade(this.grade);
    }
}
