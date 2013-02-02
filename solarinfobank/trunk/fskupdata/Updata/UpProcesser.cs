/*******************************
/* 项目：具体处理数据上传线程            
/* 版本：1.0                           
/* 作者：陈波                   
/* 日期：2012年12月14日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Threading;
using System.IO;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Configuration;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Net;
using System.Xml;
using MSXML2;
namespace Updata
{
    /// <summary>
    /// 数据上传处理类
    /// 参照《太陽能设备参数 V3.1-20121214.xls》
    /// </summary>
    public class UpProcesser
    {
        //预定义各种设备类型的测点码和接口定义的设备个参数序号的对应关系
        //逆变器接口参数序号和bank测点对应map
        public static IDictionary<int, int > invert_no_mcodemap = new Dictionary<int, int >();
        //汇流箱接口参数序号和bank测点对应map
        public static IDictionary<int, int> hlx_no_mcodemap = new Dictionary<int, int>();
        //环境检测仪接口参数序号和bank测点对应map
        public static IDictionary<int, int> detector_no_mcodemap = new Dictionary<int, int>();
        //电表接口参数序号和bank测点对应map
        public static IDictionary<int, int> ammeter_no_mcodemap = new Dictionary<int, int>();
        //服务器url
        static string server_url = ConfigurationSettings.AppSettings["server_url"] == null ? "" : ConfigurationSettings.AppSettings["server_url"];
        //线程间隔时间ms
        static int thread_interval = ConfigurationSettings.AppSettings["thread_interval"] == null ? 60000 : int.Parse(ConfigurationSettings.AppSettings["thread_interval"]);

        static string plantId = ConfigurationSettings.AppSettings["plantId"] == null ? "ZZ1" : ConfigurationSettings.AppSettings["plantId"];
        public bool runmark = true;//继续现场运行标识

        static UpProcesser()
        {
        }
        /// <summary>
        /// 定时从缓存中取得要持久化的数据进行定时持久化
        /// </summary>
        public void Processing()
        {
            Console.WriteLine("启动上传线程");
            while (runmark)
            {
                //持久化数据
                handleData();
                Thread.Sleep(thread_interval);
            }
        }
  
        public void handleData(){
            Console.WriteLine("开始上传一批数据");
            FileLogUtil.info("------------------开始上传一批数据-------------------");
            //循环所有单元
            IList<PlantUnit> allUnits = PlantUnitService.GetInstance().getAllUnits();
            foreach(PlantUnit pu in allUnits){
                FileLogUtil.info("-----开始"+pu.displayname+"-------------");
                try{
                    handleUnitDevice(pu);
                }catch(Exception e){
                    FileLogUtil.info("-----" + pu.displayname + "处理失败"+e.Message+"-------------");
                    Console.WriteLine("-----" + pu.displayname + "处理失败" + e.Message + "-------------");
                }
                FileLogUtil.info("-----结束" + pu.displayname + "-------------");
                FileLogUtil.info("");
            }
            FileLogUtil.info("------------------结束上传一批数据-------------------");
        }

        /// <summary>
        /// 循环发送某个单元下面的设备
        /// </summary>
        /// <param name="pu"></param>
        private void handleUnitDevice(PlantUnit pu) {
            String plantName="";//上上即电站名称
            Console.WriteLine("unitname" + pu.displayname);
            //if (!pu.displayname.ToLower().Equals("e01")) return;
            //包括隐藏的
            foreach (Device device in pu.devices)
            {
                plantName = plantId;//接口约定好的
                //Plant plant = PlantService.GetInstance().GetPlantInfoById(pu.plantID);
                //if(plant!=null){
                    //plantName = plant.name;
                    //if(plant.parentPlant!=null){
                        //plantName = plant.parentPlant.name;
                    //}
                //}
                if(device!=null && pu!=null){
                    try{
                        handleDevice(device, pu, plantName);
                    }catch(Exception e){
                        FileLogUtil.info("-----设备" + pu.displayname + "-" + device.deviceTypeCode + "-" + StringUtil.getstr(device.deviceAddress,3) + "处理失败"+e.Message+"-------------");
                        Console.WriteLine("-----设备" + pu.displayname + "-" + device.deviceTypeCode + "-" + StringUtil.getstr(device.deviceAddress, 3) + "处理失败" + e.Message + "-------------");
                    }
                }
            }
        }

        /// <summary>
        /// 发送单个设备
        /// </summary>
        /// <param name="device"></param>
        private void handleDevice(Device device, PlantUnit pu, String plantName)
        {
            if (pu == null) return;
            //实时数据串“,”逗号分隔
            string realDataValueStr = "";
            if (device.runData != null){//组织数据串
                switch (device.deviceTypeCode) { 
                    case DeviceData.INVERTER_CODE:
                        realDataValueStr = getInverterRunDataStr(device,pu.collector);
                        break;
                    case DeviceData.HUILIUXIANG_CODE:
                        realDataValueStr = getHlxRunDataStr(device);
                        break;
                    case DeviceData.AMMETER_CODE:
                        realDataValueStr = getAmmeterRunDataStr(device);
                        break;
                    case DeviceData.ENVRIOMENTMONITOR_CODE:
                        realDataValueStr = getDetectorRunDataStr(device);
                        break;
                    default:
                        break;
                }
            }
            string DataCollectTime = device.runData == null ? "" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss");
            try
            {
                callwebservice(server_url, plantName, pu.displayname, device.deviceAddress, device.deviceTypeCode, DataCollectTime, realDataValueStr);
            }
            catch (Exception e)
            {
                FileLogUtil.info("-----设备" + pu.displayname + "-" + device.deviceTypeCode + "-" + StringUtil.getstr(device.deviceAddress, 3) + "上传失败" + e.Message + "-------------");
                Console.WriteLine("-----设备" + pu.displayname + "-" + device.deviceTypeCode + "-" + StringUtil.getstr(device.deviceAddress, 3) + "上传失败" + e.Message + "-------------");

            }
        }

        private void callwebservice(string url,string plantName, string unitName, string deviceAddress, int deviceTypeCode, string dataCollectTime, string realDataValueStr)
        { 
            //Web服务的地址
            //拼接数据

            string data;
            data = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            data = data + "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">";
            data = data + "<soap12:Body>";
            data = data + "<UpLoadEQValue xmlns=\"http://tempuri.org/\">";
            data = data + "<PlantID>" + plantName + "</PlantID>";
            data = data + "<BuildingID>" + unitName + "</BuildingID>";
            data = data + "<EQID>" + unitName + "-" + deviceTypeCode + "-" + StringUtil.getstr(deviceAddress,3) + "</EQID>";
            data = data + "<EqType>" + deviceTypeCode + "</EqType>";
            data = data + "<DataCollectTime>" + dataCollectTime + "</DataCollectTime>";
            data = data + "<EQValues>" + realDataValueStr + "</EQValues>";
            data = data + "</UpLoadEQValue>";
            data = data + "</soap12:Body>";
            data = data + "</soap12:Envelope>";

            //创建异步对象(XMLHTTP对象在MSXML2下)
            String res = "";
            XMLHTTP xmlhttp = new XMLHTTP();

            xmlhttp.open("POST", url, false, null, null);

            xmlhttp.setRequestHeader("Content-Type", "application/soap+xml");

            xmlhttp.send(data);
            res = System.Text.Encoding.UTF8.GetString((byte[])xmlhttp.responseBody);

            FileLogUtil.info("data" + data);
            FileLogUtil.info("res" + res);
            Console.WriteLine("data" + data);
            Console.WriteLine("res"+res);
        }

        /// <summary>
        /// 按照设备
        /// </summary>
        /// <param name="device"></param>
        /// <param name="collector"></param>
        /// <returns></returns>
        private string getInverterRunDataStr(Device device,Collector collector) {
            StringBuilder sb = new StringBuilder();
            //1	逆变器运行状态	　	　	0：待机（waiting）1：正常（normal）3：故障（fault）	1
            sb.Append(device.getStatusDefinedValue()).Append(",");
            //2	逆变器输入总功率	W	0.1W
            sb.Append("333.4").Append(",");
            //3	第一路电池板电压	V	0.1V
            sb.Append("33.4").Append(",");
            //4	第一路电池板电流	A	0.1A
            sb.Append("23.4").Append(",");
            //5	第一路电池板输出功率	W	0.1W
            sb.Append("23.4").Append(",");
            //6	第二路电池板电压	V	0.1V
            sb.Append("23.4").Append(",");
            //7	第二路电池板电流	A	0.1A
            sb.Append("23.4").Append(",");
            //8	第二路电池板输出功率	W	0.1W
            sb.Append("23.4").Append(",");
            //9	逆变器输出总功率	W	0.1W
            sb.Append("23.4").Append(",");
            //10	电网频率	Hz	0.01Hz
            sb.Append("224.14").Append(",");
            //11	第一相电压	V	0.1V
            sb.Append("23.4").Append(",");
            //12	第一相电流	A	0.1A
            sb.Append("23.4").Append(",");
            //13	第一相输出功率	W	0.1W
            sb.Append("23.4").Append(",");
            //14	第二相电压	V	0.1V
            sb.Append("23.4").Append(",");
            //15	第二相电流	A	0.1A
            sb.Append("23.4").Append(",");
            //16	第二相输出功率	W	0.1W
            sb.Append("23.4").Append(",");
            //17	第三相电压	V	0.1V
            sb.Append("23.4").Append(",");
            //18	第三相电流	A	0.1A
            sb.Append("23.4").Append(",");
            //19	第三相输出功率	W	0.1W
            sb.Append("23.4").Append(",");
            //20	今日发电量	KWH	0.1KWH
            sb.Append("23.4").Append(",");
            //21	累计发电量	KWH	0.1KWH
            sb.Append("23.4").Append(",");
            //22	总发电时间	S	0.5S
            sb.Append("23.4").Append(",");
            //23	逆变器内部温度	℃	0.1℃
            sb.Append("23.4").Append(",");
            //24	逆变器运行错误码
            sb.Append("9984").Append(",");
            //25	逆变器输出功率因数
            sb.Append("1.4").Append(",");
            //26	第一路电池板今日发电量	KWH	0.1KWH
            sb.Append("23.4").Append(",");
            //27	第一路电池板累计发电量	KWH	0.1KWH
            sb.Append("23.4").Append(",");
            //28	第二路电池板今日发电量	KWH	0.1KWH
            sb.Append("23.4").Append(",");
            //29	第二路电池板累计发电量	KWH	0.1KWH
            sb.Append("23.4").Append(",");
            //30	电池板累计发电量	KWH	0.1KWH
            sb.Append("23.4").Append(",");
            //31	交流端无功功率	Var	0.1Var
            sb.Append("23.4").Append(",");
            //32	今日无功电能	KVarH	0.1KVarH
            sb.Append("23.4").Append(",");
            //33	累计无功电能	KVarH	0.1KVarH
            sb.Append("23.4").Append(",");
            //34	数据采集器序列号
            sb.Append(collector.code).Append(",");
            //35	逆变器序列号
            sb.Append("");
            return sb.ToString();
        }

        private string getHlxRunDataStr(Device device)
        {
            StringBuilder sb = new StringBuilder();
            //1	設備状态	　	　	0：待机（waiting）1：正常（normal）3：故障（fault）
            sb.Append(device.getStatusDefinedValue()).Append(",");
            //2	光伏直流通道 1 	A	0.1A		7.31
            sb.Append("7.31").Append(",");
            //3	光伏直流通道 2 	A	0.1A		7.31
            sb.Append("7.31").Append(",");
            //4	光伏直流通道 3 	A	0.1A		7.16
            sb.Append("7.16").Append(",");
            //5	光伏直流通道 4 	A	0.1A		7.27
            sb.Append("7.27").Append(",");
            //6	光伏直流通道 5 	A	0.1A		7.22
            sb.Append("7.22").Append(",");
            //7	光伏直流通道 6 	A	0.1A		7.4
            sb.Append("7.4").Append(",");
            //8	光伏直流通道 7 	A	0.1A		7.4
            sb.Append("7.4").Append(",");
            //9	光伏直流通道 8 	A	0.1A		7.38
            sb.Append("7.38").Append(",");
            //10光伏直流通道 9 	A	0.1A		7.45
            sb.Append("7.45").Append(",");
            //11光伏直流通道 10 	A	0.1A		7.47
            sb.Append("7.47").Append(",");
            //12光伏直流通道 11 	A	0.1A		7.43
            sb.Append("7.43").Append(",");
            //13光伏直流通道 12 	A	0.1A		7.18
            sb.Append("7.18").Append(",");
            //14光伏直流通道 13 	A	0.1A		0
            sb.Append("0").Append(",");
            //15光伏直流通道 14 	A	0.1A		0
            sb.Append("0").Append(",");
            //16光伏直流通道 15 	A	0.1A		0
            sb.Append("0").Append(",");
            //17光伏直流通道 16 	A	0.1A		0
            sb.Append("0").Append(",");
            //18汇流母线电压 	V	0.1V		0
            sb.Append("0").Append(",");
            //19直流母线电压 	V	0.1V		0
            sb.Append("0").Append(",");
            //20AIDC 通道 3 				
            sb.Append("").Append(",");
            //21总功率(高前低后) 	W	0.1W		45470
            sb.Append("45470").Append(",");
            //22通道 1 功率 	W	0.1W		3774
            sb.Append("3774").Append(",");
            //23通道 2 功率 	W	0.1W		3779
            sb.Append("3779").Append(",");
            //24通道 3 功率 	W	0.1W		3702
            sb.Append("3702").Append(",");
            //25通道 4 功率 	W	0.1W		3755
            sb.Append("3755").Append(",");
            //26通道 5 功率 	W	0.1W		3730
            sb.Append("3730").Append(",");
            //27通道 6 功率 	W	0.1W		3825
            sb.Append("3825").Append(",");
            //28通道 7 功率 	W	0.1W		3823
            sb.Append("3823").Append(",");
            //29通道 8 功率 	W	0.1W		3815
            sb.Append("3815").Append(",");
            //30通道 9 功率 	W	0.1W		3851
            sb.Append("3851").Append(",");
            //31通道 10 功率 	W	0.1W		3858
            sb.Append("3858").Append(",");
            //32通道 11 功率 	W	0.1W		3841
            sb.Append("3841").Append(",");
            //33通道 12 功率 	W	0.1W		3712
            sb.Append("3712").Append(",");
            //34通道 13 功率 	W	0.1W		0
            sb.Append("0").Append(",");
            //35通道 14 功率 	W	0.1W		0
            sb.Append("0").Append(",");
            //36通道 15 功率 	W	0.1W		0
            sb.Append("0").Append(",");
            //37通道 16 功率 	W	0.1W		0
            sb.Append("0").Append(",");
            //38故障代碼			"可以by Bit表示(16*4)請提供故障代碼對照表"	EI028
            sb.Append("16401").Append(",");
            //39匯流箱溫度	℃	0.1℃		    45.8
            sb.Append("45.8").Append(",");
            //40串列轉換效率	%	0.10%		98.8
            sb.Append("9808").Append(",");
            //41匯流箱轉換效率	%	0.10%		99.3
            sb.Append("99.3");

            return sb.ToString();
        }

        private string getDetectorRunDataStr(Device device)
        {
            StringBuilder sb = new StringBuilder();
            //1	設備状态			"0：待机（waiting）1：正常（normal）3：故障（fault）"	1
            sb.Append(device.getStatusDefinedValue()).Append(",");
            //2	风速	m/s	0.1m/s		2.1
            sb.Append("2.1").Append(",");
            //3	风向	°（角度）	1°		265
            sb.Append("265").Append(",");
            //4	环境温度	℃	0.1℃		11.6
            sb.Append("11.6").Append(",");
            //5	电池板温度	℃	0.1℃		19.1
            sb.Append("19.1").Append(",");
            //6	辐射强度	W/㎡	1W/㎡		306
            sb.Append("306").Append(",");
            //7	故障代碼			請提供故障代碼對照表	EI501
            sb.Append("16400");
            return sb.ToString();
        }
        
        private string getAmmeterRunDataStr(Device device)
        {
            StringBuilder sb = new StringBuilder();
            
            //1	設備状态			"0：待机（waiting）1：正常（normal）3：故障（fault）"		1
            sb.Append(device.getStatusDefinedValue()).Append(",");
            //2	有功功率	W	0.1W		有功功率	46095
            sb.Append("46095").Append(",");
            //3	无功功率	Var	0.1Var		無功功率	6982.5
            sb.Append("6982.5").Append(",");
            //4	视在功率	VA	0.1VA		視在功率	46597.5
            sb.Append("46597.5").Append(",");
            //5	有功电量	KWH	0.1KWH		有功電量	48366.16
            sb.Append("48366.16").Append(",");
            //6	无功电量	KVarh	0.1KVarh		無功電量	1393.7
            sb.Append("1393.7").Append(",");
            //7	功率因数				系統功率因素	0.9892
            sb.Append("0.9892").Append(",");
            //8	波有功電量	KWH	0.1KWH		波有功電量	1.17
            sb.Append("1.17").Append(",");
            //9	峰有功電量	KWH	0.1KWH		峰有功電量	17113.46
            sb.Append("17113.46").Append(",");
            //10	谷有功電量	KWH	0.1KWH		谷有功電量	1832.39
            sb.Append("1832.39").Append(",");
            //11	平有功電量	KWH	0.1KWH		平有功電量	29418.38
            sb.Append("29418.38").Append(",");
            //12	故障代碼			請提供故障代碼對照表	E0030	
            sb.Append("21504").Append(",");
            //13	壓量程U0				壓量程U0	250
            sb.Append("250").Append(",");
            //14	流量程I0				流量程I0	5
            sb.Append("5").Append(",");
            //15	壓比UBB				壓比UBB	1
            sb.Append("1").Append(",");
            //16	流比IBB				流比IBB	100
            sb.Append("100").Append(",");
            //17	CEIL1				CEIL1	0
            sb.Append("0").Append(",");
            //18	CEIL2				CEIL2	0
            sb.Append("0");
            return sb.ToString();

        }
    }
}
