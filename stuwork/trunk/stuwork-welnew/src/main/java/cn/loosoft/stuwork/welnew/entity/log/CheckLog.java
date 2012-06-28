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
package cn.loosoft.stuwork.welnew.entity.log;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 审查记录实体类
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-1-27
 */
@Entity
@Table(name = "wel_checklog")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class CheckLog extends IdEntity
{
    private String  examineeNo; // 考生号

    private int     checkItemId; // 审查项目编号

    private boolean error;      // 是否有误

    private boolean pass;       // 是否通过

    private String  remark;     // 备注

    private String  operater;   // 操作人

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public int getCheckItemId()
    {
        return checkItemId;
    }

    public void setCheckItemId(int checkItemId)
    {
        this.checkItemId = checkItemId;
    }

    @Column(name = "isError")
    public boolean isError()
    {
        return error;
    }

    public void setError(boolean error)
    {
        this.error = error;
    }

    @Column(name = "isPass")
    public boolean isPass()
    {
        return pass;
    }

    public void setPass(boolean pass)
    {
        this.pass = pass;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public String getOperater()
    {
        return operater;
    }

    public void setOperater(String operater)
    {
        this.operater = operater;
    }
}
