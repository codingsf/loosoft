using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;

namespace Cn.Loosoft.Zhisou.SunPower.Common.vo
{

    //-----------------开放接口apivo-----------------------
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    public class PlantOverviewVO
    {
        public PlantOverviewVO() { }

        [DataMember(Order = 0)]
        public int plantCount { get; set; }         //电站数量汇总
        [DataMember(Order = 1)]
        public string dayEnergy { get; set; }       //电站日发电量汇总
        [DataMember(Order = 2)]
        public string dayEnergyUnit { get; set; }   //电站日发电量汇总单位
        [DataMember(Order = 3)]
        public string totalEnergy { get; set; }     //电站总发电量汇总
        [DataMember(Order = 4)]
        public string totalEnergyUnit { get; set; } //电站总发电量汇总单位
        [DataMember(Order = 5)]
        public string curPower { get; set; }        //当前功率汇总
        [DataMember(Order = 6)]
        public string curPowerUnit { get; set; }    //当前功率汇总单位
        [DataMember(Order = 7)]
        public string dayCo2Reduce { get; set; }    //电站日co2减排汇总
        [DataMember(Order = 8)]
        public string dayCo2ReduceUnit { get; set; }//电站日co2减排汇总单位
        [DataMember(Order = 9)]
        public string totalCo2Reduce { get; set; }  //电站总co2减排汇总
        [DataMember(Order = 10)]
        public string totalCo2RedUnit { get; set; } //电站总co2减排汇总单位 
    }

    /// <summary>
    /// 简单电站信息vo
    /// </summary>
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    [Serializable]
    public class SimplePlantVO
    {
        public SimplePlantVO() { }
        [DataMember(Order = 0)]
        public int plantId { get; set; }         //电站id
        [DataMember(Order = 1)]
        public string plantName { get; set; }       //电站名称
    }

    /// <summary>
    /// 电站信息vo
    /// </summary>
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    [Serializable]
    public class PlantVO
    {
        public PlantVO() { }
        [DataMember(Order = 0)]
        public int plantId { get; set; }         //电站id
        [DataMember(Order = 1)]
        public string plantName { get; set; }       //电站名称
        [DataMember(Order = 2)]
        public int logCount { get; set; }        //未确认告警数量
        [DataMember(Order = 3)]
        public string dayEnergy { get; set; }               //电站id
        [DataMember(Order = 4)]
        public string dayEnergyUnit { get; set; }           //电站id
        [DataMember(Order = 5)]
        public string totalEnergy { get; set; }             //电站总发电量
        [DataMember(Order = 6)]
        public string totalEnergyUnit { get; set; }         //电站总发电量单位
        [DataMember(Order = 7)]
        public string CQ2reduce { get; set; }              //电站co2减排
        [DataMember(Order = 8)]
        public string CQ2reduceUnit { get; set; }          //电站co2减排单位
        [DataMember(Order = 9)]
        public string solarIntensity { get; set; }         //光照
        [DataMember(Order = 10)]
        public string solarIntensityUnit { get; set; }     //光照单位
        [DataMember(Order = 11)]
        public string temprature { get; set; }             //温度
        [DataMember(Order = 12)]
        public string tempratureUnit { get; set; }         //温度单位
        [DataMember(Order = 13)]
        public string curPower { get; set; }             //当前功率
        [DataMember(Order = 14)]
        public string curPowerUnit { get; set; }         //当前功率单位
        [DataMember(Order = 15)]
        public string imageArray { get; set; }         //图片地址 多长图片，分割
        [DataMember(Order = 16)]
        public string Country { get; set; }         //国家
        [DataMember(Order = 17)]
        public string City { get; set; }         //城市
        [DataMember(Order = 18)]
        public string DesignPower { get; set; }         //设计功率
        [DataMember(Order = 19)]
        public string organize { get; set; }         //所属公司
        [DataMember(Order = 20)]
        public string installDate { get; set; }         //安装日期
        [DataMember(Order = 21)]
        public string inverterCount { get; set; }       //逆变器数量
        [DataMember(Order = 22)]
        public string inverterTypeStr { get; set; }     //逆变器类型，逗号分隔
    }

    /// <summary>
    /// 封装整个图表数据
    /// </summary>
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    [Serializable]
    public class ChartData
    {
        [DataMember(Order = 0)]
        public string name { get; set; }
        [DataMember(Order = 1)]
        public string[] names { get; set; }//多维图表名称
        [DataMember(Order = 2)]
        public string[] colors { get; set; }//多维图表颜色
        [DataMember(Order = 3)]
        public string[] units { get; set; }//多维图表名称
        [DataMember(Order = 4)]
        public string[] categories { get; set; }//横坐标数据
        [DataMember(Order = 5)]
        public YData[] series { get; set; }
        [DataMember(Order = 6)]
        public bool isHasData { get; set; }
        [DataMember(Order = 7)]
        public string errorDesc { get; set; }
        [DataMember(Order = 8)]
        public string serieNo { get; set; }//唯一序列号，用户标识数据
    }

