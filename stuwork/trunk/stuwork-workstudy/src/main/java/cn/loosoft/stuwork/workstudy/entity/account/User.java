package cn.loosoft.stuwork.workstudy.entity.account;

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
import cn.loosoft.stuwork.common.entity.IdEntity;
import cn.loosoft.stuwork.workstudy.entity.company.Company;

import com.google.common.collect.Lists;

/**
 * 用户.
 * 
 * 使用JPA annotation定义ORM关系. 使用Hibernate annotation定义JPA 1.0未覆盖的部分.
 * 
 * @author shanru.wu
 */
@Entity
// 表名与类名不相同时重新定义表名.
@Table(name = "acct_user")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class User extends IdEntity
{

    private String  loginName;    // login name

    private String  password;     // 暂时使用明文保存的密码

    private String  name;         // name

    private String  email;        // 邮箱

    private Date    createDate;   // 注册日期

    private Company company;      // 所属单位

    private String  CompName;     // 单位名称

    private String  instituteCode; // 学院代码

    private String  instituteName; // 学院名称

    private int     userType;     // 用户类型

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn(name = "companyID")
    @NotFound(action = NotFoundAction.IGNORE)
    public Company getCompany()
    {
        return company;
    }

    public void setCompany(Company company)
    {
        this.company = company;
    }

    private List<Role> roleList = Lists.newArrayList(); // 有序的关联对象集合

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

    @Override
    public String toString()
    {
        return ToStringBuilder.reflectionToString(this);
    }

    @Transient
    public String getCompanyName()
    {
        return this.company != null ? company.getCompanyName() : "";
    }

    @Transient
    public Long getCompanyID()
    {
        return this.company != null ? company.getId() : 0;
    }

    public String getInstituteCode()
    {
        return instituteCode;
    }

    public void setInstituteCode(String instituteCode)
    {
        this.instituteCode = instituteCode;
    }

    public String getInstituteName()
    {
        return instituteName;
    }

    public void setInstituteName(String instituteName)
    {
        this.instituteName = instituteName;
    }

    public String getCompName()
    {
        return CompName;
    }

    public void setCompName(String compName)
    {
        CompName = compName;
    }

    public int getUserType()
    {
        return userType;
    }

    public void setUserType(int userType)
    {
        this.userType = userType;
    }

    @Transient
    public String getUserTypeDesc()
    {
        if (this.userType == 1)
        {
            return "校勤工助学指导中心";
        }
        if (this.userType == 2)
        {
            return "院系勤工助学领导小组";
        }
        if (this.userType == 3)
        {
            return "用工单位";
        }
        return "";
    }
}