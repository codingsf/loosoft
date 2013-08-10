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

        public static IList<int> notDisplayMonitor = new List<int>();//不用显示出来的测点

        public static IList<int> affixMonitors = new List<int>();//增加临时后缀的测点

        static DeviceRunData()
        {
            sortGroup.Add("group1", new List<int>() { MonitorType.MIC_INVERTER_POWER, MonitorType.MIC_INVERTER_OUTTYPE, MonitorType.MIC_INVERTER_DEVICESTATUS, MonitorType.MIC_INVERTER_RUNTIME, MonitorType.MIC_INVERTER_JNKQTEMPRATURE, MonitorType.MIC_AMMETER_SYSFREQUENCY, MonitorType.MIC_AMMETER_PHASEVOLTAGE1, MonitorType.MIC_AMMETER_PHASEVOLTAGE2, MonitorType.MIC_AMMETER_PHASEVOLTAGE3, MonitorType.MIC_AMMETER_PHASECURRENT1, MonitorType.MIC_AMMETER_PHASECURRENT2, MonitorType.MIC_AMMETER_PHASECURRENT3 });
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
            //add by qhb in 20120914 for 6、	A、B、C三项有功功率不显示 未同步到trunk
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_ADIRECTPOWER);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_BDIRECTPOWER);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_CDIRECTPOWER);
            //notDisplayMonitor.Add(MonitorType.MIC_INVERTER_TOTALWGPOWER);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_DKQTEMPRATURE);
            notDisplayMonitor.Add(MonitorType.MIC_INVERTER_OUTTYPE);
            //add by qhb in 20120825 for 增加汇流箱子的不显示测点,要进行特殊处理后单独显示
            notDisplayMonitor.Add(MonitorType.MIC_BUSBAR_DIGITALINPUT);
            notDisplayMonitor.Add(MonitorType.MIC_BUSBAR_STATUS);
            notDisplayMonitor.Add(MonitorType.MIC_BUSBAR_DUANLUDATA);
            notDisplayMonitor.Add(MonitorType.MIC_BUSBAR_DLGGDATA);
            notDisplayMonitor.Add(MonitorType.MIC_BUSBAR_DLGDDATA);
            notDisplayMonitor.Add(MonitorType.MIC_BUSBAR_KAILUDATA);
            //add by qhb in 20120825 for 增加汇流箱子的不显示测点

            notDisplayMonitor.Add(MonitorType.MIC_DETECTOR_SOI);

            //add by qhb in 20120914 for 增加临时后缀的测点 以便显示实时数据是给测点赋临时后缀，用于显示多语言
            //初始化A项电压	B项电压	C项电压  A项电流	B项电流	C项电流的临时测点后缀
            //A相电流
            affixMonitors.Add(MonitorType.MIC_INVERTER_ADIRECTCURRENT);
            //B相电流
            affixMonitors.Add(MonitorType.MIC_INVERTER_BDIRECTCURRENT);
            //C相电流
            affixMonitors.Add(MonitorType.MIC_INVERTER_CDIRECTCURRENT);
            //A相电压
            affixMonitors.Add(MonitorType.MIC_INVERTER_ADIRECTVOLT);
            //B相电压
            affixMonitors.Add(MonitorType.MIC_INVERTER_BDIRECTVOLT);
            //C相电压
            affixMonitors.Add(MonitorType.MIC_INVERTER_CDIRECTVOLT);
        }

        /// <summary>
        /// 根据输出类型判断是否要显示A、B、C项电压是否显示
        /// 如果输出类型的值为0	电网电压	不显示	不显示
        /// 同时设置器临时代码后缀，用于去该测点不同的资源key
        /// </summary>
        /// <param name="outtype"></param>
        /// <returns></returns>
        public static IList<int> getnotDisplayMonitor(float outtype)
        {
            IList<int> notDisplayMonitor = new List<int>();//不用显示出来的测点
            if (float.IsNaN(outtype)) return notDisplayMonitor;

            //默认
            if (outtype == 0)
            {
                notDisplayMonitor.Add(MonitorType.MIC_INVERTER_BDIRECTVOLT);
                notDisplayMonitor.Add(MonitorType.MIC_INVERTER_CDIRECTVOLT);
                notDisplayMonitor.Add(MonitorType.MIC_INVERTER_BDIRECTCURRENT);
                notDisplayMonitor.Add(MonitorType.MIC_INVERTER_CDIRECTCURRENT);
            }

            return notDisplayMonitor;
        }

        /// <summary>
        /// 根据额定功率判断要不显示的测点
        /// add by qhb in 20120914 for 
        /// 3）	直流电压2和直流电流2 仅SG10KTL~SG30KTL之间显示，其他不显示
        /// 直流电压2和直流电流2仅仅没有额定输出功率时显示，有额定功率是只有在10kw-30kw之间才显示
        /// 新增加SG5KTL-M，SG3KTL-M、SG4KTL-M、SG2KTL，显示直流电压2和直流电流2。
        /// 对应的额定输出功率分别是 5、3、4、2
        /// </summary>
        /// <param name="power"></param>
        /// <returns></returns>
        public static IList<int> getnotDisplayMonitorByPower(float power)
        {
            IList<int> notDisplayMonitor = new List<int>();//不用显示出来的测点
            if (float.IsNaN(power)) return notDisplayMonitor;
            if ((power <10 || power>30) && power != 5 && power!=4 && power!=3 && power !=2 )//这个范围之外时不显示直流电压2和直流电流2
            {
                notDisplayMonitor.Add(MonitorType.MIC_INVERTER_DV2);
                notDisplayMonitor.Add(MonitorType.MIC_INVERTER_DC2);
            }
            return notDisplayMonitor;
        }

        /// <summary>
        /// 取得汇流箱传感器路数
        /// </summary>
        /// <param name="rundatas"></param>
        /// <returns></returns>
        public int getHlxroute(string[] rundatas)
        {
            string[] datas = null;
            int displayHxlroute = 0;
            foreach (string data in rundatas)
            {
                datas = data.Split(':');
                int monitorCode = int.Parse(datas[0]);
                MonitorType mt = MonitorType.getMonitorTypeByCode(monitorCode);
                if (mt == null) continue;
                //判断是否接入路数测点
                if (monitorCode == MonitorType.MIC_BUSBAR_MAXLINE)
                {
                    try
                    {
                        int value = int.Parse(datas[1]);
                        if (value == 0) value = 32;
                        displayHxlroute = value;
                    }
                    catch (Exception e)
                    {

                        break;
                    }
                    break;
                }
            }
            return displayHxlroute;
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
        /// 实时今日发电量，非持久化,注意这里的今日发电量是实时数据里面的今日发电量，而不是真正的外部时间的今日发电量
        /// </summary>
        public float todayEnergy
        {
            get
            {
                if (_todayEnergy == 0)
                {
                    float d = this.getMonitorValue(MonitorType.MIC_INVERTER_TODAYENERGY);
                    if (float.IsNaN(d)) _todayEnergy = 0f;
                    else
                        _todayEnergy = d;
                }
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
                    if (float.IsNaN(tmp)) tmp = this.getMonitorValue(MonitorType.MIC_INVERTER_ACENERGY);
                    if (float.IsNaN(tmp)) tmp = 0f;
                    return tmp;
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
        public IList<IList<KeyValuePair<MonitorType, string>>> convertRunstrToList(bool isOorder,int deviceTypeCode)
        {
            IList<IList<KeyValuePair<MonitorType, string>>> resList = new List<IList<KeyValuePair<MonitorType, string>>>();
            IList<KeyValuePair<MonitorType, string>> resGroup1 = new List<KeyValuePair<MonitorType, string>>();
            IList<KeyValuePair<MonitorType, string>> resGroup2 = new List<KeyValuePair<MonitorType, string>>();
            IList<KeyValuePair<MonitorType, string>> resGroup3 = new List<KeyValuePair<MonitorType, string>>();
            IList<KeyValuePair<MonitorType, string>> resGroup4 = new List<KeyValuePair<MonitorType, string>>();
            IList<KeyValuePair<MonitorType, string>> resGroup5 = new List<KeyValuePair<MonitorType, string>>();

            string rundatastr = this.rundatastr;
            string[] rundatas = rundatastr.Split('#');

            //先取得传感器接入路数，以决定显示多少路汇流箱路数
            int displayHxlroute = 0;
            if (deviceTypeCode == DeviceData.HUILIUXIANG_CODE)
            {
                displayHxlroute = getHlxroute(rundatas);
            }

            //如果是逆变器那么先取额定功率
            float outtype = 0;
            IList<int> notdisplayInverterbyPower = new List<int>();
            IList<int> notdisplayInverterbyoutType = new List<int>();
            if (deviceTypeCode == DeviceData.INVERTER_CODE)
            {
                outtype = this.getMonitorValue(MonitorType.MIC_INVERTER_OUTTYPE);
                notdisplayInverterbyoutType = getnotDisplayMonitor(outtype);
                float power = this.getMonitorValue(MonitorType.MIC_INVERTER_POWER);
                notdisplayInverterbyPower = getnotDisplayMonitorByPower(power);
            }

            string[] datas = null;
            foreach (string data in rundatas)
            {
                datas = data.Split(':');
                int monitorCode = int.Parse(datas[0]);
                MonitorType omt = MonitorType.getMonitorTypeByCode(monitorCode);
                if (omt == null) continue;

                //如果该测点不属于此设备则也不显示，add by qhb in 20120913
                if (!MonitorType.getMonitorTypesByTypeCode(deviceTypeCode).Contains(omt)) continue;

                //重新构造一个实例，以便用tempaffix多语言显示后缀是线程安全
                string tempaffix = omt.tempaffix;
                string unit = omt.unit;
                Boolean isUP = false;//是否进制千位

                //如果是逆变器要判断abc三项电压和电流的输出类型,将输出类型作为有后缀测点的后缀
                if (deviceTypeCode == DeviceData.INVERTER_CODE)
                {
                    if (affixMonitors.Contains(monitorCode) && !float.IsNaN(outtype) && (outtype == 0 || outtype == 2))
                        tempaffix = outtype.ToString();
                    //add by qhb in 20120921 for 2）逆变器带功率的单位显示kW，不要显示W  （注意大小写）
                    if (omt.code == MonitorType.MIC_INVERTER_TOTALDPOWER || omt.code == MonitorType.MIC_INVERTER_ADIRECTPOWER || omt.code == MonitorType.MIC_INVERTER_BDIRECTPOWER || omt.code == MonitorType.MIC_INVERTER_CDIRECTPOWER || omt.code == MonitorType.MIC_INVERTER_TOTALYGPOWER || omt.code == MonitorType.MIC_INVERTER_TOTALWGPOWER)
                    {
                        unit = "kW";
                        isUP = true;
                    }
                    if (omt.code == MonitorType.MIC_INVERTER_TOTALWGPOWER)
                    {
                        unit = "kvar";
                        isUP = true;
                    }
                }

                MonitorType mt = new MonitorType(omt.code, unit, omt.zerotoline, tempaffix);

                //排除不显示的测点
                if (notDisplayMonitor.Contains(mt.code) || notdisplayInverterbyoutType.Contains(mt.code) || notdisplayInverterbyPower.Contains(mt.code)) continue;

                //如果是汇流箱非显示路数则跳过
                if (deviceTypeCode == DeviceData.HUILIUXIANG_CODE && ((monitorCode>=MonitorType.MIC_BUSBAR_17CURRENT &&monitorCode<=MonitorType.MIC_BUSBAR_32CURRENT)||(monitorCode>=MonitorType.MIC_BUSBAR_1CURRENT &&monitorCode<=MonitorType.MIC_BUSBAR_16CURRENT)) )
                {
                    if (displayHxlroute > 0)
                    {
                        if (monitorCode >= 366)
                        {
                            if (monitorCode - 365 + 16 > displayHxlroute) continue;
                        }
                        else {
                            if (monitorCode - 300 > displayHxlroute) continue;
                        }
                    }
                }

                string value = datas[1];
                //如果值为-表示该值无效，不显示该测点，“-”，数据解析器会把发送的无效值固定设为“-”
                if ("-".Equals(value)) continue;

                value = getStatusValue(monitorCode, value);
                if ("0".Equals(value) && MonitorType.getMonitorTypeByCode(monitorCode).zerotoline)
                {
                    value = "-";
                }

                //add by qhb for 单位进制
                if (isUP)
                {
                    try
                    {
                        value = Math.Round((StringUtil.stringtoDouble(value) / 1000), 2).ToString();
                    }
                    catch (Exception e)
                    {
                        //do nothing
                    }
                }

                //add by qhb in 20120917 for 1）功率因数为0和无功功率为0屏蔽不显示。
                if (omt.code == MonitorType.MIC_INVERTER_TOTALPOWERFACTOR || omt.code == MonitorType.MIC_INVERTER_TOTALWGPOWER)
                {
                    try
                    {
                        if (StringUtil.stringtoDouble(value) == 0)
                            continue;
                    }
                    catch { }
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
        public IList<KeyValuePair<MonitorType, string>> convertRunstrToList(int deviceTypeCode)
        {
            return convertRunstrToList(true,deviceTypeCode)[0];
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
                    //工作状态先从故障码map中解析对应值
                    try
                    {
                        int code = int.Parse(value);
                        if (ErrorItem.errorItemMap.ContainsKey(code))
                        {
                            return ErrorItem.getErrotItemByCode(code).name;
                        }
                    }
                    catch (Exception e)
                    {
                    }

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
                    string v = this.getStatusValue(code, datas[1]);
                    if ("0".Equals(v) && MonitorType.getMonitorTypeByCode(code).zerotoline)
                    {
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
                    //if (sts != DeviceStatusType.inverter_status_run
                    //    && sts != DeviceStatusType.inverter_status_run
                    //    && sts != DeviceStatusType.inverter_status_ajgj
                    //    && sts != DeviceStatusType.inverter_status_chshidj
                    //    && sts != DeviceStatusType.inverter_status_daiji
                    //    && sts != DeviceStatusType.inverter_status_jjtj
                    //    && sts != DeviceStatusType.inverter_status_startuping
                    //    && sts != DeviceStatusType.inverter_status_tingji)
                    //{
                    //    return true;
                    //}
                    //20120816改为从故障那里取
                    ErrorItem errorItem = ErrorItem.getErrotItemByCode(sts);
                    if (errorItem != null && (errorItem.errorType == ErrorType.ERROR_TYPE_ERROR || errorItem.errorType == ErrorType.ERROR_TYPE_FAULT))
                        return true;
                }
                //add by qhn in 20120828 增加 
                //周辉 14:21:33 
                //过80度要告警的，红色
                //工作状态和数字输入老钱 14:25:13 这样只要有一个红灯 就名字红色？
                if (int.Parse(datas[0]) == MonitorType.MIC_BUSBAR_JNTEMPRATURE)
                {
                    float value = StringUtil.stringtoFloat(datas[1]);
                    if (value > 80) return true;
                }
                //判断数字输入
                if (int.Parse(datas[0]) == MonitorType.MIC_BUSBAR_DIGITALINPUT || int.Parse(datas[0]) == MonitorType.MIC_BUSBAR_STATUS)
                {
                    bool fault = adjustDetail(int.Parse(datas[0]), datas[1]);
                    if (fault) return fault;
                }
            }

            return false;
        }

        /// <summary>
        /// add  by qhb in 20120827 for 增加告警判断
        /// 
        /// </summary>
        /// <param name="monitorCode"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        private bool adjustDetail(int monitorCode, string value)
        {
            if (monitorCode == MonitorType.MIC_BUSBAR_STATUS)
            {
                value = StringUtil.getFullbitstr(int.Parse(value));
            }
            else
            {
                value = StringUtil.getFullbitstr(int.Parse(value));
            }
            char[] desArray = new char[value.Length];
            value.CopyTo(0, desArray, 0, value.Length);
            //一次取得相应bit位的值
            string bitkey = null;
            int bitvalue = 0;
            string bititem;
            bool status = true;//状态
            int n = 0;
            for (int i = desArray.Length - 1; i >= 0; i--)
            {
                n++;
                bitkey = monitorCode.ToString() + n;
                //判断该bit位定义是否存在
                if (MonitorType.bitStatusMap.ContainsKey(bitkey))
                {
                    //取得该bit位对应值
                    bitvalue = int.Parse(desArray[i].ToString());
                    bititem = MonitorType.bitStatusMap[bitkey];
                    if (bititem.Equals(MonitorType.digital_input_item_flq) || bititem.Equals(MonitorType.work_status_item_run))
                    {
                        status = bitvalue == 0 ? true : false;
                    }
                    else
                        status = bitvalue == 0 ? false : true;

                    if (status == true) return status;
                }
            }
            return status;
        }
    }
}
