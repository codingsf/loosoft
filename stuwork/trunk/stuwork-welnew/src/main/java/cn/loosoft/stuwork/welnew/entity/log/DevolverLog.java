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

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 转移记录实体类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-12-29
 */
@Entity
@Table(name = "wel_devolverlog")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class DevolverLog extends IdEntity
{
    private String studentNo;   // 学号

    private long   devolverId;  // 转移项目编号

    private Date   devolverTime; // 转移时间

    private String operater;    // 操作人

    /**
     * @return the devolverTime
     */
    public Date getDevolverTime()
    {
        return devolverTime;
    }

    /**
     * @param devolverTime
     *            the devolverTime to set
     */
    public void setDevolverTime(Date devolverTime)
    {
        this.devolverTime = devolverTime;
    }

    /**
     * @return the operater
     */
    public String getOperater()
    {
        return operater;
    }

    /**
     * @param operater
     *            the operater to set
     */
    public void setOperater(String operater)
    {
        this.operater = operater;
    }

    /**
     * @return the studentNo
     */
    public String getStudentNo()
    {
        return studentNo;
    }

    /**
     * @param studentNo
     *            the studentNo to set
     */
    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    /**
     * @return the devolverId
     */
    public long getDevolverId()
    {
        return devolverId;
    }

    /**
     * @param devolverId
     *            the devolverId to set
     */

    public void setDevolverId(long devolverId)
    {
        this.devolverId = devolverId;
    }

}
