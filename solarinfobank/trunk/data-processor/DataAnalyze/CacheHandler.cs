using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Threading;
using System.Configuration;
namespace DataAnalyze
{
    class CacheHandler
    {
        public static string syndata = ConfigurationSettings.AppSettings["syndata"];//是否同步数据
        private static DateTime lastClear = DateTime.Now; //天数据map上次清理时间
        private static IDictionary<int, DeviceDayDataCacheHandler> cacheDayOjectMap = new Dictionary<int, DeviceDayDataCacheHandler>();

        /// <summary>
        /// 是否还有线程在工作
        /// </summary>
        /// <returns></returns>
        private static bool isWork()
        {
            foreach (DeviceDayDataCacheHandler dp in cacheDayOjectMap.Values)
            {
                if (dp.iswork) return true;
            }
            return false;
        }

        /// <summary>
        /// 将数据放入本地内存中
        /// </summary>
        /// <param name="tcpmessage"></param>
        public static void LocalCacheData(TCPMessage tcpmessage)
        {
            try
            {
                //将采集器天数据批量加入缓存
               tcpmessage.GetCollectorDaydataList();
            }
            catch (Exception e)
            {
                LogUtil.error("Local Cache " + tcpmessage.messageHeader.CollectorCode + " day data error:" + e.Message);
                //tcpmessage.GetCollectorDaydataList();
            }

            try
            {
                //将设备天数据批量放入缓存
                tcpmessage.getDeviceDayDataList();
            }
            catch (Exception e)
            {
                LogUtil.error("Cache " + tcpmessage.messageHeader.CollectorCode + " device day data  error:" + e.Message);
                //tcpmessage.getDeviceDayDataList();
            }

            try
            {
                //缓存采集器实时数据
                tcpmessage.GetCollectorRunData();
            }
            catch (Exception e)
            {
                LogUtil.error("Cache " + tcpmessage.messageHeader.CollectorCode + " run data error:" + e.Message);
            }

            try
            {
                //批量保存设备实时数据到缓存
                tcpmessage.GetDeviceRunDataList();
            }
            catch (Exception e)
            {
                LogUtil.error("Cache " + tcpmessage.messageHeader.CollectorCode + " device run data error:" + e.Message);
            }

            try
            {
                tcpmessage.GetFaultList();
            }
            catch (Exception e)
            {
                LogUtil.info("Cache " + tcpmessage.messageHeader.TimeNow + " fualt error:" + e.Message);
            }
        }

