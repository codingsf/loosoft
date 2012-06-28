package cn.loosoft.stuwork.welnew.entity.student;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.common.entity.IdEntity;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;

/**
 * 学生.
 * 
 * 使用JPA annotation定义ORM关系. 使用Hibernate annotation定义JPA 1.0未覆盖的部分.
 * 
 * @author shanru.wu
 * @author houbing.qian
 */
@Entity
// 表名与类名不相同时重新定义表名.
// 学生照片用考生号命名
@Table(name = "wel_student")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Student extends IdEntity implements Serializable
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private Welbatch          welbatch;             // 批次

    private String            examineeNo;           // 考生号

    private Date              birthday;             // 出生年月

    private String            studentNo;            // 学号

    private String            noticeId;             // 通知书编号

    private String            name;                 // 姓名

    private String            IDcard;               // 身份证号

    private String            sex;                  // 性别

    private String            nation;               // 民族

    private String            telephone;            // 电话

    private String            address;              // 联系地址

    private String            province;             // 生源省份

    private String            testaddr;             // 生源地

    private int               mark;                 // 高考分数

    private String            collegeCode;          // 录取学院代码

    private String            departCode;           // 录取系代码

    private String            majorCode;            // 录取专业代码

    private String            collegeName;          // 所在学院名称

    private String            departName;           // 所在系名称

    private String            majorName;            // 专业名称

    private String            className;            // 班级名称

    private String            classCode;            // 班级

    private String            gradation;            // 培养层次

    private String            type;                 // 学生类别 统招，定向，专升本

    private String            length;               // 学制

    private int               orderNum;             // 报到序号

    private Date              registerdate;         // 报到日期

    private boolean           reged;                // 是否入学

    private boolean           gived;                // 是否公寓用品发放

    private String            giveList;             // 发放清单,保存项目名称

    private Date              givetime;             // 公寓用品发放时间

    private String            schareaCode;          // 校区代码

    private String            schareaName;          // 校区名称

    private String            roombed;              // 寝室信息

    private boolean           checkPass;            // 是否审核通过

    private String            photo;                // 学生照片

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "batchid")
    public Welbatch getWelbatch()
    {
        return welbatch;
    }

    public void setWelbatch(Welbatch welbatch)
    {
        this.welbatch = welbatch;
    }

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getIDcard()
    {
        return IDcard;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

    public String getSex()
    {
        return sex;
    }

    public void setSex(String sex)
    {
        this.sex = sex;
    }

    public String getNation()
    {
        return nation;
    }

    public void setNation(String nation)
    {
        this.nation = nation;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public void setTelephone(String telephone)
    {
        this.telephone = telephone;
    }

    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public String getProvince()
    {
        return province;
    }

    public void setProvince(String province)
    {
        this.province = province;
    }

    public String getTestaddr()
    {
        return testaddr;
    }

    public void setTestaddr(String testaddr)
    {
        this.testaddr = testaddr;
    }

    public int getMark()
    {
        return mark;
    }

    public void setMark(int mark)
    {
        this.mark = mark;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public String getDepartCode()
    {
        return departCode;
    }

    public void setDepartCode(String departCode)
    {
        this.departCode = departCode;
    }

    public String getMajorCode()
    {
        return majorCode;
    }

    public void setMajorCode(String majorCode)
    {
        this.majorCode = majorCode;
    }

    public String getClassCode()
    {
        return classCode;
    }

    public void setClassCode(String classCode)
    {
        this.classCode = classCode;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getGradation()
    {
        return gradation;
    }

    public void setGradation(String gradation)
    {
        this.gradation = gradation;
    }

    public String getLength()
    {
        return length;
    }

    public void setLength(String length)
    {
        this.length = length;
    }

    public int getOrderNum()
    {
        return orderNum;
    }

    public void setOrderNum(int orderNum)
    {
        this.orderNum = orderNum;
    }

    public Date getRegisterdate()
    {
        return registerdate;
    }

    public void setRegisterdate(Date registerdate)
    {
        this.registerdate = registerdate;
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

    /**
     * 
     * 公寓用品是否发放
     * 
     * @since 2010-8-23
     * @author houbing.qian
     * @return
     */
    @Column(name = "isGived")
    public boolean isGived()
    {
        return gived;
    }

    public void setGived(boolean gived)
    {
        this.gived = gived;
    }

    /**
     * 
     * 公寓用品发放时间
     * 
     * @since 2010-8-23
     * @author houbing.qian
     * @return
     */
    public Date getGivetime()
    {
        return givetime;
    }

    public void setGivetime(Date givetime)
    {
        this.givetime = givetime;
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

    public String getSchareaCode()
    {
        return schareaCode;
    }

    public void setSchareaCode(String schareaCode)
    {
        this.schareaCode = schareaCode;
    }

    public String getSchareaName()
    {
        return schareaName;
    }

    public void setSchareaName(String schareaName)
    {
        this.schareaName = schareaName;
    }

    public String getRoombed()
    {
        return roombed;
    }

    public void setRoombed(String roombed)
    {
        this.roombed = roombed;
    }

    public Date getBirthday()
    {
        return birthday;
    }

    public void setBirthday(Date birthday)
    {
        this.birthday = birthday;
    }

    /**
     * 
     * 组合院系的名称
     * 
     * @since 2010-12-2
     * @author shanru.wu
     * @return
     */
    @Transient
    public String getColdepartdesc()
    {
        if (StringUtils.isNotEmpty(this.getCollegeName()))
        {
            if (StringUtils.isNotEmpty(this.getDepartName()))
            {
                return this.collegeName = this.collegeName + this.departName;
            }
            else
            {
                return this.collegeName;
            }
        }
        else
        {
            return "";
        }
    }

    @Transient
    public String getSexdesc()
    {
        return this.sex.equals("m") ? "男" : "女";
    }

    @Transient
    public String getCatdesc()
    {
        return StudentType.getDesc(this.type);
    }

    @Override
    public String toString()
    {
        return ToStringBuilder.reflectionToString(this);
    }

    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    public void setNoticeId(String noticeId)
    {
        this.noticeId = noticeId;
    }

    public String getStudentNo()
    {
        return studentNo;
    }

    public String getNoticeId()
    {
        return noticeId;
    }

    public String getGiveList()
    {
        return giveList;
    }

    public void setGiveList(String giveList)
    {
        this.giveList = giveList;
    }

    public boolean isCheckPass()
    {
        return checkPass;
    }

    public void setCheckPass(boolean checkPass)
    {
        this.checkPass = checkPass;
    }

    public String getPhoto()
    {
        if(StringUtils.isEmpty(this.photo))
        {
            if(StudentType.ZHUANSHENBEN.equals(this.type))
            {
                return this.IDcard+".jpg";
            }
            else
            {
                return this.examineeNo+".JPG";
            }
        }
        else
        {
            return this.photo;
        }
    }

    public void setPhoto(String photo)
    {
        this.photo = photo;
    }

    @Transient
    public String getTypeDesc()
    {
        return StudentType.getDesc(this.type);
       
    }
}