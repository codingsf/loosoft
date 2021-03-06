﻿/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年2月17日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Protocol;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Reflection;
using System.Configuration;
namespace DataAnalyze
{
    /// <summary>
    /// TCP消息
    /// </summary>
    public class BaseMessage : IMessage
    {
        /// <summary>
        /// bank rul地址
        /// </summary>
        protected static string bank_url = ConfigurationSettings.AppSettings["bank_url"];
        protected const int hexbytecharnum = 2;//一个十六进制字节占得字符数
        protected List<Bug> listTcpbug;
        protected List<DeviceDataBase> listTcpbody;
        public MessageHeader messageHeader;
        protected string messageContent;
        protected static string analysisAffix = "analysis";//解析方法前缀
        public static IList<DeviceDataCount> deviceDataCounts = new List<DeviceDataCount>();
        public DeviceDataCount collectorDataCount = null;
        protected int largeVersion;//协议大版本号
        protected int smallVersion;//协议小版本号
        public string msgkey = "";
        //本次消息中所包括的设备最近一日发电量map
        //值的格式为月天+发电量值，mmdd+":"+value
        public IDictionary<string, double> deviceEnergyMap = new Dictionary<string, double>();

        //实时测点map
        public IDictionary<int, object> realMonitorMap = new Dictionary<int, object>();

        //历史变化测点map
        public IDictionary<int, object> historyMonitorMap = new Dictionary<int, object>();


        //----------优化思路-------------
        //将解析后的对象集中存储，并且对象对象重用
        //设备天数据
        public static IList<IDictionary<string, DeviceDayData>> devicedayDataMapList = new List<IDictionary<string, DeviceDayData>>();
        public static IDictionary<string, CollectorDayData> collectordayDataMap = new Dictionary<string, CollectorDayData>();
        public static IDictionary<int, CollectorRunData> collectorRunDataMap = new Dictionary<int, CollectorRunData>();
        public static IDictionary<int, DeviceRunData> deviceRunDataMap = new Dictionary<int, DeviceRunData>();
        public static IList<Fault> faultList = new List<Fault>();

        static BaseMessage() { 
            for(int i=0;i<50;i++){
                devicedayDataMapList.Add(new Dictionary<string, DeviceDayData>());
            }
        }
        //----------优化
        /// <summary>
        /// 解析方法，子类覆写
        /// </summary>
        protected void analysis() { }

        protected MessageHeader MessageHeader
        {
            get
            {
                if (string.IsNullOrEmpty(messageHeader.Header))
                {
                    messageHeader.Header = this.messageContent.Substring(0, 18 * 2);
                }
                return messageHeader;
            }
            set { messageHeader = value; }
        }

        /// <summary>
        ///设备消息集
        /// </summary>
        protected List<DeviceDataBase> ListTcpbody
        {
            get
            {
                return listTcpbody;
            }
            set { listTcpbody = value; }
        }

        /// <summary>
        /// 错误消息集
        /// </summary>
        protected List<Bug> ListTcpbug
        {
            get
            {
                return listTcpbug;
            }
            set { listTcpbug = value; }
        }

        /// <summary>
        /// 取得采集器id
        /// </summary>
        /// <returns></returns>
        public int GetCollectorId()
        {
            string collectorCode = this.messageHeader.CollectorCode;
            int id = CollectorInfoService.GetInstance().getCollectorIdbyCode(collectorCode);
            if (id == 0)
            {
                //如果没有则创建一个
                Collector collector = new Collector();
                collector.code = collectorCode;
                collector.password = "123456";//按照规则生成
                collector.isUsed = true;
                try
                {
                    id = CollectorInfoService.GetInstance().Save(collector);
                }
                catch (Exception e)
                {
                    LogUtil.info("save collector " + collectorCode + " error:" + e.Message);
                }
            }

            return id;
        }

        /// <summary>
        /// 通过设备信息判断是否是否存在，不存在就新增一个设备
        /// </summary>
        /// <param name="device"></param>
        /// <returns></returns>
        private int GetDeviceId(int collectorID, string deviceAddress)
        {
            try
            {
                return DeviceService.GetInstance().getDeviceId(collectorID, deviceAddress);
            }
            catch (Exception ee) {
                //这里有System.Object到device的造型异常，可能是没有设备的情况下，后头再调试
                LogUtil.error("get device error:" + ee.Message);
                Device device =  DeviceService.GetInstance().getDevice(collectorID, deviceAddress);
                if (device != null) return device.id;
                return 0;
            }
        }

