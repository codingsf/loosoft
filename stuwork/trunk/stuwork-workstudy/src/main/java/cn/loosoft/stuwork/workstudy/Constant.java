//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Ufinity. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Ufinity
//
// Original author: chengpeng.zhang
//
//-------------------------------------------------------------------------
// UFINITY MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
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
package cn.loosoft.stuwork.workstudy;

import java.util.List;

import cn.common.lib.vo.LabelValue;

import com.google.common.collect.Lists;

/**
 * 
 * 常量信息
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-1-20
 */
public class Constant
{
    public static String SAVE_SUCCESS   = "信息保存成功";

    public static String SAVE_FAILED    = "信息保存失败";

    public static String ZPZ            = "zpz";    // 招聘中

    public static String ZPTZ           = "zptz";   // 招聘停止

    public static String ZPTG           = "zptg";   // 招聘通过

    public static String ZPWTG          = "zpwtg";  // 招聘未通过

    public static String SHZ            = "shz";    // 审核中

    public static String SHTG           = "shtg";   // 审核通过

    public static String SHWTG          = "shwtg";  // 审核未通过

    public static String CHOSING        = "chosing"; // 选择中

    public static String APPLY          = "apply";  // 选择通过

    public static String PASS           = "pass";   // 选择未通过

    public static int    PAGE_SIZE      = 20;

    public static int    NEWS_PAGE_SIZE = 2;

    public static List<LabelValue> getRecruitList()
    {
        List<LabelValue> recruitList = Lists.newArrayList();
        recruitList.add(new LabelValue(ZPZ, "招聘中"));
        recruitList.add(new LabelValue(ZPTG, "招聘通过"));
        recruitList.add(new LabelValue(ZPWTG, "招聘未通过"));
        return recruitList;
    }

    public static List<LabelValue> getChoseList()
    {
        List<LabelValue> choseList = Lists.newArrayList();
        choseList.add(new LabelValue(CHOSING, "选择中"));
        choseList.add(new LabelValue(APPLY, "选择通过"));
        choseList.add(new LabelValue(PASS, "选择未通过"));
        return choseList;
    }

    public static List<LabelValue> getStatusList()
    {
        List<LabelValue> statusList = Lists.newArrayList();
        statusList.add(new LabelValue(SHZ, "审核中"));
        statusList.add(new LabelValue(SHTG, "审核通过"));
        statusList.add(new LabelValue(SHWTG, "审核未通过"));
        return statusList;
    }

    public static void main(String[] args)
    {
        String str = "61267,61268,555,";
        System.out.println(str.indexOf("555,"));
    }
}