        /// <summary>
        /// 将数据放入缓存
        /// </summary>
        /// <param name="tcpmessage"></param>
        public static void CacheData()
        {
            try
            {
                DateTime curdt = DateTime.Now;
               
                //将采集器天数据批量加入缓存
                CollectorDayDataService.GetInstance().batchToCache(BaseMessage.collectordayDataMap);
                LogUtil.writeline("memcached collectordayDataMap用时：" + (DateTime.Now.Subtract(curdt).TotalSeconds));
            }
            catch (Exception e)
            {
                LogUtil.error("batch Cache day data error:" + e.Message);
            }
            try
            {
                DateTime curdt = DateTime.Now;
                //DeviceDayDataService.GetInstance().batchToCache(BaseMessage.devicedayDataMapList);
                ////将设备天数据批量放入缓存
                DeviceDayDataCacheHandler ddch = null;
                for (int i=0;i<50;i++)
                {
                    if (cacheDayOjectMap.ContainsKey(i))
                        ddch = cacheDayOjectMap[i];
                    else
                    {
                        ddch = new DeviceDayDataCacheHandler(i);
                        cacheDayOjectMap[i] = ddch;
                    }

                    Thread m_thread = new Thread(new ThreadStart(ddch.batchToCacheList));
                    m_thread.Name = "memcache Handel Thread-" + i;
                    m_thread.Start();
                }
                while (isWork())
                {
                    Thread.Sleep(1000);
                }
                LogUtil.writeline("memcached devicedayDataMap用时：" + (DateTime.Now.Subtract(curdt).TotalSeconds));
            }
            catch (Exception e)
            {
                LogUtil.error("batch Cache device day data  error:" + e.Message);
            }

            try
            {
                DateTime curdt = DateTime.Now;
                //缓存采集器实时数据
                CollectorRunDataService.GetInstance().batchCache(BaseMessage.collectorRunDataMap.Values);
                LogUtil.writeline("memcached collectorRunDataMap用时：" + (DateTime.Now.Subtract(curdt).TotalSeconds));
            }
            catch (Exception e)
            {
                LogUtil.error("batch Cache run data error:" + e.Message);
            }

            try
            {
                DateTime curdt = DateTime.Now;
                //批量保存设备实时数据到缓存
                DeviceRunDataService.GetInstance().BatchCache(BaseMessage.deviceRunDataMap.Values);
                LogUtil.writeline("memcached deviceRunDataMap用时：" + (DateTime.Now.Subtract(curdt).TotalSeconds));
            }
            catch (Exception e)
            {
                LogUtil.error("batch Cache device run data error:" + e.Message);
            }

            try
            {
                FaultService.GetInstance().batchSave(BaseMessage.faultList);
                BaseMessage.faultList.Clear();
            }
            catch (Exception e)
            {
                LogUtil.info("batch Cache fualt error:" + e.Message);
            }
            try
            {
                DateTime curdt = DateTime.Now;
                //将设备最大值统计数据放入缓存
                DeviceDataCountService.GetInstance().batchCache(BaseMessage.deviceDataCounts);
                BaseMessage.deviceDataCounts.Clear();
                LogUtil.writeline("memcached deviceDataCounts用时：" + (DateTime.Now.Subtract(curdt).TotalSeconds));
            }
            catch (Exception e)
            {
                LogUtil.error("save max value error:" + e.Message);
            }

            clearDayDataMap();

            //每次缓存后 同时将同步到memcahced
            if (syndata != null && syndata.Equals("true")) {
                SynDataService.GetInstance().synRunData();
            }
        }

        /// <summary>
        /// 清理两天前的天数据map中得对象，否则天数据map会越来越多
        /// </summary>
        private static void clearDayDataMap()
        {
            if (DateTime.Now > lastClear.AddDays(2))
            {
                DateTime compare = DateTime.Now.AddDays(-1);
                string[] keys = BaseMessage.collectordayDataMap.Keys.ToArray();
                foreach (string key in keys)
                {
                    //删除前天的
                    if (BaseMessage.collectordayDataMap[key].sendtime < compare) BaseMessage.collectordayDataMap.Remove(key);
                }

                //从需要持久化的list中取出对象
                String[] keyArr;
                foreach (IDictionary<string, DeviceDayData> datadic in BaseMessage.devicedayDataMapList)
                {
                    keyArr = datadic.Keys.ToArray();
                    foreach (string key in keyArr) {
                        //删除前天的
                        if (datadic[key].sendtime < compare) datadic.Remove(key);
                    }
                }
                lastClear = DateTime.Now;
            }
        }

        /// <summary>
        /// 将采集器和个设备的发电量数据进行统计后放入环境对象中
        /// </summary>
        /// <param name="tcpmessage"></param>
        public static void CacheCountData(IDictionary<string, double> deviceEnergyMap, IDictionary<string, double> collectorEnergyMap)
        {
            try
            {
                CacheDeviceEnergyData(deviceEnergyMap);
                deviceEnergyMap.Clear();
            }
            catch (Exception e)
            {
                LogUtil.error("Cache Device Energy Count Data error :" + e.Message);
            }
            try
            {
                CacheCollectorEnergyData(collectorEnergyMap);
                collectorEnergyMap.Clear();
            }
            catch (Exception e)
            {
                LogUtil.error("Cache Collector Energy Count Data error :" + e.Message);
            }
        }

