using System.Collections.Generic;
using DataAnalyze.Protocol20;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Protocol;
namespace DataAnalyze
{
    /// <summary>
    /// 2.0协议的数据类型码定义
    /// 用于标识每个分包（6969开头的完整包）的意义
    /// 用在包头中说明协议的意义
    /// 数据类型码编号	注释
    /// 1	认证
    /// 2	电站信息数据
    /// 3	设备信息数据
    /// 4	实时数据
    /// 5	历史数据
    /// 6	参数设定信息
    /// </summary>
    public class DataType
    {
        /// <summary>
        /// 认证
        /// </summary>
        public const int DataType_auth= 1;
        /// <summary>
        /// 电站信息数据
        /// </summary>
        public const int DataType_plantinfo = 2;
        /// <summary>
        /// 设备信息数据
        /// </summary>
        public const int DataType_deviceinfo = 3;
        /// <summary>
        /// 实时数据
        /// </summary>
        public const int DataType_rundata = 4;

        /// <summary>
        /// 历史数据
        /// </summary>
        public const int DataType_historydata = 5;
        /// <summary>
        /// 参数设定信息
        /// </summary>
        public const int DataType_paramset= 6;

        //设备类型
        public static IDictionary<int,int> deviceTypeNoMap = new Dictionary<int,int>();

        //--------------------------------和数据接收服务共享数据的memcached key前缀定义-----------------
        /// <summary>
        /// tcp_20_plant_sn+”_”+系统毫秒时间戳+四位随机数
        /// </summary>
        public const string memcacheddata_affix_plantinfo = "tcp_20_plant_";

        /// <summary>
        /// tcp_20_device_sn+”_”+系统毫秒时间戳+四位随机数
        /// </summary>
        public const string memcacheddata_affix_deviceinfo = "tcp_20_device_";

        /// <summary>
        /// tcp_20_run_sn_公共地址_系统毫秒时间戳+四位随机数
        /// </summary>
        public const string memcacheddata_affix_run = "tcp_20_run_";

        //--------------------------------信息体类型定义-----------------
        /// <summary>
        /// 遥测类型信息体
        /// </summary>
        public const int yaoce = 1;
        /// <summary>
        /// 遥测信息体长度，8字节 =16个字符
        /// </summary>
        public const int yaocelength = 8;
        /// <summary>
        /// 遥测信息体值占用字节数量，4字节 =8个字符
        /// </summary>
        public const int yaocebyte = 4;
        /// <summary>
        /// 遥信类型信息体
        /// </summary>
        public const int yaoxin = 2;
        /// <summary>
        /// 遥信信息体长度
        /// </summary>
        public const int yaoxinlength = 12;
        /// <summary>
        /// 遥信信息体值占用字节数量，1字节 =2个字符
        /// </summary>
        public const int yaoxinbyte = 1;
        /// <summary>
        /// 遥脉类型信息体
        /// </summary>
        public const int yaomai = 3;
        /// <summary>
        /// 遥脉信息体长度，8字节 =16个字符
        /// </summary>
        public const int yaomailength = 8;
        /// <summary>
        /// 遥脉信息体值占用字节数量，4字节 =8个字符
        /// </summary>
        public const int yaomaibyte = 4;



