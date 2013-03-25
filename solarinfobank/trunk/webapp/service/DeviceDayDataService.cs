using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Reflection;
using System.Configuration;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class DeviceDayDataService : BaseService
    {

        //设备天数据缓存中key列表不在需要那个直接用baseMessage.devicedayDataMapList
        //public static IList<string> persistentListKey = new List<string>();
        private static DeviceDayDataService _instance;
        private IDaoManager _daoManager = null;
        private IDeviceDayDataDao _DevicePowerDaydataDao = null;
        //保持存在的设备id，因为设备不能删除所以可以list保持
        private static IList<string> DeviceDayExistList = new List<string>();
        /// <summary>
        /// 天数据保持到数据库间隔，单位小时
        /// </summary>
        private static int DeviceDayDataSaveInterval = ConfigurationSettings.AppSettings["DeviceDayDataSaveInterval"] == null ? 1 : int.Parse(ConfigurationSettings.AppSettings["DeviceDayDataSaveInterval"]);
        /// <summary>
        /// 采集器天数据缓存过期时间，单位小时
        /// </summary>
        private static int DeviceDayData_expireTime = ConfigurationSettings.AppSettings["DeviceDayData_expireTime"] == null ? 1 : int.Parse(ConfigurationSettings.AppSettings["DeviceDayData_expireTime"]);
        //天数据id和上次保持小时map
        private static IDictionary<string, int> LastdayDataSaveTimeMap = new Dictionary<string, int>();
        private DeviceDayDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _DevicePowerDaydataDao = _daoManager.GetDao(typeof(IDeviceDayDataDao)) as IDeviceDayDataDao;
        }

        public static DeviceDayDataService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new DeviceDayDataService();
            }
            return _instance;
        }


        /// <summary>
        /// 删除天数据，按照id 
        /// add by qhb in 20120828 
        /// </summary>
        /// <param name="dayData"></param>
        /// <returns></returns>
        public bool Delete(DeviceDayData dayData)
        {
            return _DevicePowerDaydataDao.Remove(dayData) > 0 ? true : false;
        }

        public Hashtable GetDaydataList(Device device, string startYYYYMMDDHH, string endYYYYMMDDHH, int intervalMins, int monitorCode)
        {
            return this.GetDaydataList(null, device, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, monitorCode);
        }

        /// <summary>
        /// 取得设备跨小时的测点数据
        /// </summary>
        /// <param name="device">设备</param>
        /// <param name="startYYYYMMDDHH">开始时间 精确到小时 比如：2011062807</param>
        /// <param name="endYYYYMMDDHH">截止时间 精确到小时 比如：2011062817</param>
        /// <param name="intervalMins">数据统计的间隔时间，单位是分钟，比如60表示一小时</param>
        /// <param name="monitorCode">设备测点代码，参见MonitorType.cs</param> 
        /// <returns>hashtable,key表示时间点 value是值</returns>
        public Hashtable GetDaydataList(IList<string> XAxis, Device device, string startYYYYMMDDHH, string endYYYYMMDDHH, int intervalMins, int monitorCode)
        {
            //累加多个单元的功率数据
            Hashtable hhpowerHash = new Hashtable();
            string startYYYYMM = startYYYYMMDDHH.Substring(0, 6);
            string endYYYYMM = endYYYYMMDDHH.Substring(0, 6);
            int startDD = int.Parse(startYYYYMMDDHH.Substring(6, 2));
            int endDD = int.Parse(endYYYYMMDDHH.Substring(6, 2));
            if (startYYYYMM.Equals(endYYYYMM))
            {
                string year = startYYYYMM.Substring(0, 4);
                string month = startYYYYMM.Substring(4, 2);
                return this.getMultiDayBetweenData(XAxis, device, year, month, startDD, endDD, intervalMins, monitorCode);
            }
            else
            {
                string year = startYYYYMM.Substring(0, 4);
                string month = startYYYYMM.Substring(4, 2);
                int firstEndDD = CalenderUtil.getMonthDays(year + month);
                Hashtable firstHash = this.getMultiDayBetweenData(XAxis, device, year, month, startDD, firstEndDD, intervalMins, monitorCode);
                year = endYYYYMM.Substring(0, 4);
                month = endYYYYMM.Substring(4, 2);
                Hashtable secondHash = this.getMultiDayBetweenData(XAxis, device, year, month, 1, endDD, intervalMins, monitorCode);

                foreach (Object obj in secondHash.Keys)
                {
                    firstHash.Add(obj, secondHash[obj]);
                }
                return firstHash;
            }
        }

        private Hashtable getMultiDayBetweenData(Device device, string year, string month, int startDD, int endDD, int intervalMins, int monitorCode)
        {
            return getMultiDayBetweenData(null, device, year, month, startDD, endDD, intervalMins, monitorCode);
        }

        /// <summary>
        /// 加工处理某天某个设备多测点数据到表格输出方式
        /// </summary>
        /// <param name="device"></param>
        /// <param name="yyyyMMdd"></param>
        /// <returns>//key ：时间点 value ： 测点和值map (key:测点 value：测点值)</returns>
        public IDictionary<string, IDictionary<string, string>> handleDayData(IList<string> allmts, Device device, string yyyyMMdd)
        {
            //首先取出某个设备的所有测点的天数据
            string year = yyyyMMdd.Substring(0, 4);
            string month = yyyyMMdd.Substring(4, 2);
            int day = int.Parse(yyyyMMdd.Substring(6, 2));

            IList<DeviceDayData> deviceDayDatas = this.getDeviceDayDatas(device, year, month, day, day);
            //保存时间点对应的测点值map
            //key ：时间点 value ： 测点和值map (key:测点 value：测点值)
            IDictionary<string, IDictionary<string, string>> timemtMap = new Dictionary<string, IDictionary<string, string>>();
            //循环取出所有时间点，并把所有时间点放入map
            string timepoint = "";
            IDictionary<string, string> mtMap = null;
            MonitorType omt = null;
            string mtkey = "";
            foreach (DeviceDayData dayData in deviceDayDatas) {
                if (string.IsNullOrEmpty(dayData.dataContent)) continue;
                //存储所有测点
                omt = MonitorType.getMonitorTypeByCode(dayData.monitorCode);
                //add by qhb at 20120829 for 判断逆变器测点是否符合显示规则，参照设备实时数据那里规则

                //如果是逆变器那么先取额定功率
                float outtype = 0;
                IList<int> notdisplayInverterbyPower = new List<int>();
                IList<int> notdisplayInverterbyoutType = new List<int>();
                if (device.deviceTypeCode == DeviceData.INVERTER_CODE)
                {
                    outtype = device.getMonitorValue(MonitorType.MIC_INVERTER_OUTTYPE);
                    notdisplayInverterbyoutType = DeviceRunData.getnotDisplayMonitor(outtype);
                    float power = device.getMonitorValue(MonitorType.MIC_INVERTER_POWER);
                    notdisplayInverterbyPower = DeviceRunData.getnotDisplayMonitorByPower(power);
                }
                //排除不显示的测点
                if (DeviceRunData.notDisplayMonitor.Contains(omt.code) || notdisplayInverterbyoutType.Contains(omt.code) || notdisplayInverterbyPower.Contains(omt.code)) continue;

                //重新构造一个实例，以便用tempaffix多语言显示后缀是线程安全
                string tempaffix = omt.tempaffix;
                string unit = omt.unit;
                Boolean isUP = false;//是否进制千位

                //如果是逆变器要判断abc三项电压和电流的输出类型,将输出类型作为有后缀测点的后缀
                if (device.deviceTypeCode == DeviceData.INVERTER_CODE)
                {
                    if (DeviceRunData.affixMonitors.Contains(dayData.monitorCode) && !float.IsNaN(outtype) && (outtype == 0 || outtype == 2))
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


                if(string.IsNullOrEmpty(mt.unit)){
                    mtkey = mt.name;
                }else{
                    mtkey = mt.name + "(" + mt.unit + ")";
                }


                string[] datas = dayData.dataContent.Split('#');
                string[] timedatas=null;
                bool isAllZero = true;
                bool isAllNovalid = true;
                foreach(string data in datas){
                    if (string.IsNullOrEmpty(data)) continue;
                    timedatas = data.Split(':');
                    timepoint = timedatas[0];
                    timepoint = string.Format("{0}:{1}:{2}", timepoint.Substring(0, 2), timepoint.Substring(2, 2), timepoint.Substring(4));
                    if (timemtMap.ContainsKey(timepoint))
                    {
                        mtMap = timemtMap[timepoint];
                    }
                    else {
                        mtMap = new Dictionary<string, string>();
                        timemtMap.Add(timepoint, mtMap);
                    }

                    String value = timedatas[1];
                    //如果值为-表示该值无效，不显示该测点，“-”，数据解析器会把发送的无效值固定设为“-”
                    if ("-".Equals(value))
                    {
                        value = "";
                    }
                    else
                    {
                        isAllNovalid = false;
                    }

                    //add by qhb for 单位进制
                    if (isUP)
                    {
                        try
                        {
                            value = Math.Round((double.Parse(value) / 1000), 2).ToString();
                        }
                        catch (Exception e)
                        {
                            //do nothing
                        }
                    }
                    //add by qhb in 20121029 for 1）功率因数为0和无功功率为0屏蔽不显示。
                    if (mt.code == MonitorType.MIC_INVERTER_TOTALPOWERFACTOR || mt.code == MonitorType.MIC_INVERTER_TOTALWGPOWER)
                    {
                        try
                        {
                            if (double.Parse(value) == 0)
                                value="";
                            else
                            {
                                isAllZero = false;
                            }
                        }
                        catch { }
                    }
                    if ("0".Equals(value) && omt.zerotoline)
                    {
                        value = "-";
                    }

                    if (mtMap.ContainsKey(mtkey))
                    {
                        mtMap[mtkey] = value;
                    }
                    else {
                        mtMap.Add(mtkey, value);
                    }
                }
                //add by qhb in 20121029 for 1）功率因数为0和无功功率为0屏蔽不显示。
                if (isAllZero && (mt.code == MonitorType.MIC_INVERTER_TOTALPOWERFACTOR || mt.code == MonitorType.MIC_INVERTER_TOTALWGPOWER))
                {
                    continue;
                }
                if (isAllNovalid)
                    continue;
                allmts.Add(mtkey);
            }
            return timemtMap;
        }

        /// <summary>
        /// 取得某个设备跨天的所有测点天数据
        /// add by qhb in 20120915 
        /// </summary>
        /// <param name="device"></param>
        /// <param name="day"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="startDD"></param>
        /// <param name="endDD"></param>
        /// <returns></returns>
        public IList<DeviceDayData> getDeviceDayDatas(Device device, string year, string month, int startDD, int endDD)
        {
            string deviceTable = getDeviceTablename(device.deviceTypeCode);
            return _DevicePowerDaydataDao.GetDaydataList(device.id, deviceTable, year, month, startDD, endDD);
        }

        /// <summary>
        /// 取得某个设备天数据
        /// </summary>
        /// <param name="device"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="startDD"></param>
        /// <param name="endDD"></param>
        /// <param name="startHH"></param>
        /// <param name="endHH"></param>
        /// <param name="intervalMins"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        private Hashtable getMultiDayBetweenData(IList<string> XAxis, Device device, string year, string month, int startDD, int endDD, int intervalMins, int monitorCode)
        {
            Hashtable hhpowerHash = new Hashtable();
            //取得单个单元功率数据
            string deviceTable = getDeviceTablename(device.deviceTypeCode);

            //取得单个单元功率数据
            //如果查询天和当前时间间隔2天之内，包括2天则从数据库先缓存中查询
            bool isDB = true;
            for (int i = startDD; i <= endDD; i++)
            {
                IList unitPowerDayDatas = new List<BaseDayData>();
                if (DateTime.Now.Day >= i && DateTime.Now.Day - i <= 1)
                {
                    string key = CacheKeyUtil.buildDeviceDayDataKey(device.id, year + month, i, monitorCode);
                    object obj = MemcachedClientSatat.getInstance().Get(key);
                    if (obj != null)
                    {
                        unitPowerDayDatas.Add(obj);
                        isDB = false;
                    }
                }
                if (isDB)
                    unitPowerDayDatas = _DevicePowerDaydataDao.GetDaydataList(device.id, deviceTable, year, month, i, i, monitorCode);

                joinToPointData(XAxis, hhpowerHash, unitPowerDayDatas, intervalMins, monitorCode);
            }
            return hhpowerHash;
        }

        private string getDeviceTablename(int deviceTypeCode)
        {
            switch (deviceTypeCode)
            {
                case DeviceData.INVERTER_CODE:
                    return TableUtil.INVERTER_TABLE_NAME;
                case DeviceData.HUILIUXIANG_CODE:
                    return TableUtil.HUILIUXIANG;
                case DeviceData.CABINET_CODE:
                    return TableUtil.CABINET;
                case DeviceData.AMMETER_CODE:
                    return TableUtil.AMMETER;
                default:
                    return TableUtil.DETECTOR;
            }
        }

        /// <summary>
        /// 将设备天数据批量放入缓存
        /// 由于输入的对象开始经过缓存和数据取得了，所以这时直接放入缓存即可
        /// </summary>
        /// <param name="dayDatas"></param>
        public void batchToCache(IList<IDictionary<string, DeviceDayData>> devicedayDataMapList)
        {
            string cachekey = string.Empty;
            //int[] mtkeys = collectordayDataMap.Keys.ToArray();
            foreach (IDictionary<string, DeviceDayData> tmp in devicedayDataMapList)
            {
                //string[] keys = tmp.Keys.ToArray();
                DeviceDayData dayData = null;
                foreach (string key in tmp.Keys)
                {
                    if (key == null || !tmp.ContainsKey(key)) continue;
                    dayData = tmp[key];
                    if (dayData == null || !dayData.changed) continue;
                    //加入缓存，设置两天为缓存过期时间，避免时差问题
                    cachekey = CacheKeyUtil.buildDeviceDayDataKey(dayData.deviceID, dayData.yearmonth, dayData.sendDay, dayData.monitorCode);
                    mcs.Set(cachekey, dayData, DateTime.Now.AddDays(2));
                    //if (!persistentListKey.Contains(cachekey)) persistentListKey.Add(cachekey);
                    //dayData.changed = false;
                }
            }
        }


        /// <summary>
        /// 批量保持设备日数据对象
        /// </summary>
        /// <param name="unitDayDatas"></param>
        public void batchSave(IList<IDictionary<string, DeviceDayData>> devicedayDataMapList)
        {
            //从需要持久化的list中取出对象
            String[] keyArr;
            foreach (IDictionary<string, DeviceDayData> datadic in devicedayDataMapList)
            {
                keyArr = datadic.Keys.ToArray();
                foreach (string key in keyArr)
                {
                    object obj = MemcachedClientSatat.getInstance().Get(key);
                    if (obj == null)
                    {
                        LogUtil.warn(key + "in cache is empty of device day data ");
                        continue;
                    }
                    DeviceDayData collectorDayData = (DeviceDayData)obj;
                    if (!collectorDayData.changed) continue;
                    //持久化到数据库
                    if (collectorDayData.id == 0)
                    {
                        try
                        {
                            _DevicePowerDaydataDao.Insert(collectorDayData);
                            //添加id信息
                            MemcachedClientSatat.getInstance().Set(key, collectorDayData);
                            if (datadic.ContainsKey(key))
                                datadic[key].id = collectorDayData.id;
                        }
                        catch (Exception e)
                        {
                            LogUtil.error("insert device day data fail:" + e.Message);
                            //添加id信息
                            MemcachedClientSatat.getInstance().Set(key, collectorDayData);
                            if (datadic.ContainsKey(key))
                                datadic[key].id = collectorDayData.id;
                        }
                    }
                    else
                    {
                        try
                        {
                            _DevicePowerDaydataDao.Update(collectorDayData);
                        }
                        catch (Exception e)
                        {
                            //这里有些问题，稍后要调试下有插入索引约束异常
                            LogUtil.error("update" + collectorDayData.deviceType + " device day data fail:" + e.Message);
                        }
                    }
                    try
                    {
                        FileLogUtil.info("成功持久化设备天数据：" + "deviceid:" + collectorDayData.deviceID + ",content:" + collectorDayData.dataContent);
                    }
                    catch (Exception e) {
                        LogUtil.warn(e.Message);
                    }
                    //将变化标识置为false
                    datadic[key].changed = false;
                    //add by qhb in 20120713 for 持久化完成后从map中删除以防止天数据map愈来愈大，代替clearDayDataMap导致对于历史数据时，会将历史数据删除了，而无法持久化
                    datadic.Remove(key);
                }
            }
        }

        /// <summary>
        /// 根据设备，测点和天 取得设备数据对象
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public DeviceDayData getDeviceDayData(int deviceID, int monitorCode, int day, int year, int month)
        {
            string yearmonth = year + month.ToString("00");
            string deviceTable = getDeviceTablename(DeviceService.GetInstance().get(deviceID).deviceTypeCode);
            string key = CacheKeyUtil.buildDeviceDayDataKey(deviceID, year + month.ToString("00"), day, monitorCode);
            object obj = MemcachedClientSatat.getInstance().Get(key);
            if (obj == null || ((DeviceDayData)obj).id == 0)
                return _DevicePowerDaydataDao.getDeviceDayData(deviceID, deviceTable, monitorCode, day, yearmonth);
            return (DeviceDayData)obj;
        }

        /// <summary>
        /// 判读设备和此天的数据是否已经存在，存在后续就要做更新操作了，而非插入
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="day"></param>
        /// <param name="yearmonth"></param>
        /// <returns></returns>
        public IList<int> getDeviceDayDataMonitorCodeList(int deviceID, int day, int year, int month, int mtcount)
        {
            string key = "ddym_" + deviceID + "_" + day;
            object obj = MemcachedClientSatat.getInstance().Get(key);
            IList<int> mtList;
            if (obj == null)
            {
                string deviceTable = getDeviceTablename(DeviceService.GetInstance().get(deviceID).deviceTypeCode);
                mtList = _DevicePowerDaydataDao.getDeviceDayDataNums(deviceID, day, year + month.ToString("00"), deviceTable);
                MemcachedClientSatat.getInstance().Add(key, mtList, DateTime.Now.AddDays(1));
            }
            else
            {
                mtList = (List<int>)obj;
                if (mtList.Count != mtcount)
                {
                    string deviceTable = getDeviceTablename(DeviceService.GetInstance().get(deviceID).deviceTypeCode);
                    mtList = _DevicePowerDaydataDao.getDeviceDayDataNums(deviceID, day, year + month.ToString("00"), deviceTable);
                    MemcachedClientSatat.getInstance().Set(key, mtList);
                }
            }
            return mtList;
        }
    }
}
