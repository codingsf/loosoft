package cn.loosoft.stuwork.common;

import java.util.ArrayList;
import java.util.List;

import cn.loosoft.common.vo.LabelValue;

/**
 * 学位类别
 * 学士
 * 硕士
 * 博士
 *
 * @author            shanru.wu
 * @version           1.0
 * @since             2010-12-12
 */

public class Degree {
	
	    public static final String XUESHI="xs";
	    public static final String SHUOSHI="ss";
	    public static final String BOSHI="bs";

	    public static List<LabelValue> enumList = new ArrayList<LabelValue>();

	    static{
	        enumList.add(new LabelValue(XUESHI, "学士"));
	        enumList.add(new LabelValue(SHUOSHI, "硕士"));
	        enumList.add(new LabelValue(BOSHI, "博士"));
	    }

	    /**
	     * 
	     * 取得类型描述
	     * @since  2010-12-12
	     * @author shanru.wu
	     * @param code
	     * @return
	     */
	    public static String getDesc(String code){
	        for(LabelValue lv:enumList){
	            if(lv.getValue().equals(code)){
	                return lv.getLabel();
	            }
	        }
	        return "";
	    } 
}
