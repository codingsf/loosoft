package cn.loosoft.stuwork.common;

import java.util.ArrayList;
import java.util.List;

import cn.loosoft.common.vo.LabelValue;

/**
 * 名族
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-12
 */

public class Nation
{

    public static final String     HANZU       = "hanzu";

    public static final String     ANCHANGZU   = "anchangzu";

    public static final String     BAIZU       = "baizu";

    public static final String     BAOANZU     = "baoanzu";

    public static final String     BULANGZU    = "bulangzu";

    public static final String     BUYIZU      = "buyizu";

    public static final String     CHAOXIANZU  = "chaoxianzu";

    public static final String     DAIZU       = "daizu";

    public static final String     DAHANERZU   = "dahanerzu";

    public static final String     DEANGZU     = "deangzu";

    public static final String     DONGXIANGZU = "dongxiangzu";

    public static final String     TONGZU      = "tongzu";

    public static final String     DULONGZU    = "dulongzu";

    public static final String     ENWENKEZU   = "enwenkezu";

    public static final String     ENLUNCHUNZU = "enlunchunzu";

    public static final String     ELUOSIZU    = "eluosizu";

    public static final String     GAOSHANGZU  = "gaoshangzu";

    public static final String     HASANKEZU   = "hasankezu";

    public static final String     HANLIZU     = "hanlizu";

    public static final String     HEZHEZU     = "hezuezu";

    public static final String     HUIZU       = "huizu";

    public static final String     JINUOZU     = "jinuozu";

    public static final String     JINGBOZU    = "jingbozu";

    public static final String     JINGZU      = "jingzu";

    public static final String     MEBAZU      = "mebazu";

    public static final String     MENGGUZU    = "mengguzu";

    public static final String     MIAOZU      = "miaozu";

    public static final String     MELAOZU     = "melaozu";

    public static final String     NAXIZU      = "naxizu";

    public static final String     NUZU        = "nuzu";

    public static final String     PUMIZU      = "pumizu";

    public static final String     JIANGZU     = "jiangzu";

    public static final String     SALAZU      = "salanzu";

    public static final String     SHEZU       = "shezu";

    public static final String     SHUIZU      = "shuizu";

    public static final String     TATAERZU    = "tataerzu";

    public static final String     TAJIKEZU    = "tajikezu";

    public static final String     TUZU        = "tuzu";

    public static final String     TUJIAZU     = "tujiazu";

    public static final String     WAZU        = "wazu";

    public static final String     WEIWUERZU   = "weiwuerzu";

    public static final String     WUZIBIEKEZU = "wuzibiekezu";

    public static final String     XIBOZU      = "xibozu";

    public static final String     YAOZU       = "yaozu";

    public static final String     YIZU        = "yizu";

    public static final String     YUGUZU      = "yuguzu";

    public static final String     ZANGZU      = "zangzu";

    public static final String     ZHUANGZU    = "zhuangzu";

    public static final String     KEERKEZIZU  = "keerkezizu";

    public static final String     LAHUZU      = "lahuzu";

    public static final String     LIZU        = "lizu";

    public static final String     SUSUZU      = "susuzu";

    public static final String     LUOBAZU     = "luobazu";

    public static final String     MANZU       = "manzu";

    public static final String     MAONANZU    = "maonanzu";

    public static final String     GELAOZU     = "gelaozu";

    public static List<LabelValue> enumList    = new ArrayList<LabelValue>();