        /// <summary>
        /// 取得设备天数据列表
        /// </summary>
        /// <returns></returns>
        public void getDeviceDayDataList()
        {
            if (this.listTcpbody != null && listTcpbody.Count > 0)
            {
                Device device = null;
                int collectorID = GetCollectorId();
                DeviceDayData mdd = null;
                foreach (DeviceDataBase ddb in ListTcpbody)
                {
                    int deviceID = GetDeviceId(collectorID, ddb.deviceAddress);
                    if (deviceID == 0)
                    {
                        //构造设备
                        device = new Device();
                        device.collectorID = collectorID;
                        device.deviceAddress = ddb.deviceAddress.ToString();
                        //根据协议类型取得说属大类型
                        device.deviceTypeCode = DeviceData.getProtocolTypeByCode(ddb.protocolType).deviceType.code;
                        device.deviceModel = new DeviceModel() { code = ddb.deviceXh };
                        device.status = ddb.deviceState.ToString();
                        deviceID = DeviceService.GetInstance().Save(device);
                        LogUtil.info("has new device,collectorID is " + collectorID + ",deviceAddress is "+device.deviceAddress);
                        //有新设备要更新bank缓存
                        HttpClientUtil.requestUrl(bank_url);
                    }
                    else
                    {   
                        //这里影响解析性能，出了型号会变，设备类型也会变所以也要更新
                        device = DeviceService.GetInstance().get(deviceID);
                        if (ddb.deviceXh != device.deviceModelCode || (DeviceData.getProtocolTypeByCode(ddb.protocolType).typecode != device.deviceTypeCode))
                        { //型号有变化更新设备信息
                            device.deviceModelCode = ddb.deviceXh;
                            device.deviceModel = new DeviceModel() { code = ddb.deviceXh };
                            device.deviceTypeCode = DeviceData.getProtocolTypeByCode(ddb.protocolType).typecode;
                            device.name = "";
                            LogUtil.info("has device update,collectorID is " + collectorID + ",deviceAddress is " + device.deviceAddress);
                            DeviceService.GetInstance().Save(device);

                            //设备类型编号也要更新bank缓存
                            HttpClientUtil.requestUrl(bank_url);
                        }
                    }

                    //设置设备的发电量
                    if(ddb.todayEnergy>-1){
                        deviceEnergyMap[deviceID + ":" +messageHeader.year + messageHeader.month + messageHeader.day] = ddb.todayEnergy;
                    }

                    //设置设备的增量日照强度，参照发电量记录，用发电量的记录逻辑，因为发电量的设备id是逆变器，现在时环境监测仪所以不会重复，可以用发电量的结构
                    //如果增量日照强度大于0则表示有就记录下来，用于后面的累计 add by qianhb in 2012/01/13
                    if(ddb.todaySunshine>-1){
                        deviceEnergyMap[deviceID + ":" +messageHeader.year + messageHeader.month + messageHeader.day] = ddb.todaySunshine;
                    }

                    
                    //这里需要改进为依据设备时间，防止设备数据的时间和采集器的时间是不一致的
                    string mapObjectKey;
                    IDictionary<string, DeviceDayData> tmpdic = null;
                    foreach (int key in ddb.historyMonitorMap.Keys)
                    {
                        tmpdic = devicedayDataMapList[deviceID%50];
                        mapObjectKey = CacheKeyUtil.buildDeviceDayDataKey(deviceID, messageHeader.year + messageHeader.month, int.Parse(messageHeader.day), key);
                        if (!tmpdic.ContainsKey(mapObjectKey))
                        {
                            //先从缓存中取得
                            mdd = DeviceDayDataService.GetInstance().getDeviceDayData(deviceID, key, int.Parse(messageHeader.day), int.Parse(messageHeader.year), int.Parse(messageHeader.month));
                            if (mdd == null)
                                mdd = new DeviceDayData() { deviceID = deviceID, sendDay = int.Parse(messageHeader.day), monitorCode = key, deviceType = ddb.deviceType };
                            else { 
                                if(mdd.id==0)
                                    LogUtil.warn("mdd id is 0" + deviceID + "-" + key + "-" + ddb.deviceType);
                            }

                            tmpdic[mapObjectKey] = mdd;
                        }
                        else
                        {
                            mdd = tmpdic[mapObjectKey];
                        }
                        //非持久化属性赋值，用于指定所在表
                        mdd.yearmonth = messageHeader.year + messageHeader.month;
                        float newValue = ddb.historyMonitorMap[key] == null ? 0 : float.Parse(ddb.historyMonitorMap[key].ToString());
                        mdd.dataContent += "#" + messageHeader.hour + messageHeader.minute + messageHeader.second + ":" + newValue;
                        mdd.sendtime = messageHeader.TimeNow;
                        mdd.localAcceptTime = DateTime.Now;
                        mdd.deviceType = ddb.deviceType;
                        mdd.changed = true;
                        //将功率和关照的最大发生时间记录下来,稍后在优化下
                        if (key == MonitorType.MIC_INVERTER_TOTALYGPOWER || key == MonitorType.MIC_DETECTOR_SUNLINGHT || key == MonitorType.MIC_BUSBAR_TOTALCURRENT) {
                            deviceDataCounts.Add(new DeviceDataCount() { deviceId = deviceID, monitorCode = key, year = int.Parse(messageHeader.year), month = int.Parse(messageHeader.month), day = int.Parse(messageHeader.day), deviceTable = TableUtil.DEVICE, maxValue = newValue, maxTime = messageHeader.TimeNow, localAcceptTime = DateTime.Now });
                        }

                    }
                }
            }
        }

