//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: Administrator
//
//-------------------------------------------------------------------------
// LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
// THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
// LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
// MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
// THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
// CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
// PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
// NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
// SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
// SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
// PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
// SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
// HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------
package cn.loosoft.data.webservice.api.batch.dto;

import java.util.Date;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * Web Service传输Bmbatch批次信息的DTO.
 * 
 * 分离entity类与web service接口间的耦合，隔绝entity类的修改对接口的影响. 使用JAXB
 * 2.0的annotation标注JAVA-XML映射，尽量使用默认约定.
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Batch")
public class BatchDTO
{
    public BatchDTO()
    {

    }

    public BatchDTO(Long id, String year, String season, Date startdate,
            Date enddate, boolean current)
    {
        this.id = id;
        this.year = year;
        this.season = season;
        this.startdate = startdate;
        this.enddate = enddate;
        this.current = current;
    }

    private Long    id;

    private String  year;     // 批次年份

    private String  season;   // 批次季节

    private Date    startdate; // 开始日期

    private Date    enddate;  // 结束日期

    private boolean current;  // 是否是当前学生批次

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public boolean isCurrent()
    {
        return current;
    }

    public String getYear()
    {
        return year;
    }

    public void setYear(String year)
    {
        this.year = year;
    }

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
    public String getComname()
    {
        return this.year + "-" + this.season;
    }
}