        /// <summary>
        /// 缓存设备发电量统计
        /// 要进行修正缓存丢失
        /// </summary>
        /// <param name="tcpmessage"></param>
        private static void CacheDeviceEnergyData(IDictionary<string, double> deviceEnergyMap)
        {
            int deviceID;
            string yearMonth;
            int year;
            int month;
            int day;
            float? data;
            //string[] keys = deviceEnergyMap.Keys.ToArray();
            foreach (string ekey in deviceEnergyMap.Keys)
            {
                deviceID = int.Parse(ekey.Split(':')[0]);
                yearMonth = ekey.Split(':')[1];
                year = int.Parse(yearMonth.Substring(0, 4));
                month = int.Parse(yearMonth.Substring(4, 2));
                day = int.Parse(yearMonth.Substring(6, 2));
                data = float.Parse(deviceEnergyMap[ekey].ToString());
                string d_column = "d_" + day;

                //取得月天数据对象
                DeviceMonthDayData deviceMonthDayData = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(year, deviceID, month);
                deviceMonthDayData.curDay = day;
                //给相应属性赋值
                if (deviceMonthDayData != null)
                {
                    object ovalue = ReflectionUtil.getProperty(deviceMonthDayData, d_column);
                    if (ovalue == null || float.Parse(ovalue.ToString()) < data)
                    {
                        ReflectionUtil.setProperty(deviceMonthDayData, d_column, data);
                    }
                }
                DeviceMonthDayDataService.GetInstance().Cache(deviceMonthDayData);

                //更新年月发电量数据
                //统计年月
                string m_column = "m_" + month;
                float? m_value = deviceMonthDayData.count();
                DeviceYearMonthData ymdData = DeviceYearMonthDataService.GetInstance().GetDeviceYearMonthData(deviceID, year);
                ymdData.curMonth = month;
                //给年月数据对象相应属性赋值
                if (ymdData != null)
                {
                    object ovalue = ReflectionUtil.getProperty(ymdData, m_column);
                    if (ovalue == null || float.Parse(ovalue.ToString()) < m_value)
                    {
                        ReflectionUtil.setProperty(ymdData, m_column, m_value);
                    }
                }
                DeviceYearMonthDataService.GetInstance().Cache(ymdData);

                //统计总体发电量
                float? y_value = ymdData.count();
                DeviceYearData yd = DeviceYearDataService.GetInstance().GetDeviceYearData(deviceID, year);
                if (yd == null) yd = new DeviceYearData() { dataValue = 0, deviceID = deviceID, year = year };
                yd.localAcceptTime = DateTime.Now;
                //给年月数据对象相应属性赋值
                if (yd != null)
                {
                    object ovalue = yd.dataValue;
                    if (ovalue == null || float.Parse(ovalue.ToString()) < y_value)
                    {
                        yd.dataValue = y_value == null ? 0 : float.Parse(y_value.ToString());
                    }
                }
                DeviceYearDataService.GetInstance().Cache(yd);
            }
        }

