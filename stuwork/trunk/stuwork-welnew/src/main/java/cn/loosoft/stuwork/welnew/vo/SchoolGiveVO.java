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
import java.util.List;

/**
 * 各学院发放统计VO
 * 
 * @author fangyong
 * @version 1.0
 * @since 2010-8-24
 */

public class SchoolGiveVO implements Serializable
{

    /**
     * serialVersionUID long
     */
    private static final long     serialVersionUID = 992382978706271488L;

    private String                collegeName;                           // 学院名称

    private List<AllSchoolGiveVO> allSchoolGiveVOs;                      // 统计各项目

    public List<AllSchoolGiveVO> getAllSchoolGiveVOs()
    {
        return allSchoolGiveVOs;
    }

    public void setAllSchoolGiveVOs(List<AllSchoolGiveVO> allSchoolGiveVOs)
    {
        this.allSchoolGiveVOs = allSchoolGiveVOs;
    }

    public String getCollegeName()
    {
        return collegeName;
    }

    public void setCollegeName(String collegeName)
    {
        this.collegeName = collegeName;
    }

}
