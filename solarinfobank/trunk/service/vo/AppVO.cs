using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;
namespace Cn.Loosoft.Zhisou.SunPower.Service.vo
{
    /// <summary>
    /// app应用错误
    /// </summary>
    ///         
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class AppError
    {
        //用户名密码错误
        public static int usernameOrpasswordError = 11;

        //用户名不存在
        public static int useridnoexist = 21;

        //电站不存在
        public static int plantnoexist = 31;

        //设备不存在
        public static int devicenoexist = 41;

        public AppError()
        {
        }

        public AppError(int code, string desc)
        {
            this.code = code;
            this.desc = desc;
        }
        [DataMember(Order = 0)]
        public int code { get; set; }
        [DataMember(Order = 1)]
        public string desc { get; set; }
    }

    /// <summary>
    /// 用户VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
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

    /// <summary>
    /// 简要电站VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class SimplePlantVO
    {
        public SimplePlantVO() { }

        public SimplePlantVO(int id, string name, string fullpic, string todayEnergy, string power, string totalEnergy)
        {
            this.id = id;
            this.name = name;
            this.fullpic = fullpic;
            this.todayEnergy = todayEnergy;
            this.power = power;
            this.totalEnergy = totalEnergy;
        }

        [DataMember(Order = 0)]
        public int id { get; set; }//电站id
        [DataMember(Order = 1)]
        public string name { get; set; }//电站名称
        [DataMember(Order = 2)]
        public string fullpic { get; set; }//图片
        [DataMember(Order = 3)]
        public string todayEnergy { get; set; }//今日发电量
        [DataMember(Order = 4)]
        public string power { get; set; }//功率
        [DataMember(Order = 5)]
        public string totalEnergy { get; set; }//总发电量
    }


    /// <summary>
    /// 电站简要信息和单元列表VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class Plant2UnitVO
    {
        [DataMember(Order = 0)]
        public int plantId { get; set; }//电站id
        [DataMember(Order = 1)]
        public string name { get; set; }//电站名称
        [DataMember(Order = 2)]
        public float totalEnergy { get; set; } //总发电量
        [DataMember(Order = 3)]
        public float todayEnergy { get; set; } //今日发电量
        [DataMember(Order = 4)]
        public float power { get; set; }       //电站功率
        [DataMember(Order = 5)]
        public float co2Reduction { get; set; }//CO2减排
        [DataMember(Order = 6)]
        public double revenue { get; set; }    //收益
        [DataMember(Order = 7)]
        public string pic { get; set; }        //电站图片
        [DataMember(Order = 8)]
        public string totalEnergyUnit { get; set; }    //总发电量单位
        [DataMember(Order = 9)]
        public string powerUnit { get; set; }          //功率单位
        [DataMember(Order = 10)]
        public string todayEnergyUnit { get; set; }    //今日发电量单位
        [DataMember(Order = 11)]
        public string co2ReductionUnit { get; set; }   //co2减排单位
        [DataMember(Order = 12)]
        public string revenueUnit { get; set; }        //收益单位
        [DataMember(Order = 13)]
        public int errorcount { get; set; }            //错误数量 
        [DataMember(Order = 14)]
        public IList<SimpleUnitVO> units { get; set; } //电站列表
        [DataMember(Order = 15)]
        public string city { get; set; }    //城市
        [DataMember(Order = 16)]
        public string country { get; set; } //国家
    }


    /// <summary>
    /// 简要单元VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class SimpleUnitVO
    {

        public SimpleUnitVO() { }

        public SimpleUnitVO(int id, string name, string workStatus, int deviceNums)
        {
            this.unitId = id;
            this.name = name;
            this.workStatus = workStatus;
            this.deviceNums = deviceNums;
        }

        [DataMember(Order = 0)]
        public int unitId { get; set; }//单元id
        [DataMember(Order = 1)]
        public string name { get; set; }//单元名称
        [DataMember(Order = 2)]
        public string workStatus { get; set; }//工作状态
        [DataMember(Order = 3)]
        public float deviceNums { get; set; } //设备数量
    }