        /// <summary>
        /// 缓存采集器发电量统计
        /// 要进行修正缓存丢失
        /// 
        /// </summary>
        /// <param name="tcpmessage"></param>
        private static void CacheCollectorEnergyData(IDictionary<string, double> collectorEnergyMap)
        {
            int collectorID;
            string[] keyArr;
            int year;
            int month;
            int day;
            float? data;
            Collector collector = null;
            //string[] keys = collectorEnergyMap.Keys.ToArray();
            foreach (string ekey in collectorEnergyMap.Keys)
            {
                //原来是通过消息头部取得，现在改为
                //data = float.Parse(collectorEnergyMap[ekey].ToString());
                //现在改为通过采集器的设备的今日电量来累加
                keyArr = ekey.Split(':');
                collectorID = int.Parse(keyArr[0]);
                collector = CollectorInfoService.GetInstance().Get(collectorID);
                if (keyArr.Length<4 || (string.IsNullOrEmpty(keyArr[1]) || string.IsNullOrEmpty(keyArr[2]) || string.IsNullOrEmpty(keyArr[3]))) continue;
                data = collector.TodayEnergy(keyArr[1] + keyArr[2] + keyArr[3]);

                //改为通过所含设备的
                year = int.Parse(keyArr[1]);
                month = int.Parse(keyArr[2]);
                day = int.Parse(keyArr[3]);
                string d_column = "d_" + day;

                //取得月天数据对象
                CollectorMonthDayData collectorMonthDayData = CollectorMonthDayDataService.GetInstance().GetCollectorMonthDayData(year, collectorID, month);
                collectorMonthDayData.curDay = day;
                //给相应属性赋值
                if (collectorMonthDayData != null)
                {
                    object ovalue = ReflectionUtil.getProperty(collectorMonthDayData, d_column);
                    //if (ovalue == null || float.Parse(ovalue.ToString()) < data)
                    //{
                        ReflectionUtil.setProperty(collectorMonthDayData, d_column, data);
                    //}
                }
                CollectorMonthDayDataService.GetInstance().Cache(collectorMonthDayData);

                //更新年月发电量数据
                //统计年月
                string m_column = "m_" + month;
                float? m_value = collectorMonthDayData.count();
                CollectorYearMonthData ymdData = CollectorYearMonthDataService.GetInstance().GetCollectorYearMonthData(collectorID, year); ;
                ymdData.curMonth = month;
                //给年月数据对象相应属性赋值
                if (ymdData != null)
                {
                    object ovalue = ReflectionUtil.getProperty(ymdData, m_column);
                    if (ovalue == null || float.Parse(ovalue.ToString()) < m_value)
                    {
                        ReflectionUtil.setProperty(ymdData, m_column, m_value);
                    }
                }
                CollectorYearMonthDataService.GetInstance().Cache(ymdData);

                //统计总体发电量
                float? y_value = ymdData.count();
                CollectorYearData yd = CollectorYearDataService.GetInstance().GetCollectorYearData(collectorID, year);
                if (yd == null) yd = new CollectorYearData() { dataValue = 0, collectorID = collectorID, year = year };
                yd.localAcceptTime = DateTime.Now;
                //给年月数据对象相应属性赋值
                if (yd != null)
                {
                    object ovalue = yd.dataValue;
                    if (ovalue == null || float.Parse(ovalue.ToString()) < y_value)
                    {
                        yd.dataValue = y_value == null ? 0 : float.Parse(y_value.ToString());
                    }
                }
                CollectorYearDataService.GetInstance().Cache(yd);
            }
        }
    }


   
    /// <summary>
    /// 设备天数据的多线程cache类
    /// </summary>
    public class DeviceDayDataCacheHandler
    {
        public bool iswork = false;
        private int mtKey;
        public DeviceDayDataCacheHandler(int key) {
            this.mtKey = key;
        }

        /// <summary>
        /// 缓存集合
        /// </summary>
        /// <param name="devicedayDataMapList"></param>
        public void batchToCacheList()
        {
            iswork = true;
            string cachekey = string.Empty;
            IDictionary<string, DeviceDayData> devicedayDataMapList = BaseMessage.devicedayDataMapList[mtKey];
            DeviceDayData dayData = null;
            ICollection<string> keys;
            try
            {
                keys = devicedayDataMapList.Keys.ToArray();
            }
            catch (Exception ee) {
                LogUtil.error(ee.Message);
                return;
            }

            foreach (string key in keys)
            {
                if (key == null || !devicedayDataMapList.ContainsKey(key)) continue;
                dayData = devicedayDataMapList[key];
                if (dayData == null || !dayData.changed) continue;
                //加入缓存，设置两天为缓存过期时间，避免时差问题
                cachekey = CacheKeyUtil.buildDeviceDayDataKey(dayData.deviceID, dayData.yearmonth, dayData.sendDay, dayData.monitorCode);
                MemcachedClientSatat.getInstance().Set(cachekey, dayData, DateTime.Now.AddDays(2));
                //这里当数量大得时候，list结构插入很慢
                //if (!DeviceDayDataService.persistentListKey.Contains(cachekey)) DeviceDayDataService.persistentListKey.Add(cachekey);
                //dayData.changed = false;
            }
            iswork=false;
        }
    }
}