        /// <summary>
        /// 用峰值替换属性数据
        /// 废弃
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="curHH"></param>
        /// <param name="value"></param>
        private void replaceMax(object obj, int curHH, float newValue)
        {
            string field = "h_" + curHH;
            object ovalue = getField(obj, field);
            if (ovalue == null || newValue > float.Parse(ovalue.ToString()))
            {
                SetField(obj, field, newValue);
            }
        }

        /// <summary>
        /// 取得采集器日数据列表
        /// </summary>
        /// <returns></returns>
        public void GetCollectorDaydataList()
        {
            //将单元头部的发电量加入历史测点数据map中，然后统一处理
            historyMonitorMap[MonitorType.PLANT_MONITORITEM_ENERGY_CODE] = messageHeader.DayEnergy ;
            historyMonitorMap[MonitorType.PLANT_MONITORITEM_POWER_CODE] = messageHeader.Power;

            int collectorID = GetCollectorId();
            //根据历史测点数据构建设备天数据
            //这里需要改进为依据设备时间，防止设备数据的时间和采集器的时间是不一致的
            CollectorDayData mdd;
            string mapObjectKey;
            //遍历测点数据
            foreach (int key in historyMonitorMap.Keys)
            {
                mapObjectKey = CacheKeyUtil.buildCollectorDayDataKey(collectorID, messageHeader.year + messageHeader.month, int.Parse(messageHeader.day), key);
                if (!collectordayDataMap.ContainsKey(mapObjectKey))
                {
                    //先从缓存中取得
                    mdd = CollectorDayDataService.GetInstance().getCollectorDayData(collectorID, key, int.Parse(messageHeader.day), int.Parse(messageHeader.year), int.Parse(messageHeader.month));
                    if (mdd == null)
                        mdd = new CollectorDayData() { collectorID = collectorID, sendDay = int.Parse(messageHeader.day), monitorCode = key, yearmonth = messageHeader.year + messageHeader.month };
                    collectordayDataMap[mapObjectKey] = mdd;
                }
                else {
                    mdd = collectordayDataMap[mapObjectKey];
                }
                float newValue = historyMonitorMap[key]==null?0:float.Parse(historyMonitorMap[key].ToString());
                mdd.dataContent += "#" + messageHeader.hour + messageHeader.minute + messageHeader.second + ":" + newValue;
                mdd.sendtime = messageHeader.TimeNow;
                mdd.localAcceptTime = DateTime.Now;
                mdd.yearmonth = messageHeader.year + messageHeader.month;
                mdd.changed = true;
                //将功率和关照的最大发生时间记录下来.稍后优化下
                if (key == MonitorType.PLANT_MONITORITEM_POWER_CODE)
                {
                    //if (collectorID >= 189 && collectorID < 199)
                    //{
                    //    LogUtil.writeline(messageHeader.TimeNow + "-" + newValue);
                    //}
                    collectorDataCount = new DeviceDataCount() { deviceId = collectorID, monitorCode = key, year = int.Parse(messageHeader.year), month = int.Parse(messageHeader.month), day = int.Parse(messageHeader.day), deviceTable = TableUtil.PLANT, maxValue = newValue, maxTime = messageHeader.TimeNow, localAcceptTime = DateTime.Now };
                }
  
            }
        }

