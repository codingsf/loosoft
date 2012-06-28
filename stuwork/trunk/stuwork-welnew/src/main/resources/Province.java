package com.lansin;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts.util.LabelValueBean;

import com.lansin.util.ResourceUtil;
import com.lansin.util.StringUtil;

public class Province {
	//省份map
	public static Map<String, String> provinceMap= new LinkedHashMap<String, String>(10, 0.75f, true);
	//省份城市map
	public static Map<String, Map<String,String>> provincecityMap= new LinkedHashMap<String, Map<String,String>>(10, 0.75f, true);
	//城市map
	public static Map<String, String> beijingcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> shanghaicityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> tianjincityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> chongqingcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> sichuancityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> guizhoucityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> guangdongcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> zhejiangcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> fujiancityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> hunancityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> hubeicityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> shandongcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> shanxicityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> henancityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> hebeicityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> jilincityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> liaoningcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> heilongjiangcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> anhuicityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> jiangsucityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> jiangxicityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> hainancityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> shanxi2cityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> yunnancityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> qinghaicityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> ningxiacityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> gansucityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> xinjiangcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> xizangcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> guangxicityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> neimenggucityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> xianggangcityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> taiwancityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> aomencityMap= new LinkedHashMap<String, String>();
	public static Map<String, String> guowaicityMap= new LinkedHashMap<String, String>();

