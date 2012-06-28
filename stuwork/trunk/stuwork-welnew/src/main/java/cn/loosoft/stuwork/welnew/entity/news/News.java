package cn.loosoft.stuwork.welnew.entity.news;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 新闻管理实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-27
 */
@Entity
@Table(name = "wel_news")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class News extends IdEntity
{
    private String  title;    // 标题

    private String  content;  // 内容

    private String  publisher; // 发布者

    private Date    postTime; // 发布时间

    private String  subject;  // 摘要

    private boolean top;      // 是否置顶

    private String  type;     // 类型

    private Date    topTime;  // 置顶时间

    public String getSubject()
    {
        return subject;
    }

    public void setSubject(String subject)
    {
        this.subject = subject;
    }

    @Column(name = "IsTop")
    public boolean isTop()
    {
        return top;
    }

    public void setTop(boolean top)
    {
        this.top = top;
    }

    public Date getTopTime()
    {
        return topTime;
    }

    public void setTopTime(Date topTime)
    {
        this.topTime = topTime;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public String getPublisher()
    {
        return publisher;
    }

    public void setPublisher(String publisher)
    {
        this.publisher = publisher;
    }

    public Date getPostTime()
    {
        return postTime;
    }

    public void setPostTime(Date postTime)
    {
        this.postTime = postTime;
    }

    @Transient
    public String getTypeDesc()
    {
        return top ? "是" : "否";
    }

}
