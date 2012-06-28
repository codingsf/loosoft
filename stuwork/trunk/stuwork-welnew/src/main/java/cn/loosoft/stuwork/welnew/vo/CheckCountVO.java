//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: zzHe
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

public class CheckCountVO
{
    private String name;        // 学院名称

    private long   allCount;    // 应审查人数

    private long   passCount;   // 通过人数

    private long   unpassCount; // 未通过人数

    private long   noCheckCount; // 漏审人数

    private String passRate;    // 通过率

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public long getAllCount()
    {
        return allCount;
    }

    public void setAllCount(long allCount)
    {
        this.allCount = allCount;
    }

    public long getPassCount()
    {
        return passCount;
    }

    public void setPassCount(long passCount)
    {
        this.passCount = passCount;
    }

    public long getUnpassCount()
    {
        return unpassCount;
    }

    public void setUnpassCount(long unpassCount)
    {
        this.unpassCount = unpassCount;
    }

    public long getNoCheckCount()
    {
        return noCheckCount;
    }

    public void setNoCheckCount(long noCheckCount)
    {
        this.noCheckCount = noCheckCount;
    }

    public String getPassRate()
    {
        return passRate;
    }

    public void setPassRate(String passRate)
    {
        this.passRate = passRate;
    }
}