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
package cn.loosoft.stuwork.stuinfo.vo;

import javax.persistence.Transient;

/**
 * 
 * 专业统计
 * 
 * @author fangyong
 * @version 1.0
 * @since 2011-11-4
 */
public class SpecialCountVO
{

    private int    specialSize;      // 学院下的专业数

    private String collegeName;      // 学院名称

    private int    size;             // 学院下的专业个数

    private String specialName;      // 专业名称

    private long   totalCount;        // 合计学生数

    private String specialCode;      // 专业编码

    private long   yukeClCount;      // 预科班级数

    private long   yukeStuCount;     // 预科学生数

    private long   freBeClCount;     // 一年级本科班级数

    private long   freZhClCount;     // 一年级专科班级数

    private long   freZsbClCount;    // 一年级专升本班级数

    private long   freBeStuCount;    // 一年级本科学生人数

    private long   freZhStuCount;    // 一年级专科班学生人数

    private long   freZsbStuCount;   // 一年级专升本学生人数

    private long   sopBeClCount;     // 二年级本科班级数

    private long   sopZhClCount;     // 二年级专科班级数

    private long   sopZsbClCount;    // 二年级专升本班级数

    private long   sopBeStuCount;    // 二年级本科学生人数

    private long   sopZhStuCount;    // 二年级专科学生人数

    private long   sopZsbStuCount;   // 二年级专升本学生人数

    private long   junBeClCount;     // 三年级本科班级数

    private long   junZhClCount;     // 三年级专科班级数

    private long   junBeStuCount;    // 三年级本科学生人数

    private long   junZhStuCount;    // 三年级专科学生人数

    private long   senBeClCount;     // 四年级本科班级数

    private long   senBeStuCount;    // 四年级本科学生人数

    private long   totalBenStuNumber; // 预计毕业本科学生数

    private long   totalZhStuNumber; // 预计毕业专科学生数

    private long   totalZsbStuNumber; // 预计毕业专升本学生数

    private long   totalNumber;      // 预计毕业生数

    public long getTotalBenStuNumber()
    {
        return totalBenStuNumber;
    }

    public void setTotalBenStuNumber(long totalBenStuNumber)
    {
        this.totalBenStuNumber = totalBenStuNumber;
    }

    /**
     * @return the yukeClCount
     */
    public long getYukeClCount()
    {
        return yukeClCount;
    }

    /**
     * @param yukeClCount
     *            the yukeClCount to set
     */
    public void setYukeClCount(long yukeClCount)
    {
        this.yukeClCount = yukeClCount;
    }

    /**
     * @return the yukeStuCount
     */
    public long getYukeStuCount()
    {
        return yukeStuCount;
    }

    /**
     * @param yukeStuCount
     *            the yukeStuCount to set
     */
    public void setYukeStuCount(long yukeStuCount)
    {
        this.yukeStuCount = yukeStuCount;
    }

    public long getTotalZhStuNumber()
    {
        return totalZhStuNumber;
    }

    public void setTotalZhStuNumber(long totalZhStuNumber)
    {
        this.totalZhStuNumber = totalZhStuNumber;
    }

    public long getTotalZsbStuNumber()
    {
        return totalZsbStuNumber;
    }

    public void setTotalZsbStuNumber(long totalZsbStuNumber)
    {
        this.totalZsbStuNumber = totalZsbStuNumber;
    }

    public long getTotalNumber()
    {
        return totalNumber;
    }

    public void setTotalNumber(long totalNumber)
    {
        this.totalNumber = totalNumber;
    }

    public String getSpecialName()
    {
        return specialName;
    }

    public void setSpecialName(String specialName)
    {
        this.specialName = specialName;
    }

    public int getSpecialSize()
    {
        return specialSize;
    }

    public void setSpecialSize(int specialSize)
    {
        this.specialSize = specialSize;
    }

    public String getCollegeName()
    {
        return collegeName;
    }

    public void setCollegeName(String collegeName)
    {
        this.collegeName = collegeName;
    }

    public int getSize()
    {
        return size;
    }

    public void setSize(int size)
    {
        this.size = size;
    }

    public long getTotalCount()
    {
        return totalCount;
    }

    public void setTotalCount(long totalCount)
    {
        this.totalCount = totalCount;
    }

    public String getSpecialCode()
    {
        return specialCode;
    }

    public void setSpecialCode(String specialCode)
    {
        this.specialCode = specialCode;
    }

