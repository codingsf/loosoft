package cn.loosoft.stuwork.welnew.entity.item;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 审查项目设置实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Entity
@Table(name = "wel_checkItem")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class CheckItem extends IdEntity
{
    private String project;    // 审查项目

    private String solution;   // 处理办法

    private String description; // 描述

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getSolution()
    {
        return solution;
    }

    public void setSolution(String solution)
    {
        this.solution = solution;
    }

    public String getProject()
    {
        return project;
    }

    public void setProject(String project)
    {
        this.project = project;
    }

}