        /// <summary>
        /// 执行属性赋值
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="fieldName"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        private void SetField(object obj,string propertyName,float value) {
            Type ht = obj.GetType();
            PropertyInfo propertyInfo = ht.GetProperty(propertyName);
            if (propertyInfo != null)
            {
                propertyInfo.SetValue(obj, value,null);
            }
        }

        /// <summary>
        /// 执行去属性方法
        /// 如果为null回返回0
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="fieldName"></param>
        /// <returns></returns>
        private object getField(object obj, string propertyName)
        {
            Type ht = obj.GetType();
            PropertyInfo propertyInfo = ht.GetProperty(propertyName);
            if (propertyInfo != null)
            {
                return propertyInfo.GetValue(obj, null);
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 取得告警列表
        /// </summary>
        /// <returns></returns>
        public void GetFaultList()
        {
            if (this.listTcpbug != null && listTcpbug.Count > 0)
            {
                Fault fault = null;
                int colllectorID = GetCollectorId();
                foreach (Bug bug in listTcpbug)
                {
                    fault = new Fault();
                    fault.address = bug.deviceAddress.ToString();
                    fault.errorCode = bug.faultType;
                    ErrorItem errorItem = ErrorItem.getErrotItemByCode(bug.faultType);
                    fault.errorTypeCode = errorItem == null?ErrorType.ERROR_TYPE_FAULT:errorItem.errorType;
                    fault.sendTime = bug.faultTime;
                    fault.collectorID = colllectorID;
                    fault.confirm = false;
                    int deviceID = this.GetDeviceId(colllectorID, bug.deviceAddress);
                    fault.device = new Device() { id = deviceID };
                    faultList.Add(fault);
                }
            }
        }

        /// <summary>
        /// 取得采集器实时数据
        /// </summary>
        /// <returns></returns>
        public void GetCollectorRunData()
        {
            int collectorID = GetCollectorId();
            CollectorRunData dsrd;
            if (!collectorRunDataMap.ContainsKey(collectorID))
            {
                dsrd = CollectorRunDataService.GetInstance().Get(collectorID);
                if (dsrd == null)
                    dsrd = new CollectorRunData();
                dsrd.collectorID = collectorID;
                collectorRunDataMap[collectorID] = dsrd;
            }
            else
            {
                dsrd = collectorRunDataMap[collectorID];
            }

            if ((dsrd.dayEnergy < messageHeader.DayEnergy || dsrd.sendTime.Day != messageHeader.TimeNow.Day) || (messageHeader.TimeNow.Hour<6 && messageHeader.DayEnergy==0))
                dsrd.dayEnergy = messageHeader.DayEnergy;

            if (dsrd.totalEnergy < messageHeader.TotalEnergy)
                dsrd.totalEnergy = messageHeader.TotalEnergy;

            dsrd.power = messageHeader.Power;
            dsrd.sendTime = messageHeader.TimeNow;

            if (realMonitorMap.ContainsKey(MonitorType.PLANT_MONITORITEM_WINDSPEED))
            {
                string str = this.realMonitorMap[MonitorType.PLANT_MONITORITEM_WINDSPEED].ToString();
                dsrd.windSpeed = str.IndexOf(".") > 0 ? int.Parse(str.Substring(0, str.IndexOf("."))) : int.Parse(str);
            }
            else {
                dsrd.windSpeed = null;
            }

            if (realMonitorMap.ContainsKey(MonitorType.PLANT_MONITORITEM_WINDDIRECTION))
            {
                string str = this.realMonitorMap[MonitorType.PLANT_MONITORITEM_WINDDIRECTION].ToString();
                dsrd.windDirection = str.IndexOf(".") > 0 ? int.Parse(str.Substring(0, str.IndexOf("."))) : int.Parse(str);
            }
            else {
                dsrd.windDirection = null;
            }

            if (realMonitorMap.ContainsKey(MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE))
                dsrd.temperature = float.Parse(this.realMonitorMap[MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE].ToString());
            else {
                dsrd.temperature = null;
            }

            if (realMonitorMap.ContainsKey(MonitorType.PLANT_MONITORITEM_LINGT_CODE))
            {
                string str = this.realMonitorMap[MonitorType.PLANT_MONITORITEM_LINGT_CODE].ToString();
                dsrd.sunStrength = str.IndexOf(".") > 0 ? int.Parse(str.Substring(0, str.IndexOf("."))) : int.Parse(str);
            }
            else {
                dsrd.sunStrength = null;
            }
            //dsrd.changed = true;
        }

        /// <summary>
        /// 取得设备的实时数据列表
        /// 可以不要做防止小数覆盖，因为没有时就不会有此条数据
        /// </summary>
        /// <returns></returns>
        public void GetDeviceRunDataList()
        {
            List<DeviceRunData> dayDatalist = new List<DeviceRunData>();
            DeviceRunData mdd = null;
            int collectorID = GetCollectorId();
            int deviceID;
            StringBuilder sb;
            foreach (DeviceDataBase ddb in ListTcpbody)
            {
                deviceID = GetDeviceId(collectorID, ddb.deviceAddress);
                //根据历史测点数据构建设备天数据
                if (!deviceRunDataMap.ContainsKey(deviceID))
                {
                    mdd = new DeviceRunData();
                    mdd.deviceID = deviceID;
                    deviceRunDataMap[deviceID] = mdd;
                }
                else
                {
                    mdd = deviceRunDataMap[deviceID];
                }
                //就的数据不再更新实时数据
                if (mdd.updateTime > messageHeader.TimeNow) continue;
                sb = new StringBuilder();
                //测点代码:数据#代码:数据..
                foreach (int key in ddb.realMonitorMap.Keys)
                {
                    sb.Append("#").Append(key + ":").Append(ddb.realMonitorMap[key]);
                    if (key == MonitorType.MIC_INVERTER_TOTALENERGY || key == MonitorType.MIC_INVERTER_ACENERGY)
                        mdd.energy = float.Parse(ddb.realMonitorMap[key].ToString());
                    if (key == MonitorType.MIC_INVERTER_TODAYENERGY)
                        mdd.todayEnergy = float.Parse(ddb.realMonitorMap[key].ToString());
                }
                
                mdd.rundatastr = sb.Length>0?sb.ToString(1,sb.Length-1):"";
                mdd.updateTime = messageHeader.TimeNow;
                mdd.collectorID = collectorID;
                mdd.changed = true;

            }
        }
    }

