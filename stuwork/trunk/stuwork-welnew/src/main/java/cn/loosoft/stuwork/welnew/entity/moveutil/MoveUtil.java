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
package cn.loosoft.stuwork.welnew.entity.moveutil;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 通知书设置实体
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-8-25
 */
@Entity
@Table(name = "wel_moveutil")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class MoveUtil extends IdEntity
{
    private String year;             // 年限

    private String introduce;        // 说明

    private String address;          // 地址

    private String imageName;        // 存放地址

    private String status;           // 状态

    private String noticeMoveLeft;   // 通知书编号左边

    private String noticeMoveTop;    // 通知书编号上边

    private String nameMoveLeft;     // 姓名左边

    private String nameMoveTop;      // 姓名上边

    private String collegeMoveLeft;  // 院系左边

    private String collegeMoveTop;   // 院系上边

    private String majorMoveLeft;    // 专业左边

    private String majorMoveTop;     // 专业上边

    private String yearMoveLeft;     // 年制左边

    private String yearMoveTop;      // 年制上边

    private String workMoveLeft;     // 工作导向左边

    private String workMoveTop;      // 工作导向上边

    private String admitMoveLeft;    // 录取左边

    private String admitMoveTop;     // 录取上边

    private String startDateMoveLeft; // 报到开始时间左边

    private String startDateMoveTop; // 报到开始时间上边

    private String endDateMoveLeft;  // 报到结束时间左边

    private String endDateMoveTop;   // 报到结束时间上边

    private String xingMaMoveLeft;   // 条形码左边

    private String xingMaMoveTop;    // 条形码上边

    public String getYear()
    {
        return year;
    }

    public void setYear(String year)
    {
        this.year = year;
    }

    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public String getIntroduce()
    {
        return introduce;
    }

    public void setIntroduce(String introduce)
    {
        this.introduce = introduce;
    }

    public String getImageName()
    {
        return imageName;
    }

    public void setImageName(String imageName)
    {
        this.imageName = imageName;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    /**
     * @return the noticeMoveLeft
     */
    public String getNoticeMoveLeft()
    {
        return noticeMoveLeft;
    }

    /**
     * @param noticeMoveLeft
     *            the noticeMoveLeft to set
     */
    public void setNoticeMoveLeft(String noticeMoveLeft)
    {
        this.noticeMoveLeft = noticeMoveLeft;
    }

    /**
     * @return the noticeMoveTop
     */
    public String getNoticeMoveTop()
    {
        return noticeMoveTop;
    }

    /**
     * @param noticeMoveTop
     *            the noticeMoveTop to set
     */
    public void setNoticeMoveTop(String noticeMoveTop)
    {
        this.noticeMoveTop = noticeMoveTop;
    }

    /**
     * @return the nameMoveLeft
     */
    public String getNameMoveLeft()
    {
        return nameMoveLeft;
    }

    /**
     * @param nameMoveLeft
     *            the nameMoveLeft to set
     */
    public void setNameMoveLeft(String nameMoveLeft)
    {
        this.nameMoveLeft = nameMoveLeft;
    }

    /**
     * @return the nameMoveTop
     */
    public String getNameMoveTop()
    {
        return nameMoveTop;
    }

    /**
     * @param nameMoveTop
     *            the nameMoveTop to set
     */
    public void setNameMoveTop(String nameMoveTop)
    {
        this.nameMoveTop = nameMoveTop;
    }

    /**
     * @return the collegeMoveLeft
     */
    public String getCollegeMoveLeft()
    {
        return collegeMoveLeft;
    }

    /**
     * @param collegeMoveLeft
     *            the collegeMoveLeft to set
     */
    public void setCollegeMoveLeft(String collegeMoveLeft)
    {
        this.collegeMoveLeft = collegeMoveLeft;
    }

    /**
     * @return the collegeMoveTop
     */
    public String getCollegeMoveTop()
    {
        return collegeMoveTop;
    }

    /**
     * @param collegeMoveTop
     *            the collegeMoveTop to set
     */
    public void setCollegeMoveTop(String collegeMoveTop)
    {
        this.collegeMoveTop = collegeMoveTop;
    }

    /**
     * @return the majorMoveLeft
     */
    public String getMajorMoveLeft()
    {
        return majorMoveLeft;
    }

    /**
     * @param majorMoveLeft
     *            the majorMoveLeft to set
     */
    public void setMajorMoveLeft(String majorMoveLeft)
    {
        this.majorMoveLeft = majorMoveLeft;
    }

    /**
     * @return the majorMoveTop
     */
    public String getMajorMoveTop()
    {
        return majorMoveTop;
    }

    /**
     * @param majorMoveTop
     *            the majorMoveTop to set
     */
    public void setMajorMoveTop(String majorMoveTop)
    {
        this.majorMoveTop = majorMoveTop;
    }

    /**
     * @return the yearMoveLeft
     */
    public String getYearMoveLeft()
    {
        return yearMoveLeft;
    }

    /**
     * @param yearMoveLeft
     *            the yearMoveLeft to set
     */
    public void setYearMoveLeft(String yearMoveLeft)
    {
        this.yearMoveLeft = yearMoveLeft;
    }

    /**
     * @return the yearMoveTop
     */
    public String getYearMoveTop()
    {
        return yearMoveTop;
    }

    /**
     * @param yearMoveTop
     *            the yearMoveTop to set
     */
    public void setYearMoveTop(String yearMoveTop)
    {
        this.yearMoveTop = yearMoveTop;
    }

    /**
     * @return the workMoveLeft
     */
    public String getWorkMoveLeft()
    {
        return workMoveLeft;
    }

    /**
     * @param workMoveLeft
     *            the workMoveLeft to set
     */
    public void setWorkMoveLeft(String workMoveLeft)
    {
        this.workMoveLeft = workMoveLeft;
    }

    /**
     * @return the workMoveTop
     */
    public String getWorkMoveTop()
    {
        return workMoveTop;
    }

    /**
     * @param workMoveTop
     *            the workMoveTop to set
     */
    public void setWorkMoveTop(String workMoveTop)
    {
        this.workMoveTop = workMoveTop;
    }

    public String getAdmitMoveLeft()
    {
        return admitMoveLeft;
    }

    public void setAdmitMoveLeft(String admitMoveLeft)
    {
        this.admitMoveLeft = admitMoveLeft;
    }

    public String getAdmitMoveTop()
    {
        return admitMoveTop;
    }

    public void setAdmitMoveTop(String admitMoveTop)
    {
        this.admitMoveTop = admitMoveTop;
    }

    public String getStartDateMoveLeft()
    {
        return startDateMoveLeft;
    }

    public void setStartDateMoveLeft(String startDateMoveLeft)
    {
        this.startDateMoveLeft = startDateMoveLeft;
    }

    public String getStartDateMoveTop()
    {
        return startDateMoveTop;
    }

    public void setStartDateMoveTop(String startDateMoveTop)
    {
        this.startDateMoveTop = startDateMoveTop;
    }

    public String getEndDateMoveLeft()
    {
        return endDateMoveLeft;
    }

    public void setEndDateMoveLeft(String endDateMoveLeft)
    {
        this.endDateMoveLeft = endDateMoveLeft;
    }

    public String getEndDateMoveTop()
    {
        return endDateMoveTop;
    }

    public void setEndDateMoveTop(String endDateMoveTop)
    {
        this.endDateMoveTop = endDateMoveTop;
    }

    /**
     * @return the xingMaMoveLeft
     */
    public String getXingMaMoveLeft()
    {
        return xingMaMoveLeft;
    }

    /**
     * @param xingMaMoveLeft
     *            the xingMaMoveLeft to set
     */
    public void setXingMaMoveLeft(String xingMaMoveLeft)
    {
        this.xingMaMoveLeft = xingMaMoveLeft;
    }

    /**
     * @return the xingMaMoveTop
     */
    public String getXingMaMoveTop()
    {
        return xingMaMoveTop;
    }

    /**
     * @param xingMaMoveTop
     *            the xingMaMoveTop to set
     */
    public void setXingMaMoveTop(String xingMaMoveTop)
    {
        this.xingMaMoveTop = xingMaMoveTop;
    }
}