    /// <summary>
    /// y轴数据
    /// </summary>
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    [Serializable]
    public class YData
    {
        [DataMember(Order = 0)]
        public string name { get; set; }  //纬度名称
        [DataMember(Order = 1)]
        public string type { get; set; }  //图表类型
        [DataMember(Order = 2)]
        public string color { get; set; } //颜色
        [DataMember(Order = 3)]
        public string yAxis { get; set; } //y轴序列
        [DataMember(Order = 4)]
        public float?[] data { get; set; }//数据
        [DataMember(Order = 5)]
        public float max { get; set; }    //y轴最大值
    }

    /// <summary>
    /// app应用错误
    /// </summary>
    ///         
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    public class ApiError
    {
        //用户名密码错误
        public static int usernameOrpasswordError = 11;

        //用户名不存在
        public static int useridnoexist = 21;

        //电站不存在
        public static int plantnoexist = 31;

        //设备不存在
        public static int devicenoexist = 41;

        public ApiError()
        {
        }

        public ApiError(int code, string desc)
        {
            this.code = code;
            this.desc = desc;
        }
        [DataMember(Order = 0)]
        public int code { get; set; }
        [DataMember(Order = 1)]
        public string desc { get; set; }
    }

    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    public class PlantInfoVo
    {
        [DataMember(Order = 0)]
        public string plantId { get; set; }    //电站id
        [DataMember(Order = 1)]
        public string plantName { get; set; }  //电站名称
        [DataMember(Order = 2)]
        public string country { get; set; }    //国家
        [DataMember(Order = 3)]
        public string city { get; set; }       //城市
        [DataMember(Order = 4)]
        public double Longitude { get; set; }  //纬度
        [DataMember(Order = 5)]
        public double latitude { get; set; }   //精度
        [DataMember(Order = 6)]
        public string design_power { get; set; } //设计功率
    }


    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    public class TotalInfo
    {
        [DataMember(Order = 0)]
        public int plantsCount { get; set; }  //电站总数

        [DataMember(Order = 1)]
        public double totalDayEnergy { get; set; }  //今日总发电量数据

        [DataMember(Order = 2)]
        public string totalDayEnergyUnit { get; set; }  //今日总发电量单位

        [DataMember(Order = 3)]
        public double totalEnergy { get; set; } //总发电量

        [DataMember(Order = 4)]
        public string totalEnergyUnit { get; set; } //总发电量单位

        [DataMember(Order = 5)]
        public double totalCO2Reduce { get; set; } //CO2减排

        [DataMember(Order = 6)]
        public string totalCO2ReduceUnit { get; set; } //CO2减排单位

        [DataMember(Order = 7)]
        public double totalTodayPower { get; set; } //今日功率

        [DataMember(Order = 8)]
        public string totalTodayPowerUnit { get; set; } //今日功率单位


        [DataMember(Order = 9)]
        public double totalPower { get; set; } //总装机容量

        [DataMember(Order = 10)]
        public string totalPowerUnit { get; set; } //总装机容量单位

        [DataMember(Order = 11)]
        public string treeNum { get; set; } //等效树木棵数
    }

    //add by qhb in 20120831 电站时区vo
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    public class PlantTimezoneVo
    {
        [DataMember(Order = 0)]
        public string plantId { get; set; }    //电站id
        [DataMember(Order = 1)]
        public string plantName { get; set; }  //电站名称
        [DataMember(Order = 2)]
        public string timezoneCode { get; set; }   //时区
        [DataMember(Order = 3)]
        public string timezoneName { get; set; }   //时区名称
    }

    /// <summary>
    /// add by qhb in 20120831 for 分页时区vo
    /// </summary>
    public class PlantTimezonePageVo
    {
        public int totalpagecount { get; set; }
        public IList<PlantTimezoneVo> timezones { get; set; }

    }

    /// <summary>
    /// 用户VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    public class UserPlantVO
    {
        [DataMember(Order = 0)]
        public int userId { get; set; }
        [DataMember(Order = 1)]
        public string username { get; set; }
        [DataMember(Order = 2)]
        public double totalEnergy { get; set; }
        [DataMember(Order = 3)]
        public string totalEnergyUnit { get; set; }   //总发电量单位
        [DataMember(Order = 4)]
        public double todayEnergy { get; set; }
        [DataMember(Order = 5)]
        public string todayEnergyUnit { get; set; }   //今日发电量单位
        [DataMember(Order = 6)]
        public double power { get; set; }
        [DataMember(Order = 7)]
        public string powerUnit { get; set; }   //功率单位
        [DataMember(Order = 8)]
        public double co2Reduction { get; set; }//CO2减排
        [DataMember(Order = 9)]
        public string co2ReductionUnit { get; set; }//CO2减排单位
        [DataMember(Order = 10)]
        public double revenue { get; set; }//收益
        [DataMember(Order = 11)]
        public string revenueUnit { get; set; }//收益单位
        [DataMember(Order = 12)]
        public string families { get; set; }//家庭日用电户数
        [DataMember(Order = 13)]
        public int warnNums { get; set; }//告警数量
        [DataMember(Order = 14)]
        public IList<SimplePlantVO> plants { get; set; }//电站列表
    }

}