    public long getFreBeClCount()
    {
        return freBeClCount;
    }

    public void setFreBeClCount(long freBeClCount)
    {
        this.freBeClCount = freBeClCount;
    }

    public long getFreZhClCount()
    {
        return freZhClCount;
    }

    public void setFreZhClCount(long freZhClCount)
    {
        this.freZhClCount = freZhClCount;
    }

    public long getFreZsbClCount()
    {
        return freZsbClCount;
    }

    public void setFreZsbClCount(long freZsbClCount)
    {
        this.freZsbClCount = freZsbClCount;
    }

    public long getFreBeStuCount()
    {
        return freBeStuCount;
    }

    public void setFreBeStuCount(long freBeStuCount)
    {
        this.freBeStuCount = freBeStuCount;
    }

    public long getFreZhStuCount()
    {
        return freZhStuCount;
    }

    public void setFreZhStuCount(long freZhStuCount)
    {
        this.freZhStuCount = freZhStuCount;
    }

    public long getFreZsbStuCount()
    {
        return freZsbStuCount;
    }

    public void setFreZsbStuCount(long freZsbStuCount)
    {
        this.freZsbStuCount = freZsbStuCount;
    }

    public long getSopBeClCount()
    {
        return sopBeClCount;
    }

    public void setSopBeClCount(long sopBeClCount)
    {
        this.sopBeClCount = sopBeClCount;
    }

    public long getSopZhClCount()
    {
        return sopZhClCount;
    }

    public void setSopZhClCount(long sopZhClCount)
    {
        this.sopZhClCount = sopZhClCount;
    }

    public long getSopZsbClCount()
    {
        return sopZsbClCount;
    }

    public void setSopZsbClCount(long sopZsbClCount)
    {
        this.sopZsbClCount = sopZsbClCount;
    }

    public long getSopBeStuCount()
    {
        return sopBeStuCount;
    }

    public void setSopBeStuCount(long sopBeStuCount)
    {
        this.sopBeStuCount = sopBeStuCount;
    }

    public long getSopZhStuCount()
    {
        return sopZhStuCount;
    }

    public void setSopZhStuCount(long sopZhStuCount)
    {
        this.sopZhStuCount = sopZhStuCount;
    }

    public long getSopZsbStuCount()
    {
        return sopZsbStuCount;
    }

    public void setSopZsbStuCount(long sopZsbStuCount)
    {
        this.sopZsbStuCount = sopZsbStuCount;
    }

    public long getJunBeClCount()
    {
        return junBeClCount;
    }

    public void setJunBeClCount(long junBeClCount)
    {
        this.junBeClCount = junBeClCount;
    }

    public long getJunZhClCount()
    {
        return junZhClCount;
    }

    public void setJunZhClCount(long junZhClCount)
    {
        this.junZhClCount = junZhClCount;
    }

    public long getJunBeStuCount()
    {
        return junBeStuCount;
    }

    public void setJunBeStuCount(long junBeStuCount)
    {
        this.junBeStuCount = junBeStuCount;
    }

    public long getJunZhStuCount()
    {
        return junZhStuCount;
    }

    public void setJunZhStuCount(long junZhStuCount)
    {
        this.junZhStuCount = junZhStuCount;
    }

    public long getSenBeClCount()
    {
        return senBeClCount;
    }

    public void setSenBeClCount(long senBeClCount)
    {
        this.senBeClCount = senBeClCount;
    }

    public long getSenBeStuCount()
    {
        return senBeStuCount;
    }

    public void setSenBeStuCount(long senBeStuCount)
    {
        this.senBeStuCount = senBeStuCount;
    }

    // 小计班级数
    @Transient
    public long getTotalClNumber()
    {
        return this.yukeClCount + this.freBeClCount + this.freZhClCount
                + this.freZsbClCount + this.sopBeClCount + this.sopZhClCount
                + this.sopZsbClCount + this.junBeClCount + this.junZhClCount
                + this.senBeClCount;
    }

    // 小计学生数
    @Transient
    public long getTotalStuNumber()
    {
        return this.yukeStuCount + this.freBeStuCount + this.freZhStuCount
                + this.freZsbStuCount + this.sopBeStuCount + this.sopZhStuCount
                + this.sopZsbStuCount + this.junBeStuCount + this.junZhStuCount
                + +this.senBeStuCount;
    }

}
