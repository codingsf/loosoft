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
package cn.loosoft.data.webservice.api.news.dto;

import java.util.Date;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * Web Service传输News新闻信息的DTO.
 * 
 * 分离entity类与web service接口间的耦合，隔绝entity类的修改对接口的影响. 使用JAXB
 * 2.0的annotation标注JAVA-XML映射，尽量使用默认约定.
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "News")
public class NewsDTO
{
    private Long   id;

    private String title;      // 标题

    private String content;    // 内容

    private Date   pubdate;    // 发布时间

    private String pubuser;    // 作者

    private int    clickscount; // 访问次数

    public NewsDTO()
    {

    }

    public NewsDTO(Long id, String title, String content, Date pubdate,
            String pubuser, int clickscount)
    {
        this.id = id;
        this.title = title;
        this.content = content;
        this.pubdate = pubdate;
        this.pubuser = pubuser;
        this.clickscount = clickscount;
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

    public Date getPubdate()
    {
        return pubdate;
    }

    public void setPubdate(Date pubdate)
    {
        this.pubdate = pubdate;
    }

    public String getPubuser()
    {
        return pubuser;
    }

    public void setPubuser(String pubuser)
    {
        this.pubuser = pubuser;
    }

    public int getClickscount()
    {
        return clickscount;
    }

    public void setClickscount(int clickscount)
    {
        this.clickscount = clickscount;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

}
