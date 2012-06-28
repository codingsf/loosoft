package cn.loosoft.stuwork.welnew.entity.register;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 新生注册实体类
 * 
 * @author bo.chen
 * @version 1.0
 * @since 2010-12-2
 */
@Entity
@Table(name = "wel_register")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Register extends IdEntity
{

    private String noticeId;   // 通知书编号

    private String pid;        // 身份证号码

    private String password;   // 密码

    private String passwordque; // 密码保护问题

    private String passwordans; // 密码保护答案

    private String email;      // 邮箱

    private String loginName;

    public String getNoticeId()
    {
        return noticeId;
    }

    public void setNoticeId(String noticeid)
    {
        this.noticeId = noticeid;
    }

    public String getPid()
    {
        return pid;
    }

    public void setPid(String pid)
    {
        this.pid = pid;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword(String password)
    {
        this.password = password;
    }

    public String getPasswordque()
    {
        return passwordque;
    }

    public void setPasswordque(String passwordque)
    {
        this.passwordque = passwordque;
    }

    public String getPasswordans()
    {
        return passwordans;
    }

    public void setPasswordans(String email)
    {
        this.passwordans = email;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getLoginName()
    {
        return this.loginName;
    }

    public void setLoginName(String loginName)
    {
        this.loginName = loginName;
    }
}
