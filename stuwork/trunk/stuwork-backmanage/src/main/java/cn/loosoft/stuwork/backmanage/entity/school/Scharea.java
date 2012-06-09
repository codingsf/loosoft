package cn.loosoft.stuwork.backmanage.entity.school;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 校区model类.
 * 
 * 注释见{@link User}.
 * 
 * @author houbing.qian
 */
@Entity
@Table(name = "bm_schoolarea")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Scharea extends IdEntity {
    /**校区代码 */
    private String code;    
    /**校区名称 */
    private String name;
    /**校区地址 */
    private String address;    

    public Scharea() {
    }

    public Scharea(Long id, String code, String name,String address) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.address = address;
    }

    @Column(nullable = false, unique = true)
    public String getCode()
    {
        return code;
    }

    public void setCode(String code)
    {
        this.code = code;
    }

    @Column(nullable = false)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(nullable = false)
    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
