/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月11日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using System.Configuration;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class DeviceDataCountService: BaseChartService
    {
        //采集器天数据缓存中key列表
        private static IList<string> persistentListKey = new List<string>();
        private static DeviceDataCountService _instance;
        private IDaoManager _daoManager = null;
        private IDeviceDataCountDao _ReportGroupDao = null;
        //天数据id和上次保持小时map
        private static IDictionary<string, int> LastdayDataSaveTimeMap = new Dictionary<string, int>();
        /// <summary>
        /// 天数据保持到数据库间隔，单位小时
        /// </summary>
        private static int DeviceDataCount_expireTime = ConfigurationSettings.AppSettings["DeviceDataCount_expireTime"] == null ? 48 : int.Parse(ConfigurationSettings.AppSettings["DeviceDataCount_expireTime"]);

        private DeviceDataCountService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _ReportGroupDao = _daoManager.GetDao(typeof(IDeviceDataCountDao)) as IDeviceDataCountDao;
        }

        public static DeviceDataCountService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new DeviceDataCountService();
            }
            return _instance;
        }

        /// <summary>
        /// 插入自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public int Insert(DeviceDataCount customReport)
        {
            return _ReportGroupDao.Insert(customReport);
        }

        /// <summary>
        /// 缓存采集器统计数据
        /// </summary>
        /// <param name="deviceDataCounts"></param>
        public void CacheCollectorCount(IList<DeviceDataCount> deviceDataCounts)
        {
            //object loco = new object();
            //lock (loco)
            //{
                //先记录下采集器的当天的所有时间的数据
            IDictionary<string, DeviceDataCount> recordMap = new Dictionary<string, DeviceDataCount>();
            try
            {
                recordMap = CacheCollectorCountRecord(deviceDataCounts, 5);
            }
            catch (Exception re) {
                LogUtil.error("CacheCollectorCountRecord异常" + re.Message);
            }

            //取出采集器对应的电站列表
            IDictionary<int, int> unitMap = getAllPlantUnit();
            try
            {
                //处理电站最大值
                computeMax(unitMap, recordMap);
            }
            catch (Exception ure) {
                LogUtil.error("computeMax异常"+ure.Message);
            }
            //}
        }

        /// <summary>
        /// 计算电站的所有采集器的最大值，并缓存
        /// </summary>
        /// <param name="unitMap"></param>
        /// <param name="deviceDataCounts"></param>
        private void computeMax(IDictionary<int, int> unitMap, IDictionary<string,DeviceDataCount> recordMap)
        {
            //电站天对应日统计记录 
            IDictionary<string, IList<Hashtable>> plantCount = new Dictionary<string, IList<Hashtable>>();
            IList<Hashtable> tmpPlantRecordList;
            IDictionary<string, DeviceDataCount> tmpDDCMap = new Dictionary<string,DeviceDataCount>();
            string plantrkey;
            int plantID;
            DeviceDataCount collectorDataCount;
            foreach (string recordCacheKey in recordMap.Keys)
            {
                collectorDataCount = recordMap[recordCacheKey];
                //取得采集器日统计记录
                object obj = MemcachedClientSatat.getInstance().Get(recordCacheKey);
                if (obj == null || !unitMap.ContainsKey(collectorDataCount.deviceId)) continue;
                plantID = unitMap[collectorDataCount.deviceId];
                plantrkey = CacheKeyUtil.buildDeviceDataCountKey(collectorDataCount.year, collectorDataCount.month, collectorDataCount.day, plantID, collectorDataCount.monitorCode);
                if (plantCount.ContainsKey(plantrkey))
                {
                    tmpPlantRecordList = plantCount[plantrkey];
                }
                else
                    tmpPlantRecordList = new List<Hashtable>();

                tmpPlantRecordList.Add((Hashtable)obj);
                collectorDataCount.deviceId = plantID; 
                tmpDDCMap[plantrkey] = collectorDataCount;
                plantCount[plantrkey] = tmpPlantRecordList;
            }

            //统计电站最大值
            //plantCount[plantKey]废弃
            foreach (string plantKey in plantCount.Keys) {
                mergeRecord2Cache(plantKey, tmpDDCMap[plantKey]);
            }
        }

        /// <summary>
        /// 合并某个电站的所有采集器的值记录
        /// </summary>
        /// <param name="plantId"></param>
        /// <param name="plantRecordList"></param>
        private void mergeRecord2Cache(string countCacheKey, DeviceDataCount collectorDataCount)
        {
            IDictionary<string, float> maxDictionary = new Dictionary<string, float>();
            //平滑用，统一标准坐标
            string daystr = collectorDataCount.year.ToString("00") + collectorDataCount.month.ToString("00") + collectorDataCount.day.ToString("00");
            string[] tmpIc = base.getXseriesFromYYYYMMDDHH(daystr + "00", daystr+"23", 5).ToArray();
            //给电站的采集器集合增加为完整的所有的采集器集合，以便每次都能统计所有采集器累计的最大发生值

            Plant plant = PlantService.GetInstance().GetPlantInfoById(collectorDataCount.deviceId);
            if (plant == null) return;
            string tmpcachkey = "";
            IList<Hashtable> plantRecordList = new List<Hashtable>();
            foreach (PlantUnit unit in plant.allFactUnits)
            {
                tmpcachkey = CacheKeyUtil.buildCollectorDataCountKey(collectorDataCount.year, collectorDataCount.month, collectorDataCount.day, unit.collectorID, collectorDataCount.monitorCode);
                //取得采集器日统计记录
                object obj = MemcachedClientSatat.getInstance().Get(tmpcachkey);
                if (obj == null) continue;
                plantRecordList.Add((Hashtable)obj);
            }

            foreach (Hashtable tmpMap in plantRecordList)
            {   
                //先平滑
                base.FirstHandleChartData(tmpIc, tmpMap);
                foreach(string key in tmpMap.Keys){
                    if (maxDictionary.ContainsKey(key))
                    {
                        maxDictionary[key] = maxDictionary[key] + (float)tmpMap[key];
                    }
                    else {
                        maxDictionary[key] = (float)tmpMap[key];
                    }
                }
            }

            //取得所有时间点中最大值
            float maxValue = 0 ;
            string maxTimeKey = "000000";
            float tmpValue;
            foreach (string key in maxDictionary.Keys) { 
                tmpValue = maxDictionary[key];
                if (tmpValue > maxValue) {
                    maxValue = tmpValue;
                    maxTimeKey = key;
                }
            }
            //
            collectorDataCount.maxTime = new DateTime(collectorDataCount.maxTime.Year, collectorDataCount.maxTime.Month, collectorDataCount.maxTime.Day, int.Parse(maxTimeKey.Substring(2, 2)), int.Parse(maxTimeKey.Substring(4,2)),0);
            collectorDataCount.maxValue = maxValue;
            LogUtil.writeline("plant max count" + collectorDataCount.deviceId + "-" + collectorDataCount.maxTime + "-" + maxValue);
            Cache(collectorDataCount);
        }

        /// <summary>
        /// 取得所有电站,现在注视掉，能当单元变更是，不能即时同步电站单元对应关系的缓存
        /// </summary>
        /// <returns></returns>
        public IDictionary<int,int> getAllPlantUnit() {
            IDictionary<int, int> unitMap;
            //string cacheKey = CacheKeyUtil.buildPlantUnitKey();
             // object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            //
            //if (obj == null)
            //{   
                //从数据库中取得
                IList<PlantUnit> plantUnits = PlantUnitService.GetInstance().List();
                unitMap = new Dictionary<int, int>();
                foreach (PlantUnit unit in plantUnits)
                {
                    if (!unitMap.ContainsKey(unit.collectorID))
                        unitMap.Add(unit.collectorID, unit.plantID);
                }
               // MemcachedClientSatat.getInstance().Set(cacheKey, unitMap, DateTime.Now.AddHours(2));
           // }
            //else
            //{
                //unitMap = (IDictionary<int, int>)obj;
            //}

            return unitMap;
        }


        /// <summary>
        /// cache采集器统计数据记录
        /// </summary>
        /// <param name="deviceDataCounts"></param>
        /// <param name="intervalTime"></param>
        /// <returns>采集器id列表</returns>
        private IDictionary<string,DeviceDataCount> CacheCollectorCountRecord(IList<DeviceDataCount> deviceDataCounts, int intervalTime)
        {
            String cacheKey;
            Hashtable maxDictionary;
            string intKey;
            IDictionary<string,DeviceDataCount> recordMap= new Dictionary<string,DeviceDataCount>();
            foreach (DeviceDataCount collectorDataCount in deviceDataCounts)
            {
                cacheKey = CacheKeyUtil.buildCollectorDataCountKey(collectorDataCount.year, collectorDataCount.month, collectorDataCount.day, collectorDataCount.deviceId, collectorDataCount.monitorCode);
                object obj = MemcachedClientSatat.getInstance().Get(cacheKey);

                int intMins = (collectorDataCount.maxTime.Minute - collectorDataCount.maxTime.Minute%intervalTime);
                intKey = collectorDataCount.maxTime.Day.ToString("00")+collectorDataCount.maxTime.Hour.ToString("00")+intMins.ToString("00");
                if (obj != null && !string.IsNullOrEmpty(obj.ToString()))//存在即修改
                {
                    maxDictionary = (Hashtable)obj;
                    //取得intervalTime分钟间隔的值
                    if (maxDictionary.ContainsKey(intKey))
                    {
                        float ovalue = (float)maxDictionary[intKey];
                        if (ovalue < collectorDataCount.maxValue)
                        {
                            maxDictionary[intKey] = collectorDataCount.maxValue;
                        }
                    }
                    else
                    {
                        maxDictionary.Add(intKey, collectorDataCount.maxValue);
                    }
                    if (collectorDataCount.deviceId >= 189 && collectorDataCount.deviceId<199)
                    {
                        LogUtil.writeline(collectorDataCount.maxValue.ToString());
                    }
                    MemcachedClientSatat.getInstance().Set(cacheKey, maxDictionary);
                }
                else
                {
                    maxDictionary = new Hashtable();
                    maxDictionary.Add(intKey, collectorDataCount.maxValue);
                    MemcachedClientSatat.getInstance().Add(cacheKey, maxDictionary, DateTime.Now.AddHours(DeviceDataCount_expireTime));
                    if (collectorDataCount.deviceId >= 189 && collectorDataCount.deviceId < 199)
                    {
                        LogUtil.writeline(collectorDataCount.maxValue.ToString());
                    }

                }
                if (!recordMap.ContainsKey(cacheKey))
                    recordMap.Add(cacheKey, collectorDataCount);
            }
            return recordMap;
        }

  
        /// <summary>
        /// 将最大值统计数据放入缓存
        /// </summary>
        /// <param name="deviceDataCounts"></param>
        public void batchCache(IList<DeviceDataCount> deviceDataCounts)
        {
            foreach (DeviceDataCount deviceDataCount in deviceDataCounts)
            {
                try
                {
                    Cache(deviceDataCount);
                }
                catch (Exception onee) {
                    LogUtil.writeline("handle one deviceDataCount of " + deviceDataCount.deviceId + "error:" +onee.Message);
                }
            }
        }

        /// <summary>
        /// 缓存单个统计对象
        /// </summary>
        /// <param name="deviceDataCount"></param>
        private void Cache(DeviceDataCount deviceDataCount)
        {
            string cacheKey = CacheKeyUtil.buildDeviceDataCountKey(deviceDataCount.year, deviceDataCount.month, deviceDataCount.day, deviceDataCount.deviceId, deviceDataCount.monitorCode);

            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            if (obj != null && !string.IsNullOrEmpty(obj.ToString()))//存在即修改
            {
                DeviceDataCount ddc = (DeviceDataCount)obj;
                if (ddc.maxValue < deviceDataCount.maxValue)
                {
                    ddc.maxValue = deviceDataCount.maxValue;
                    ddc.maxTime = deviceDataCount.maxTime;
                    ddc.localAcceptTime = DateTime.Now;
                    mcs.Set(cacheKey, ddc);
                }
            }
            else
            {
                DeviceDataCount ddc = _ReportGroupDao.Get(deviceDataCount);

                if (ddc != null && deviceDataCount.maxValue < ddc.maxValue)
                {
                    deviceDataCount.maxValue = ddc.maxValue;
                    deviceDataCount.maxTime = ddc.maxTime;
                }

                deviceDataCount.localAcceptTime = DateTime.Now;
                mcs.Add(cacheKey, deviceDataCount);
            }
            if (!persistentListKey.Contains(cacheKey)) persistentListKey.Add(cacheKey);
            //设置月度最大
            SetMonthMax(deviceDataCount);
            //设置年度最大
            SetYearMax(deviceDataCount);
        }

        /// <summary>
        /// 批量持久化天最大值统计
        /// </summary>
        public void batchSave()
        {
            DeviceDataCount deviceDataCount;
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = MemcachedClientSatat.getInstance().Get(key);
                if (obj == null || string.IsNullOrEmpty(obj.ToString())) {
                    LogUtil.warn(key + "in cache is empty of divice data count");
                    return; 
                }
                deviceDataCount = (DeviceDataCount)obj;
                if (deviceDataCount.year == 0 || string.IsNullOrEmpty(deviceDataCount.deviceTable)) {
                    MemcachedClientSatat.getInstance().Delete(key);
                    continue;
                }
                try
                {
                    if (deviceDataCount.id > 0)
                    {
                        this.Update(deviceDataCount);
                    }
                    else
                    {
                        this.Insert(deviceDataCount);

                        MemcachedClientSatat.getInstance().Set(key, deviceDataCount);
                    }
                }
                catch (Exception ee) {
                    LogUtil.error("save device data count error:" + ee.Message);
                }
                //判断是否不在持久化
                if (deviceDataCount.localAcceptTime.Day != DateTime.Now.Day)
                {
                    deviceDataCount.dontPersitent = true;
                    persistentListKey.Remove(key);
                }
            }
        }

        /// <summary>
        /// 插入自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public int Remove(DeviceDataCount customReport)
        {
            return _ReportGroupDao.Remove(customReport);
        }

        /// <summary>
        /// 修改自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public int Update(DeviceDataCount customReport)
        {
            return _ReportGroupDao.Update(customReport);
        }
        
        /// <summary>
        /// 取得电站某个测点最大发生时间和值
        /// </summary>
        /// <param name="plantId">电站id</param>
        /// <param name="monitorCode">测点代码，参见MonitorType.cs，比如：MonitorType.PLANT_MONITORITEM_POWER_CODE</param>
        /// <param name="year">年</param>
        /// <param name="month">月</param>
        /// <param name="day">日</param>
        /// <returns></returns>
        public DeviceDataCount GetPlantMax(int plantId, int monitorCode, int year, int month, int day)
        {
            DeviceDataCount ddc = new DeviceDataCount() { deviceId = plantId, deviceTable = TableUtil.PLANT, monitorCode = monitorCode, year = year, day = day, month = month };
            return this.Get(ddc);
        }

        /// <summary>
        /// 取得设备某个测点最大发生时间和值
        /// </summary>
        /// <param name="deviceId">设备id</param>
        /// <param name="monitorCode">测点代码，参见MonitorType.cs，比如：MonitorType.PLANT_MONITORITEM_POWER_CODE</param>
        /// <param name="year">年</param>
        /// <param name="month">月</param>
        /// <param name="day">日</param>
        /// <returns></returns>
        public DeviceDataCount GetDeviceMax(int deviceId, int monitorCode, int year, int month, int day)
        {
            DeviceDataCount ddc = new DeviceDataCount() { deviceId = deviceId, deviceTable = TableUtil.PLANT, monitorCode = monitorCode, year = year, day = day, month = month };
            return this.Get(ddc);
        }

        /// <summary>
        /// 取得电站或设备某个测点最大发生时间和值
        /// </summary>
        /// <param name="deviceDataCount"></param>
        /// <returns></returns>
        public DeviceDataCount Get(DeviceDataCount deviceDataCount)
        {
            string cacheKey = CacheKeyUtil.buildDeviceDataCountKey(deviceDataCount.year, deviceDataCount.month, deviceDataCount.day, deviceDataCount.deviceId, deviceDataCount.monitorCode);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            //暂时注释 待部署新的解析服务后 再放开
            if (obj!=null && !string.IsNullOrEmpty(obj.ToString()))
                return (DeviceDataCount)obj;
            else
            {
                DeviceDataCount ddc = _ReportGroupDao.Get(deviceDataCount);
                if (ddc != null)
                    MemcachedClientSatat.getInstance().Add(cacheKey,ddc);
                return ddc;
            }
        }

        /// <summary>
        /// 设置月度的最大值发生时间
        /// </summary>
        /// <param name="deviceDataCount"></param>
        /// <returns></returns>
        public void SetMonthMax(DeviceDataCount deviceDataCount) {
            string cacheKey = CacheKeyUtil.buildDeviceDataCountMonthKey(deviceDataCount.year, deviceDataCount.month, deviceDataCount.deviceId, deviceDataCount.monitorCode);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            DeviceDataCount ddc;
            if (obj == null || string.IsNullOrEmpty(obj.ToString()))
            {
                ddc = _ReportGroupDao.GetMonthMax(deviceDataCount);
                if (ddc != null)
                {
                    if (deviceDataCount.maxValue < ddc.maxValue)
                    {
                        deviceDataCount.maxValue = ddc.maxValue;
                        deviceDataCount.maxTime = ddc.maxTime;
                    }
                }
                mcs.Add(cacheKey, deviceDataCount, DateTime.Now.AddDays(7));
            }
            else {
                ddc = (DeviceDataCount)obj;
                if (deviceDataCount.maxValue > ddc.maxValue)
                {
                    ddc.maxValue = deviceDataCount.maxValue;
                    ddc.maxTime = deviceDataCount.maxTime;
                    MemcachedClientSatat.getInstance().Set(cacheKey, ddc);
                }
            }
        }

        /// <summary>
        /// 设置年度的最大值发生时间
        /// </summary>
        /// <param name="deviceDataCount"></param>
        /// <returns></returns>
        public void SetYearMax(DeviceDataCount deviceDataCount)
        {
            string cacheKey = CacheKeyUtil.buildDeviceDataCountYearKey(deviceDataCount.year, deviceDataCount.deviceId, deviceDataCount.monitorCode);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            DeviceDataCount ddc;
            if (obj == null || string.IsNullOrEmpty(obj.ToString()))
            {
                ddc = _ReportGroupDao.GetYearMax(deviceDataCount);
                if (ddc != null)
                {
                    if (deviceDataCount.maxValue < ddc.maxValue)
                    {
                        deviceDataCount.maxValue = ddc.maxValue;
                        deviceDataCount.maxTime = ddc.maxTime;
             
                    }
                }
                MemcachedClientSatat.getInstance().Add(cacheKey, deviceDataCount, DateTime.Now.AddDays(7));
            }
            else
            {
                ddc = (DeviceDataCount)obj;
                if (deviceDataCount.maxValue > ddc.maxValue)
                {
                    ddc.maxValue = deviceDataCount.maxValue;
                    ddc.maxTime = deviceDataCount.maxTime;
                    MemcachedClientSatat.getInstance().Set(cacheKey, ddc);
                }
            }
        }

        /// <summary>
        /// 取得月度的最大值发生时间
        /// </summary>
        /// <param name="deviceDataCount"></param>
        /// <returns></returns>
        public DeviceDataCount GetMonthMax(DeviceDataCount deviceDataCount)
        {
            string cacheKey = CacheKeyUtil.buildDeviceDataCountMonthKey(deviceDataCount.year, deviceDataCount.month, deviceDataCount.deviceId, deviceDataCount.monitorCode);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            if (obj == null || string.IsNullOrEmpty(obj.ToString()))
            {
                DeviceDataCount ddc = _ReportGroupDao.GetMonthMax(deviceDataCount);
                if (ddc != null)
                {
                    MemcachedClientSatat.getInstance().Add(cacheKey, ddc);
                }
                return ddc;
            }
            else
            {
                return (DeviceDataCount)obj;
            }
        }

        /// <summary>
        /// 取得年度的最大值发生时间
        /// </summary>
        /// <param name="deviceDataCount"></param>
        /// <returns></returns>
        public DeviceDataCount GetYearMax(DeviceDataCount deviceDataCount) {
            string cacheKey = CacheKeyUtil.buildDeviceDataCountYearKey(deviceDataCount.year, deviceDataCount.deviceId, deviceDataCount.monitorCode);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            if (obj == null || string.IsNullOrEmpty(obj.ToString()))
            {
                DeviceDataCount ddc = _ReportGroupDao.GetYearMax(deviceDataCount);
                if (ddc != null)
                {
                    MemcachedClientSatat.getInstance().Add(cacheKey, ddc);
                }
                return ddc;
            }
            else
            {
                return (DeviceDataCount)obj;
            }
        }
    }
}