    /// <summary>
    /// 故障告警信息vo
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class FaultVO
    {
        [DataMember(Order = 0)]
        public int faultId { get; set; }
        [DataMember(Order = 1)]
        public string deviceAddress { get; set; }//设备地址
        [DataMember(Order = 2)]
        public string deviceModel { get; set; }//设备型号
        [DataMember(Order = 3)]
        public string deviceType { get; set; } //设备类型
        [DataMember(Order = 4)]
        public string faultDesc { get; set; }  //错误描述
        [DataMember(Order = 5)]
        public string datetime { get; set; }     //告警时间
        [DataMember(Order = 6)]
        public string isConfirmed { get; set; } //是否确认
        [DataMember(Order = 7)]
        public string errorType { get; set; }    //错误类型
    }


    /// <summary>
    /// 故障告警信息vofro androind
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class AFaultVO
    {
        [DataMember(Order = 0)]
        public int faultId { get; set; }
        [DataMember(Order = 1)]
        public string deviceAddress { get; set; }//设备地址
        [DataMember(Order = 2)]
        public string deviceModel { get; set; }//设备型号
        [DataMember(Order = 3)]
        public string deviceType { get; set; } //设备类型
        [DataMember(Order = 4)]
        public string faultDesc { get; set; }  //错误描述
        [DataMember(Order = 5)]
        public string datetime { get; set; }     //告警时间
        [DataMember(Order = 6)]
        public string isConfirmed { get; set; } //是否确认
        [DataMember(Order = 7)]
        public string errorType { get; set; }    //错误类型
        [DataMember(Order = 8)]
        public string plantName { get; set; }    //电站名称
    }

    public class FaultVoResult
    {
        public int totalpagecount { get; set; }
        public IList<FaultVO> faults { get; set; }

    }

    public class AFaultVoResult
    {
        public int totalpagecount { get; set; }
        public IList<AFaultVO> faults { get; set; }

    }

    /// <summary>
    /// 电站详细信息vo
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class PlantInfoVO
    {
        [DataMember(Order = 0)]
        public int pId { get; set; }            //电站id
        [DataMember(Order = 1)]
        public string name { get; set; }        //电站名称
        [DataMember(Order = 2)]
        public string location { get; set; }    //电站位置
        [DataMember(Order = 3)]
        public string country { get; set; }     //所在国家
        [DataMember(Order = 4)]
        public string city { get; set; }        //所在城市
        [DataMember(Order = 5)]
        public string street { get; set; }      //所在街道
        [DataMember(Order = 6)]
        public string installdate { get; set; } //安装时间
        [DataMember(Order = 7)]
        public string direction { get; set; }   //电站朝向
        [DataMember(Order = 8)]
        public string angle { get; set; }       //角度
        [DataMember(Order = 9)]
        public string pic { get; set; }         //电站图片
        [DataMember(Order = 10)]
        public string longitude { get; set; }   //经度
        [DataMember(Order = 11)]
        public string latitude { get; set; }    //维度
        [DataMember(Order = 12)]
        public string sunlight { get; set; }    //关照强度
        [DataMember(Order = 13)]
        public string temperature { get; set; } //温度
        [DataMember(Order = 14)]
        public string weather { get; set; }      //天气
        [DataMember(Order = 15)]
        public float totalEnergy { get; set; }  //总发电量
        [DataMember(Order = 16)]
        public float todayEnergy { get; set; }  //今日发电量
        [DataMember(Order = 17)]
        public float designPower { get; set; }  //电站设计功率
        [DataMember(Order = 18)]
        public string manufacturer { get; set; }  //制造商
        [DataMember(Order = 19)]
        public string moduleType { get; set; }    //光伏模块类型
        [DataMember(Order = 20)]
        public string timeZone { get; set; }      //时区
        [DataMember(Order = 21)]
        public string operatorPerson { get; set; }//操作人   
        [DataMember(Order = 22)]
        public string zipCode { get; set; }       //邮编
        [DataMember(Order = 23)]
        public string phone { get; set; }         //电话
        [DataMember(Order = 24)]
        public string email { get; set; }         //邮箱
        [DataMember(Order = 25)]
        public string revenueRate { get; set; }   //收益折算率

        [DataMember(Order = 26)]
        public float co2Reduction { get; set; } //CO2减排
        [DataMember(Order = 27)]
        public double revenue { get; set; }     //收益
        [DataMember(Order = 28)]
        public string totalEnergyUnit { get; set; }    //总发电量单位
        [DataMember(Order = 29)]
        public string powerUnit { get; set; }          //功率单位
        [DataMember(Order = 30)]
        public string todayEnergyUnit { get; set; }    //今日发电量单位
        [DataMember(Order = 31)]
        public string co2ReductionUnit { get; set; }   //co2减排单位
        [DataMember(Order = 32)]
        public string revenueUnit { get; set; }        //收益单位
    }

