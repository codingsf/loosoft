using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Globalization;
namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：逆变设备实体
    /// 作者：张月
    /// 时间：2011年2月16日 14:10:26
    /// </summary>
    [Serializable]

    public class Device
    {
        /// <summary>
        /// 无参构造函数
        /// </summary>
        public Device() { }
        public Device(int id) { this.id = id; }

        #region Model
        public int id { get; set; }  //Id
        public int deviceTypeCode { get; set; }        //类型
        public DeviceModel deviceModel { get; set; }   //型号
        public int deviceModelCode { get; set; }       //型号代码
        public string deviceAddress { get; set; }      //设备地址
        public int collectorID { get; set; }           //所属采集器id
        public string status { get; set; }             //所属操作类型
        public bool isHidden { get; set; }             //是否隐藏

        public string currentPower { get; set; }
        
        public string name { get; set; }

        /// <summary>
        /// 设备真实设计功率，如果currentPower为null 那么去设备类型对应的功率
        /// 
        /// </summary>
        public float designPower
        {
            get
            {
                if (string.IsNullOrEmpty(currentPower))
                {
                    if (deviceModel == null)
                        return 100;
                    else
                        return deviceModel.designPower;
                }
                else
                    return float.Parse(currentPower, new CultureInfo("en-us"));
            }
        }
        public string faulttype { get; set; }
        public int faultcount { get; set; }
        #endregion Model

        private DeviceRunData _rundata;
        public DeviceRunData runData
        {
            get
            {
                //首先取自缓存
                string cacheKey = CacheKeyUtil.buildDeviceRunDataKey(this.id);
                object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
                if (obj == null)
                    return _rundata;
                else
                {
                    return (DeviceRunData)obj;
                }
            }
            set
            {
                _rundata = value;
            }
        }//实时数据
        public Plant plant { get; set; }
        public bool Over1Day(float tz)
        {
            if (runData == null)
                return true;
            return (CalenderUtil.curDateWithTimeZone(tz) - runData.updateTime).TotalDays > 1;
        }

        /// <summary>
        /// 是否工作,不超过一天
        /// add by qhb in 
        /// </summary>
        /// <param name="tz"></param>
        /// <returns></returns>
        public bool isWork(float tz)
        {
            return  !Over1Day(tz);
        }

        /// <summary>
        /// 是否超过一小时
        /// </summary>
        /// <param name="tz"></param>
        /// <returns></returns>
        public bool Over1Hour(float tz)
        {
            if (runData == null)
                return true;
            return (CalenderUtil.curDateWithTimeZone(tz) - runData.updateTime).TotalHours > 1;
        }


        /// <summary>
        /// 这里要加入时区来判断
        /// </summary>
        /// <param name="tz"></param>
        /// <returns>如果没有实时数据，则返回-1</returns>
        public int stopTime(float tz)
        {
            if (runData == null)
                return -1;
            return (int)(CalenderUtil.curDateWithTimeZone(tz) - runData.updateTime).TotalHours;
        }

        /// <summary>
        /// 类型名称
        /// </summary>
        public string typeName
        {
            get
            {
                return DeviceData.getDeviceTypeByCode(this.deviceTypeCode).name == null ? LanguageUtil.getDesc("UNKNOWN") : DeviceData.getDeviceTypeByCode(this.deviceTypeCode).name;
            }
        }

        /// <summary>
        /// 型号
        /// </summary>
        public string xinhaoName
        {
            get
            {
                if (this.deviceModel == null || this.deviceModel.code == 0)
                {
                    if (this.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE)
                    {
                        return "EM";
                    }
                    else if (this.deviceTypeCode == DeviceData.HUILIUXIANG_CODE)
                    {
                        return "PVS";
                    }
                    else if (this.deviceTypeCode == DeviceData.INVERTER_CODE)
                    {
                        return "SG";
                    }
                    else if (this.deviceTypeCode == DeviceData.AMMETER_CODE)
                    {
                        return "METER";
                    }
                    else if (this.deviceTypeCode == DeviceData.CABINET_CODE)
                    {
                        return "CABINET";
                    }
                    else
                    {
                        return LanguageUtil.getDesc("UNKNOWN");
                    }
                }
                else
                {
                    return this.deviceModel.name;
                }
            }
        }

        /// <summary>
        /// 组合名称，在用户没有自定义的情况下使用
        /// </summary>
        public string comFullName
        {
            get
            {
                return this.xinhaoName + "#" + this.deviceAddress;
            }
        }

        /// <summary>
        /// 全名,设备显示名称，页面要用这个
        /// </summary>
        public string fullName
        {
            get
            {
                return string.IsNullOrEmpty(this.name) ? this.comFullName : this.name;
            }
        }

        /// <summary>
        /// 逆变器设备的总发电量
        /// </summary>
        public float TotalEnergy
        {
            get
            {
                if (this.deviceTypeCode == DeviceData.INVERTER_CODE && runData != null)
                {
                    float tmp = getMonitorValue(MonitorType.MIC_INVERTER_TOTALENERGY);
                    if (float.IsNaN(tmp))
                    {
                        tmp = getMonitorValue(MonitorType.MIC_INVERTER_ACENERGY);
                        return float.IsNaN(tmp) ? 0 : tmp;
                    }
                    return tmp;
                }
                return 0;
            }
        }

        /// <summary>
        /// 逆变器设备的总功率
        /// </summary>
        public float TotalPower
        {
            get
            {
                if (this.deviceTypeCode == DeviceData.INVERTER_CODE && runData != null)
                {
                    float res = runData.getMonitorValue(MonitorType.MIC_INVERTER_TOTALYGPOWER);
                    return float.IsNaN(res) ? 0 : res;
                }
                return 0;
            }
        }

        /// <summary>
        /// 环境检测仪设备的光照
        /// </summary>
        public float Sunlight
        {
            get
            {
                if (this.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE && runData != null)
                {
                    float res = runData.getMonitorValue(MonitorType.MIC_DETECTOR_SUNLINGHT);
                    return float.IsNaN(res) ? 0 : res;
                }
                return 0;
            }
        }

        /// <summary>
        /// 环境检测仪设备的增量光照
        /// </summary>
        public float RenderSunlight()
        {
            if (this.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE && runData != null)
            {
                float res = runData.getMonitorValue(MonitorType.MIC_DETECTOR_DAYRADIATION);
                return float.IsNaN(res) ? 0 : res;
            }
            return 0;
        }

        /// <summary>
        /// 逆变器设备的今日发电量
        /// </summary>
        public float TodayEnergy(int timezone)
        {
            if (this.deviceTypeCode == DeviceData.INVERTER_CODE && runData != null && CalenderUtil.formatDate(runData.updateTime, "yyyyMMdd").Equals(CalenderUtil.curDateWithTimeZone(timezone, "yyyyMMdd")))
            {
                float res = runData.getMonitorValue(MonitorType.MIC_INVERTER_TODAYENERGY);
                return float.IsNaN(res) ? 0 : res;
            }
            return 0;
        }

        /// <summary>
        /// 逆变器设备的今日发电量
        /// </summary>
        public float TodayEnergy(string yyyyMMdd)
        {
            if (this.deviceTypeCode == DeviceData.INVERTER_CODE && runData != null && CalenderUtil.formatDate(runData.updateTime, "yyyyMMdd").Equals(yyyyMMdd))
            {
                float res = runData.getMonitorValue(MonitorType.MIC_INVERTER_TODAYENERGY);
                return float.IsNaN(res) ? 0 : res;
            }
            return 0;
        }

        /// <summary>
        /// 显示设备的总发电量，待进制
        /// </summary>
        public float DisplayTotalEnergy
        {
            get
            {
                return float.Parse(Util.upDigtal(TotalEnergy).ToString());
            }
        }

        /// <summary>
        /// 总发电量单位待进制
        /// </summary>
        public string TotalEnergyUnit
        {
            get
            {
                return Util.upEnergyUnit(TotalEnergy);
            }

        }
        /// <summary>
        /// 取得测点值和单位串，无测点数据为--
        /// </summary>
        /// <param name="mtcode"></param>
        /// <returns></returns>
        public string getMonitor(int mtcode)
        {
            if (runData == null)
                return "-";
            string value = runData.getMonitorValueWithStatus(mtcode);
            return value + " " + MonitorType.getMonitorTypeByCode(mtcode).unit;
        }

        /// <summary>
        /// 取得测点的值，注意一定是数值型的值
        /// 
        /// </summary>
        /// <param name="mtcode"></param>
        /// <returns></returns>
        public float getMonitorValue(int mtcode)
        {
            if (runData == null)
                return 0;
            return runData.getMonitorValue(mtcode);
        }

        /// <summary>
        /// 取得测点的值,带状态串
        /// 
        /// </summary>
        /// <param name="mtcode"></param>
        /// <returns></returns>
        public string getMonitorValueWithStatus(int mtcode)
        {
            if (runData == null)
                return "-";
            return runData.getMonitorValueWithStatus(mtcode);
        }

        /// <summary>
        /// 用于图表kwh/kwp计算的功率
        /// 实际功率为0的情况下用设计功率
        /// </summary>
        public float chartPower
        {
            get
            {
                if (this.designPower == 0)
                {
                    return 1;
                }
                return designPower;
            }
        }

        /// <summary>
        /// 设备最后更新时间
        /// </summary>
        public string lastUpdateTime
        {
            get
            {
                if (this.runData == null)
                    return "";
                return CalenderUtil.formatDate(this.runData.updateTime, "yyyy-MM-dd HH:mm:ss"); ;
            }
        }

        /// <summary>
        /// 判断是否运行故障
        /// </summary>
        /// <returns></returns>
        public bool isFault()
        {
            if (this.runData != null)
                return this.runData.isFault();
            else
                return true;
        }

        /// <summary>
        /// 是否有增量日照测点
        /// </summary>
        public bool isRenderSunlight(string yyyyMMdd)
        {
            if (this.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE && runData != null && CalenderUtil.formatDate(runData.updateTime, "yyyyMMdd").Equals(yyyyMMdd))
                return runData.hasMonitor(MonitorType.MIC_DETECTOR_DAYRADIATION);
            return false;
        }

        /// <summary>
        /// 取得设备状态
        /// </summary>
        /// <returns></returns>
        public string getStatus()
        {
            if (this.runData == null)
                return LanguageUtil.getDesc("DEVICESTATUSTYPE_" + DeviceStatusType.device_offline);

            string value = "0";

            if (this.deviceTypeCode == DeviceData.INVERTER_CODE)
            {
                value = this.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS);
            }
            else if (this.deviceTypeCode == DeviceData.HUILIUXIANG_CODE)
            {
                value = this.getMonitorValueWithStatus(MonitorType.MIC_BUSBAR_STATUS);
            }
            else if (this.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE)
            {
                value = "-";
            }
            else if (this.deviceTypeCode == DeviceData.CABINET_CODE)
            {
                value = this.getMonitorValueWithStatus(MonitorType.MIC_BUSBAR_STATUS);
            }

            if (value.Equals("-"))
            {
                if (DateTime.Now.AddDays(-1) > this.runData.updateTime)
                    return LanguageUtil.getDesc("DEVICESTATUSTYPE_" + DeviceStatusType.device_offline);
                else
                    return LanguageUtil.getDesc("DEVICESTATUSTYPE_" + DeviceStatusType.device_run);
            }
            else
                return value;
        }

        /// <summary>
        /// 取得设备状态吗，0：待机，1正常，3故障
        /// </summary>
        /// <returns></returns>
        public int getStatusDefinedValue()
        {
            if (this.runData == null)
                return 0;

            float value = 0;

            if (this.deviceTypeCode == DeviceData.INVERTER_CODE)
            {
                value = this.getMonitorValue(MonitorType.MIC_INVERTER_DEVICESTATUS);
            }
            else if (this.deviceTypeCode == DeviceData.HUILIUXIANG_CODE)
            {
                value = this.getMonitorValue(MonitorType.MIC_BUSBAR_STATUS);
            }
            else if (this.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE)
            {
                value = 1;
            }
            else if (this.deviceTypeCode == DeviceData.CABINET_CODE)
            {
                value = this.getMonitorValue(MonitorType.MIC_BUSBAR_STATUS);
            }

            if (value.Equals("-"))
            {
                if (DateTime.Now.AddDays(-1) > this.runData.updateTime)
                    return 3;
                else
                    return 1;
            }
            else
                return 1;
        }

        /// <summary>
        /// 是否有增量日照测点
        /// </summary>
        public bool isRenderSunlight()
        {
            if (this.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE && runData != null)
                return runData.hasMonitor(MonitorType.MIC_DETECTOR_DAYRADIATION);
            return false;
        }
    }
}