    /// <summary>
    /// TCP消息头
    /// </summary>
    public class MessageHeader
    {
        public MessageHeader() { }

        protected string _Header;
        protected string _Version;
        protected string _CollectorCode;
        protected int _DevicesNum;
        protected int _BugNum;
        protected DateTime _TimeNow;
        public string year;
        public string month;
        public string day;
        public string hour;
        public string minute;
        public string second;

        protected float _dayEnergy;

        public float DayEnergy
        {
            get { return _dayEnergy; }
            set { _dayEnergy = value; }
        }
        protected float _totalEnergy;

        public float TotalEnergy
        {
            get { return _totalEnergy; }
            set { _totalEnergy = value; }
        }
        protected float _power;

        public float Power
        {
            get { return _power; }
            set { _power = value; }
        }

        public string Header
        {
            get
            {
                return _Header;
            }
            set { _Header = value; }
        }


        /// <summary>
        /// 版本号
        /// </summary>
        public string Version
        {
            get
            {
                return _Version;
            }
            set { _Version = value; }
        }
        /// <summary>
        /// 设备单元ID
        /// </summary>
        public string CollectorCode
        {
            get
            {
                return _CollectorCode;
            }
            set { _CollectorCode = value; }
        }

        /// <summary>
        /// 当前时间 设备所在地区时间 
        /// </summary>
        public DateTime TimeNow
        {
            get
            {
                return _TimeNow;
            }
            set { 
                _TimeNow = value;
                this.year = value.Year.ToString();
                this.minute = value.Minute.ToString("00");
                this.month = value.Month.ToString("00");
                this.day = value.Day.ToString("00");
                this.hour = value.Hour.ToString("00");
                this.second = value.Second.ToString("00");
            }
        }
        /// <summary>
        /// 设备数
        /// </summary>
        public int DevicesNum
        {
            get
            {
                return _DevicesNum;
            }
            set { _DevicesNum = value; }
        }
        /// <summary>
        /// 故障信息数
        /// </summary>
        public int BugNum
        {
            get
            {
                return _BugNum;
            }
            set { _BugNum = value; }
        }
        /// <summary>
        /// 解析头部
        /// </summary>
        /// <param name="header"></param>
        public virtual void analyze(string header)
        { 
        
        }
    }

