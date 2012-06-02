package cn.loosoft.stuwork.common;

import java.util.ArrayList;
import java.util.List;

import cn.loosoft.common.vo.LabelValue;

/**
 * 婚姻状况
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-12
 */

public class Marriage
{

    public static final String     YIHUEN   = "yh";

    public static final String     WEIHUEN  = "wh";

    public static final String     LIYI     = "ly";

    public static final String     SANGOU   = "so";

    public static final String     WUPEIOU  = "wpo";

    public static final String     TONGJU   = "tj";

    public static List<LabelValue> enumList = new ArrayList<LabelValue>();

    static
    {
        enumList.add(new LabelValue(YIHUEN, "已婚"));
        enumList.add(new LabelValue(WEIHUEN, "未婚"));
        enumList.add(new LabelValue(LIYI, "离异"));
        enumList.add(new LabelValue(SANGOU, "丧偶"));
        //enumList.add(new LabelValue(WUPEIOU, "无配偶"));
        //enumList.add(new LabelValue(TONGJU, "同居"));
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
     * 导入Excel时以字符串形式存储(如已婚以yh存储)
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
