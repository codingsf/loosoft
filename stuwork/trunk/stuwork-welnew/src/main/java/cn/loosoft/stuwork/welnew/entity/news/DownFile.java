package cn.loosoft.stuwork.welnew.entity.news;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 附件管理实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-12-2
 */
@Entity
@Table(name = "wel_downfile")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class DownFile extends IdEntity
{
    private String name;    // 附件名称

    private Date   postTime; // 发布时间

    private String fileName; // 附件地址

    private String saveName; // 保存到磁盘上的文件名称

    public String getSaveName()
    {
        return saveName;
    }

    public void setSaveName(String saveName)
    {
        this.saveName = saveName;
    }

    public String getFileName()
    {
        return fileName;
    }

    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }

    public Date getPostTime()
    {
        return postTime;
    }

    public void setPostTime(Date postTime)
    {
        this.postTime = postTime;
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