    /// <summary>
    /// TCP消息头
    /// </summary>
    public class TcpHeader : MessageHeader
    {
        static string debug_collector = ConfigurationSettings.AppSettings["debug_collector"];
        public TcpHeader()
        { }
        /// <summary>
        /// 覆写解析方法
        /// </summary>
        /// <param name="header"></param>
        public override void analyze(string header)
        {
            this._Header = header;

            //StringBuilder sbUnitID = new StringBuilder();
            //for (int i = 4; i < 19; i++)
            //{
            //    sbUnitID.Append(ASCII.Chr((int)SystemCode.HexNumberToDenary(this._Header.Substring(i * 2, 2), false, 8, 'u')));
            //}
            string sbUnitID = "";
            bool isNormal = false;
            string tmpchar;
            //将后面是00的抛弃
            for (int i = 18; i >=4; i--)
            {
                tmpchar = this._Header.Substring(i * 2, 2);
                if (!isNormal && !tmpchar.Equals("00"))
                {
                    isNormal = true;
                }
                if (isNormal)
                    sbUnitID = ASCII.Chr((int)SystemCode.HexNumberToDenary(tmpchar, false, 8, 'u')) + sbUnitID;
            }
            _CollectorCode = sbUnitID.ToString();
            _CollectorCode = _CollectorCode.Replace("\0", "0");//临时处理非法测试数据
            _Version = SystemCode.HexNumberToDenary(this._Header.Substring(19 * 2, 2 * 2), true, 16, 'u').ToString();
            if (debug_collector.Equals(_CollectorCode)) {
                Console.WriteLine("");
            }
            string ssss = this._Header.Substring(21 * 2, 6 * 2);
            int year = 2000 + (int)SystemCode.HexNumberToDenary(ssss.Substring(0, 2), true, 16, 'u') % 99;
            int moth = (int)SystemCode.HexNumberToDenary(ssss.Substring(2, 2), true, 16, 'u');
            if (moth > 12) moth = 12;
            int day = (int)SystemCode.HexNumberToDenary(ssss.Substring(4, 2), true, 16, 'u');
            if (day > 31) day = 28;
            int hh = (int)SystemCode.HexNumberToDenary(ssss.Substring(6, 2), true, 16, 'u');
            if (hh > 23) hh = 23;
            int mm = (int)SystemCode.HexNumberToDenary(ssss.Substring(8, 2), true, 16, 'u');
            if (mm > 60) mm = 59;
            int ss = (int)SystemCode.HexNumberToDenary(ssss.Substring(10, 2), true, 16, 'u');
            if (ss > 60) ss = 59;
            this.TimeNow = new DateTime(year, moth, day, hh, mm, ss);

            string dayestr = SystemCode.ReversionAll(this._Header.Substring(31 * 2, 4 * 2));
            _dayEnergy = (float)SystemCode.HexNumberToDenary(dayestr, false, 32, 'u');
            //add in 8/6  for 原来是4字节无符号整形，改为无符号带一位小数整形
            _dayEnergy = _dayEnergy * 0.1F;
            LogUtil.info("collector energy " + _dayEnergy);

            string totalstr = SystemCode.ReversionAll(this._Header.Substring(35 * 2, 4 * 2));
            _totalEnergy = SystemCode.HexNumberToDenary(totalstr, false, 32, 'U');
            string powerstr = SystemCode.ReversionAll(this._Header.Substring(27 * 2, 4 * 2));
            _power = (int)SystemCode.HexNumberToDenary(powerstr, false, 32, 'u');
            _power = float.Parse(Math.Round(_power / 1000, 3).ToString());//换算成kw

            _DevicesNum = (int)SystemCode.HexNumberToDenary(this._Header.Substring(39 * 2, 1 * 2), false, 8, 'u');

            BugNum = (int)SystemCode.HexNumberToDenary(this._Header.Substring(40 * 2, 1 * 2), false, 8, 'u');
        }


    }
    
    /// <summary>
    /// Email消息头
    /// </summary>
    public class EmailHeader : MessageHeader
    {
        public void Analyze(string header)
        {
            this._Header = header.Replace("[DATALOG]", string.Empty);
            string[] head = this._Header.Split('=');
            if (head.Length == 9)
            {
                _CollectorCode = head[1].Replace("DEVVER", string.Empty);
                _Version = head[2].Replace("TIME", string.Empty);
                _TimeNow = DateTime.Parse(head[3].Replace("PAC", string.Empty)); ;
                _power = float.Parse(head[4].Replace("EDAY", string.Empty));
                _dayEnergy = float.Parse(head[5].Replace("ETOT", string.Empty));
                _totalEnergy = float.Parse(head[6].Replace("CHILDDEVNUM", string.Empty));
                _DevicesNum = int.Parse(head[6].Replace("FALUTNUM", string.Empty));
                _BugNum = int.Parse(head[7]);
            }
        }
    }
}