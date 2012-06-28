package cn.loosoft.stuwork.welnew.entity.batch;

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
 * 迎新批次
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-21
 */
@Entity
@Table(name = "wel_batch")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Welbatch extends IdEntity
{
    private String  year;     // 批次年份

    private String  season;   // 批次季节

    private Date    startdate; // 开始日期

    private Date    enddate;  // 结束日期

    private boolean current;  // 是否是当前迎新批次

    @Column(name = "isCurrent", nullable = false)
    public boolean isCurrent()
    {
        return current;
    }

    @Column(nullable = false)
    public String getYear()
    {
        return year;
    }

    public void setYear(String year)
    {
        this.year = year;
    }

    @Column(nullable = false)
    public String getSeason()
    {
        return season;
    }

    public void setSeason(String season)
    {
        this.season = season;
    }

    public Date getStartdate()
    {
        return startdate;
    }

    public void setStartdate(Date startdate)
    {
        this.startdate = startdate;
    }

    public Date getEnddate()
    {
        return enddate;
    }

    public void setEnddate(Date enddate)
    {
        this.enddate = enddate;
    }

    public void setCurrent(boolean current)
    {
        this.current = current;
    }

    /**
     * 
     * 取得批次的组合名称奶年度+"-"+季节
     * 
     * @since 2010-8-22
     * @author houbing.qian
     * @return
     */
    @Transient
    public String getComname()
    {
        return this.year + "-" + this.season;
    }
}
