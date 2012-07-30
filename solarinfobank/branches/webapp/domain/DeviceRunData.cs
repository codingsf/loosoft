using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：各种设备实时数据实体
    /// 数据来源于解析程序
    /// 作者：鄢睿
    /// 创建时间：2011年02月20日
    /// </summary>
    [Serializable]

    public class DeviceRunData
    {
        static IDictionary<string, IList<int>> sortGroup = new Dictionary<string, IList<int>>();

        private static IList<int> notDisplayMonitor = new List<int>();//不用显示出来的测点
      
        static DeviceRunData()
        {
            sortGroup.Add("group1", new List<int>() { MonitorType.MIC_INVERTER_POWER, MonitorType.MIC_INVERTER_OUTTYPE, MonitorType.MIC_INVERTER_DEVICESTATUS, MonitorType.MIC_INVERTER_RUNTIME, MonitorType.MIC_INVERTER_JNKQTEMPRATURE, MonitorType.MIC_AMMETER_SYSFREQUENCY,MonitorType.MIC_AMMETER_PHASEVOLTAGE1,MonitorType.MIC_AMMETER_PHASEVOLTAGE2,MonitorType.MIC_AMMETER_PHASEVOLTAGE3,MonitorType.MIC_AMMETER_PHASECURRENT1,MonitorType.MIC_AMMETER_PHASECURRENT2,MonitorType.MIC_AMMETER_PHASECURRENT3 });
            sortGroup.Add("group2", new List<int>() { MonitorType.MIC_INVERTER_TODAYENERGY, MonitorType.MIC_INVERTER_TOTALENERGY, MonitorType.MIC_INVERTER_TOTALDPOWER, MonitorType.MIC_INVERTER_TOTALYGPOWER, MonitorType.MIC_INVERTER_TOTALWGPOWER, MonitorType.MIC_INVERTER_TOTALPOWERFACTOR, MonitorType.MIC_INVERTER_DWPL,
                MonitorType.MIC_AMMETER_PHASEACTIVEPOWER1,MonitorType.MIC_AMMETER_PHASEACTIVEPOWER2,MonitorType.MIC_AMMETER_PHASEACTIVEPOWER3,MonitorType.MIC_AMMETER_SYSACTIVEPOWER
                ,MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER1,MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER2,MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER3,MonitorType.MIC_AMMETER_SYSREACTIVEPOWER
                ,MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER1,MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER2,MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER3,MonitorType.MIC_AMMETER_SYSAPPARENTPOWER
                ,MonitorType.MIC_AMMETER_PHASEPOWERFACTOR1,MonitorType.MIC_AMMETER_PHASEPOWERFACTOR2,MonitorType.MIC_AMMETER_PHASEPOWERFACTOR3,MonitorType.MIC_AMMETER_SYSPOWERFACTOR1});
            sortGroup.Add("group3", new List<int>() { MonitorType.MIC_INVERTER_DV1, MonitorType.MIC_INVERTER_DC1, MonitorType.MIC_INVERTER_DV2, MonitorType.MIC_INVERTER_DC2, MonitorType.MIC_INVERTER_DV3, MonitorType.MIC_INVERTER_DC3,MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE,MonitorType.MIC_AMMETER_REVERSEACTIVEPOWERDEGREE,MonitorType.MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE
                 ,MonitorType.MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE,MonitorType.MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE,MonitorType.MIC_AMMETER_PUREACTIVEPOWERDEGREE
                ,MonitorType.MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE,MonitorType.MIC_AMMETER_PUREREACTIVEPOWERDEGREE });
            sortGroup.Add("group4", new List<int>() { MonitorType.MIC_INVERTER_ADIRECTVOLT, MonitorType.MIC_INVERTER_BDIRECTVOLT, MonitorType.MIC_INVERTER_CDIRECTVOLT, MonitorType.MIC_INVERTER_ADIRECTCURRENT, MonitorType.MIC_INVERTER_BDIRECTCURRENT, MonitorType.MIC_INVERTER_CDIRECTCURRENT, MonitorType.MIC_INVERTER_ADIRECTPOWER, MonitorType.MIC_INVERTER_BDIRECTPOWER, MonitorType.MIC_INVERTER_CDIRECTPOWER });

            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_JNBYQTEMPRATURE);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_JNSRQTEMPRATURE);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_INVERTERXL);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_STATUSTIME);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_STATUSDATA1);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_STATUSDATA2);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_STATUSDATA3);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_DV3);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_DC3);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_TOTALWGPOWER);
            
            notDisplayMonitor.Add(MonitorType.MIC_DETECTOR_SOI);
        }
        //根据输出类型判断是否要显示A、B、c项电压是否显示
        private static IList<int> getnotDisplayMonitor(float outtype)
        {
            IList<int> notDisplayMonitor = new List<int>();//不用显示出来的测点
            if (float.IsNaN(outtype)) return notDisplayMonitor;
            if(outtype == 0){
                notDisplayMonitor.Add(MonitorType.MIC_INVERTER_CDIRECTVOLT);
            }
            return notDisplayMonitor;
        }


        /// <summary>
        /// 设备id 主键
        /// </summary>
        public int deviceID { get; set; }
        /// <summary>
        /// 数据串，格式 测点代码:数据#代码:数据...
        /// </summary>
        public string rundatastr { get; set; }
        /// <summary>
        /// 数据更新时间
        /// </summary>
        public DateTime updateTime { get; set; }

        private float _todayEnergy = 0;

        /// <summary>
        /// 实时今日发电量，非持久化
        /// </summary>
        public float todayEnergy
        {
            get
            {
                if (_todayEnergy == 0)
                {
                    return this.getMonitorValue(MonitorType.MIC_INVERTER_TODAYENERGY);
                }
                else
                    return _todayEnergy;
            }
            set
            {
                _todayEnergy = value;
            }
        }

        private float _energy = 0;

        /// <summary>
        /// 实时总发电量，非持久化
        /// </summary>
        public float energy
        {
            get
            {
                if (_energy == 0)
                {
                    float tmp = this.getMonitorValue(MonitorType.MIC_INVERTER_TOTALENERGY);
                    if (float.IsNaN(tmp) || tmp == 0) tmp = this.getMonitorValue(MonitorType.MIC_INVERTER_ACENERGY);
                    return float.IsNaN(tmp) ? 0 : tmp;
                }
                else
                    return _energy;
            }
            set
            {
                _energy = value;
            }
        }

        /// <summary>
        /// 采集器id，非持久化
        /// </summary>
        public int collectorID { get; set; }

        private bool _changed = true;
        /// <summary>
        /// 数据是否有改变
        /// </summary>
        public bool changed
        {
            get
            {
                return _changed;
            }
            set
            {
                _changed = value;
            }
        }
        /// <summary>
        /// 将实时数据串转换成键值对象
        /// </summary>
        /// <param name="deviceRunData">实时数据对象</param>
        /// <returns>值对列表</returns>
        public IList<IList<KeyValuePair<MonitorType, string>>> convertRunstrToList(bool isOorder)
        {
            IList<IList<KeyValuePair<MonitorType, string>>> resList = new List<IList<KeyValuePair<MonitorType, string>>>();
            IList<KeyValuePair<MonitorType, string>> resGroup1 = new List<KeyValuePair<MonitorType, string>>();
            IList<KeyValuePair<MonitorType, string>> resGroup2 = new List<KeyValuePair<MonitorType, string>>();
            IList<KeyValuePair<MonitorType, string>> resGroup3 = new List<KeyValuePair<MonitorType, string>>();
            IList<KeyValuePair<MonitorType, string>> resGroup4 = new List<KeyValuePair<MonitorType, string>>();
            IList<KeyValuePair<MonitorType, string>> resGroup5 = new List<KeyValuePair<MonitorType, string>>();
            //先取得逆变器的输出类型
            float outtype = this.getMonitorValue(MonitorType.MIC_INVERTER_OUTTYPE);
            string rundatastr = this.rundatastr;
            string[] rundatas = rundatastr.Split('#');
            string[] datas = null;
            foreach (string data in rundatas)
            {
                datas = data.Split(':');
                int monitorCode = int.Parse(datas[0]);
                MonitorType mt = MonitorType.getMonitorTypeByCode(monitorCode);
                if (mt == null) continue;
                //排除不显示的测点
                if (notDisplayMonitor.Contains(mt.code) || getnotDisplayMonitor(outtype).Contains(mt.code)) continue;

                string value = datas[1];
                //如果值为-表示该值无效，不显示该测点，“-”，数据解析器会把发送的无效值固定设为“-”
                if ("-".Equals(value)) continue;

                value = getStatusValue(monitorCode, value);
                if ("0".Equals(value) && MonitorType.getMonitorTypeByCode(monitorCode).zerotoline)
                {
                    value =  "-";
                }
                if (isOorder)
                {
                    if (sortGroup["group1"].Contains(monitorCode))
                    {
                        resGroup1.Add(new KeyValuePair<MonitorType, string>(mt, value));
                    }
                    else if (sortGroup["group2"].Contains(monitorCode))
                    {
                        resGroup2.Add(new KeyValuePair<MonitorType, string>(mt, value));
                    }
                    else if (sortGroup["group3"].Contains(monitorCode))
                    {
                        resGroup3.Add(new KeyValuePair<MonitorType, string>(mt, value));
                    }
                    else if (sortGroup["group4"].Contains(monitorCode))
                    {
                        resGroup4.Add(new KeyValuePair<MonitorType, string>(mt, value));
                    }
                    else
                    {
                        resGroup5.Add(new KeyValuePair<MonitorType, string>(mt, value));
                    }
                }
                else
                {
                    resGroup5.Add(new KeyValuePair<MonitorType, string>(mt, value));
                }
            }
            if (resGroup1.Count > 0)
                resList.Add(resGroup1);
            if (resGroup2.Count > 0)
                resList.Add(resGroup2);
            if (resGroup3.Count > 0)
                resList.Add(resGroup3);
            if (resGroup4.Count > 0)
                resList.Add(resGroup4);
            if (resGroup5.Count > 0)
                resList.Add(resGroup5);
            return resList;
        }

        /// <summary>
        /// 转换为列表但不排序
        /// </summary>
        /// <returns></returns>
        public IList<KeyValuePair<MonitorType, string>> convertRunstrToList()
        {
            return convertRunstrToList(true)[0];
        }

        /// <summary>
        /// 取得状态值，没有则返回原来的值
        /// </summary>
        /// <param name="monitorCode"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        private string getStatusValue(int monitorCode, string value)
        {
            //判断该值是否为状态类型值
            if (DeviceData.statusMonitorList.Contains(monitorCode))
            {
                if ((monitorCode == MonitorType.MIC_INVERTER_DEVICESTATUS) && DateTime.Now.AddDays(-1) > updateTime)
                {
                    return LanguageUtil.getDesc("DEVICESTATUSTYPE_" + DeviceStatusType.device_offline);
                }
                else
                {
                    IList<DeviceStatusType> stList = DeviceData.monitorStatusMap[monitorCode];
                    foreach (DeviceStatusType dst in stList)
                    {
                        if (dst.code == int.Parse(value))
                        {
                            value = dst.name;
                            break;
                        }
                    }                    
                }
            }
            return value;
        }

        /// <summary>
        /// 将实时数据串转换成键值对象,待状态
        /// </summary>
        /// <param name="deviceRunData">实时数据对象</param>
        /// <returns>值对列表</returns>
        public string getMonitorValueWithStatus(int code)
        {
            IList<KeyValuePair<MonitorType, string>> kvpList = new List<KeyValuePair<MonitorType, string>>();
            string rundatastr = this.rundatastr;
            string[] rundatas = rundatastr.Split('#');
            string[] datas = null;
            foreach (string data in rundatas)
            {
                datas = data.Split(':');
                if (code == int.Parse(datas[0]))
                {
                    string v = this.getStatusValue(code,datas[1]);
                    if ("0".Equals(v) && MonitorType.getMonitorTypeByCode(code).zerotoline) {
                        return "-";
                    }
                    return v;
                }
            }
            //没有该测点的值则返回-
            return "-";
        }

        /// <summary>
        /// 将实时数据串转换成键值对象
        /// </summary>
        /// <param name="deviceRunData">实时数据对象</param>
        /// <returns>值对列表</returns>
        public float getMonitorValue(int code)
        {
            IList<KeyValuePair<MonitorType, string>> kvpList = new List<KeyValuePair<MonitorType, string>>();
            string rundatastr = this.rundatastr;
            string[] rundatas = rundatastr.Split('#');
            string[] datas = null;
            foreach (string data in rundatas)
            {
                datas = data.Split(':');
                if (code == int.Parse(datas[0]))
                { 
                    return StringUtil.stringtoFloat(datas[1]);
                }
            }
            //没有该测点的值则返回-
            return float.NaN;
        }

        /// <summary>
        /// 时间收到的测点中是否有某个测点
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public bool hasMonitor(int code)
        {
            string rundatastr = this.rundatastr;
            string[] rundatas = rundatastr.Split('#');
            string[] datas = null;
            foreach (string data in rundatas)
            {
                datas = data.Split(':');
                if (code == int.Parse(datas[0]))
                {
                    return true;
                }
            }
            return false;
        }

        /// <summary>
        /// 判断是否运行故障，包括超过两天无数据，和设备本身错误状态
        /// “运行 停机 初始待机  按键关机 待机 紧急停机 启动中 关机中”不属于警告状态
        /// </summary>
        /// <returns></returns>
        public bool isFault()
        {
            string rundatastr = this.rundatastr;
            string[] rundatas = rundatastr.Split('#');
            string[] datas = null;

            if (DateTime.Now.AddDays(-1) > updateTime)
                return true;

            foreach (string data in rundatas)
            {
                datas = data.Split(':');

                //MonitorType mt = MonitorType.getMonitorTypeByCode(int.Parse(datas[0]));
                if (int.Parse(datas[0]) == MonitorType.MIC_INVERTER_DEVICESTATUS)
                {
                    int sts = int.Parse(datas[1]);
                    if (sts != DeviceStatusType.inverter_status_run
                        && sts != DeviceStatusType.inverter_status_run
                        && sts != DeviceStatusType.inverter_status_ajgj
                        && sts != DeviceStatusType.inverter_status_chshidj
                        && sts != DeviceStatusType.inverter_status_daiji
                        && sts != DeviceStatusType.inverter_status_jjtj
                        && sts != DeviceStatusType.inverter_status_startuping
                        && sts != DeviceStatusType.inverter_status_tingji)
                    {
                        return true;
                    }
                    return false;
                }
            }

            return false;
        }
    }
}
