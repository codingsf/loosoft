package cn.loosoft.stuwork.welnew.entity.item;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 转移项目设置实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Entity
@Table(name = "wel_devolveItem")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class DevolveItem extends IdEntity
{
    private String name;       // 名称

    private String description; // 描述

    @Transient
    public String getTypeDesc()
    {
        return super.id.toString();
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

}