        //--------------信息单元地址定义----------------------
        /// <summary>
        /// 日发电量
        /// </summary>
        public const int plant_dayenergy = 1;
        /// <summary>
        /// 累计发电量
        /// </summary>
        public const int plant_totalenergy = 2;
        /// <summary>
        /// 水平日照幅度
        /// </summary>
        public const int plant_sunlight = 3;
        /// <summary>
        /// 环境温度
        /// </summary>
        public const int plant_temperature = 5;
        /// <summary>
        /// 功率
        /// </summary>
        public const int plant_power = 7;
        //设备类型map
        public static Hashtable deviceTypeMap = new Hashtable();
        public DataType()
        {
            if (deviceTypeMap.Keys.Count > 0) return;
            //-------------------电站数据信息单元地址定义------------------
            deviceTypeMap.Add(plant_dayenergy, new InfoUnitAddress(1, MonitorType.PLANT_MONITORITEM_ENERGY_CODE, "日发电量", InfoUnitAddress.sign_type_u, 1, yaomai, DeviceData.PLANT_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(plant_totalenergy, new InfoUnitAddress(2, MonitorType.PLANT_MONITORITEM_TOTALENERGY_CODE, "总发电量", InfoUnitAddress.sign_type_u, 1, yaomai, DeviceData.PLANT_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(plant_sunlight, new InfoUnitAddress(3, MonitorType.PLANT_MONITORITEM_LINGT_CODE, "水平日照幅度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.PLANT_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(4, new InfoUnitAddress(4, MonitorType.p, "斜面日照幅度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.PLANT_CODE, false));
            deviceTypeMap.Add(plant_temperature, new InfoUnitAddress(5, MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE, "环境温度", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.PLANT_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(6, new InfoUnitAddress(6, 0, "电池板温度", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.PLANT_CODE, false));
            deviceTypeMap.Add(plant_power, new InfoUnitAddress(7, MonitorType.PLANT_MONITORITEM_POWER_CODE, "功率", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.PLANT_CODE, SystemCode.ReversionType_all));

            //-------------------逆变器数据信息单元地址定义--------
            deviceTypeMap.Add(201, new InfoUnitAddress(201, MonitorType.MIC_INVERTER_TODAYENERGY, "日发电量", InfoUnitAddress.sign_type_u, 1, yaomai, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(202, new InfoUnitAddress(202, MonitorType.MIC_INVERTER_TOTALENERGY, "总发电量", InfoUnitAddress.sign_type_u, 1, yaomai, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(203, new InfoUnitAddress(203, MonitorType.MIC_INVERTER_RUNTIME, "总运行时间", InfoUnitAddress.sign_type_u, 0, yaomai, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(204, new InfoUnitAddress(204, MonitorType.MIC_INVERTER_JNKQTEMPRATURE, "机内空气温度", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(205, new InfoUnitAddress(205, MonitorType.MIC_INVERTER_JNBYQTEMPRATURE, "机内变压器温度", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(206, new InfoUnitAddress(206, MonitorType.MIC_INVERTER_JNSRQTEMPRATURE, "机内散热器温度", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(207, new InfoUnitAddress(207, MonitorType.MIC_INVERTER_DV, "直流电压", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(208, new InfoUnitAddress(208, MonitorType.MIC_INVERTER_DC, "直流电流", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(209, new InfoUnitAddress(209, MonitorType.MIC_INVERTER_TOTALDPOWER, "总直流功率", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(210, new InfoUnitAddress(210, MonitorType.MIC_INVERTER_ADIRECTVOLT, "A相电压", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(211, new InfoUnitAddress(211, MonitorType.MIC_INVERTER_BDIRECTVOLT, "B相电压", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(212, new InfoUnitAddress(212, MonitorType.MIC_INVERTER_CDIRECTVOLT, "C相电压", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(213, new InfoUnitAddress(213, MonitorType.MIC_INVERTER_ADIRECTCURRENT, "A相电流", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(214, new InfoUnitAddress(214, MonitorType.MIC_INVERTER_BDIRECTCURRENT, "B相电流", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(215, new InfoUnitAddress(215, MonitorType.MIC_INVERTER_CDIRECTCURRENT, "C相电流", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(216, new InfoUnitAddress(216, MonitorType.MIC_INVERTER_ADIRECTPOWER, "A相有功功率", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(217, new InfoUnitAddress(217, MonitorType.MIC_INVERTER_BDIRECTPOWER, "B相有功功率", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(218, new InfoUnitAddress(218, MonitorType.MIC_INVERTER_CDIRECTPOWER, "C相有功功率", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(219, new InfoUnitAddress(219, MonitorType.MIC_INVERTER_TOTALYGPOWER, "总有功功率", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(220, new InfoUnitAddress(220, MonitorType.MIC_INVERTER_TOTALWGPOWER, "总无功功率", InfoUnitAddress.sign_type_s, 0, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(221, new InfoUnitAddress(221, MonitorType.MIC_INVERTER_TOTALPOWERFACTOR, "总功率因数", InfoUnitAddress.sign_type_s, 3, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(222, new InfoUnitAddress(222, MonitorType.MIC_INVERTER_DWPL, "电网频率", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(223, new InfoUnitAddress(223, MonitorType.MIC_INVERTER_INVERTERXL, "逆变器效率", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.INVERTER_CODE, SystemCode.ReversionType_all));

            //-------------------汇流箱数据信息单元地址定义--------
            deviceTypeMap.Add(301, new InfoUnitAddress(301, MonitorType.MIC_BUSBAR_JNTEMPRATURE, "机内温度", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(302, new InfoUnitAddress(302, MonitorType.MIC_BUSBAR_DCUXVOLT, "直流母线电压", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(303, new InfoUnitAddress(303, MonitorType.MIC_BUSBAR_1CURRENT, "第一路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(304, new InfoUnitAddress(304, MonitorType.MIC_BUSBAR_2CURRENT, "第二路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(305, new InfoUnitAddress(305, MonitorType.MIC_BUSBAR_3CURRENT, "第三路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(306, new InfoUnitAddress(306, MonitorType.MIC_BUSBAR_4CURRENT, "第四路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(307, new InfoUnitAddress(307, MonitorType.MIC_BUSBAR_5CURRENT, "第五路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(308, new InfoUnitAddress(308, MonitorType.MIC_BUSBAR_6CURRENT, "第六路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(309, new InfoUnitAddress(309, MonitorType.MIC_BUSBAR_7CURRENT, "第七路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(310, new InfoUnitAddress(310, MonitorType.MIC_BUSBAR_8CURRENT, "第八路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(311, new InfoUnitAddress(311, MonitorType.MIC_BUSBAR_9CURRENT, "第九路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(312, new InfoUnitAddress(312, MonitorType.MIC_BUSBAR_10CURRENT, "第十路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(313, new InfoUnitAddress(313, MonitorType.MIC_BUSBAR_11CURRENT, "第十一路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(314, new InfoUnitAddress(314, MonitorType.MIC_BUSBAR_12CURRENT, "第十二路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(315, new InfoUnitAddress(315, MonitorType.MIC_BUSBAR_13CURRENT, "第十三路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(316, new InfoUnitAddress(316, MonitorType.MIC_BUSBAR_14CURRENT, "第十四路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(317, new InfoUnitAddress(317, MonitorType.MIC_BUSBAR_15CURRENT, "第十五路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(318, new InfoUnitAddress(318, MonitorType.MIC_BUSBAR_16CURRENT, "第十六路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(319, new InfoUnitAddress(319, MonitorType., "第十七路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(320, new InfoUnitAddress(320, MonitorType., "第十八路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(321, new InfoUnitAddress(321, MonitorType., "第十九路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(322, new InfoUnitAddress(322, MonitorType., "第二十路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(323, new InfoUnitAddress(323, MonitorType., "第二十一路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(324, new InfoUnitAddress(324, MonitorType., "第二十二路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(325, new InfoUnitAddress(325, MonitorType., "第二十三路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(326, new InfoUnitAddress(326, MonitorType., "第二十四路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(327, new InfoUnitAddress(327, MonitorType., "第二十五路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(328, new InfoUnitAddress(328, MonitorType., "第二十六路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(329, new InfoUnitAddress(329, MonitorType., "第二十七路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(330, new InfoUnitAddress(330, MonitorType., "第二十八路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(331, new InfoUnitAddress(331, MonitorType., "第二十九路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(332, new InfoUnitAddress(332, MonitorType., "第三十路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(333, new InfoUnitAddress(333, MonitorType., "第三十一路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(334, new InfoUnitAddress(334, MonitorType., "第三十二路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.HUILIUXIANG_CODE, SystemCode.ReversionType_all));
            //-----------------------环境监测仪信息单元地址定义------------------------
            deviceTypeMap.Add(401, new InfoUnitAddress(401, MonitorType.MIC_DETECTOR_DAYRADIATION, "日累计幅度", InfoUnitAddress.sign_type_u, 0, yaomai, DeviceData.ENVRIOMENTMONITOR_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(402, new InfoUnitAddress(402, MonitorType.MIC_DETECTOR_TOTALRADIATION, "累计幅度", InfoUnitAddress.sign_type_u, 0, yaomai, DeviceData.ENVRIOMENTMONITOR_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(403, new InfoUnitAddress(403, MonitorType.MIC_DETECTOR_SUNLINGHT, "水平日照幅度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.ENVRIOMENTMONITOR_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(404, new InfoUnitAddress(404, MonitorType.MIC_DETECTOR_XMRZQD, "斜面日照幅度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.ENVRIOMENTMONITOR_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(405, new InfoUnitAddress(405, MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE, "环境温度", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.ENVRIOMENTMONITOR_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(406, new InfoUnitAddress(406, MonitorType.MIC_DETECTOR_PANELTEMPRATURE, "电池板温度", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.ENVRIOMENTMONITOR_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(407, new InfoUnitAddress(407, MonitorType.MIC_DETECTOR_WINDSPEED, "风速", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.ENVRIOMENTMONITOR_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(408, new InfoUnitAddress(408, MonitorType.MIC_DETECTOR_WINDDIRECTION, "风向", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.ENVRIOMENTMONITOR_CODE, SystemCode.ReversionType_all));

            //-----------------------电表信息单元地址定义------------------------
            deviceTypeMap.Add(501, new InfoUnitAddress(501, MonitorType.MIC_AMMETER_SYSFREQUENCY, "系统频率", InfoUnitAddress.sign_type_u, 2, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(502, new InfoUnitAddress(502, MonitorType.MIC_AMMETER_PHASEVOLTAGE1, "相电压V1", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(503, new InfoUnitAddress(503, MonitorType.MIC_AMMETER_PHASEVOLTAGE2, "相电压V2", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(504, new InfoUnitAddress(504, MonitorType.MIC_AMMETER_PHASEVOLTAGE3, "相电压V3", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(505, new InfoUnitAddress(505, MonitorType.MIC_AMMETER_PHASECURRENT1, "相（线）电流I1", InfoUnitAddress.sign_type_u, 2, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(506, new InfoUnitAddress(506, MonitorType.MIC_AMMETER_PHASECURRENT2, "相（线）电流I2", InfoUnitAddress.sign_type_u, 2, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(507, new InfoUnitAddress(507, MonitorType.MIC_AMMETER_PHASECURRENT3, "相（线）电流I3", InfoUnitAddress.sign_type_u, 2, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(508, new InfoUnitAddress(508, MonitorType.MIC_AMMETER_PHASEACTIVEPOWER1, "分相有功功率P1", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(509, new InfoUnitAddress(509, MonitorType.MIC_AMMETER_PHASEACTIVEPOWER2, "分相有功功率P2", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(510, new InfoUnitAddress(510, MonitorType.MIC_AMMETER_PHASEACTIVEPOWER3, "分相有功功率P3", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(511, new InfoUnitAddress(511, MonitorType.MIC_AMMETER_SYSACTIVEPOWER, "系统有功功率Psum", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(512, new InfoUnitAddress(512, MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER1, "分相无功功率Q1", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(513, new InfoUnitAddress(513, MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER2, "分相无功功率Q2", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(514, new InfoUnitAddress(514, MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER3, "分相无功功率Q3", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(515, new InfoUnitAddress(515, MonitorType.MIC_AMMETER_SYSREACTIVEPOWER, "系统无功功率Qsum", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(516, new InfoUnitAddress(516, MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER1, "分相视在功率S1", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(517, new InfoUnitAddress(517, MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER2, "分相视在功率S2", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(518, new InfoUnitAddress(518, MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER3, "分相视在功率S3", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(519, new InfoUnitAddress(519, MonitorType.MIC_AMMETER_SYSAPPARENTPOWER, "系统视在功率Ssum", InfoUnitAddress.sign_type_u, 1, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(520, new InfoUnitAddress(520, MonitorType.MIC_AMMETER_PHASEPOWERFACTOR1, "分相功率因数PF1", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(521, new InfoUnitAddress(521, MonitorType.MIC_AMMETER_PHASEPOWERFACTOR2, "分相功率因数PF2", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(522, new InfoUnitAddress(522, MonitorType.MIC_AMMETER_PHASEPOWERFACTOR3, "分相功率因数PF3", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(523, new InfoUnitAddress(523, MonitorType.MIC_AMMETER_SYSPOWERFACTOR1, "系统功率因数PF", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(524, new InfoUnitAddress(524, MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE, "正向有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(525, new InfoUnitAddress(525, MonitorType.MIC_AMMETER_REVERSEACTIVEPOWERDEGREE, "反向有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(526, new InfoUnitAddress(526, MonitorType.MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE, "正向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(527, new InfoUnitAddress(527, MonitorType.MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE, "反向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(528, new InfoUnitAddress(528, MonitorType.MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE, "绝对值和有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(529, new InfoUnitAddress(529, MonitorType.MIC_AMMETER_PUREACTIVEPOWERDEGREE, "净有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(530, new InfoUnitAddress(530, MonitorType.MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE, "绝对值和无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(531, new InfoUnitAddress(531, MonitorType.MIC_AMMETER_PUREREACTIVEPOWERDEGREE, "净无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(532, new InfoUnitAddress(532, MonitorType.MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE, "费率波正向有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(533, new InfoUnitAddress(533, MonitorType.MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE, "费率波反向有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(534, new InfoUnitAddress(534, MonitorType.MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE, "费率波正向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(535, new InfoUnitAddress(535, MonitorType.MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE, "费率波反向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(536, new InfoUnitAddress(536, MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE, "费率峰正向有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(537, new InfoUnitAddress(537, MonitorType.MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE, "费率峰反向有功度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(538, new InfoUnitAddress(538, MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE, "费率峰正向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(539, new InfoUnitAddress(539, MonitorType.MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE, "费率峰反向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(540, new InfoUnitAddress(540, MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE, "费率谷正向有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(541, new InfoUnitAddress(541, MonitorType.MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE, "费率谷反向有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(542, new InfoUnitAddress(542, MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE, "费率谷正向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(543, new InfoUnitAddress(543, MonitorType.MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE, "费率谷反向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(544, new InfoUnitAddress(544, MonitorType.MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE, "费率平正向有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(545, new InfoUnitAddress(545, MonitorType.MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE, "费率平反向有功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(546, new InfoUnitAddress(546, MonitorType.MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE, "费率平正向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(547, new InfoUnitAddress(547, MonitorType.MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE, "费率平反向无功电度", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(548, new InfoUnitAddress(548, MonitorType, "电压不平衡度", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(549, new InfoUnitAddress(549, MonitorType, "电流不平衡度", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(550, new InfoUnitAddress(550, MonitorType, "有功功率需量", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(551, new InfoUnitAddress(551, MonitorType, "无功功率需量", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(552, new InfoUnitAddress(552, MonitorType, "视在功率需量", InfoUnitAddress.sign_type_u, 0, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(553, new InfoUnitAddress(553, MonitorType, "V1或V12总谐波畸变率", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(554, new InfoUnitAddress(554, MonitorType, "V2或V31总谐波畸变率", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(555, new InfoUnitAddress(555, MonitorType, "V3或V23总谐波畸变率", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(556, new InfoUnitAddress(556, MonitorType, "相或线电压平均总谐波畸变", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(557, new InfoUnitAddress(557, MonitorType, "I1总谐波畸变率THD_I1", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(558, new InfoUnitAddress(558, MonitorType, "I2总谐波畸变率THD_I2", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(559, new InfoUnitAddress(558, MonitorType, "I3总谐波畸变率THD_I3", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(560, new InfoUnitAddress(560, MonitorType, "相或线电流平均总谐波畸变率", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(561, new InfoUnitAddress(561, MonitorType, "V1或V12奇谐波畸变率", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(562, new InfoUnitAddress(562, MonitorType, "V1或V12偶谐波畸变率", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(563, new InfoUnitAddress(563, MonitorType, "V1或V12波峰系数", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(564, new InfoUnitAddress(564, MonitorType, "V1或V12电话谐波波形因数", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(565, new InfoUnitAddress(565, MonitorType, "V2或V31奇谐波畸变率", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(566, new InfoUnitAddress(566, MonitorType, "V2或V31偶谐波畸变率", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(567, new InfoUnitAddress(567, MonitorType, "V2或V31波峰系数", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(568, new InfoUnitAddress(568, MonitorType, "V2或V31波峰系数", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(569, new InfoUnitAddress(569, MonitorType, "V2或V31电话谐波波形因数", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(570, new InfoUnitAddress(570, MonitorType, "V3或V23波峰系数", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(571, new InfoUnitAddress(571, MonitorType, "V3或V23波峰系数", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(572, new InfoUnitAddress(572, MonitorType, "V3或V23电话谐波波形因数", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(573, new InfoUnitAddress(573, MonitorType, "I1奇谐波畸变率", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(574, new InfoUnitAddress(574, MonitorType, "I1偶谐波畸变率", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(575, new InfoUnitAddress(575, MonitorType, "I1 K系数", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(576, new InfoUnitAddress(576, MonitorType, "I2偶谐波畸变率", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(577, new InfoUnitAddress(577, MonitorType, "I2偶谐波畸变率", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(578, new InfoUnitAddress(578, MonitorType, "I2 K系数", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(579, new InfoUnitAddress(579, MonitorType, "I3奇谐波畸变率", InfoUnitAddress.sign_type_u, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(580, new InfoUnitAddress(580, MonitorType, "I3偶谐波畸变率", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(581, new InfoUnitAddress(581, MonitorType, "I3 K系数", InfoUnitAddress.sign_type_s, 4, yaoce, DeviceData.AMMETER_CODE, SystemCode.ReversionType_all));
            
            //---------------直流配电柜信息单元地址定义--------------------
            deviceTypeMap.Add(801, new InfoUnitAddress(801, MonitorType.MIC_BUSBAR_TOTALCURRENT, "总电流", InfoUnitAddress.sign_type_s, 1, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(802, new InfoUnitAddress(802, MonitorType.MIC_BUSBAR_1CURRENT, "第一路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(803, new InfoUnitAddress(803, MonitorType.MIC_BUSBAR_2CURRENT, "第二路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(804, new InfoUnitAddress(804, MonitorType.MIC_BUSBAR_3CURRENT, "第三路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(805, new InfoUnitAddress(805, MonitorType.MIC_BUSBAR_4CURRENT, "第四路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(806, new InfoUnitAddress(806, MonitorType.MIC_BUSBAR_5CURRENT, "第五路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(807, new InfoUnitAddress(807, MonitorType.MIC_BUSBAR_6CURRENT, "第六路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(808, new InfoUnitAddress(808, MonitorType.MIC_BUSBAR_7CURRENT, "第七路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(809, new InfoUnitAddress(809, MonitorType.MIC_BUSBAR_8CURRENT, "第八路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(810, new InfoUnitAddress(810, MonitorType.MIC_BUSBAR_9CURRENT, "第九路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(811, new InfoUnitAddress(811, MonitorType.MIC_BUSBAR_10CURRENT, "第十路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(812, new InfoUnitAddress(812, MonitorType.MIC_BUSBAR_11CURRENT, "第十一路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(813, new InfoUnitAddress(813, MonitorType.MIC_BUSBAR_12CURRENT, "第十二路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(814, new InfoUnitAddress(814, MonitorType.MIC_BUSBAR_13CURRENT, "第十三路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(815, new InfoUnitAddress(815, MonitorType.MIC_BUSBAR_14CURRENT, "第十四路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(816, new InfoUnitAddress(816, MonitorType.MIC_BUSBAR_15CURRENT, "第十五路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeMap.Add(817, new InfoUnitAddress(817, MonitorType.MIC_BUSBAR_16CURRENT, "第十六路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(818, new InfoUnitAddress(818, 0, "第十七路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(819, new InfoUnitAddress(819, 0, "第十八路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(820, new InfoUnitAddress(820, 0, "第十九路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(821, new InfoUnitAddress(821, 0, "第二十路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(822, new InfoUnitAddress(822, 0, "第二十一路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(823, new InfoUnitAddress(823, 0, "第二十二路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(824, new InfoUnitAddress(824, 0, "第二十三路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(825, new InfoUnitAddress(825, 0, "第二十四路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(826, new InfoUnitAddress(826, 0, "第二十五路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(827, new InfoUnitAddress(827, 0, "第二十六路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(828, new InfoUnitAddress(828, 0, "第二十七路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(829, new InfoUnitAddress(829, 0, "第二十八路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(830, new InfoUnitAddress(830, 0, "第二十九路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(831, new InfoUnitAddress(831, 0, "第三十路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(832, new InfoUnitAddress(832, 0, "第三十一路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            //deviceTypeMap.Add(833, new InfoUnitAddress(833, 0, "第三十二路电流", InfoUnitAddress.sign_type_s, 2, yaoce, DeviceData.CABINET_CODE, SystemCode.ReversionType_all));
            deviceTypeNoMap.Add(1,DeviceData.INVERTER_CODE);
            deviceTypeNoMap.Add(2,DeviceData.HUILIUXIANG_CODE);
            deviceTypeNoMap.Add(3,DeviceData.CABINET_CODE);
            deviceTypeNoMap.Add(4,DeviceData.CABINET_CODE);
            deviceTypeNoMap.Add(5,DeviceData.ENVRIOMENTMONITOR_CODE);
            deviceTypeNoMap.Add(6,DeviceData.AMMETER_CODE);
            //deviceTypeNoMap.Add(1,DeviceData.INVERTER_CODE);
            //        1 逆变器
            //2 汇流箱
            //3 直流配电柜
            //4 交流配电柜
            //5 环境监测装置
            //6 电表计量装置
            //7 光伏跟踪系统
            //8 BMS
        }
    }
}
