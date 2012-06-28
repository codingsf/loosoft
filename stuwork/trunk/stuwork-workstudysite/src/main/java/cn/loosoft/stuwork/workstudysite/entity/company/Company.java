package cn.loosoft.stuwork.workstudysite.entity.company;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 单位表
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-28
 */

@Entity
@Table(name = "stujob_company")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Company extends IdEntity
{

    private String companyName; // 单位名称

    private String manager;     // 法人代表

    private String address;     // 地址

    private String phone;       // 电话

    private String introduction; // 单位简介

    private String remark;      // 备注

    private String freeze;      // 是否冻结

    public String getFreeze()
    {
        return freeze;
    }

    public void setFreeze(String freeze)
    {
        this.freeze = freeze;
    }

    public String getCompanyName()
    {
        return companyName;
    }

    public void setCompanyName(String companyName)
    {
        this.companyName = companyName;
    }

    public String getManager()
    {
        return manager;
    }

    public void setManager(String manager)
    {
        this.manager = manager;
    }

    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public String getPhone()
    {
        return phone;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public String getIntroduction()
    {
        return introduction;
    }

    public void setIntroduction(String introduction)
    {
        this.introduction = introduction;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

}
