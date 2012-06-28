package cn.loosoft.stuwork.welnew.entity.item;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 缴费项目设置实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Entity
@Table(name = "wel_costitem")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class CostItem extends IdEntity
{
    private String  project; // 缴费项目

    private Double  price;   // 缴费单价

    private boolean need;    // 是否必须缴纳

    private boolean give;    // 是否为发放物品

    private boolean returned; // 是否可以归还

    @Column(name = "isGive")
    public boolean isGive()
    {
        return give;
    }

    public void setGive(boolean give)
    {
        this.give = give;
    }

    @Column(name = "isReturn")
    public boolean isReturned()
    {
        return returned;
    }

    public void setReturned(boolean returned)
    {
        this.returned = returned;
    }

    @Column(name = "isNeed")
    public boolean isNeed()
    {
        return need;
    }

    public void setNeed(boolean need)
    {
        this.need = need;
    }

    public String getProject()
    {
        return project;
    }

    public void setProject(String project)
    {
        this.project = project;
    }

    public Double getPrice()
    {
        return price;
    }

    public void setPrice(Double price)
    {
        this.price = price;
    }

    @Transient
    public String getTypeDesc()
    {
        return need ? "是" : "否";
    }

    @Transient
    public String getGiveDesc()
    {
        return give ? "是" : "否";
    }

    @Transient
    public String getReturnedDesc()
    {
        return returned ? "是" : "否";
    }
}
