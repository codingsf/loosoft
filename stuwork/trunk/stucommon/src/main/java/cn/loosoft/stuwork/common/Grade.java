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
package cn.loosoft.stuwork.common;

import java.util.ArrayList;
import java.util.List;

import cn.loosoft.common.vo.LabelValue;

/**
 * 年级
 * 
 * @author Administrator
 * @version 1.0
 * @since 2010-11-24
 */

public class Grade
{
    public static final int        FRESHMAN  = 1;

    public static final int        SOPHOMORE = 2;

    public static final int        JUNIOR    = 3;

    public static final int        SENIOR    = 4;

    public static final int        YUKE      = 5;

    public static List<LabelValue> enumList  = new ArrayList<LabelValue>();

    static
    {
        enumList.add(new LabelValue(String.valueOf(FRESHMAN), "1年级"));
        enumList.add(new LabelValue(String.valueOf(SOPHOMORE), "2年级"));
        enumList.add(new LabelValue(String.valueOf(JUNIOR), "3年级"));
        enumList.add(new LabelValue(String.valueOf(SENIOR), "4年级"));
        enumList.add(new LabelValue(String.valueOf(YUKE), "预科"));
    }

    /**
     * 
     * 取得中文描述
     * 
     * @since 2010-12-12
     * @author shanru.wu
     * @param code
     * @return
     */
    public static String getGrade(int grade)
    {
        for (LabelValue lv : enumList)
        {
            if (lv.getValue().equals(String.valueOf(grade)))
            {
                return lv.getLabel();
            }
        }
        return "";
    }

}
