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
 * 
 * 学历
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-1-6
 */

public class Education
{
    public static final String     GAOZHONG      = "gaozhong";

    public static final String     XIAOXUE       = "xiaoxue";

    public static final String     CHUZHONG      = "chuzhong";

    public static final String     ZHONGZHUAN    = "zhongzhuan";

    public static final String     DAZHUAN       = "dazhuan";

    public static final String     ZHUANSHENGBEN = "zhuanshengben";

    public static final String     BENKE         = "benke";

    public static final String     YANJIUSHENG   = "yanjiusheng";

    public static final String     BOSHI         = "boshi";

    public static final String     SHUOSHI       = "shuoshi";

    public static List<LabelValue> enumList      = new ArrayList<LabelValue>();

    static
    {
        //enumList.add(new LabelValue(GAOZHONG, "高中"));
        //enumList.add(new LabelValue(ZHONGZHUAN, "中专"));
        //enumList.add(new LabelValue(XIAOXUE, "小学"));
        //enumList.add(new LabelValue(CHUZHONG, "初中"));
        enumList.add(new LabelValue(DAZHUAN, "大专"));
        enumList.add(new LabelValue(ZHUANSHENGBEN, "专升本"));
        enumList.add(new LabelValue(BENKE, "本科"));
        //enumList.add(new LabelValue(YANJIUSHENG, "研究生"));
        enumList.add(new LabelValue(SHUOSHI, "硕士"));        
        enumList.add(new LabelValue(BOSHI, "博士"));

    }

    /**
     * 
     * 取得类型描述
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

    /**
     * 
     * 导入Excel时以字符串形式存储(如博士以boshi存储)
     * 
     * @since 2011-2-3
     * @author shanru.wu
     * @param label
     * @return
     */
    public static String getValue(String label)
    {
        for (LabelValue lv : enumList)
        {
            if (lv.getLabel().equals(label))
            {
                return lv.getValue();
            }
        }
        return "";
    }
}
