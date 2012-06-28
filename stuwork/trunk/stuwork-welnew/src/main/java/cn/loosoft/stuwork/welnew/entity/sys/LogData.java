//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: qingang
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
package cn.loosoft.stuwork.welnew.entity.sys;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.common.lib.util.date.DateUtils;
import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 系统操作日志
 * 
 * @author qingang
 * @version 1.0
 * @since 2011-9-1
 */
@Entity
@Table(name = "wel_logdata")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class LogData extends IdEntity
{
    public static String operate_type_reg = "1";//报到业务
    public static String operate_type_fee = "1";//交费业务
    private String username;

    private String operate;

    private String operatetype;

    private Date   operatedate;

    public LogData(String username, String operate,String operatetype){
        this.username =username;
        this.operate = operate;
        this.operatetype = operatetype;
        this.operatedate = DateUtils.getNowTimestamp();
    }

    public LogData(){}
    public String getUsername()
    {
        return username;
    }

    public void setUsername(String username)
    {
        this.username = username;
    }

    public String getOperate()
    {
        return operate;
    }

    public void setOperate(String operate)
    {
        this.operate = operate;
    }

    public String getOperatetype()
    {
        return operatetype;
    }

    public void setOperatetype(String operatetype)
    {
        this.operatetype = operatetype;
    }

    public Date getOperatedate()
    {
        return operatedate;
    }

    public void setOperatedate(Date operatedate)
    {
        this.operatedate = operatedate;
    }
}