    /// <summary>
    /// 单元下的设备列表VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class AUnitDeviceVO
    {
        [DataMember(Order = 0)]
        public int unitId { get; set; }//单元id
        [DataMember(Order = 1)]
        public string name { get; set; }//单元名称
        [DataMember(Order = 2)]
        public IList<ATypeDeviceVO> units { get; set; }//类型设备列表
    }

    /// <summary>
    /// 单元下的设备列表VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class UnitDeviceVO
    {
        [DataMember(Order = 0)]
        public int unitId { get; set; }//单元id
        [DataMember(Order = 1)]
        public string name { get; set; }//单元名称
        [DataMember(Order = 2)]
        public IList<TypeDeviceVO> units { get; set; }//类型设备列表
    }

    /// <summary>
    /// 类型设备列表VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class TypeDeviceVO
    {
        [DataMember(Order = 0)]
        public string type { get; set; }//设备类型
        [DataMember(Order = 1)]
        public IList<SimpleDeviceVO> devices { get; set; }//设备列表
    }

    /// <summary>
    /// 类型设备列表VO信ATypeDeviceVO息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class ATypeDeviceVO
    {
        [DataMember(Order = 0)]
        public string type { get; set; }//设备类型
        [DataMember(Order = 1)]
        public IList<ASimpleDeviceVO> devices { get; set; }//设备列表
    }

    /// <summary>
    /// 简要设备VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class SimpleDeviceVO
    {

        public SimpleDeviceVO() { }

        public SimpleDeviceVO(int id, string deviceModel, string workStatus, string deviceType, string address)
        {
            this.deviceId = id;
            this.deviceModel = deviceModel;
            this.workStatus = workStatus;
            this.deviceType = deviceType;
            this.address = address;
        }

        [DataMember(Order = 0)]
        public int deviceId { get; set; }//设备id
        [DataMember(Order = 1)]
        public string deviceModel { get; set; }//设备型号
        [DataMember(Order = 2)]
        public string deviceType { get; set; }//设备类型
        [DataMember(Order = 3)]
        public string workStatus { get; set; }//工作状态
        [DataMember(Order = 4)]
        public string address { get; set; }   //设备地址
        [DataMember(Order = 5)]
        public string displayField { get; set; }//今日发电量
        [DataMember(Order = 6)]
        public string pic { get; set; }         //图片
        [DataMember(Order = 7)]
        public string displayStatus { get; set; } //提醒状态 1 正常 2 黄色警告 3 红色警告
        [DataMember(Order = 8)]
        public string lastUpdatedTime { get; set; } //数据最后更新时间
    }