    static
    {

        enumList.add(new LabelValue(HANZU, "汉族"));
        enumList.add(new LabelValue(ANCHANGZU, "阿昌族"));
        enumList.add(new LabelValue(BAIZU, "白族"));
        enumList.add(new LabelValue(BAOANZU, "保安族"));
        enumList.add(new LabelValue(BULANGZU, "布朗族"));
        enumList.add(new LabelValue(BUYIZU, "布依族"));
        enumList.add(new LabelValue(CHAOXIANZU, "朝鲜族"));
        enumList.add(new LabelValue(DAIZU, "傣族"));
        enumList.add(new LabelValue(DAHANERZU, "达斡尔族"));
        enumList.add(new LabelValue(DEANGZU, "德昂族"));
        enumList.add(new LabelValue(DONGXIANGZU, "东乡族"));
        enumList.add(new LabelValue(TONGZU, "侗族"));
        enumList.add(new LabelValue(DULONGZU, "独龙族 "));
        enumList.add(new LabelValue(ENWENKEZU, "鄂温克族"));
        enumList.add(new LabelValue(ENLUNCHUNZU, "鄂伦春族"));
        enumList.add(new LabelValue(ELUOSIZU, "俄罗斯族"));
        enumList.add(new LabelValue(GAOSHANGZU, "高山族"));
        enumList.add(new LabelValue(HASANKEZU, "哈萨克族"));
        enumList.add(new LabelValue(HANLIZU, "哈尼族"));
        enumList.add(new LabelValue(HEZHEZU, "赫哲族"));
        enumList.add(new LabelValue(HUIZU, "回族"));
        enumList.add(new LabelValue(JINUOZU, "基诺族"));
        enumList.add(new LabelValue(JINGBOZU, "景颇族"));
        enumList.add(new LabelValue(JINGZU, "京族"));
        enumList.add(new LabelValue(MEBAZU, "门巴族"));
        enumList.add(new LabelValue(MENGGUZU, "蒙古族"));
        enumList.add(new LabelValue(MIAOZU, "苗族"));
        enumList.add(new LabelValue(MELAOZU, "仫佬族 "));
        enumList.add(new LabelValue(NAXIZU, "纳西族"));
        enumList.add(new LabelValue(NUZU, "怒族 "));
        enumList.add(new LabelValue(PUMIZU, "普米族"));
        enumList.add(new LabelValue(JIANGZU, "羌族"));
        enumList.add(new LabelValue(SALAZU, "撒拉族"));
        enumList.add(new LabelValue(SHEZU, "畲族"));
        enumList.add(new LabelValue(SHUIZU, "水族"));
        enumList.add(new LabelValue(TATAERZU, "塔塔尔族"));
        enumList.add(new LabelValue(TAJIKEZU, "塔吉克族"));
        enumList.add(new LabelValue(TUZU, "土族"));
        enumList.add(new LabelValue(TUJIAZU, "土家族"));
        enumList.add(new LabelValue(WAZU, "佤族"));
        enumList.add(new LabelValue(WEIWUERZU, "维吾尔族"));
        enumList.add(new LabelValue(WUZIBIEKEZU, "乌孜别克族"));
        enumList.add(new LabelValue(XIBOZU, "锡伯族"));
        enumList.add(new LabelValue(YAOZU, "瑶族"));
        enumList.add(new LabelValue(YIZU, "彝族 "));
        enumList.add(new LabelValue(YUGUZU, "裕固族"));
        enumList.add(new LabelValue(ZANGZU, "藏族"));
        enumList.add(new LabelValue(ZHUANGZU, "壮族"));
        enumList.add(new LabelValue(KEERKEZIZU, "柯尔克孜族"));
        enumList.add(new LabelValue(LAHUZU, "拉祜族"));
        enumList.add(new LabelValue(LIZU, "黎族"));
        enumList.add(new LabelValue(SUSUZU, "僳僳族"));
        enumList.add(new LabelValue(LUOBAZU, "珞巴族"));
        enumList.add(new LabelValue(ZHUANGZU, "壮族"));
        enumList.add(new LabelValue(MANZU, "满族"));
        enumList.add(new LabelValue(MAONANZU, "毛南族 "));
        enumList.add(new LabelValue(GELAOZU, "仡佬族"));

    }

    /**
     * 
     * 取得民族描述
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
     * 导入Excel时以字符串形式存储(如汉族以hanzu存储)
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
