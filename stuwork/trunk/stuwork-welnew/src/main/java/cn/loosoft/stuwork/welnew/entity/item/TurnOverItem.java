package cn.loosoft.stuwork.welnew.entity.item;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 上缴项目设置实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Entity
@Table(name = "wel_turnoverItem")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class TurnOverItem extends IdEntity
{
    private String name;        // 上缴名称

    private String description; // 描述

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
