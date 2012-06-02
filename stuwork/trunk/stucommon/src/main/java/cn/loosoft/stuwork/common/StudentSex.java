package cn.loosoft.stuwork.common;

import java.util.ArrayList;
import java.util.List;

import cn.loosoft.common.vo.LabelValue;


/**
 * 学生性别
 *
 * @author            shanru.wu
 * @version           1.0
 * @since             2010-11-28
 */

public class StudentSex {
	private static final String MALE="m";
	private static final String FEMALE="f";
	
	public static List<LabelValue> enumList=new ArrayList<LabelValue>();
	static{
		enumList.add(new LabelValue(MALE,"男"));
		enumList.add(new LabelValue(FEMALE, "女"));
	}
	
}
