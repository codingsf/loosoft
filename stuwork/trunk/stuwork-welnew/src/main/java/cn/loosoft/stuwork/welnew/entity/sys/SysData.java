package cn.loosoft.stuwork.welnew.entity.sys;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 基础数据实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Entity
@Table(name = "wel_sysdata")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SysData extends IdEntity
{
    public static final String BDSJ = "bdsj"; // 报到时间

    public static final String LXFS = "lxfs"; // 来校方式

    public static final String XHSZ = "xhsz"; // 学号设置

    private String             setvalue;     // 值

    private String             type;         // 基础数据类型

    private String             description;  // 描述

    public String getSetvalue()
    {
        return setvalue;
    }

    public void setSetvalue(String setvalue)
    {
        this.setvalue = setvalue;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }
}
