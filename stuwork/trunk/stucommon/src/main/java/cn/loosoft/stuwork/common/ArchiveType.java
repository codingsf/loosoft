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
 * Description of the class
 * 
 * @author Administrator
 * @version 1.0
 * @since 2010-11-24
 */

public class ArchiveType
{
    private static final String    TYPEYI   = "在库";

    private static final String    TYPEER   = "调阅";

    private static final String    TYPESAN  = "调出";

    private static final String    TYPESI   = "缺档";

    public static List<LabelValue> enumList = new ArrayList<LabelValue>();

    static
    {
        enumList.add(new LabelValue(TYPEYI, "在库"));
        enumList.add(new LabelValue(TYPEER, "调阅"));
        enumList.add(new LabelValue(TYPESAN, "调出"));
        enumList.add(new LabelValue(TYPESI, "缺档"));
    }

    /**
     * 
     * 取得培养方式描述
     * 
     * @since 2010-12-12
     * @author shanru.wu
     * @param code
     * @return
     */
    public static String getDesc(String code)
    {
        for (LabelValue lv : enumList)
        {
            if (lv.getValue().equals(code))
            {
                return lv.getLabel();
            }
        }
        return "";
    }

}
