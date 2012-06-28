package cn.loosoft.stuwork.welnew.entity.news;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 迎新词管理实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-27
 */
@Entity
@Table(name = "wel_welcomearticle")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class WelcomeArticle extends IdEntity
{
    private String title;  // 标题

    private String user;   // 作者

    private String content; // 内容

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getUser()
    {
        return user;
    }

    public void setUser(String user)
    {
        this.user = user;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

}