    /// <summary>
    /// androind简要设备VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class ASimpleDeviceVO
    {

        public ASimpleDeviceVO() { }

        public ASimpleDeviceVO(int id, string devicename, string deviceModel, string workStatus, string deviceType, string address)
        {
            this.deviceId = id;
            this.deviceModel = deviceModel;
            this.workStatus = workStatus;
            this.deviceType = deviceType;
            this.address = address;
        }

        [DataMember(Order = 0)]
        public int deviceId { get; set; }//设备id
        [DataMember(Order = 1)]
        public string deviceName { get; set; }//设备名称
        [DataMember(Order = 2)]
        public string deviceModel { get; set; }//设备型号
        [DataMember(Order = 3)]
        public string deviceType { get; set; }//设备类型
        [DataMember(Order = 4)]
        public string workStatus { get; set; }//工作状态
        [DataMember(Order = 5)]
        public string address { get; set; }   //设备地址
        [DataMember(Order = 6)]
        public string displayField { get; set; }//今日发电量
        [DataMember(Order = 7)]
        public string pic { get; set; }         //图片
        [DataMember(Order = 8)]
        public string displayStatus { get; set; } //提醒状态 1 正常 2 黄色警告 3 红色警告
        [DataMember(Order = 9)]
        public string lastUpdatedTime { get; set; } //数据最后更新时间
    }

    /// <summary>
    /// 设备详细信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class DeviceInfoVO
    {
        [DataMember(Order = 0)]
        public int deviceId { get; set; }//设备id
        [DataMember(Order = 1)]
        public string deviceName { get; set; }//设备名称
        [DataMember(Order = 2)]
        public string deviceModel { get; set; }//设备型号
        [DataMember(Order = 3)]
        public string deviceTypeCode { get; set; } //设备类型代码
        [DataMember(Order = 4)]
        public string deviceType { get; set; } //设备类型
        [DataMember(Order = 5)]
        public string workStatus { get; set; } //工作状态
        [DataMember(Order = 6)]
        public string address { get; set; }//设备地址
        [DataMember(Order = 7)]
        public string displayField { get; set; }//显示字段串，格式name:value unit
        [DataMember(Order = 8)]
        public IList<MonitorDataVO> datas { get; set; }//设备列表
        [DataMember(Order = 9)]
        public string hasChart { get; set; }           //是否显示图表
        [DataMember(Order = 10)]
        public string lastUpdateTime { get; set; }     //最后更新时间
    }

    /// <summary>
    /// 设备详细信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class ADeviceInfoVO
    {
        [DataMember(Order = 0)]
        public int deviceId { get; set; }//设备id
        [DataMember(Order = 1)]
        public string deviceName { get; set; }//设备名称
        [DataMember(Order = 2)]
        public string deviceModel { get; set; }//设备型号
        [DataMember(Order = 3)]
        public string deviceTypeCode { get; set; } //设备类型代码
        [DataMember(Order = 4)]
        public string deviceType { get; set; } //设备类型
        [DataMember(Order = 5)]
        public string workStatus { get; set; } //工作状态
        [DataMember(Order = 6)]
        public string address { get; set; }//设备地址
        [DataMember(Order = 7)]
        public string displayField { get; set; }//显示字段串，格式name:value unit
        [DataMember(Order = 8)]
        public IList<MonitorDataVO> datas { get; set; }//设备列表
        [DataMember(Order = 9)]
        public string hasChart { get; set; }           //是否显示图表
        [DataMember(Order = 10)]
        public string lastUpdateTime { get; set; }     //最后更新时间
    }


    /// <summary>
    /// 设备测点数据VO信息
    /// </summary>
    [DataContract(Namespace = " http://www.suninfobank.com ")]
    public class MonitorDataVO
    {
        public MonitorDataVO() { }

        [DataMember(Order = 0)]
        public int monitorCode { get; set; }//测点名称
        [DataMember(Order = 1)]
        public string monitorName { get; set; }//测点名称
        [DataMember(Order = 2)]
        public string monitorValue { get; set; }//设备型号
        [DataMember(Order = 3)]
        public string hasChart { get; set; }//是否显示图表
        [DataMember(Order = 4)]
        public string isEmpty { get; set; }//是否空行
    }
}