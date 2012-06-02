package cn.loosoft.stuwork.common;

import java.util.ArrayList;
import java.util.List;

import cn.loosoft.common.vo.LabelValue;

/**
 * 学生学制
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-11-28
 */

public class StudentLength
{

    public static final String     XUEZHIYI  = "一";

    public static final String     XUEZHIER  = "二";

    public static final String     XUEZHISAN = "三";

    public static final String     XUEZHISI  = "四";

    public static final String     XUEZHIWU  = "五";

    public static List<LabelValue> enumList  = new ArrayList<LabelValue>();

    static
    {
        enumList.add(new LabelValue(XUEZHIYI, "一"));
        enumList.add(new LabelValue(XUEZHIER, "二"));
        enumList.add(new LabelValue(XUEZHISAN, "三"));
        enumList.add(new LabelValue(XUEZHISI, "四"));
        enumList.add(new LabelValue(XUEZHIWU, "五"));
    }

}