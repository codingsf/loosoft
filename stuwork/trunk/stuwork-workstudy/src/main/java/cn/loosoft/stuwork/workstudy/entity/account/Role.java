package cn.loosoft.stuwork.workstudy.entity.account;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springside.modules.utils.ReflectionUtils;

import cn.loosoft.stuwork.common.entity.IdEntity;

import com.google.common.collect.Lists;

/**
 * 角色.
 * 
 * 注释见{@link User}.
 * 
 * @author shanru.wu
 */
@Entity
@Table(name = "acct_role")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Role extends IdEntity
{

    private String          name;

    private List<Authority> authorityList = Lists.newArrayList();

    public Role()
    {

    }

    public Role(Long id, String name)
    {
        this.id = id;
        this.name = name;
    }

    @Column(nullable = false, unique = true)
    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    @ManyToMany
    @JoinTable(name = "acct_role_authority", joinColumns = { @JoinColumn(name = "ROLE_ID") }, inverseJoinColumns = { @JoinColumn(name = "AUTHORITY_ID") })
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("id")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<Authority> getAuthorityList()
    {
        return authorityList;
    }

    public void setAuthorityList(List<Authority> authorityList)
    {
        this.authorityList = authorityList;
    }

    @Transient
    public String getAuthNames()
    {
        return ReflectionUtils.convertElementPropertyToString(authorityList,
                "name", ", ");
    }

    @Transient
    @SuppressWarnings("unchecked")
    public List<Long> getAuthIds()
    {
        return ReflectionUtils
                .convertElementPropertyToList(authorityList, "id");
    }

    @Override
    public String toString()
    {
        return ToStringBuilder.reflectionToString(this);
    }
}