	static{
		//����ʡ��
		provinceMap.put("beijing", ResourceUtil.getValue("beijing","北京市"));
		provinceMap.put("beijing_jl","北京");
		provinceMap.put("tianjin", ResourceUtil.getValue("tianjin","天津市"));
		provinceMap.put("tianjin_jl","天津");
		provinceMap.put("hebei", ResourceUtil.getValue("hebei","河北省"));
		provinceMap.put("hebei_jl","河北");
		provinceMap.put("shanxi", ResourceUtil.getValue("shanxi","山西省"));
		provinceMap.put("shanxi_jl","山西");
		provinceMap.put("neimenggu", ResourceUtil.getValue("neimenggu","内蒙古自治区"));
		provinceMap.put("neimenggu_jl","内蒙古");
		provinceMap.put("liaoning", ResourceUtil.getValue("liaoning","辽宁省"));
		provinceMap.put("liaoning_jl","辽宁");
		provinceMap.put("jilin", ResourceUtil.getValue("jilin","吉林省"));
		provinceMap.put("jilin_jl","吉林");
		provinceMap.put("heilongjiang", ResourceUtil.getValue("heilongjiang","黑龙江省"));
		provinceMap.put("heilongjiang_jl","黑龙江");
		provinceMap.put("shanghai", ResourceUtil.getValue("shanghai","上海市"));
		provinceMap.put("shanghai_jl", "上海");
		provinceMap.put("jiangsu", ResourceUtil.getValue("jiangsu","江苏省"));
		provinceMap.put("jiangsu_jl","江苏");
		provinceMap.put("zhejiang", ResourceUtil.getValue("zhejiang","浙江省"));
		provinceMap.put("zhejiang_jl","浙江");
		provinceMap.put("anhui", ResourceUtil.getValue("anhui","安徽省"));
		provinceMap.put("anhui_jl","安徽");
		provinceMap.put("fujian", ResourceUtil.getValue("fujian","福建省"));
		provinceMap.put("fujian_jl", "福建");
		provinceMap.put("jiangxi", ResourceUtil.getValue("jiangxi","江西省"));
		provinceMap.put("jiangxi_jl", "江西");
		provinceMap.put("shandong", ResourceUtil.getValue("shandong","山东省"));
		provinceMap.put("shandong_jl","山东");
		provinceMap.put("henan", ResourceUtil.getValue("henan","河南省"));
		provinceMap.put("henan_jl","河南");
		provinceMap.put("hubei", ResourceUtil.getValue("hubei","湖北省"));
		provinceMap.put("hubei_jl","湖北");
		provinceMap.put("hunan", ResourceUtil.getValue("hunan","湖南省"));
		provinceMap.put("hunan_jl","湖南");
		provinceMap.put("guangdong", ResourceUtil.getValue("guangdong","广东省"));
		provinceMap.put("guangdong_jl", "广东");
		provinceMap.put("guangxi", ResourceUtil.getValue("guangxi","广西壮族自治区"));
		provinceMap.put("guangxi_jl","广西");
		provinceMap.put("hainan", ResourceUtil.getValue("hainan","海南省"));
		provinceMap.put("hainan_jl","海南");
		provinceMap.put("chongqing", ResourceUtil.getValue("chongqing","重庆市"));
		provinceMap.put("chongqing_jl","重庆");
		provinceMap.put("sichuan", ResourceUtil.getValue("sichuan","四川省"));
		provinceMap.put("sichuan_jl","四川");
		provinceMap.put("guizhou", ResourceUtil.getValue("guizhou","贵州省"));
		provinceMap.put("guizhou_jl","贵州");
		provinceMap.put("yunnan", ResourceUtil.getValue("yunnan","云南省"));
		provinceMap.put("yunnan_jl","云南");
		provinceMap.put("xizang", ResourceUtil.getValue("xizang","西藏自治区"));
		provinceMap.put("xizang_jl", "西藏");
		provinceMap.put("shanxi2", ResourceUtil.getValue("shanxi2","陕西省"));
		provinceMap.put("shanxi2_jl", "陕西");
		provinceMap.put("gansu", ResourceUtil.getValue("gansu","甘肃省"));
		provinceMap.put("gansu_jl", "甘肃");
		provinceMap.put("qinghai", ResourceUtil.getValue("qinghai","青海省"));
		provinceMap.put("qinghai_jl","青海");
		provinceMap.put("ningxia", ResourceUtil.getValue("ningxia","宁夏"));	
		provinceMap.put("ningxia_jl", "宁夏");	
		provinceMap.put("xinjiang", ResourceUtil.getValue("xinjiang","新疆维吾尔自治区"));
		provinceMap.put("xinjiang_jl","新疆");
		provinceMap.put("taiwan", ResourceUtil.getValue("taiwan","台湾"));
		provinceMap.put("taiwan_jl","台湾");		
		provinceMap.put("xianggang", ResourceUtil.getValue("xianggang","香港"));		
		provinceMap.put("xianggang_jl","香港");		
		provinceMap.put("aomen", ResourceUtil.getValue("aomen","澳门"));
		provinceMap.put("aomen_jl","澳门");
		provinceMap.put("guowai", ResourceUtil.getValue("guowai","国外"));
		provinceMap.put("guowai_jl","国外");
		//ÿ�����
		beijingcityMap.put("beijing",  ResourceUtil.getValue("beijing.beijing","北京市"));//����
		shanghaicityMap.put("shanghai",  ResourceUtil.getValue("shanghai.shanghai","上海市"));//�
		tianjincityMap.put("tianjin",  ResourceUtil.getValue("tianjin.tianjin","天津市"));//���
		chongqingcityMap.put("chongqing",  ResourceUtil.getValue("chongqing.chongqing","重庆市"));//����
		
		sichuancityMap.put("chengdu",  ResourceUtil.getValue("sichuan.chengdu","成都市"));//�Ĵ�
		sichuancityMap.put("zigong",  ResourceUtil.getValue("sichuan.zigong","自贡市"));
		sichuancityMap.put("panzhihua",  ResourceUtil.getValue("sichuan.panzhihua","攀枝花市"));
		sichuancityMap.put("luzhou",  ResourceUtil.getValue("sichuan.luzhou","泸州市"));
		sichuancityMap.put("deyang",  ResourceUtil.getValue("sichuan.deyang","德阳市"));
		sichuancityMap.put("mianyang",  ResourceUtil.getValue("sichuan.mianyang","绵阳市"));
		sichuancityMap.put("guangyuan",  ResourceUtil.getValue("sichuan.guangyuan","广元市"));
		sichuancityMap.put("suining",  ResourceUtil.getValue("sichuan.suining","遂宁市"));
		sichuancityMap.put("neijiang",  ResourceUtil.getValue("sichuan.neijiang","内江市"));
		sichuancityMap.put("leshan",  ResourceUtil.getValue("sichuan.leshan","乐山市"));
		sichuancityMap.put("nanchong",  ResourceUtil.getValue("sichuan.nanchong","南充市"));
		sichuancityMap.put("meishan",  ResourceUtil.getValue("sichuan.meishan","眉山市"));
		sichuancityMap.put("yibing",  ResourceUtil.getValue("sichuan.yibing","宜宾市"));
		sichuancityMap.put("guangan",  ResourceUtil.getValue("sichuan.guangan","广安市"));
		sichuancityMap.put("dazhou",  ResourceUtil.getValue("sichuan.dazhou","达州市"));
		sichuancityMap.put("yaan",  ResourceUtil.getValue("sichuan.yaan","雅安市"));
		sichuancityMap.put("bazhong",  ResourceUtil.getValue("sichuan.bazhong","巴中市"));
		sichuancityMap.put("ziyang",  ResourceUtil.getValue("sichuan.ziyang","资阳市"));
		sichuancityMap.put("aba",  ResourceUtil.getValue("sichuan.aba","阿坝州"));
		sichuancityMap.put("ganzi",  ResourceUtil.getValue("sichuan.ganzi","甘孜州"));
		sichuancityMap.put("liangshan",  ResourceUtil.getValue("sichuan.liangshan","凉山州"));
		
		guizhoucityMap.put("guiyang",  ResourceUtil.getValue("guizhou.guiyang","贵阳市"));//����
		guizhoucityMap.put("liupanshui",  ResourceUtil.getValue("guizhou.liupanshui","六盘水市"));
		guizhoucityMap.put("zunyi",  ResourceUtil.getValue("guizhou.zunyi","遵义市"));
		guizhoucityMap.put("anshun",  ResourceUtil.getValue("guizhou.anshun","安顺市"));
		guizhoucityMap.put("tongren",  ResourceUtil.getValue("guizhou.tongren","铜仁地区"));
		guizhoucityMap.put("qianxinan",  ResourceUtil.getValue("guizhou.qianxinan","黔西南州"));
		guizhoucityMap.put("bijie",  ResourceUtil.getValue("guizhou.bijie","毕节地区"));
		guizhoucityMap.put("qiandongnan",  ResourceUtil.getValue("guizhou.qiandongnan","黔东南州"));
		guizhoucityMap.put("qiannan",  ResourceUtil.getValue("guizhou.qiannan","黔南州"));
		
		guangdongcityMap.put("guangzhou",  ResourceUtil.getValue("guangdong.guangzhou","广州市"));//�㶫
		guangdongcityMap.put("shaoguan",  ResourceUtil.getValue("guangdong.shaoguan","韶关市"));
		guangdongcityMap.put("shenzhen",  ResourceUtil.getValue("guangdong.shenzhen","深圳市"));
		guangdongcityMap.put("zhuhai",  ResourceUtil.getValue("guangdong.zhuhai","珠海市"));
		guangdongcityMap.put("shantou",  ResourceUtil.getValue("guangdong.shantou","汕头市"));
		guangdongcityMap.put("foshan",  ResourceUtil.getValue("guangdong.foshan","佛山市"));
		guangdongcityMap.put("jiangmen",  ResourceUtil.getValue("guangdong.jiangmen","江门市"));
		guangdongcityMap.put("zhanjiang",  ResourceUtil.getValue("guangdong.zhanjiang","湛江市"));
		guangdongcityMap.put("maoming",  ResourceUtil.getValue("guangdong.maoming","茂名市"));
		guangdongcityMap.put("zhaoqing",  ResourceUtil.getValue("guangdong.zhaoqing","肇庆市"));
		guangdongcityMap.put("huizhou",  ResourceUtil.getValue("guangdong.huizhou","惠州市"));
		guangdongcityMap.put("meizhou",  ResourceUtil.getValue("guangdong.meizhou","梅州市"));
		guangdongcityMap.put("shanwei",  ResourceUtil.getValue("guangdong.shanwei","汕尾市"));
		guangdongcityMap.put("heyuan",  ResourceUtil.getValue("guangdong.heyuan","河源市"));
		guangdongcityMap.put("yangjiang",  ResourceUtil.getValue("guangdong.yangjiang","阳江市"));
		guangdongcityMap.put("qingyuan",  ResourceUtil.getValue("guangdong.qingyuan","清远市"));
		guangdongcityMap.put("dongguan",  ResourceUtil.getValue("guangdong.dongguan","东莞市"));
		guangdongcityMap.put("zhongshan",  ResourceUtil.getValue("guangdong.zhongshan","中山市"));
		guangdongcityMap.put("chaozhou",  ResourceUtil.getValue("guangdong.chaozhou","潮州市"));
		guangdongcityMap.put("jieyang",  ResourceUtil.getValue("guangdong.jieyang","揭阳市"));
		guangdongcityMap.put("yunfu",  ResourceUtil.getValue("guangdong.yunfu","云浮市"));
		
		zhejiangcityMap.put("hangzhou",  ResourceUtil.getValue("zhejiang.hangzhou","杭州市"));//�㽭
		zhejiangcityMap.put("ningbo",  ResourceUtil.getValue("zhejiang.ningbo","宁波市"));
		zhejiangcityMap.put("wenzhou",  ResourceUtil.getValue("zhejiang.wenzhou","温州市"));
		zhejiangcityMap.put("jiaxing",  ResourceUtil.getValue("zhejiang.jiaxing","嘉兴市"));
		zhejiangcityMap.put("huzhou",  ResourceUtil.getValue("zhejiang.huzhou","湖州市"));
		zhejiangcityMap.put("shaoxing",  ResourceUtil.getValue("zhejiang.shaoxing","绍兴市"));
		zhejiangcityMap.put("jinhua",  ResourceUtil.getValue("zhejiang.jinhua","金华市"));
		zhejiangcityMap.put("quzhou",  ResourceUtil.getValue("zhejiang.quzhou","衢州市"));
		zhejiangcityMap.put("zhoushan",  ResourceUtil.getValue("zhejiang.zhoushan","中山市"));
		zhejiangcityMap.put("taizhou",  ResourceUtil.getValue("zhejiang.taizhou","台州市"));
		zhejiangcityMap.put("lishui",  ResourceUtil.getValue("zhejiang.lishui","丽水市"));
		
		fujiancityMap.put("fuzhou",  ResourceUtil.getValue("fujian.fuzhou","福州市"));//����
		fujiancityMap.put("xiamen",  ResourceUtil.getValue("fujian.xiamen","厦门市"));
		fujiancityMap.put("putian",  ResourceUtil.getValue("fujian.putian","莆田市"));
		fujiancityMap.put("sanming",  ResourceUtil.getValue("fujian.sanming","三明市"));
		fujiancityMap.put("quanzhou",  ResourceUtil.getValue("fujian.quanzhou","泉州市"));
		fujiancityMap.put("zhangzhou",  ResourceUtil.getValue("fujian.zhangzhou","漳州市"));
		fujiancityMap.put("nanping",  ResourceUtil.getValue("fujian.nanping","南平市"));
		fujiancityMap.put("longyan",  ResourceUtil.getValue("fujian.longyan","龙岩市"));
		fujiancityMap.put("ningde",  ResourceUtil.getValue("fujian.ningde","宁德市"));
		
		hunancityMap.put("changsha",  ResourceUtil.getValue("hunan.changsha","长沙市"));//����
		hunancityMap.put("zhuzhou",  ResourceUtil.getValue("hunan.zhuzhou","株州市"));
		hunancityMap.put("xiangtan",  ResourceUtil.getValue("hunan.xiangtan","湘潭市"));
		hunancityMap.put("hengyang",  ResourceUtil.getValue("hunan.hengyang","衡阳市"));
		hunancityMap.put("shaoyang",  ResourceUtil.getValue("hunan.shaoyang","邵阳市"));
		hunancityMap.put("yueyang",  ResourceUtil.getValue("hunan.yueyang","岳阳市"));
		hunancityMap.put("changde",  ResourceUtil.getValue("hunan.changde","常德市"));
		hunancityMap.put("zhangjiajie",  ResourceUtil.getValue("hunan.zhangjiajie","张家界市"));
		hunancityMap.put("yiyang",  ResourceUtil.getValue("hunan.yiyang","益阳市"));
		hunancityMap.put("chenzhou",  ResourceUtil.getValue("hunan.chenzhou","郴州市"));
		hunancityMap.put("yongzhou",  ResourceUtil.getValue("hunan.yongzhou","永州市"));
		hunancityMap.put("huaihua",  ResourceUtil.getValue("hunan.huaihua","怀化市"));
		hunancityMap.put("loudi",  ResourceUtil.getValue("hunan.loudi","娄底市"));
		hunancityMap.put("xiangxi",  ResourceUtil.getValue("hunan.xiangxi","湘西州"));
		
		hubeicityMap.put("wuhan",  ResourceUtil.getValue("hubei.wuhan","武汉市"));//����
		hubeicityMap.put("huangshi",  ResourceUtil.getValue("hubei.huangshi","黄石市"));
		hubeicityMap.put("shiyan",  ResourceUtil.getValue("hubei.shiyan","十堰市"));
		hubeicityMap.put("yichang",  ResourceUtil.getValue("hubei.yichang","宜昌市"));
		hubeicityMap.put("xiangfan",  ResourceUtil.getValue("hubei.xiangfan","襄樊市"));
		hubeicityMap.put("ezhou",  ResourceUtil.getValue("hubei.ezhou","鄂州市"));
		hubeicityMap.put("jingmen",  ResourceUtil.getValue("hubei.jingmen","荆门市"));
		hubeicityMap.put("xiaogan",  ResourceUtil.getValue("hubei.xiaogan","孝感市"));
		hubeicityMap.put("jingzhou",  ResourceUtil.getValue("hubei.jingzhou","荆州市"));
		hubeicityMap.put("huanggang",  ResourceUtil.getValue("hubei.huanggang","黄冈市"));
		hubeicityMap.put("xianning",  ResourceUtil.getValue("hubei.xianning","咸宁市"));
		hubeicityMap.put("suizhou",  ResourceUtil.getValue("hubei.suizhou","随州市"));
		hubeicityMap.put("enshi",  ResourceUtil.getValue("hubei.enshi","恩施州"));
		hubeicityMap.put("xiantao",  ResourceUtil.getValue("hubei.xiantao","仙桃市"));
		
		shandongcityMap.put("jinan",  ResourceUtil.getValue("shandong.jinan","济南市"));//ɽ��
		shandongcityMap.put("qingdao",  ResourceUtil.getValue("shandong.qingdao","青岛市"));
		shandongcityMap.put("zibo",  ResourceUtil.getValue("shandong.zibo","淄博市"));
		shandongcityMap.put("zaozhuang",  ResourceUtil.getValue("shandong.zaozhuang","枣庄市"));
		shandongcityMap.put("dongying",  ResourceUtil.getValue("shandong.dongying","东营市"));
		shandongcityMap.put("yantai",  ResourceUtil.getValue("shandong.yantai","烟台市"));
		shandongcityMap.put("weifang",  ResourceUtil.getValue("shandong.weifang","潍坊市"));
		shandongcityMap.put("jining",  ResourceUtil.getValue("shandong.jining","济宁市"));
		shandongcityMap.put("taian",  ResourceUtil.getValue("shandong.taian","泰安市"));
		shandongcityMap.put("weihai",  ResourceUtil.getValue("shandong.weihai","威海市"));
		shandongcityMap.put("rizhao",  ResourceUtil.getValue("shandong.rizhao","日照市"));
		shandongcityMap.put("laiwu",  ResourceUtil.getValue("shandong.laiwu","莱芜市"));
		shandongcityMap.put("linyi",  ResourceUtil.getValue("shandong.linyi","临沂市"));
		shandongcityMap.put("dezhou",  ResourceUtil.getValue("shandong.dezhou","德州市"));
		shandongcityMap.put("liaocheng",  ResourceUtil.getValue("shandong.liaocheng","聊城市"));
		shandongcityMap.put("binzhou",  ResourceUtil.getValue("shandong.binzhou","滨州市"));
		shandongcityMap.put("heze",  ResourceUtil.getValue("shandong.heze","菏泽市"));
		
		shanxicityMap.put("taiyuan",  ResourceUtil.getValue("shanxi.taiyuan","太原市"));//ɽ��
		shanxicityMap.put("datong",  ResourceUtil.getValue("shanxi.datong","大同市"));
		shanxicityMap.put("yangquan",  ResourceUtil.getValue("shanxi.yangquan","阳泉市"));
		shanxicityMap.put("changzhi",  ResourceUtil.getValue("shanxi.changzhi","长治市"));
		shanxicityMap.put("jincheng",  ResourceUtil.getValue("shanxi.jincheng","晋城市"));
		shanxicityMap.put("shuozhou",  ResourceUtil.getValue("shanxi.shuozhou","朔州市"));
		shanxicityMap.put("jinzhong",  ResourceUtil.getValue("shanxi.jinzhong","晋中市"));
		shanxicityMap.put("yuncheng",  ResourceUtil.getValue("shanxi.yuncheng","运城市"));
		shanxicityMap.put("xinzhou",  ResourceUtil.getValue("shanxi.xinzhou","忻州市"));
		shanxicityMap.put("linfen",  ResourceUtil.getValue("shanxi.linfen","临汾市"));
		shanxicityMap.put("lvliang",  ResourceUtil.getValue("shanxi.lvliang","吕梁市"));
		
		henancityMap.put("zhengzhou",  ResourceUtil.getValue("henan.zhengzhou","郑州市"));//����
		henancityMap.put("kaifeng",  ResourceUtil.getValue("henan.kaifeng","开封市"));
		henancityMap.put("luoyang",  ResourceUtil.getValue("henan.luoyang","洛阳市"));
		henancityMap.put("pingdingshan",  ResourceUtil.getValue("henan.pingdingshan","平顶山市"));
		henancityMap.put("anyang",  ResourceUtil.getValue("henan.anyang","安阳市"));
		henancityMap.put("hebi",  ResourceUtil.getValue("henan.hebi","鹤壁市"));
		henancityMap.put("xinxiang",  ResourceUtil.getValue("henan.xinxiang","新乡市"));
		henancityMap.put("jiaozuo",  ResourceUtil.getValue("henan.jiaozuo","焦作市"));
		henancityMap.put("puyang",  ResourceUtil.getValue("henan.puyang","濮阳市"));
		henancityMap.put("xuchang",  ResourceUtil.getValue("henan.xuchang","许昌市"));
		henancityMap.put("luohe",  ResourceUtil.getValue("henan.luohe","漯河市"));
		henancityMap.put("sanmenxia",  ResourceUtil.getValue("henan.sanmenxia","三门峡市"));
		henancityMap.put("nanyang",  ResourceUtil.getValue("henan.nanyang","南阳市"));
		henancityMap.put("shangqiu",  ResourceUtil.getValue("henan.shangqiu","商丘市"));
		henancityMap.put("xinyang",  ResourceUtil.getValue("henan.xinyang","信阳市"));
		henancityMap.put("zhoukou",  ResourceUtil.getValue("henan.zhoukou","周口市"));
		henancityMap.put("zhumadian",  ResourceUtil.getValue("henan.zhumadian","驻马店市"));
		henancityMap.put("jiyuan",  ResourceUtil.getValue("henan.jiyuan","济源市"));
		
		hebeicityMap.put("shijiazhuang",  ResourceUtil.getValue("hebei.shijiazhuang","石家庄市"));//�ӱ�
		hebeicityMap.put("tangshan",  ResourceUtil.getValue("hebei.tangshan","唐山市"));
		hebeicityMap.put("qinhuangdao",  ResourceUtil.getValue("hebei.qinhuangdao","秦皇岛市"));
		hebeicityMap.put("handan",  ResourceUtil.getValue("hebei.handan","邯郸市"));
		hebeicityMap.put("xingtai",  ResourceUtil.getValue("hebei.xingtai","邢台市"));
		hebeicityMap.put("baoding",  ResourceUtil.getValue("hebei.baoding","保定市"));
		hebeicityMap.put("zhangjiakou",  ResourceUtil.getValue("hebei.zhangjiakou","张家口市"));
		hebeicityMap.put("chengde",  ResourceUtil.getValue("hebei.chengde","承德市"));
		hebeicityMap.put("cangzhou",  ResourceUtil.getValue("hebei.cangzhou","沧州市"));
		hebeicityMap.put("langfang",  ResourceUtil.getValue("hebei.langfang","廊坊市"));
		hebeicityMap.put("hengshui",  ResourceUtil.getValue("hebei.hengshui","衡水市"));
		
		jilincityMap.put("changchun",  ResourceUtil.getValue("jilin.changchun","长春市"));//����
		jilincityMap.put("jilin",  ResourceUtil.getValue("jilin.jilin","吉林市"));
		jilincityMap.put("siping",  ResourceUtil.getValue("jilin.siping","四平市"));
		jilincityMap.put("liaoyuan",  ResourceUtil.getValue("jilin.liaoyuan","辽源市"));
		jilincityMap.put("tonghua",  ResourceUtil.getValue("jilin.tonghua","通化市"));
		jilincityMap.put("baishan",  ResourceUtil.getValue("jilin.baishan","白山市"));
		jilincityMap.put("songyuan",  ResourceUtil.getValue("jilin.songyuan","松原市"));
		jilincityMap.put("baicheng",  ResourceUtil.getValue("jilin.baicheng","白城市"));
		jilincityMap.put("yanbian",  ResourceUtil.getValue("jilin.yanbian","延边州"));
		
		liaoningcityMap.put("shenyang",  ResourceUtil.getValue("liaoning.shenyang","沈阳市"));//����
		liaoningcityMap.put("dalian",  ResourceUtil.getValue("liaoning.dalian","大连市"));
		liaoningcityMap.put("anshan",  ResourceUtil.getValue("liaoning.anshan","鞍山市"));
		liaoningcityMap.put("fushun",  ResourceUtil.getValue("liaoning.fushun","抚顺市"));
		liaoningcityMap.put("benxi",  ResourceUtil.getValue("liaoning.benxi","本溪市"));
		liaoningcityMap.put("dandong",  ResourceUtil.getValue("liaoning.dandong","丹东市"));
		liaoningcityMap.put("jinzhou",  ResourceUtil.getValue("liaoning.jinzhou","锦州市"));
		liaoningcityMap.put("yingkou",  ResourceUtil.getValue("liaoning.yingkou","营口市"));
		liaoningcityMap.put("fuxin",  ResourceUtil.getValue("liaoning.fuxin","阜新市"));
		liaoningcityMap.put("liaoyang",  ResourceUtil.getValue("liaoning.liaoyang","辽阳市"));
		liaoningcityMap.put("panjin",  ResourceUtil.getValue("liaoning.panjin","盘锦市"));
		liaoningcityMap.put("tieling",  ResourceUtil.getValue("liaoning.tieling","铁岭市"));
		liaoningcityMap.put("chaoyang",  ResourceUtil.getValue("liaoning.chaoyang","朝阳市"));
		liaoningcityMap.put("huludao",  ResourceUtil.getValue("liaoning.huludao","葫芦岛市"));
		
		heilongjiangcityMap.put("haerbin",  ResourceUtil.getValue("heilongjiang.haerbin","哈尔滨市"));//����
		heilongjiangcityMap.put("qiqihaer",  ResourceUtil.getValue("heilongjiang.qiqihaer","齐齐哈尔市"));
		heilongjiangcityMap.put("jixi",  ResourceUtil.getValue("heilongjiang.jixi","鸡西市"));
		heilongjiangcityMap.put("hegang",  ResourceUtil.getValue("heilongjiang.hegang","鹤岗市"));
		heilongjiangcityMap.put("shuangyashan",  ResourceUtil.getValue("heilongjiang.shuangyashan","双鸭山市"));
		heilongjiangcityMap.put("daqing",  ResourceUtil.getValue("heilongjiang.daqing","大庆市"));
		heilongjiangcityMap.put("yichun",  ResourceUtil.getValue("heilongjiang.yichun","伊春市"));
		heilongjiangcityMap.put("jiamusi",  ResourceUtil.getValue("heilongjiang.jiamusi","佳木斯市"));
		heilongjiangcityMap.put("qitaihe",  ResourceUtil.getValue("heilongjiang.qitaihe","七台河市"));
		heilongjiangcityMap.put("mudanjiang",  ResourceUtil.getValue("heilongjiang.mudanjiang","牡丹江市"));
		heilongjiangcityMap.put("heihe",  ResourceUtil.getValue("heilongjiang.heihe","黑河市"));
		heilongjiangcityMap.put("suihua",  ResourceUtil.getValue("heilongjiang.suihua","绥化市"));
		heilongjiangcityMap.put("daxinganling",  ResourceUtil.getValue("heilongjiang.daxinganling","大兴安岭地区"));
		
		anhuicityMap.put("hefei",  ResourceUtil.getValue("anhui.hefei","合肥市"));//����
		anhuicityMap.put("wuhu",  ResourceUtil.getValue("anhui.wuhu","芜湖市"));
		anhuicityMap.put("bengbu",  ResourceUtil.getValue("anhui.bengbu","蚌埠市"));
		anhuicityMap.put("huainan",  ResourceUtil.getValue("anhui.huainan","淮南市"));
		anhuicityMap.put("maanshan",  ResourceUtil.getValue("anhui.maanshan","马鞍山市"));
		anhuicityMap.put("huaibei",  ResourceUtil.getValue("anhui.huaibei","淮北市"));
		anhuicityMap.put("tongling",  ResourceUtil.getValue("anhui.tongling","铜陵市"));
		anhuicityMap.put("anqing",  ResourceUtil.getValue("anhui.anqing","安庆市"));
		anhuicityMap.put("huangshan",  ResourceUtil.getValue("anhui.huangshan","黄山市"));
		anhuicityMap.put("chuzhou",  ResourceUtil.getValue("anhui.chuzhou","滁州市"));
		anhuicityMap.put("fuyang",  ResourceUtil.getValue("anhui.fuyang","阜阳市	"));
		anhuicityMap.put("suzhou",  ResourceUtil.getValue("anhui.suzhou","宿州市"));
		anhuicityMap.put("chaohu",  ResourceUtil.getValue("anhui.chaohu","巢湖市"));
		anhuicityMap.put("luan",  ResourceUtil.getValue("anhui.luan","六安市"));
		anhuicityMap.put("bozhou",  ResourceUtil.getValue("anhui.bozhou","亳州市"));
		anhuicityMap.put("chizhou",  ResourceUtil.getValue("anhui.chizhou","池州市"));
		anhuicityMap.put("xuancheng",  ResourceUtil.getValue("anhui.xuancheng","宣城市"));
		
		jiangsucityMap.put("nanjing",  ResourceUtil.getValue("jiangsu.nanjing","南京市"));//����
		jiangsucityMap.put("wuxi",  ResourceUtil.getValue("jiangsu.wuxi","无锡市"));
		jiangsucityMap.put("xuzhou",  ResourceUtil.getValue("jiangsu.xuzhou","徐州市"));
		jiangsucityMap.put("changzhou",  ResourceUtil.getValue("jiangsu.changzhou","常州市"));
		jiangsucityMap.put("suzhou",  ResourceUtil.getValue("jiangsu.suzhou","苏州市"));
		jiangsucityMap.put("nantong",  ResourceUtil.getValue("jiangsu.nantong","南通市"));
		jiangsucityMap.put("lianyungang",  ResourceUtil.getValue("jiangsu.lianyungang","连云港市"));
		jiangsucityMap.put("huaian",  ResourceUtil.getValue("jiangsu.huaian","淮安市"));
		jiangsucityMap.put("yancheng",  ResourceUtil.getValue("jiangsu.yancheng","盐城市"));
		jiangsucityMap.put("yangzhou",  ResourceUtil.getValue("jiangsu.yangzhou","扬州市"));
		jiangsucityMap.put("zhenjiang",  ResourceUtil.getValue("jiangsu.zhenjiang","镇江市"));
		jiangsucityMap.put("taizhou",  ResourceUtil.getValue("jiangsu.taizhou","泰州市"));
		jiangsucityMap.put("suqian",  ResourceUtil.getValue("jiangsu.suqian","宿迁市"));
		jiangsucityMap.put("kunshan",  ResourceUtil.getValue("jiangsu.kunshan","昆山市"));
		
		jiangxicityMap.put("nanchang",  ResourceUtil.getValue("jiangxi.nanchang","南昌市"));//����
		jiangxicityMap.put("jingdezhen",  ResourceUtil.getValue("jiangxi.jingdezhen","景德镇市"));
		jiangxicityMap.put("pingxiang",  ResourceUtil.getValue("jiangxi.pingxiang","萍乡市"));
		jiangxicityMap.put("jiujiang",  ResourceUtil.getValue("jiangxi.jiujiang","九江市"));
		jiangxicityMap.put("xinyu",  ResourceUtil.getValue("jiangxi.xinyu","新余市"));
		jiangxicityMap.put("yingtan",  ResourceUtil.getValue("jiangxi.yingtan","鹰潭市"));
		jiangxicityMap.put("ganzhou",  ResourceUtil.getValue("jiangxi.ganzhou","赣州市"));
		jiangxicityMap.put("jian",  ResourceUtil.getValue("jiangxi.jian","吉安市"));
		jiangxicityMap.put("yichun",  ResourceUtil.getValue("jiangxi.yichun","宜春市"));
		jiangxicityMap.put("fuzhou",  ResourceUtil.getValue("jiangxi.fuzhou","抚州市"));
		jiangxicityMap.put("shangrao",  ResourceUtil.getValue("jiangxi.shangrao","上饶市"));
		
		hainancityMap.put("haikou",  ResourceUtil.getValue("hainan.haikou","海口市"));//����
		hainancityMap.put("sanya",  ResourceUtil.getValue("hainan.sanya","三亚市"));
		hainancityMap.put("wuzhishan",  ResourceUtil.getValue("hainan.wuzhishan","五指山市"));
		hainancityMap.put("qionghai",  ResourceUtil.getValue("hainan.qionghai","琼海市"));
		hainancityMap.put("danzhou",  ResourceUtil.getValue("hainan.danzhou","儋州市"));
		hainancityMap.put("qiongshan",  ResourceUtil.getValue("hainan.qiongshan","琼山市"));
		hainancityMap.put("wenchang",  ResourceUtil.getValue("hainan.wenchang","文昌市"));
		hainancityMap.put("wanning",  ResourceUtil.getValue("hainan.wanning","万宁市"));
		hainancityMap.put("dongfang",  ResourceUtil.getValue("hainan.dongfang","东方市"));
		
		shanxi2cityMap.put("xian",  ResourceUtil.getValue("shanxi2.xian","西安市"));//����
		shanxi2cityMap.put("tongchuan",  ResourceUtil.getValue("shanxi2.tongchuan","铜川市"));
		shanxi2cityMap.put("baoji",  ResourceUtil.getValue("shanxi2.baoji","宝鸡市"));
		shanxi2cityMap.put("xianyang",  ResourceUtil.getValue("shanxi2.xianyang","咸阳市"));
		shanxi2cityMap.put("weinan",  ResourceUtil.getValue("shanxi2.weinan","渭南市"));
		shanxi2cityMap.put("yanan",  ResourceUtil.getValue("shanxi2.yanan","延安市"));
		shanxi2cityMap.put("hanzhong",  ResourceUtil.getValue("shanxi2.hanzhong","汉中市"));
		shanxi2cityMap.put("yulin",  ResourceUtil.getValue("shanxi2.yulin","榆林市"));
		shanxi2cityMap.put("ankang",  ResourceUtil.getValue("shanxi2.ankang","安康市"));
		shanxi2cityMap.put("shangluo",  ResourceUtil.getValue("shanxi2.shangluo","商洛市"));
		
		yunnancityMap.put("kunming",  ResourceUtil.getValue("yunnan.kunming","昆明市"));//����
		yunnancityMap.put("qujing",  ResourceUtil.getValue("yunnan.qujing","曲靖市"));
		yunnancityMap.put("yuxi",  ResourceUtil.getValue("yunnan.yuxi","玉溪市"));
		yunnancityMap.put("baoshan",  ResourceUtil.getValue("yunnan.baoshan","保山市"));
		yunnancityMap.put("zhaotong",  ResourceUtil.getValue("yunnan.zhaotong","昭通市"));
		yunnancityMap.put("chuxiong",  ResourceUtil.getValue("yunnan.chuxiong","楚雄州"));
		yunnancityMap.put("honghe",  ResourceUtil.getValue("yunnan.honghe","红河州"));
		yunnancityMap.put("wenshan",  ResourceUtil.getValue("yunnan.wenshan","文山州"));
		yunnancityMap.put("simao",  ResourceUtil.getValue("yunnan.simao","思茅市"));
		yunnancityMap.put("xishuangbanna",  ResourceUtil.getValue("yunnan.xishuangbanna","西双版纳州"));
		yunnancityMap.put("dali",  ResourceUtil.getValue("yunnan.dali","大理州"));
		yunnancityMap.put("dehong",  ResourceUtil.getValue("yunnan.dehong","德宏州"));
		yunnancityMap.put("lijiang",  ResourceUtil.getValue("yunnan.lijiang","丽江市"));
		yunnancityMap.put("nujiang",  ResourceUtil.getValue("yunnan.nujiang","怒江州"));
		yunnancityMap.put("diqing",  ResourceUtil.getValue("yunnan.diqing","迪庆州"));
		yunnancityMap.put("lincang",  ResourceUtil.getValue("yunnan.lincang","临沧市"));
		
		qinghaicityMap.put("xining",  ResourceUtil.getValue("qinghai.xining","西宁市"));//�ຣ
		qinghaicityMap.put("haidong",  ResourceUtil.getValue("qinghai.haidong","海东地区"));
		qinghaicityMap.put("haibei",  ResourceUtil.getValue("qinghai.haibei","海北州"));
		qinghaicityMap.put("huangnan",  ResourceUtil.getValue("qinghai.huangnan","黄南州"));
		qinghaicityMap.put("hainan",  ResourceUtil.getValue("qinghai.hainan","海南州"));
		qinghaicityMap.put("guoluo",  ResourceUtil.getValue("qinghai.guoluo","果洛州"));
		qinghaicityMap.put("yushu",  ResourceUtil.getValue("qinghai.yushu","玉树州"));
		qinghaicityMap.put("haixi",  ResourceUtil.getValue("qinghai.haixi","海西州"));
		
		ningxiacityMap.put("yinchuan",  ResourceUtil.getValue("ningxia.yinchuan","银川市"));//����
		ningxiacityMap.put("shizuishan",  ResourceUtil.getValue("ningxia.shizuishan","石嘴山市"));
		ningxiacityMap.put("wuzhong",  ResourceUtil.getValue("ningxia.wuzhong","吴忠市"));
		ningxiacityMap.put("guyuan",  ResourceUtil.getValue("ningxia.guyuan","固原市"));
		ningxiacityMap.put("zhongwei",  ResourceUtil.getValue("ningxia.zhongwei","中卫市"));
		
		gansucityMap.put("lanzhou",  ResourceUtil.getValue("gansu.lanzhou","兰州市"));//����
		gansucityMap.put("jiayuguan",  ResourceUtil.getValue("gansu.jiayuguan","嘉峪关市"));
		gansucityMap.put("jinchang",  ResourceUtil.getValue("gansu.jinchang","金昌市"));
		gansucityMap.put("baiyin",  ResourceUtil.getValue("gansu.baiyin","白银市"));
		gansucityMap.put("tianshui",  ResourceUtil.getValue("gansu.tianshui","天水市"));
		gansucityMap.put("wuwei",  ResourceUtil.getValue("gansu.wuwei","武威市"));
		gansucityMap.put("jiuquan",  ResourceUtil.getValue("gansu.jiuquan","酒泉市"));
		gansucityMap.put("zhangye",  ResourceUtil.getValue("gansu.zhangye","张掖市"));
		gansucityMap.put("dingxi",  ResourceUtil.getValue("gansu.dingxi","定西市"));
		gansucityMap.put("longnan",  ResourceUtil.getValue("gansu.longnan","陇南市"));
		gansucityMap.put("pingliang",  ResourceUtil.getValue("gansu.pingliang","平凉市"));
		gansucityMap.put("qingyang",  ResourceUtil.getValue("gansu.qingyang","庆阳市"));
		gansucityMap.put("linxia",  ResourceUtil.getValue("gansu.linxia","临夏州"));
		gansucityMap.put("gannan",  ResourceUtil.getValue("gansu.gannan","甘南州"));
		
		xinjiangcityMap.put("wulumuqi",  ResourceUtil.getValue("xinjiang.wulumuqi","乌鲁木齐市"));//�½�
		xinjiangcityMap.put("kelamayi",  ResourceUtil.getValue("xinjiang.kelamayi","克拉玛依市"));
		xinjiangcityMap.put("tulufan",  ResourceUtil.getValue("xinjiang.tulufan","吐鲁番地区"));
		xinjiangcityMap.put("hami",  ResourceUtil.getValue("xinjiang.hami","哈密地区"));
		xinjiangcityMap.put("changji",  ResourceUtil.getValue("xinjiang.changji","昌吉州"));
		xinjiangcityMap.put("boertala",  ResourceUtil.getValue("xinjiang.boertala","博尔塔拉州"));
		xinjiangcityMap.put("bayinguoleng",  ResourceUtil.getValue("xinjiang.bayinguoleng","巴音郭楞州"));
		xinjiangcityMap.put("kezilesu",  ResourceUtil.getValue("xinjiang.kezilesu","克孜勒苏州"));
		xinjiangcityMap.put("kashi",  ResourceUtil.getValue("xinjiang.kashi","喀什地区"));
		xinjiangcityMap.put("hetian",  ResourceUtil.getValue("xinjiang.hetian","和田地区"));
		xinjiangcityMap.put("yili",  ResourceUtil.getValue("xinjiang.yili","伊犁州"));
		xinjiangcityMap.put("tacheng",  ResourceUtil.getValue("xinjiang.tacheng","塔城地区"));
		xinjiangcityMap.put("aletai",  ResourceUtil.getValue("xinjiang.aletai","阿勒泰地区"));
		xinjiangcityMap.put("akesu",  ResourceUtil.getValue("xinjiang.akesu","阿克苏地区"));
		xinjiangcityMap.put("shihezi",  ResourceUtil.getValue("xinjiang.shihezi","石河子市"));
		xinjiangcityMap.put("alaer",  ResourceUtil.getValue("xinjiang.alaer","阿拉尔市"));
		xinjiangcityMap.put("tumushuke",  ResourceUtil.getValue("xinjiang.tumushuke","图木舒克市"));
		xinjiangcityMap.put("wujiaqu",  ResourceUtil.getValue("xinjiang.wujiaqu","五家渠市"));
		
		xizangcityMap.put("lasa",  ResourceUtil.getValue("xizang.lasa","拉萨市"));//���
		xizangcityMap.put("changdu",  ResourceUtil.getValue("xizang.changdu","昌都地区"));
		xizangcityMap.put("shannan",  ResourceUtil.getValue("xizang.shannan","山南地区"));
		xizangcityMap.put("rikaze",  ResourceUtil.getValue("xizang.rikaze","日喀则地区"));
		xizangcityMap.put("naqu",  ResourceUtil.getValue("xizang.naqu","那曲地区"));
		xizangcityMap.put("ali",  ResourceUtil.getValue("xizang.ali","阿里地区"));
		xizangcityMap.put("linzhi",  ResourceUtil.getValue("xizang.linzhi","林芝地区"));
		
		guangxicityMap.put("nanning",  ResourceUtil.getValue("guangxi.nanning","南宁市"));//����
		guangxicityMap.put("liuzhou",  ResourceUtil.getValue("guangxi.liuzhou","柳州市"));
		guangxicityMap.put("guilin",  ResourceUtil.getValue("guangxi.guilin","桂林市"));
		guangxicityMap.put("wuzhou",  ResourceUtil.getValue("guangxi.wuzhou","梧州市"));
		guangxicityMap.put("beihai",  ResourceUtil.getValue("guangxi.beihai","北海市"));
		guangxicityMap.put("fangchenggang",  ResourceUtil.getValue("guangxi.fangchenggang","防城港市"));
		guangxicityMap.put("qinzhou",  ResourceUtil.getValue("guangxi.qinzhou","钦州市"));
		guangxicityMap.put("guigang",  ResourceUtil.getValue("guangxi.guigang","贵港市"));
		guangxicityMap.put("yulin",  ResourceUtil.getValue("guangxi.yulin","玉林市"));
		guangxicityMap.put("chongzuo",  ResourceUtil.getValue("guangxi.chongzuo","崇左市"));
		guangxicityMap.put("laibing",  ResourceUtil.getValue("guangxi.laibing","来宾市"));
		guangxicityMap.put("hezhou",  ResourceUtil.getValue("guangxi.hezhou","贺州市"));
		guangxicityMap.put("baise",  ResourceUtil.getValue("guangxi.baise","百色市"));
		guangxicityMap.put("hechi",  ResourceUtil.getValue("guangxi.hechi","河池市"));
		
		neimenggucityMap.put("huhehaote",  ResourceUtil.getValue("neimenggu.huhehaote","呼和浩特市"));//���ɹ�
		neimenggucityMap.put("baotou",  ResourceUtil.getValue("neimenggu.baotou","包头市"));
		neimenggucityMap.put("wuhai",  ResourceUtil.getValue("neimenggu.wuhai","乌海市"));
		neimenggucityMap.put("chifeng",  ResourceUtil.getValue("neimenggu.chifeng","赤峰市"));
		neimenggucityMap.put("tongliao",  ResourceUtil.getValue("neimenggu.tongliao","通辽市"));
		neimenggucityMap.put("eerduosi",  ResourceUtil.getValue("neimenggu.eerduosi","鄂尔多斯市"));
		neimenggucityMap.put("hulunbeier",  ResourceUtil.getValue("neimenggu.hulunbeier","呼伦贝尔市"));
		neimenggucityMap.put("xingan",  ResourceUtil.getValue("neimenggu.xingan","兴安盟"));
		neimenggucityMap.put("xilinguole",  ResourceUtil.getValue("neimenggu.xilinguole","锡林郭勒盟"));
		neimenggucityMap.put("wulancabu",  ResourceUtil.getValue("neimenggu.wulancabu","乌兰察布市"));
		neimenggucityMap.put("bayannaoer",  ResourceUtil.getValue("neimenggu.bayannaoer","巴彦淖尔市"));
		neimenggucityMap.put("alashan",  ResourceUtil.getValue("neimenggu.alashan","阿拉善盟"));
		neimenggucityMap.put("hlaer",  ResourceUtil.getValue("neimenggu.hlaer","海拉尔市"));
		
		taiwancityMap.put("taibei",  ResourceUtil.getValue("taiwan.taibei","台北市"));//̨��
		taiwancityMap.put("gaoxiong",  ResourceUtil.getValue("taiwan.gaoxiong","高雄市"));
		taiwancityMap.put("taizhong",  ResourceUtil.getValue("taiwan.taizhong","台中市"));
		taiwancityMap.put("tainan",  ResourceUtil.getValue("taiwan.tainan","台南市"));
		taiwancityMap.put("jilong",  ResourceUtil.getValue("taiwan.jilong","基隆市"));
		taiwancityMap.put("xinzhu",  ResourceUtil.getValue("taiwan.xinzhu","新竹市"));
		taiwancityMap.put("jiayi",  ResourceUtil.getValue("taiwan.jiayi","嘉义市"));
		
		xianggangcityMap.put("xianggang",  ResourceUtil.getValue("xianggang.xianggang","香港特别行政区"));//���
		aomencityMap.put("aomen",  ResourceUtil.getValue("aomen.aomen","澳门特别行政区"));//����
		guowaicityMap.put("guowai",  ResourceUtil.getValue("guowai.guowai","国外"));//
		
		
		
		//城市和身份map
		provincecityMap.put("beijing", beijingcityMap);
		provincecityMap.put("tianjin", tianjincityMap);
		provincecityMap.put("hebei", hebeicityMap);
		provincecityMap.put("shanxi", shanxicityMap);
		provincecityMap.put("neimenggu", neimenggucityMap);
		provincecityMap.put("liaoning", liaoningcityMap);
		provincecityMap.put("jilin", jilincityMap);
		provincecityMap.put("heilongjiang", heilongjiangcityMap);	
		provincecityMap.put("shanghai", shanghaicityMap);
		provincecityMap.put("jiangsu", jiangsucityMap);
		provincecityMap.put("zhejiang", zhejiangcityMap);
		provincecityMap.put("anhui", anhuicityMap);
		provincecityMap.put("fujian", fujiancityMap);
		provincecityMap.put("jiangxi", jiangxicityMap);
		provincecityMap.put("shandong", shandongcityMap);
		provincecityMap.put("henan", henancityMap);
		provincecityMap.put("hubei", hubeicityMap);
		provincecityMap.put("hunan", hunancityMap);
		provincecityMap.put("guangdong", guangdongcityMap);
		provincecityMap.put("guangxi", guangxicityMap);
		provincecityMap.put("hainan", hainancityMap);
		provincecityMap.put("chongqing", chongqingcityMap);
		provincecityMap.put("sichuan", sichuancityMap);
		provincecityMap.put("guizhou", guizhoucityMap);
		provincecityMap.put("yunnan", yunnancityMap);
		provincecityMap.put("xizang", xizangcityMap);
		provincecityMap.put("shanxi2", shanxi2cityMap);
		provincecityMap.put("gansu", gansucityMap);
		provincecityMap.put("qinghai", qinghaicityMap);
		provincecityMap.put("ningxia", ningxiacityMap);		
		provincecityMap.put("xinjiang", xinjiangcityMap);	
		provincecityMap.put("taiwan", taiwancityMap);
		provincecityMap.put("xianggang", xianggangcityMap);		
		provincecityMap.put("aomen", aomencityMap);
		provincecityMap.put("guowai",guowaicityMap);
	}
	
	/**
	 * 取得文章所在
	 * @return
	 */
	public static List<LabelValueBean> getCitys(String province){
		List<LabelValueBean> result = new ArrayList<LabelValueBean>();
		if (!StringUtil.isEmpty(province) && !province.equals("null")) {
			Map<String, String> citymap = provincecityMap.get(province);
			Iterator<String> cityIter = citymap.keySet().iterator();
			String name = null;
			while (cityIter.hasNext()) {
				name = (String) cityIter.next();
				result.add(new LabelValueBean(citymap.get(name).toString(), name));
			}
		}
		return result;
	}
}
