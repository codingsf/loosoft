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
 * 发放项目设置实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Entity
@Table(name = "wel_extendItem")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ExtendItem extends IdEntity
{
    private String  type;  // 发放类别

    private int     num;   // 数量

    private boolean enable; // 是否生效

    private double  price; // 单价

    private String  depart; // 发放部门

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public int getNum()
    {
        return num;
    }

    public void setNum(int num)
    {
        this.num = num;
    }

    public double getPrice()
    {
        return price;
    }

    public void setPrice(double price)
    {
        this.price = price;
    }

    public String getDepart()
    {
        return depart;
    }

    public void setDepart(String depart)
    {
        this.depart = depart;
    }

    @Column(name = "IsEnable")
    public boolean isEnable()
    {
        return enable;
    }

    public void setEnable(boolean enable)
    {
        this.enable = enable;
    }

    @Transient
    public String getTypeDesc()
    {
        return enable ? "是" : "否";
    }
}
