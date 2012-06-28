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

/**
 * 新生入学报到统计VO
 * 
 * @author yfang
 * @version 1.0
 * @since 2010-8-24
 */

public class StudentReportVO
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 992382978706271488L;

    private String            unitName;                              // 单位名称

    private long              mustReportCount;                       // 应入学人数

    private long              alreadyReportCount;                    // 已入学人数

    private String            noReportCount;                         // 报到率

    private boolean           flag;                                  // 标识

    public boolean isFlag()
    {
        return flag;
    }

    public void setFlag(boolean flag)
    {
        this.flag = flag;
    }

    public String getUnitName()
    {
        return unitName;
    }

    public void setUnitName(String unitName)
    {
        this.unitName = unitName;
    }

    public long getAlreadyReportCount()
    {
        return alreadyReportCount;
    }

    public void setAlreadyReportCount(long alreadyReportCount)
    {
        this.alreadyReportCount = alreadyReportCount;
    }

    public long getMustReportCount()
    {
        return mustReportCount;
    }

    public void setMustReportCount(long mustReportCount)
    {
        this.mustReportCount = mustReportCount;
    }

    public String getNoReportCount()
    {
        return noReportCount;
    }

    public void setNoReportCount(String noReportCount)
    {
        this.noReportCount = noReportCount;
    }

}
