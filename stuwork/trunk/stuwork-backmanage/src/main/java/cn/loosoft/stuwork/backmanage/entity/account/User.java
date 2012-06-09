package cn.loosoft.stuwork.backmanage.entity.account;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.springside.modules.utils.ReflectionUtils;

import cn.loosoft.common.util.date.DateUtils;
import cn.loosoft.stuwork.backmanage.entity.school.Clazz;
import cn.loosoft.stuwork.backmanage.entity.school.Department;
import cn.loosoft.stuwork.backmanage.entity.school.Institute;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;
import cn.loosoft.stuwork.common.entity.IdEntity;

import com.google.common.collect.Lists;

/**
 * 用户.
 * 
 * 使用JPA annotation定义ORM关系. 使用Hibernate annotation定义JPA 1.0未覆盖的部分.
 * 
 * @author houbing.qian
 */
@Entity
// 表名与类名不相同时重新定义表名.
@Table(name = "acct_user")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class User extends IdEntity
{

    private String      loginName;                       // login name

    private String      password;                        // 暂时使用明文保存的密码

    private String      examineeNo;                      // 考试号

    private String      name;                            // name

    private String      email;                           // 邮箱

    private Date        createDate;                      // 注册日期

    private Department  department;                      // 所在系

    private Institute   institute;                       // 所在学院

    private Specialty   specialty;                       // 所在专业

    // private UserType userType;

    private List<Role>  roleList  = Lists.newArrayList(); // 有序的关联对象集合

    private String      clazzCode;                       // 用户所管辖的班级clazzCode列表,之间以逗号隔开

    private String      clazzName;                       // 用户所管辖的班级名称列表,之间已逗号隔开

    private int         type;                            // (0:学生 1:老师)

    // 管辖班级
    private List<Clazz> clazzList = Lists.newArrayList(); // 有序的关联对象集合

    // 字段非空且唯一, 用于提醒Entity使用者及生成DDL.
    @Column(nullable = false, unique = true, name = "loginName")
    public String getLoginName()
    {
        return loginName;
    }

    public void setLoginName(String loginName)
    {
        this.loginName = loginName;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword(String password)
    {
        this.password = password;
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

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    /**
     * @return the createDate
     */
    public Date getCreateDate()
    {
        return createDate;
    }

    /**
     * @param createDate
     *            the createDate to set
     */
    public void setCreateDate(Date createDate)
    {
        this.createDate = createDate;
    }

    // 多对多定义
    @ManyToMany
    // 中间表定义,表名采用默认命名规则
    @JoinTable(name = "acct_user_role", joinColumns = { @JoinColumn(name = "userID") }, inverseJoinColumns = { @JoinColumn(name = "roleID") })
    // Fecth策略定义
    @Fetch(FetchMode.SUBSELECT)
    // 集合按id排序.
    @OrderBy("id")
    // 集合中对象id的缓存.
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<Role> getRoleList()
    {
        return roleList;
    }

    public void setRoleList(List<Role> roleList)
    {
        this.roleList = roleList;
    }

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "departmentID")
    public Department getDepartment()
    {
        return department;
    }

    public void setDepartment(Department department)
    {
        this.department = department;
    }

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "instituteID")
    public Institute getInstitute()
    {
        return institute;
    }

    public void setInstitute(Institute institute)
    {
        this.institute = institute;
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

    // @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    // @NotFound(action = NotFoundAction.IGNORE)
    // @JoinColumn(name = "typeID")
    // public UserType getUserType()
    // {
    // return userType;
    // }
    //
    // public void setUserType(UserType userType)
    // {
    // this.userType = userType;
    // }

    // 多对多定义
    @ManyToMany
    // 中间表定义,表名采用默认命名规则
    @JoinTable(name = "bm_fdyuser_class", joinColumns = { @JoinColumn(name = "fdyUserID") }, inverseJoinColumns = { @JoinColumn(name = "classID") })
    // Fecth策略定义
    @Fetch(FetchMode.SUBSELECT)
    // 集合按id排序.
    @OrderBy("id")
    // 集合中对象id的缓存.
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<Clazz> getClazzList()
    {
        return clazzList;
    }

    public void setClazzList(List<Clazz> clazzList)
    {
        this.clazzList = clazzList;
    }

    /**
     * 用户拥有的角色名称字符串, 多个角色名称用','分隔.
     */
    // 非持久化属性.
    @Transient
    public String getRoleNames()
    {
        return ReflectionUtils.convertElementPropertyToString(roleList, "name",
        ", ");
    }

    /**
     * 用户拥有的角色id字符串, 多个角色id用','分隔.
     */
    // 非持久化属性.
    @Transient
    @SuppressWarnings("unchecked")
    public List<Long> getRoleIds()
    {
        return ReflectionUtils.convertElementPropertyToList(roleList, "id");
    }

    /**
     * 取得用户的创建年月
     * 
     * @return
     */
    @Transient
    public String getCreateYm()
    {
        return DateUtils.getDateYM(this.createDate);
    }

    public String getClazzCode()
    {
        return clazzCode;
    }

    public void setClazzCode(String clazzCode)
    {
        this.clazzCode = clazzCode;
    }

    @Override
    public String toString()
    {
        return ToStringBuilder.reflectionToString(this);
    }

    @Transient
    public String getDepartmentName()
    {
        return this.department != null ? this.department.getName() : "";
    }

    @Transient
    public String getDepartmentCode()
    {
        return this.department != null ? this.department.getCode() : "";
    }

    @Transient
    public String getInstituteCode()
    {
        return this.institute != null ? this.institute.getCode() : "";
    }

    @Transient
    public String getInstituteName()
    {
        return this.institute != null ? this.institute.getName() : "";
    }

    @Transient
    public String getSpecialtyCode()
    {
        return this.specialty != null ? this.specialty.getCode() : "";
    }

    @Transient
    public String getSpecialtyName()
    {
        return this.specialty != null ? this.specialty.getName() : "";
    }

    public String getClazzName()
    {
        return clazzName;
    }

    public void setClazzName(String clazzName)
    {
        this.clazzName = clazzName;
    }

    public int getType()
    {
        return type;
    }

    public void setType(int type)
    {
        this.type = type;
    }
}