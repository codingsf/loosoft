//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Loosoft. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Loosoft
//
// Original author: houbing.qian
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
package cn.loosoft.stuwork.welnew.vo;

import java.io.Serializable;

/**
 * 全校发放统计VO
 * 
 * @author fangyong
 * @version 1.0
 * @since 2010-8-24
 */

public class AllSchoolGiveVO implements Serializable
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 992382978706271488L;

    private String            name;                                  // 发放项目名称

    private long              mustGiveCount;                         // 应发人数

    private long              alreadyGiveCount;                      // 已发人数

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public long getMustGiveCount()
    {
        return mustGiveCount;
    }

    public void setMustGiveCount(long mustGiveCount)
    {
        this.mustGiveCount = mustGiveCount;
    }

    public long getAlreadyGiveCount()
    {
        return alreadyGiveCount;
    }

    public void setAlreadyGiveCount(long alreadyGiveCount)
    {
        this.alreadyGiveCount = alreadyGiveCount;
    }

}
