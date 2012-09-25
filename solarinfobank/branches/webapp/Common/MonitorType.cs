using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using System.Globalization;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 测点类型定义
    /// </summary>
    public class MonitorType
    {
        //----add by qhb in 20120825
        ///数字输入项目定义
        /// <summary>
        /// 防雷器  1：正常，0：故障
        /// </summary>
        public const string digital_input_item_flq = "digitalinputflq";

        /// <summary>
        /// 断路器 0：闭合 1：脱扣或者断开
        /// </summary>
        public const string digital_input_item_dlq = "digitalinputdlq";

        ///工作状态项目定义
        /// <summary>
        /// 运行 0：未运行 1：运行
        /// </summary>
        public const string work_status_item_run = "workstatusrun";

        /// <summary>
        /// 停止 0：未停止 1：停止
        /// </summary>
        public const string work_status_item_stop = "workstatusstop";

        /// <summary>
        /// 防雷器 0：正常 1：故障
        /// </summary>
        public const string work_status_item_flq = "workstatusflq";

        /// <summary>
        /// 机内温度 0：正常 1：警告
        /// </summary>
        public const string work_status_item_jnwd = "workstatusjnwd";

        /// <summary>
        /// 短路 0：正常 1：警告
        /// </summary>
        public const string work_status_item_duanlu = "workstatusduanlu";

        /// <summary>
        /// 电流过高 0：正常 1：警告
        /// </summary>
        public const string work_status_item_dlgg = "workstatusdlgg";

        /// <summary>
        /// 电流过低 0：正常 1：警告
        /// </summary>
        public const string work_status_item_dlgd = "workstatusdlgd";

        /// <summary>
        /// 开路 0：正常 1：警告
        /// </summary>
        public const string work_status_item_kailu = "workstatuskailu";

        //bit位和状态项目的对应关系 key 为测点+bit位 如： MIC_BUSBAR_DIGITALINPUT+0,MIC_BUSBAR_DIGITALINPUT+1
        public static IDictionary<string, string> bitStatusMap = new Dictionary<string, string>();
        //----add by qhb in 20120825 end
        
        /// <summary>
        /// 电站发电量测点
        /// </summary>
        public const int PLANT_MONITORITEM_ENERGY_CODE = 11;

        /// <summary>
        /// 电站功率
        /// </summary>
        public const int PLANT_MONITORITEM_POWER_CODE = 13;

        /// <summary>
        /// 日照强度
        /// </summary>
        public const int PLANT_MONITORITEM_LINGT_CODE = 15;

        /// <summary>
        /// 电站环境温度
        /// </summary>
        public const int PLANT_MONITORITEM_AMBIENTTEMP_CODE = 17;

        /// <summary>
        /// 电站风速
        /// </summary>
        public const int PLANT_MONITORITEM_WINDSPEED = 19;

        /// <summary>
        /// 电站风向
        /// </summary>
        public const int PLANT_MONITORITEM_WINDDIRECTION = 21;
        /// <summary>
        /// 日辐射量
        /// </summary>
        public const int PLANT_MONITORITEM_DAYRADIATION = 22;

        /// <summary>
        /// 总辐射量
        /// </summary>
        public const int PLANT_MONITORITEM_TOTALRADIATION = 22;
        //需要统计曲线的测点列表
        public static IList<int> historyMonitorList = new List<int>();

        //--------------------inveter-----------------------------------------------
        //逆变器测点 定义规则设备类型+"_"+测点在协议中的地址起始序号
        //YC量就是瞬时测量的值，YX量就是状态量，YM量就是不断累加的量。 YC量做历史数据其他制作实时数据
        /// <summary>
        /// 额定输出功率 201
        /// </summary>
        public static readonly int MIC_INVERTER_POWER = int.Parse(DeviceData.INVERTER_CODE + "01");
        /// <summary>
        /// 输出类型 202
        /// </summary>
        public static readonly int MIC_INVERTER_OUTTYPE = int.Parse(DeviceData.INVERTER_CODE + "02");
        /// <summary>
        /// 日发电量 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_TODAYENERGY = int.Parse(DeviceData.INVERTER_CODE + "03");
        /// <summary>
        /// 总发电量  ym量
        /// </summary>
        public static readonly int MIC_INVERTER_TOTALENERGY = int.Parse(DeviceData.INVERTER_CODE + "04");
        /// <summary>
        /// 总运行时间 ym量
        /// </summary>
        public static readonly int MIC_INVERTER_RUNTIME = int.Parse(DeviceData.INVERTER_CODE + "05");
        /// <summary>
        /// 机内空气温度  保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_JNKQTEMPRATURE = int.Parse(DeviceData.INVERTER_CODE + "06");
        /// <summary>
        /// 机内变压器温度 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_JNBYQTEMPRATURE = int.Parse(DeviceData.INVERTER_CODE + "07");
        /// <summary>
        /// 机内散热器温度 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_JNSRQTEMPRATURE = int.Parse(DeviceData.INVERTER_CODE + "08");
        /// <summary>
        /// 直流电压1 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_DV1 = int.Parse(DeviceData.INVERTER_CODE + "09");
        /// <summary>
        /// 直流电流1 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_DC1 = int.Parse(DeviceData.INVERTER_CODE + "10");
        /// <summary>
        /// 直流电压2 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_DV2 = int.Parse(DeviceData.INVERTER_CODE + "11");
        /// <summary>
        /// 直流电流2 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_DC2 = int.Parse(DeviceData.INVERTER_CODE + "12");
        /// <summary>
        /// 直流电压3 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_DV3 = int.Parse(DeviceData.INVERTER_CODE + "13");
        /// <summary>
        /// 直流电流3 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_DC3 = int.Parse(DeviceData.INVERTER_CODE + "14");
        /// <summary>
        /// 总直流功率 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_TOTALDPOWER = int.Parse(DeviceData.INVERTER_CODE + "15");
        /// <summary>
        /// A相电压 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_ADIRECTVOLT = int.Parse(DeviceData.INVERTER_CODE + "16");
        /// <summary>
        /// B相电压 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_BDIRECTVOLT = int.Parse(DeviceData.INVERTER_CODE + "17");
        /// <summary>
        /// C相电压 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_CDIRECTVOLT = int.Parse(DeviceData.INVERTER_CODE + "18");
        /// <summary>
        /// A相电流 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_ADIRECTCURRENT = int.Parse(DeviceData.INVERTER_CODE + "19");
        /// <summary>
        /// B相电流 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_BDIRECTCURRENT = int.Parse(DeviceData.INVERTER_CODE + "20");
        /// <summary>
        /// C相电流 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_CDIRECTCURRENT = int.Parse(DeviceData.INVERTER_CODE + "21");
        /// <summary>
        /// A相有功功率 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_ADIRECTPOWER = int.Parse(DeviceData.INVERTER_CODE + "22");
        /// <summary>
        /// B相有功功率 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_BDIRECTPOWER = int.Parse(DeviceData.INVERTER_CODE + "23");
        /// <summary>
        /// C相有功功率 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_CDIRECTPOWER = int.Parse(DeviceData.INVERTER_CODE + "24");
        /// <summary>
        /// 总有功功率 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_TOTALYGPOWER = int.Parse(DeviceData.INVERTER_CODE + "25");
        /// <summary>
        /// 总无功功率 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_TOTALWGPOWER = int.Parse(DeviceData.INVERTER_CODE + "26");
        /// <summary>
        /// 总功率因数 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_TOTALPOWERFACTOR = int.Parse(DeviceData.INVERTER_CODE + "27");
        /// <summary>
        /// 电网频率 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_DWPL = int.Parse(DeviceData.INVERTER_CODE + "28");
        /// <summary>
        /// 逆变器效率 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_INVERTERXL = int.Parse(DeviceData.INVERTER_CODE + "29");
        /// <summary>
        /// 设备状态 
        /// </summary>
        public static readonly int MIC_INVERTER_DEVICESTATUS = int.Parse(DeviceData.INVERTER_CODE + "30");
        /// <summary>
        /// 状态时间：年月日时分秒串起来
        /// </summary>
        public static readonly int MIC_INVERTER_STATUSTIME = int.Parse(DeviceData.INVERTER_CODE + "31");
        /// <summary>
        /// 状态数据1
        /// </summary>
        public static readonly int MIC_INVERTER_STATUSDATA1 = int.Parse(DeviceData.INVERTER_CODE + "32");
        /// <summary>
        /// 状态数据2
        /// </summary>
        public static readonly int MIC_INVERTER_STATUSDATA2 = int.Parse(DeviceData.INVERTER_CODE + "33");
        /// <summary>
        /// 状态数据3
        /// </summary>
        public static readonly int MIC_INVERTER_STATUSDATA3 = int.Parse(DeviceData.INVERTER_CODE + "34");
        /// <summary>
        /// 交流电压 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_AV = int.Parse(DeviceData.INVERTER_CODE + "35");
        /// <summary>
        /// 交流电流 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_AC = int.Parse(DeviceData.INVERTER_CODE + "36");
        /// <summary>
        /// 直流电压 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_DV = int.Parse(DeviceData.INVERTER_CODE + "37");
        /// <summary>
        /// 直流电流 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_DC = int.Parse(DeviceData.INVERTER_CODE + "38");
        /// <summary>
        /// 逆变器温度 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_INVETERTEMPRATURE = int.Parse(DeviceData.INVERTER_CODE + "39");
        /// <summary>
        /// 交流发电量 保留历史
        /// </summary>
        public static readonly int MIC_INVERTER_ACENERGY = int.Parse(DeviceData.INVERTER_CODE + "40");

        /// <summary>
        /// 故障状态 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_ERRORSTATUS = int.Parse(DeviceData.INVERTER_CODE + "41");
        /// <summary>
        /// 故障状态2 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_ERRORSTATUS2 = int.Parse(DeviceData.INVERTER_CODE + "42");
        /// <summary>
        /// 电抗器温度 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_DKQTEMPRATURE = int.Parse(DeviceData.INVERTER_CODE + "43");
        /// <summary>
        /// 模块温度1 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_MODULETEMP1 = int.Parse(DeviceData.INVERTER_CODE + "44");
        /// <summary>
        /// 模块温度2 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_MODULETEMP2 = int.Parse(DeviceData.INVERTER_CODE + "45");
        /// <summary>
        /// 模块温度3 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_MODULETEMP3 = int.Parse(DeviceData.INVERTER_CODE + "46");
        /// <summary>
        /// 模块温度4 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_MODULETEMP4 = int.Parse(DeviceData.INVERTER_CODE + "47");
        /// <summary>
        /// 模块温度5 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_MODULETEMP5 = int.Parse(DeviceData.INVERTER_CODE + "48");
        /// <summary>
        /// 模块温度6 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_MODULETEMP6 = int.Parse(DeviceData.INVERTER_CODE + "49");
        /// <summary>
        /// 环境温度1 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_ENVTEMP1 = int.Parse(DeviceData.INVERTER_CODE + "50");
        /// <summary>
        /// 环境温度2 add by qhb in 20120823
        /// </summary>
        public static readonly int MIC_INVERTER_ENVTEMP2 = int.Parse(DeviceData.INVERTER_CODE + "51");

        //--------------------inveter  end-----------------------------------------------

        //--------------------huiliuxiang-----------------------------------------------
        //汇流箱测点 定义规则设备类型+"_"+测点在协议中的序号起始序号
        /// <summary>
        /// 第一路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_1CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "01");
        /// <summary>
        /// 第二路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_2CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "02");
        /// <summary>
        /// 三路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_3CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "03");
        /// <summary>
        /// 第四路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_4CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "04");
        /// <summary>
        /// 第五路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_5CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "05");
        /// <summary>
        /// 第六路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_6CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "06");
        /// <summary>
        /// 第七路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_7CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "07");
        /// <summary>
        /// 第八路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_8CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "08");
        /// <summary>
        /// 第九路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_9CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "09");
        /// <summary>
        /// 第十路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_10CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "10");
        /// <summary>
        /// 第十一路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_11CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "11");
        /// <summary>
        /// 第十二路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_12CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "12");
        /// <summary>
        /// 第十三路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_13CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "13");
        /// <summary>
        /// 第十四路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_14CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "14");
        /// <summary>
        /// 第十五路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_15CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "15");
        /// <summary>
        /// 第十六路电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_16CURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "16");
        /// <summary>
        /// 阵列电压 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_ZLVOILT = int.Parse(DeviceData.HUILIUXIANG_CODE + "18");
        /// <summary>
        /// 数字输入
        /// </summary>
        public static readonly int MIC_BUSBAR_DIGITALINPUT = int.Parse(DeviceData.HUILIUXIANG_CODE + "19");
        /// <summary>
        /// 继电器输出
        /// </summary>
        public static readonly int MIC_BUSBAR_JDQOUT = int.Parse(DeviceData.HUILIUXIANG_CODE + "20");
        /// <summary>
        /// 接入传感器路数
        /// </summary>
        public static readonly int MIC_BUSBAR_CGQLINENUM = int.Parse(DeviceData.HUILIUXIANG_CODE + "21");
        /// <summary>
        /// 通讯类型
        /// </summary>
        public static readonly int MIC_BUSBAR_COMMUNICATION = int.Parse(DeviceData.HUILIUXIANG_CODE + "22");

        /// <summary>
        /// 最大接入路数
        /// </summary>
        public static readonly int MIC_BUSBAR_MAXLINE = int.Parse(DeviceData.HUILIUXIANG_CODE + "23");
        /// <summary>
        /// 机内温度 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_JNTEMPRATURE = int.Parse(DeviceData.HUILIUXIANG_CODE + "24");
        /// <summary>
        /// 直流母线电压 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_DCUXVOLT = int.Parse(DeviceData.HUILIUXIANG_CODE + "25");
        /// <summary>
        /// 总电流 保留历史
        /// </summary>
        public static readonly int MIC_BUSBAR_TOTALCURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "26");
        /// <summary>
        /// 最大电流
        /// </summary>
        public static readonly int MIC_BUSBAR_MAXCURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "27");
        /// <summary>
        /// 平均电流
        /// </summary>
        public static readonly int MIC_BUSBAR_AVGCURRENT = int.Parse(DeviceData.HUILIUXIANG_CODE + "28");
        /// <summary>
        /// 状态
        /// </summary>
        public static readonly int MIC_BUSBAR_STATUS = int.Parse(DeviceData.HUILIUXIANG_CODE + "29");
        /// <summary>
        /// 短路数据
        /// </summary>
        public static readonly int MIC_BUSBAR_DUANLUDATA = int.Parse(DeviceData.HUILIUXIANG_CODE + "30");
        /// <summary>
        /// 电流过高数据
        /// </summary>
        public static readonly int MIC_BUSBAR_DLGGDATA = int.Parse(DeviceData.HUILIUXIANG_CODE + "31");
        /// <summary>
        /// 电流过低数据
        /// </summary>
        public static readonly int MIC_BUSBAR_DLGDDATA = int.Parse(DeviceData.HUILIUXIANG_CODE + "32");
        /// <summary>
        /// 开路数据
        /// </summary>
        public static readonly int MIC_BUSBAR_KAILUDATA = int.Parse(DeviceData.HUILIUXIANG_CODE + "33");



        //环境检测仪测点 定义规则设备类型+"_"+测点在协议中的序号起始序号  一些没放到资源库中
        /// <summary>
        /// Soi（ED）
        /// </summary>
        public static readonly int MIC_DETECTOR_SOI = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "01");
        /// <summary>
        /// Adr
        /// </summary>
        public static readonly int MIC_DETECTOR_ADR = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "02");
        /// <summary>
        /// 日照强度（W/㎡） 保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_SUNLINGHT = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "03");
        /// <summary>
        /// 电池板温度（0.1℃） 保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_PANELTEMPRATURE = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "04");
        /// <summary>
        /// 环境温度（0.1℃）保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_ENRIONMENTTEMPRATURE = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "05");
        /// <summary>
        /// 电池板温度（0.1℃）高精度 保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_PANELTEMPRATUREHIGH = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "06");
        /// <summary>
        /// 环境温度（0.1℃）高精度 保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_ENRIONMENTTEMPRATUREHIGH = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "07");
        /// <summary>
        /// 风速（m/s） 保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_WINDSPEED = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "08");
        /// <summary>
        /// 风速（0.1m/s）高精度 保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_WINDSPEEDHIGH = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "09");
        /// <summary>
        /// 斜面日照强度（W/㎡） 保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_XMRZQD = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "10");
        /// <summary>
        /// 风向 保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_WINDDIRECTION = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "11");
        /// <summary>
        /// 日辐射量 保留历史
        /// </summary>
        public static readonly int MIC_DETECTOR_DAYRADIATION = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "12");
        /// <summary>
        /// 总辐射量 
        /// </summary>
        public static readonly int MIC_DETECTOR_TOTALRADIATION = int.Parse(DeviceData.ENVRIOMENTMONITOR_CODE + "13");


        //---------------------电表测点-------------------------
        /// <summary>
        /// 系统频率F 0.01Hz U16
        /// </summary>
        public static readonly int MIC_AMMETER_SYSFREQUENCY = int.Parse(DeviceData.AMMETER_CODE + "01");
        /// <summary>
        /// 相电压V1 0.1V U16
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEVOLTAGE1 = int.Parse(DeviceData.AMMETER_CODE + "02");
        /// <summary>
        /// 相电压V2 0.1V U16
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEVOLTAGE2 = int.Parse(DeviceData.AMMETER_CODE + "03");
        /// <summary>
        /// 相电压V3 0.1V U16
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEVOLTAGE3 = int.Parse(DeviceData.AMMETER_CODE + "04");

        /// <summary>
        /// 相（线）电流I1  0.1A U16
        /// </summary>
        public static readonly int MIC_AMMETER_PHASECURRENT1 = int.Parse(DeviceData.AMMETER_CODE + "05");
        /// <summary>
        /// 相（线）电流I2  0.1A U16
        /// </summary>
        public static readonly int MIC_AMMETER_PHASECURRENT2 = int.Parse(DeviceData.AMMETER_CODE + "06");
        /// <summary>
        /// 相（线）电流I3  0.1A U16
        /// </summary>
        public static readonly int MIC_AMMETER_PHASECURRENT3 = int.Parse(DeviceData.AMMETER_CODE + "07");

        /// <summary>
        /// 分相有功功率P1 s32 W
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEACTIVEPOWER1 = int.Parse(DeviceData.AMMETER_CODE + "08");
        /// <summary>
        /// 分相有功功率P2 s32 W
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEACTIVEPOWER2 = int.Parse(DeviceData.AMMETER_CODE + "09");
        /// <summary>
        /// 分相有功功率P3 s32 W
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEACTIVEPOWER3 = int.Parse(DeviceData.AMMETER_CODE + "10");

        /// <summary>
        /// 系统有功功率Psum s32 W
        /// </summary>
        public static readonly int MIC_AMMETER_SYSACTIVEPOWER = int.Parse(DeviceData.AMMETER_CODE + "11");

        /// <summary>
        /// 分相无功功率Q1 Var S32
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEREACTIVEPOWER1 = int.Parse(DeviceData.AMMETER_CODE + "12");
        /// <summary>
        /// 分相无功功率Q2 Var S32
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEREACTIVEPOWER2 = int.Parse(DeviceData.AMMETER_CODE + "13");
        /// <summary>
        /// 分相无功功率Q3 Var S32
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEREACTIVEPOWER3 = int.Parse(DeviceData.AMMETER_CODE + "14");

        /// <summary>
        /// 系统无功功率Qsum S32 Var
        /// </summary>
        public static readonly int MIC_AMMETER_SYSREACTIVEPOWER = int.Parse(DeviceData.AMMETER_CODE + "15");

        /// <summary>
        /// 分相视在功率S1 U32 VA
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEAPPARENTPOWER1 = int.Parse(DeviceData.AMMETER_CODE + "16");
        /// <summary>
        /// 分相视在功率S2 U32 VA
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEAPPARENTPOWER2 = int.Parse(DeviceData.AMMETER_CODE + "17");
        /// <summary>
        /// 分相视在功率S3 U32 VA
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEAPPARENTPOWER3 = int.Parse(DeviceData.AMMETER_CODE + "18");

        /// <summary>
        /// 系统视在功率Ssum U32 VA
        /// </summary>
        public static readonly int MIC_AMMETER_SYSAPPARENTPOWER = int.Parse(DeviceData.AMMETER_CODE + "19");

        /// <summary>
        /// 分相功率因数PF1 S16 0.0001
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEPOWERFACTOR1 = int.Parse(DeviceData.AMMETER_CODE + "20");
        /// <summary>
        /// 分相功率因数PF2 S16 0.0001
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEPOWERFACTOR2 = int.Parse(DeviceData.AMMETER_CODE + "21");
        /// <summary>
        /// 分相功率因数PF3 S16 0.0001
        /// </summary>
        public static readonly int MIC_AMMETER_PHASEPOWERFACTOR3 = int.Parse(DeviceData.AMMETER_CODE + "22");
        /// <summary>
        /// 系统功率因数PF S16 0.0001
        /// </summary>
        public static readonly int MIC_AMMETER_SYSPOWERFACTOR1 = int.Parse(DeviceData.AMMETER_CODE + "23");

        /// <summary>
        /// 正向有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "24");
        /// <summary>
        /// 反向有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_REVERSEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "25");
        /// <summary>
        /// 正向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "26");
        /// <summary>
        /// 反向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "27");
        /// <summary>
        /// 绝对值和有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "28");
        /// <summary>
        /// 净有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_PUREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "29");
        /// <summary>
        /// 绝对值和无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "30");
        /// <summary>
        /// 净无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_PUREREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "31");   
     
        /// <summary>
        /// 费率波正向有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "32");        
        /// <summary>
        /// 费率波反向有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "33");       
        /// <summary>
        /// 费率波正向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "34");       
        /// <summary>
        /// 费率波反向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "35");       
 
        /// <summary>
        /// 费率峰正向有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "36");        
        /// <summary>
        /// 费率峰反向有功度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "37");
        /// <summary>
        /// 费率峰正向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "38");
        /// <summary>
        /// 费率峰反向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "39");

        /// <summary>
        /// 费率谷正向有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "40");
        /// <summary>
        /// 费率谷反向有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "41");
        /// <summary>
        /// 费率谷正向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "42");
        /// <summary>
        /// 费率谷反向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "43");

        /// <summary>
        /// 费率平正向有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "44");
        /// <summary>
        /// 费率平反向有功电度 U32 kWh
        /// </summary>
        public static readonly int MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "45");
        /// <summary>
        /// 费率平正向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "46");
        /// <summary>
        /// 费率平反向无功电度 U32 kVarh
        /// </summary>
        public static readonly int MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE = int.Parse(DeviceData.AMMETER_CODE + "47");  


        //设备类型对应在用测点list map
        public static IDictionary<int, IList<MonitorType>> typeMonitorsMap = new Dictionary<int, IList<MonitorType>>();

        //所有测点map
        public static IDictionary<int, MonitorType> monitorMap = new Dictionary<int, MonitorType>();

        static MonitorType()
        {
            monitorMap.Add(PLANT_MONITORITEM_AMBIENTTEMP_CODE, new MonitorType() { code = PLANT_MONITORITEM_AMBIENTTEMP_CODE, unit = "°C", zerotoline=false });

            monitorMap.Add(PLANT_MONITORITEM_ENERGY_CODE, new MonitorType() { code = PLANT_MONITORITEM_ENERGY_CODE, unit = "kWh", zerotoline = false });

            monitorMap.Add(PLANT_MONITORITEM_LINGT_CODE, new MonitorType() { code = PLANT_MONITORITEM_LINGT_CODE, unit = "W/㎡", zerotoline = false });

            monitorMap.Add(PLANT_MONITORITEM_POWER_CODE, new MonitorType() { code = PLANT_MONITORITEM_POWER_CODE, unit = "kW", zerotoline = false });

            monitorMap.Add(PLANT_MONITORITEM_WINDDIRECTION, new MonitorType() { code = PLANT_MONITORITEM_WINDDIRECTION, unit = "", zerotoline = false });

            monitorMap.Add(PLANT_MONITORITEM_WINDSPEED, new MonitorType() { code = PLANT_MONITORITEM_WINDSPEED, unit = "m/s", zerotoline = false });

            monitorMap.Add(MIC_BUSBAR_10CURRENT, new MonitorType() { code = MIC_BUSBAR_10CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_11CURRENT, new MonitorType() { code = MIC_BUSBAR_11CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_12CURRENT, new MonitorType() { code = MIC_BUSBAR_12CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_13CURRENT, new MonitorType() { code = MIC_BUSBAR_13CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_14CURRENT, new MonitorType() { code = MIC_BUSBAR_14CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_15CURRENT, new MonitorType() { code = MIC_BUSBAR_15CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_16CURRENT, new MonitorType() { code = MIC_BUSBAR_16CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_1CURRENT, new MonitorType() { code = MIC_BUSBAR_1CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_2CURRENT, new MonitorType() { code = MIC_BUSBAR_2CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_3CURRENT, new MonitorType() { code = MIC_BUSBAR_3CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_4CURRENT, new MonitorType() { code = MIC_BUSBAR_4CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_5CURRENT, new MonitorType() { code = MIC_BUSBAR_5CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_6CURRENT, new MonitorType() { code = MIC_BUSBAR_6CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_7CURRENT, new MonitorType() { code = MIC_BUSBAR_7CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_8CURRENT, new MonitorType() { code = MIC_BUSBAR_8CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_9CURRENT, new MonitorType() { code = MIC_BUSBAR_9CURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_CGQLINENUM, new MonitorType() { code = MIC_BUSBAR_CGQLINENUM, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_COMMUNICATION, new MonitorType() { code = MIC_BUSBAR_COMMUNICATION, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_DCUXVOLT, new MonitorType() { code = MIC_BUSBAR_DCUXVOLT, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_DIGITALINPUT, new MonitorType() { code = MIC_BUSBAR_DIGITALINPUT, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_JDQOUT, new MonitorType() { code = MIC_BUSBAR_JDQOUT, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_JNTEMPRATURE, new MonitorType() { code = MIC_BUSBAR_JNTEMPRATURE, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_MAXLINE, new MonitorType() { code = MIC_BUSBAR_MAXLINE, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_ZLVOILT, new MonitorType() { code = MIC_BUSBAR_ZLVOILT, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_TOTALCURRENT, new MonitorType() { code = MIC_BUSBAR_TOTALCURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_STATUS, new MonitorType() { code = MIC_BUSBAR_STATUS, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_DUANLUDATA, new MonitorType() { code = MIC_BUSBAR_DUANLUDATA, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_DLGGDATA, new MonitorType() { code = MIC_BUSBAR_DLGGDATA, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_DLGDDATA, new MonitorType() { code = MIC_BUSBAR_DLGDDATA, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_KAILUDATA, new MonitorType() { code = MIC_BUSBAR_KAILUDATA, unit = "", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_MAXCURRENT, new MonitorType() { code = MIC_BUSBAR_MAXCURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_BUSBAR_AVGCURRENT, new MonitorType() { code = MIC_BUSBAR_AVGCURRENT, unit = "A", zerotoline = false });

            monitorMap.Add(MIC_DETECTOR_ADR, new MonitorType() { code = MIC_DETECTOR_ADR, unit = "", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_ENRIONMENTTEMPRATURE, new MonitorType() { code = MIC_DETECTOR_ENRIONMENTTEMPRATURE, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_ENRIONMENTTEMPRATUREHIGH, new MonitorType() { code = MIC_DETECTOR_ENRIONMENTTEMPRATUREHIGH, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_PANELTEMPRATURE, new MonitorType() { code = MIC_DETECTOR_PANELTEMPRATURE, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_PANELTEMPRATUREHIGH, new MonitorType() { code = MIC_DETECTOR_PANELTEMPRATUREHIGH, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_SOI, new MonitorType() { code = MIC_DETECTOR_SOI, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_SUNLINGHT, new MonitorType() { code = MIC_DETECTOR_SUNLINGHT, unit = "W/㎡", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_WINDDIRECTION, new MonitorType() { code = MIC_DETECTOR_WINDDIRECTION, unit = "", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_WINDSPEED, new MonitorType() { code = MIC_DETECTOR_WINDSPEED, unit = "m/s", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_WINDSPEEDHIGH, new MonitorType() { code = MIC_DETECTOR_WINDSPEEDHIGH, unit = "m/s", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_XMRZQD, new MonitorType() { code = MIC_DETECTOR_XMRZQD, unit = "W/㎡", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_DAYRADIATION, new MonitorType() { code = MIC_DETECTOR_DAYRADIATION, unit = "Wh/㎡", zerotoline = false });
            monitorMap.Add(MIC_DETECTOR_TOTALRADIATION, new MonitorType() { code = MIC_DETECTOR_TOTALRADIATION, unit = "Wh/㎡", zerotoline = false });
            
            monitorMap.Add(MIC_INVERTER_AC, new MonitorType() { code = MIC_INVERTER_AC, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_ACENERGY, new MonitorType() { code = MIC_INVERTER_ACENERGY, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_ADIRECTCURRENT, new MonitorType() { code = MIC_INVERTER_ADIRECTCURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_ADIRECTPOWER, new MonitorType() { code = MIC_INVERTER_ADIRECTPOWER, unit = "W", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_ADIRECTVOLT, new MonitorType() { code = MIC_INVERTER_ADIRECTVOLT, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_AV, new MonitorType() { code = MIC_INVERTER_AV, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_BDIRECTCURRENT, new MonitorType() { code = MIC_INVERTER_BDIRECTCURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_BDIRECTPOWER, new MonitorType() { code = MIC_INVERTER_BDIRECTPOWER, unit = "W", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_BDIRECTVOLT, new MonitorType() { code = MIC_INVERTER_BDIRECTVOLT, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_CDIRECTCURRENT, new MonitorType() { code = MIC_INVERTER_CDIRECTCURRENT, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_CDIRECTPOWER, new MonitorType() { code = MIC_INVERTER_CDIRECTPOWER, unit = "W", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_CDIRECTVOLT, new MonitorType() { code = MIC_INVERTER_CDIRECTVOLT, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DC, new MonitorType() { code = MIC_INVERTER_DC, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DC1, new MonitorType() { code = MIC_INVERTER_DC1, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DC2, new MonitorType() { code = MIC_INVERTER_DC2, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DC3, new MonitorType() { code = MIC_INVERTER_DC3, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DEVICESTATUS, new MonitorType() { code = MIC_INVERTER_DEVICESTATUS, unit = "", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DV, new MonitorType() { code = MIC_INVERTER_DV, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DV1, new MonitorType() { code = MIC_INVERTER_DV1, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DV2, new MonitorType() { code = MIC_INVERTER_DV2, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DV3, new MonitorType() { code = MIC_INVERTER_DV3, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DWPL, new MonitorType() { code = MIC_INVERTER_DWPL, unit = "Hz", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_INVERTERXL, new MonitorType() { code = MIC_INVERTER_INVERTERXL, unit = "%", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_INVETERTEMPRATURE, new MonitorType() { code = MIC_INVERTER_INVETERTEMPRATURE, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_JNBYQTEMPRATURE, new MonitorType() { code = MIC_INVERTER_JNBYQTEMPRATURE, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_JNKQTEMPRATURE, new MonitorType() { code = MIC_INVERTER_JNKQTEMPRATURE, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_JNSRQTEMPRATURE, new MonitorType() { code = MIC_INVERTER_JNSRQTEMPRATURE, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_OUTTYPE, new MonitorType() { code = MIC_INVERTER_OUTTYPE, unit = "", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_POWER, new MonitorType() { code = MIC_INVERTER_POWER, unit = "kW", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_RUNTIME, new MonitorType() { code = MIC_INVERTER_RUNTIME, unit = "h", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_STATUSDATA1, new MonitorType() { code = MIC_INVERTER_STATUSDATA1, unit = "", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_STATUSDATA2, new MonitorType() { code = MIC_INVERTER_STATUSDATA2, unit = "", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_STATUSDATA3, new MonitorType() { code = MIC_INVERTER_STATUSDATA3, unit = "", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_STATUSTIME, new MonitorType() { code = MIC_INVERTER_STATUSTIME, unit = "", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_TODAYENERGY, new MonitorType() { code = MIC_INVERTER_TODAYENERGY, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_TOTALDPOWER, new MonitorType() { code = MIC_INVERTER_TOTALDPOWER, unit = "W", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_TOTALENERGY, new MonitorType() { code = MIC_INVERTER_TOTALENERGY, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_TOTALPOWERFACTOR, new MonitorType() { code = MIC_INVERTER_TOTALPOWERFACTOR, unit = "", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_TOTALWGPOWER, new MonitorType() { code = MIC_INVERTER_TOTALWGPOWER, unit = "Var", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_TOTALYGPOWER, new MonitorType() { code = MIC_INVERTER_TOTALYGPOWER, unit = "W", zerotoline = false });
            
            //add by qhb in 20120823
            monitorMap.Add(MIC_INVERTER_ERRORSTATUS, new MonitorType() { code = MIC_INVERTER_ERRORSTATUS, unit = "", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_ERRORSTATUS2, new MonitorType() { code = MIC_INVERTER_ERRORSTATUS2, unit = "", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_DKQTEMPRATURE, new MonitorType() { code = MIC_INVERTER_DKQTEMPRATURE, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_MODULETEMP1, new MonitorType() { code = MIC_INVERTER_MODULETEMP1, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_MODULETEMP2, new MonitorType() { code = MIC_INVERTER_MODULETEMP2, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_MODULETEMP3, new MonitorType() { code = MIC_INVERTER_MODULETEMP3, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_MODULETEMP4, new MonitorType() { code = MIC_INVERTER_MODULETEMP4, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_MODULETEMP5, new MonitorType() { code = MIC_INVERTER_MODULETEMP5, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_MODULETEMP6, new MonitorType() { code = MIC_INVERTER_MODULETEMP6, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_ENVTEMP1, new MonitorType() { code = MIC_INVERTER_ENVTEMP1, unit = "℃", zerotoline = false });
            monitorMap.Add(MIC_INVERTER_ENVTEMP2, new MonitorType() { code = MIC_INVERTER_ENVTEMP2, unit = "℃", zerotoline = false });

            //电表
            monitorMap.Add(MIC_AMMETER_SYSFREQUENCY, new MonitorType() { code = MIC_AMMETER_SYSFREQUENCY, unit = "Hz", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEVOLTAGE1, new MonitorType() { code = MIC_AMMETER_PHASEVOLTAGE1, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEVOLTAGE2, new MonitorType() { code = MIC_AMMETER_PHASEVOLTAGE2, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEVOLTAGE3, new MonitorType() { code = MIC_AMMETER_PHASEVOLTAGE3, unit = "V", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASECURRENT1, new MonitorType() { code = MIC_AMMETER_PHASECURRENT1, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASECURRENT2, new MonitorType() { code = MIC_AMMETER_PHASECURRENT2, unit = "A", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASECURRENT3, new MonitorType() { code = MIC_AMMETER_PHASECURRENT3, unit = "A", zerotoline = false });
            
            monitorMap.Add(MIC_AMMETER_PHASEACTIVEPOWER1, new MonitorType() { code = MIC_AMMETER_PHASEACTIVEPOWER1, unit = "W", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEACTIVEPOWER2, new MonitorType() { code = MIC_AMMETER_PHASEACTIVEPOWER2, unit = "W", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEACTIVEPOWER3, new MonitorType() { code = MIC_AMMETER_PHASEACTIVEPOWER3, unit = "W", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_SYSACTIVEPOWER, new MonitorType() { code = MIC_AMMETER_SYSACTIVEPOWER, unit = "W", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEREACTIVEPOWER1, new MonitorType() { code = MIC_AMMETER_PHASEREACTIVEPOWER1, unit = "Var", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEREACTIVEPOWER2, new MonitorType() { code = MIC_AMMETER_PHASEREACTIVEPOWER2, unit = "Var", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEREACTIVEPOWER3, new MonitorType() { code = MIC_AMMETER_PHASEREACTIVEPOWER3, unit = "Var", zerotoline = false });

            monitorMap.Add(MIC_AMMETER_SYSREACTIVEPOWER, new MonitorType() { code = MIC_AMMETER_SYSREACTIVEPOWER, unit = "Var", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEAPPARENTPOWER1, new MonitorType() { code = MIC_AMMETER_PHASEAPPARENTPOWER1, unit = "VA", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEAPPARENTPOWER2, new MonitorType() { code = MIC_AMMETER_PHASEAPPARENTPOWER2, unit = "VA", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEAPPARENTPOWER3, new MonitorType() { code = MIC_AMMETER_PHASEAPPARENTPOWER3, unit = "VA", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_SYSAPPARENTPOWER, new MonitorType() { code = MIC_AMMETER_SYSAPPARENTPOWER, unit = "", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEPOWERFACTOR1, new MonitorType() { code = MIC_AMMETER_PHASEPOWERFACTOR1, unit = "", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEPOWERFACTOR2, new MonitorType() { code = MIC_AMMETER_PHASEPOWERFACTOR2, unit = "", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PHASEPOWERFACTOR3, new MonitorType() { code = MIC_AMMETER_PHASEPOWERFACTOR3, unit = "", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_SYSPOWERFACTOR1, new MonitorType() { code = MIC_AMMETER_SYSPOWERFACTOR1, unit = "", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_REVERSEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_REVERSEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PUREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_PUREACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_PUREREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_PUREREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });

            monitorMap.Add(MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });

            monitorMap.Add(MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE, unit = "kWh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false });
            monitorMap.Add(MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE, new MonitorType() { code = MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE, unit = "kVarh", zerotoline = false }); 


            //添加需要做历史的测点
            //汇流箱
            historyMonitorList.Add(MIC_BUSBAR_1CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_2CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_3CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_4CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_5CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_6CURRENT);


            historyMonitorList.Add(MIC_BUSBAR_7CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_8CURRENT);


            historyMonitorList.Add(MIC_BUSBAR_9CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_10CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_11CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_12CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_13CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_14CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_15CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_16CURRENT);

            historyMonitorList.Add(MIC_BUSBAR_DCUXVOLT);

            historyMonitorList.Add(MIC_BUSBAR_JNTEMPRATURE);

            historyMonitorList.Add(MIC_BUSBAR_TOTALCURRENT);

            historyMonitorList.Add(MIC_BUSBAR_MAXCURRENT);

            historyMonitorList.Add(MIC_BUSBAR_AVGCURRENT);


            //环境监测仪
            historyMonitorList.Add(MIC_DETECTOR_ENRIONMENTTEMPRATURE);

            historyMonitorList.Add(MIC_DETECTOR_ENRIONMENTTEMPRATUREHIGH);

            historyMonitorList.Add(MIC_DETECTOR_PANELTEMPRATURE);

            historyMonitorList.Add(MIC_DETECTOR_PANELTEMPRATUREHIGH);

            historyMonitorList.Add(MIC_DETECTOR_SUNLINGHT);

            historyMonitorList.Add(MIC_DETECTOR_WINDDIRECTION);

            historyMonitorList.Add(MIC_DETECTOR_WINDSPEED);

            historyMonitorList.Add(MIC_DETECTOR_WINDSPEEDHIGH);

            historyMonitorList.Add(MIC_DETECTOR_XMRZQD);

            historyMonitorList.Add(MIC_DETECTOR_DAYRADIATION);

            
            //逆变器
            historyMonitorList.Add(MIC_INVERTER_TODAYENERGY);

            historyMonitorList.Add(MIC_INVERTER_TOTALENERGY);

            historyMonitorList.Add(MIC_INVERTER_TOTALYGPOWER);

            historyMonitorList.Add(MIC_INVERTER_TOTALWGPOWER);

            historyMonitorList.Add(MIC_INVERTER_AC);

            historyMonitorList.Add(MIC_INVERTER_AV);

            historyMonitorList.Add(MIC_INVERTER_DC);

            historyMonitorList.Add(MIC_INVERTER_DV);

            historyMonitorList.Add(MIC_INVERTER_TOTALDPOWER);

            historyMonitorList.Add(MIC_INVERTER_DC1);

            historyMonitorList.Add(MIC_INVERTER_DC2);

            historyMonitorList.Add(MIC_INVERTER_DC3);

            historyMonitorList.Add(MIC_INVERTER_DV1);

            historyMonitorList.Add(MIC_INVERTER_DV2);

            historyMonitorList.Add(MIC_INVERTER_DV3);

            historyMonitorList.Add(MIC_INVERTER_JNKQTEMPRATURE);

            historyMonitorList.Add(MIC_INVERTER_JNSRQTEMPRATURE);

            historyMonitorList.Add(MIC_INVERTER_JNBYQTEMPRATURE);

            historyMonitorList.Add(MIC_INVERTER_ACENERGY);

            historyMonitorList.Add(MIC_INVERTER_ADIRECTCURRENT);

            historyMonitorList.Add(MIC_INVERTER_BDIRECTCURRENT);

            historyMonitorList.Add(MIC_INVERTER_CDIRECTCURRENT);

            historyMonitorList.Add(MIC_INVERTER_ADIRECTVOLT);

            historyMonitorList.Add(MIC_INVERTER_BDIRECTVOLT);

            historyMonitorList.Add(MIC_INVERTER_CDIRECTVOLT);

            historyMonitorList.Add(MIC_INVERTER_ADIRECTPOWER);

            historyMonitorList.Add(MIC_INVERTER_BDIRECTPOWER);

            historyMonitorList.Add(MIC_INVERTER_CDIRECTPOWER);

            historyMonitorList.Add(MIC_INVERTER_DWPL);

            historyMonitorList.Add(MIC_INVERTER_INVERTERXL);

            historyMonitorList.Add(MIC_INVERTER_INVETERTEMPRATURE);
            //ADD BY QHB IN 20120824
            historyMonitorList.Add(MIC_INVERTER_DKQTEMPRATURE);
            historyMonitorList.Add(MIC_INVERTER_ENVTEMP1);
            historyMonitorList.Add(MIC_INVERTER_ENVTEMP2);
            historyMonitorList.Add(MIC_INVERTER_MODULETEMP1);
            historyMonitorList.Add(MIC_INVERTER_MODULETEMP2);
            historyMonitorList.Add(MIC_INVERTER_MODULETEMP3);
            historyMonitorList.Add(MIC_INVERTER_MODULETEMP4);
            historyMonitorList.Add(MIC_INVERTER_MODULETEMP5);
            historyMonitorList.Add(MIC_INVERTER_MODULETEMP6);
            //ADD BY QHB IN 20120824 END

            //电表
            historyMonitorList.Add(MIC_AMMETER_PHASEVOLTAGE1);
            historyMonitorList.Add(MIC_AMMETER_PHASEVOLTAGE2);
            historyMonitorList.Add(MIC_AMMETER_PHASEVOLTAGE3);
            historyMonitorList.Add(MIC_AMMETER_PHASECURRENT1);
            historyMonitorList.Add(MIC_AMMETER_PHASECURRENT2);
            historyMonitorList.Add(MIC_AMMETER_PHASECURRENT3);

            historyMonitorList.Add(MIC_AMMETER_PHASEACTIVEPOWER1);
            historyMonitorList.Add(MIC_AMMETER_PHASEACTIVEPOWER2);
            historyMonitorList.Add(MIC_AMMETER_PHASEACTIVEPOWER3);
            historyMonitorList.Add(MIC_AMMETER_SYSACTIVEPOWER);
            historyMonitorList.Add(MIC_AMMETER_PHASEREACTIVEPOWER1);
            historyMonitorList.Add(MIC_AMMETER_PHASEREACTIVEPOWER2);
            historyMonitorList.Add(MIC_AMMETER_PHASEREACTIVEPOWER3);

            historyMonitorList.Add(MIC_AMMETER_SYSREACTIVEPOWER);
            historyMonitorList.Add(MIC_AMMETER_PHASEAPPARENTPOWER1);
            historyMonitorList.Add(MIC_AMMETER_PHASEAPPARENTPOWER2);
            historyMonitorList.Add(MIC_AMMETER_PHASEAPPARENTPOWER3);
            historyMonitorList.Add(MIC_AMMETER_SYSAPPARENTPOWER);

            historyMonitorList.Add(MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_REVERSEACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_PUREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_PUREREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE);

            historyMonitorList.Add(MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE);

            historyMonitorList.Add(MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE);
            historyMonitorList.Add(MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE);
            
            IList<MonitorType> inverterMonitors = new List<MonitorType>();
            /// <summary>
            /// 额定输出功率 201
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_POWER]);
            /// <summary>
            /// 输出类型 202
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_OUTTYPE]);
            /// <summary>
            /// 日发电量
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_TODAYENERGY]);
            /// <summary>
            /// 总发电量
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_TOTALENERGY]);
            /// <summary>
            /// 总运行时间
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_RUNTIME]);
            /// <summary>
            /// 机内空气温度
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_JNKQTEMPRATURE]);
            /// <summary>
            /// 机内变压器温度
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_JNBYQTEMPRATURE]);
            /// <summary>
            /// 机内散热器温度
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_JNSRQTEMPRATURE]);
            /// <summary>
            /// 直流电压1
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_DV1]);
            /// <summary>
            /// 直流电流1
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_DC1]);
            /// <summary>
            /// 直流电压2
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_DV2]);
            /// <summary>
            /// 直流电流2
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_DC2]);
            /// <summary>
            /// 直流电压3
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_DV3]);
            /// <summary>
            /// 直流电流3
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_DC3]);
            /// <summary>
            /// 总直流功率
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_TOTALDPOWER]);
            /// <summary>
            /// A相电压
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_ADIRECTVOLT]);
            /// <summary>
            /// B相电压
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_BDIRECTVOLT]);
            /// <summary>
            /// C相电压
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_CDIRECTVOLT]);
            /// <summary>
            /// A相电流
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_ADIRECTCURRENT]);
            /// <summary>
            /// B相电流
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_BDIRECTCURRENT]);
            /// <summary>
            /// C相电流
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_CDIRECTCURRENT]);
            /// <summary>
            /// A相有功功率
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_ADIRECTPOWER]);
            /// <summary>
            /// B相有功功率
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_BDIRECTPOWER]);
            /// <summary>
            /// C相有功功率
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_CDIRECTPOWER]);
            /// <summary>
            /// 总有功功率
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_TOTALYGPOWER]);
            /// <summary>
            /// 总无功功率
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_TOTALWGPOWER]);
            /// <summary>
            /// 总功率因数
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_TOTALPOWERFACTOR]);
            /// <summary>
            /// 电网频率
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_DWPL]);
            /// <summary>
            /// 逆变器效率
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_INVERTERXL]);
            /// <summary>
            /// 设备状态
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_DEVICESTATUS]);
            /// <summary>
            /// 状态时间：年月日时分秒串起来
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_STATUSTIME]);
            /// <summary>
            /// 状态数据1
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_STATUSDATA1]);
            /// <summary>
            /// 状态数据2
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_STATUSDATA2]);
            /// <summary>
            /// 状态数据3
            /// </summary>
            inverterMonitors.Add(monitorMap[MIC_INVERTER_STATUSDATA3]);
            typeMonitorsMap.Add(DeviceData.INVERTER_CODE, inverterMonitors);


            //汇流箱在用测点
            IList<MonitorType> huiliuxiangMonitors = new List<MonitorType>();
            /// <summary>
            /// 最大接入路数
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_MAXLINE]);
            /// <summary>
            /// 机内温度
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_JNTEMPRATURE]);
            /// <summary>
            /// 直流母线电压
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_DCUXVOLT]);
            /// <summary>
            /// 数字输入
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_DIGITALINPUT]);
            /// <summary>
            /// 第一路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_1CURRENT]);
            /// <summary>
            /// 第二路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_2CURRENT]);
            /// <summary>
            /// 第三路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_3CURRENT]);
            /// <summary>
            /// 第四路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_4CURRENT]);
            /// <summary>
            /// 第五路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_5CURRENT]);
            /// <summary>
            /// 第六路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_6CURRENT]);
            /// <summary>
            /// 第七路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_7CURRENT]);
            /// <summary>
            /// 第八路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_8CURRENT]);
            /// <summary>
            /// 第九路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_9CURRENT]);
            /// <summary>
            /// 第十路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_10CURRENT]);
            /// <summary>
            /// 第十一路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_11CURRENT]);
            /// <summary>
            /// 第十二路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_12CURRENT]);
            /// <summary>
            /// 第十三路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_13CURRENT]);
            /// <summary>
            /// 第十四路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_14CURRENT]);
            /// <summary>
            /// 第十五路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_15CURRENT]);
            /// <summary>
            /// 第十六路电流
            /// </summary>
            huiliuxiangMonitors.Add(monitorMap[MIC_BUSBAR_16CURRENT]);


            typeMonitorsMap.Add(DeviceData.HUILIUXIANG_CODE, huiliuxiangMonitors);

            //环境监测仪在用测点
            IList<MonitorType> detectorMonitors = new List<MonitorType>();
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_ADR]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_ENRIONMENTTEMPRATURE]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_ENRIONMENTTEMPRATUREHIGH]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_PANELTEMPRATURE]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_PANELTEMPRATUREHIGH]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_SUNLINGHT]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_WINDDIRECTION]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_WINDSPEED]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_WINDSPEEDHIGH]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_XMRZQD]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_DAYRADIATION]);
            detectorMonitors.Add(monitorMap[MIC_DETECTOR_TOTALRADIATION]);
            typeMonitorsMap.Add(DeviceData.ENVRIOMENTMONITOR_CODE, detectorMonitors);

            //配电柜测点
            IList<MonitorType> cabinetMonitors = new List<MonitorType>();
            /// <summary>
            /// 最大接入路数
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_MAXLINE]);
            /// <summary>
            /// 机内温度
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_JNTEMPRATURE]);
            /// <summary>
            /// 直流母线电压
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_DCUXVOLT]);
            /// <summary>
            /// 数字输入
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_DIGITALINPUT]);
            /// <summary>
            /// 第一路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_1CURRENT]);
            /// <summary>
            /// 第二路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_2CURRENT]);
            /// <summary>
            /// 第三路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_3CURRENT]);
            /// <summary>
            /// 第四路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_4CURRENT]);
            /// <summary>
            /// 第五路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_5CURRENT]);
            /// <summary>
            /// 第六路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_6CURRENT]);
            /// <summary>
            /// 第七路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_7CURRENT]);
            /// <summary>
            /// 第八路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_8CURRENT]);
            /// <summary>
            /// 第九路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_9CURRENT]);
            /// <summary>
            /// 第十路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_10CURRENT]);
            /// <summary>
            /// 第十一路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_11CURRENT]);
            /// <summary>
            /// 第十二路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_12CURRENT]);
            /// <summary>
            /// 第十三路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_13CURRENT]);
            /// <summary>
            /// 第十四路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_14CURRENT]);
            /// <summary>
            /// 第十五路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_15CURRENT]);
            /// <summary>
            /// 第十六路电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_16CURRENT]);

            /// <summary>
            /// 最大电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_MAXCURRENT]);

            /// <summary>
            /// 平均电流
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_AVGCURRENT]);

            /// <summary>
            /// 状态
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_STATUS]);
            /// <summary>
            /// 短路数据
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_DUANLUDATA]);

            /// <summary>
            /// 电流过高数据
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_DLGGDATA]);

            /// <summary>
            /// 电流过低数据
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_DLGDDATA]);
            /// <summary>
            /// 开路数据
            /// </summary>
            cabinetMonitors.Add(monitorMap[MIC_BUSBAR_KAILUDATA]);
            typeMonitorsMap.Add(DeviceData.CABINET_CODE, cabinetMonitors);


            //电表测点
            IList<MonitorType> ammeterMonitors = new List<MonitorType>();
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_SYSFREQUENCY]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEVOLTAGE1]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEVOLTAGE2]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEVOLTAGE3]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASECURRENT1]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASECURRENT2]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASECURRENT3]);

            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEACTIVEPOWER1]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEACTIVEPOWER2]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEACTIVEPOWER3]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_SYSACTIVEPOWER]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEREACTIVEPOWER1]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEREACTIVEPOWER2]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEREACTIVEPOWER3]);

            ammeterMonitors.Add(monitorMap[MIC_AMMETER_SYSREACTIVEPOWER]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEAPPARENTPOWER1]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEAPPARENTPOWER2]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PHASEAPPARENTPOWER3]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_SYSAPPARENTPOWER]);

            ammeterMonitors.Add(monitorMap[MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_REVERSEACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PUREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_PUREREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE]);

            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE]);

            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE]);
            ammeterMonitors.Add(monitorMap[MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE]);

            typeMonitorsMap.Add(DeviceData.AMMETER_CODE, ammeterMonitors);

            //电站在用测点
            IList<MonitorType> plantMonitors = new List<MonitorType>();
            plantMonitors.Add(monitorMap[PLANT_MONITORITEM_AMBIENTTEMP_CODE]);
            plantMonitors.Add(monitorMap[PLANT_MONITORITEM_ENERGY_CODE]);
            plantMonitors.Add(monitorMap[PLANT_MONITORITEM_LINGT_CODE]);
            plantMonitors.Add(monitorMap[PLANT_MONITORITEM_POWER_CODE]);
            plantMonitors.Add(monitorMap[PLANT_MONITORITEM_WINDDIRECTION]);
            plantMonitors.Add(monitorMap[PLANT_MONITORITEM_WINDSPEED]);
            typeMonitorsMap.Add(DeviceData.PLANT_CODE, plantMonitors);


            //add by qhb in 20120827 for 建立测点的bit位和状态项目的对应关系 协议上是0和3 要+1个
            bitStatusMap.Add(MIC_BUSBAR_DIGITALINPUT.ToString() + 1, digital_input_item_flq);
            bitStatusMap.Add(MIC_BUSBAR_DIGITALINPUT.ToString() + 4, digital_input_item_dlq);
            bitStatusMap.Add(MIC_BUSBAR_STATUS.ToString() + 1, work_status_item_run);
            bitStatusMap.Add(MIC_BUSBAR_STATUS.ToString() + 2, work_status_item_stop);
            bitStatusMap.Add(MIC_BUSBAR_STATUS.ToString() + 3, work_status_item_flq);
            bitStatusMap.Add(MIC_BUSBAR_STATUS.ToString() + 4, work_status_item_jnwd);
            bitStatusMap.Add(MIC_BUSBAR_STATUS.ToString() + 6, work_status_item_duanlu);
            bitStatusMap.Add(MIC_BUSBAR_STATUS.ToString() + 7, work_status_item_dlgg);
            bitStatusMap.Add(MIC_BUSBAR_STATUS.ToString() + 8, work_status_item_dlgd);
            bitStatusMap.Add(MIC_BUSBAR_STATUS.ToString() + 9, work_status_item_kailu);
            //add by qhb in 20120827 end
        }

        /// <summary>
        /// 根据测点代码取得测点对象
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static MonitorType getMonitorTypeByCode(int code)
        {
            return monitorMap[code];
        }

        /// <summary>
        /// 根据类型取得在用测点列表
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static IList<MonitorType> getMonitorTypesByTypeCode(int code)
        {
            if (typeMonitorsMap.ContainsKey(code))
                return typeMonitorsMap[code];
            else
                return new List<MonitorType>();
        }

        public static IList<MonitorType> getFilterMonitorTypesByTypeCode(int code)
        {
            IList<MonitorType> filterMonitor = typeMonitorsMap[code];
            IList<MonitorType> tempMonitor = new List<MonitorType>();
            foreach (MonitorType type in filterMonitor)
            {

                if (type.code == MonitorType.MIC_DETECTOR_ADR || type.code == MonitorType.MIC_DETECTOR_SOI || type.code == MonitorType.MIC_DETECTOR_WINDDIRECTION || type.code == MonitorType.MIC_BUSBAR_MAXLINE || type.code == MonitorType.MIC_BUSBAR_COMMUNICATION || type.code == MonitorType.MIC_BUSBAR_DIGITALINPUT || type.code == MonitorType.MIC_BUSBAR_JDQOUT || type.code == MonitorType.MIC_BUSBAR_MAXLINE || type.code == MonitorType.MIC_INVERTER_STATUSTIME || type.code == MonitorType.MIC_INVERTER_DEVICESTATUS || type.code == MonitorType.MIC_INVERTER_OUTTYPE || type.code == MonitorType.MIC_INVERTER_POWER || type.code == MonitorType.MIC_INVERTER_RUNTIME || type.code == MonitorType.MIC_INVERTER_STATUSDATA1 || type.code == MonitorType.MIC_INVERTER_STATUSDATA2 || type.code == MonitorType.MIC_INVERTER_STATUSDATA3 || type.code == MonitorType.MIC_INVERTER_TODAYENERGY)
                    continue;
                tempMonitor.Add(type);
            }

            return tempMonitor;
        }

        private string _name;

        public MonitorType()
        {
        }
        /// <summary>
        /// 增加一个构造器 add by qhb in 20120914 for  能够快速实例化一个测点对象，比边tempaffix能够多线程安全
        /// </summary>
        /// <param name="code"></param>
        /// <param name="unit"></param>
        /// <param name="zerotoline"></param>
        /// <param name="tempaffix"></param>
        public MonitorType(int code, string unit, bool zerotoline,string tempaffix)
        {
            this.code = code;
            this.unit = unit;
            this.zerotoline = zerotoline;
            this.tempaffix = tempaffix;
        }

        public int code { get; set; }                 //测点代码
        public string unit { get; set; }              //测点单位
        public bool zerotoline { get; set; }          //改测点是否将0值改为-线输出
        public string tempaffix { get; set; }         //add by qhb in 20120914，for 测点代码临时后缀，如果有临时后缀那么去资源时，要在key后面增加“_”+临时后缀用于指向不同资源key从而取得不同资源名称
        public string name                            //测点名称
        {
            set
            {
                this._name = value;
            }
            get
            {
                if (string.IsNullOrEmpty(tempaffix))
                {
                    return LanguageUtil.getDesc("DEVICEMONITORITEM_" + this.code);
                }else
                    return LanguageUtil.getDesc("DEVICEMONITORITEM_" + this.code + "_" + this.tempaffix);
            }
        }

        /// <summary>
        /// 取得测点单位数组
        /// </summary>
        /// <returns></returns>
        public string[] units()
        {
            return unit.Split(',');
        }

        /// <summary>
        /// 根据电站测点代码取得测点第一个单位
        /// </summary>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public string getMonitorFirstUnitByCode()
        {
            if (unit.Length > 0)
                return unit.Split(',')[0];
            return "";
        }
        /// <summary>
        /// 是否显示历史曲线
        /// </summary>
        /// <returns></returns>
        public bool isHistory()
        {
            if (historyMonitorList.Contains(this.code))
                return true;
            return false;
        }
    }
}