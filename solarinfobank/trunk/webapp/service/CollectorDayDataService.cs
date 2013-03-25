using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using System.Reflection;
using System.Configuration;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 日功率业务逻辑
    /// 陈波
    /// 2011-2-27
    /// </summary>
    public class CollectorDayDataService : BaseService
    {
        //采集器天数据缓存中key列表
        private static IList<string> persistentListKey = new List<string>();
        private static CollectorDayDataService _instance = new CollectorDayDataService();
        private IDaoManager _daoManager = null;
        private ICollectorDayDataDao _powerDayDataDao = null;

        //保持存在的设备id，因为设备不能删除所以可以list保持
        private static IDictionary<string, int> dayDataIdMap = new Dictionary<string, int>();
        /// <summary>
        /// 天数据保持到数据库间隔，单位小时
        /// </summary>
        private static int CollectorDayDataSaveInterval = ConfigurationSettings.AppSettings["CollectorDayDataSaveInterval"] == null ? 1 : int.Parse(ConfigurationSettings.AppSettings["CollectorDayDataSaveInterval"]);
        /// <summary>
        /// 采集器天数据缓存过期时间，单位小时
        /// </summary>
        private static int CollectorDayData_expireTime = ConfigurationSettings.AppSettings["CollectorDayData_expireTime"] == null ? 1 : int.Parse(ConfigurationSettings.AppSettings["CollectorDayData_expireTime"]);
 
        private CollectorDayDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _powerDayDataDao = _daoManager.GetDao(typeof(ICollectorDayDataDao)) as ICollectorDayDataDao;
        }

        public static CollectorDayDataService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new CollectorDayDataService();
            }
            return _instance;
        }

        /// <summary>
        /// 获取电站日数据信息
        /// </summary>
        /// <param name="dayData"></param>
        /// <returns></returns>
        public CollectorDayData Get(CollectorDayData dayData)
        {
            return _powerDayDataDao.Get(dayData);
        }

        /// <summary>
        /// 删除天数据，按照id 
        /// add by qhb in 20120828 
        /// </summary>
        /// <param name="dayData"></param>
        /// <returns></returns>
        public bool Delete(CollectorDayData dayData)
        {
            return _powerDayDataDao.Remove(dayData)>0?true:false;
        }

        /// <summary>
        /// 仅仅支持跨月度的天直接的测点数据，不能跨多个月度
        /// </summary>
        /// <param name="units">电站单元列表 单个电站使用plant.plantunits取得，对于多个电站可以将多个电站的plantunits进行合并成一个list传入即可</param>
        /// <param name="startYYYYMMDDHH">开始时间 精确到小时 比如：2011062807</param>
        /// <param name="endYYYYMMDDHH">截止时间 精确到小时 比如：2011062817</param>
        /// <param name="intervalMins">数据统计的间隔时间，单位是分钟，比如60表示一小时</param>
        /// <param name="monitorCode">测点代码，参见MonitorType.cs</param> 
        /// <returns></returns>
        public Hashtable GetUnitDaydataList(IList<PlantUnit> units, string startYYYYMMDDHH, string endYYYYMMDDHH, int intervalMins, int monitorCode) {

            return GetUnitDaydataList(null, units, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, monitorCode);
        }

        /// <summary>
        /// 仅仅支持跨月度的天直接的测点数据，不能跨多个月度
        /// </summary>
        /// <param name="XAxis">时间完整的坐标，和间隔有关，用于数据平滑</param> 
        /// <param name="units">电站单元列表 单个电站使用plant.plantunits取得，对于多个电站可以将多个电站的plantunits进行合并成一个list传入即可</param>
        /// <param name="startYYYYMMDDHH">开始时间 精确到小时 比如：2011062807</param>
        /// <param name="endYYYYMMDDHH">截止时间 精确到小时 比如：2011062817</param>
        /// <param name="intervalMins">数据统计的间隔时间，单位是分钟，比如60表示一小时</param>
        /// <param name="monitorCode">测点代码，参见MonitorType.cs</param> 
        /// 
        /// <returns></returns>
        public Hashtable GetUnitDaydataList(IList<string> XAxis, IList<PlantUnit> units, string startYYYYMMDDHH, string endYYYYMMDDHH, int intervalMins, int monitorCode)
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
                return this.getMultiUnitBetweenData(XAxis,units, year, month, startDD, endDD, intervalMins, monitorCode);
            }
            else
            {
                string year = startYYYYMM.Substring(0, 4);
                string month = startYYYYMM.Substring(4, 2);
                int firstEndDD = CalenderUtil.getMonthDays(year + month);
                Hashtable firstHash = this.getMultiUnitBetweenData(XAxis, units, year, month, startDD, firstEndDD, intervalMins, monitorCode);
                year = endYYYYMM.Substring(0, 4);
                month = endYYYYMM.Substring(4, 2);
                Hashtable secondHash = this.getMultiUnitBetweenData(XAxis,units, year, month, 1, endDD, intervalMins, monitorCode);
                foreach(Object obj in secondHash.Keys){
                    firstHash.Add(obj, secondHash[obj]);
                }
                return firstHash;
            }
        }

        /// <summary>
        /// 取得多个单元跨天的功率
        /// </summary>
        /// <param name="units"></param>
        /// <param name="startYYYYMM"></param>
        /// <param name="startDD"></param>
        /// <param name="endDD"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        private Hashtable getMultiUnitBetweenData(IList<string> XAxis, IList<PlantUnit> units, string year, string month, int startDD, int endDD, int intervalMins, int monitorCode)
        {
            Hashtable hhpowerHash = new Hashtable();
            foreach (PlantUnit unit in units)
            {
                //取得单个单元功率数据
                //如果查询天和当前时间间隔2天之内，包括2天则从数据库先缓存中查询
                bool isDB = true ;
                for (int i = startDD; i <= endDD; i++)
                {
                    IList unitPowerDayDatas = new List<CollectorDayData>();
                    if (DateTime.Now.Day >= i && DateTime.Now.Day - i <= 1)
                    {
                        string key = CacheKeyUtil.buildCollectorDayDataKey(unit.collector.id, year + month, i, monitorCode);
                        object obj = mcs.Get(key);
                        if (obj != null)
                        {
                            unitPowerDayDatas.Add(obj);
                            isDB = false;
                        }
                    }
                    if(isDB)
                        unitPowerDayDatas = _powerDayDataDao.GetCollectorDaydataList(unit.collector.id, year, month, i, i, monitorCode);

                    joinToPointData(XAxis, hhpowerHash, unitPowerDayDatas, intervalMins, monitorCode);
                }
            }
            return hhpowerHash;
        }

        /// <summary>
        /// 将采集器天数据批量加入缓存
        /// 由于输入的对象开始经过缓存和数据取得了，所以这时直接放入缓存即可
        /// </summary>
        /// <param name="collectorDayDatas"></param>
        public void batchToCache(IDictionary<string, CollectorDayData> collectordayDataMap)
        {
            string cachekey = string.Empty;
            CollectorDayData collectorDayData = null;
            foreach (string key in collectordayDataMap.Keys)
            {
                try{
                    collectorDayData = collectordayDataMap[key];
                    if (!collectorDayData.changed) continue;
                    //加入缓存，设置两天为缓存过期时间，避免时差问题
                    //先判断改数据是否在缓存中存在
                    cachekey = CacheKeyUtil.buildCollectorDayDataKey(collectorDayData.collectorID, collectorDayData.yearmonth, collectorDayData.sendDay, collectorDayData.monitorCode);
                    mcs.Set(cachekey, collectorDayData, DateTime.Now.AddHours(CollectorDayData_expireTime));//过期时间设为两天
                    //标识为需要持久化
                    if (!persistentListKey.Contains(cachekey)) persistentListKey.Add(cachekey);
                    collectorDayData.changed = false;
                }
                catch (Exception onee)
                {
                    LogUtil.writeline("handle one collectordayDataMap of " + key + "error:" + onee.Message);
                }
            }
        }

        /// <summary>
        /// 批量保持单元日数据对象
        /// </summary>
        /// <param name="unitDayDatas"></param>
        public void batchSave(IDictionary<string, CollectorDayData> collectordayDataMap)
        { 
            //从需要持久化的list中取出对象
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = mcs.Get(key);
                if (obj == null)
                {
                    LogUtil.warn(key + "in cache is empty of collector day data ");
                    continue;
                }
                CollectorDayData collectorDayData = (CollectorDayData)obj;

                //持久化到数据库
                if (collectorDayData.id == 0)
                {
                    try
                    {
                        _powerDayDataDao.Insert(collectorDayData);
                        //添加id信息
                        mcs.Set(key, collectorDayData);
                        if (collectordayDataMap.ContainsKey(key))
                            collectordayDataMap[key].id = collectorDayData.id;

                        LogUtil.writeline("insert collector day data succes:" + collectorDayData.monitorCode + "-" + collectorDayData.sendDay);
                    }
                    catch (Exception e)
                    {
                        LogUtil.error("insert collector day data fail:" + e.Message);
                        //添加id信息
                        mcs.Set(key, collectorDayData);
                        if (collectordayDataMap.ContainsKey(key))
                            collectordayDataMap[key].id = collectorDayData.id;
                    }
                }
                else
                {
                    try
                    {
                        _powerDayDataDao.Update(collectorDayData);
                        LogUtil.writeline("update collector day data succes:" + collectorDayData.monitorCode + "-" + collectorDayData.sendDay);
                    }
                    catch (Exception e)
                    {
                        LogUtil.error("update collector day data fail:" + e.Message);
                    }
                }

                //判断是否需要不在持久化了
                if (collectorDayData.localAcceptTime.Day != DateTime.Now.Day)
                    persistentListKey.Remove(key);
                //add by qhb in 20120713 for 持久化完成后从map中删除以防止天数据map愈来愈大，代替clearDayDataMap导致对于历史数据时，会将历史数据删除了，而无法持久化
                collectordayDataMap.Remove(key);
            }
        }

        /// <summary>
        /// 根据设备，测点和天 取得设备数据对象
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="day"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public CollectorDayData getCollectorDayData(int collectorID, int monitorCode, int day, int year, int month)
        {
            string key = CacheKeyUtil.buildCollectorDayDataKey(collectorID, year + month.ToString("00"), day, monitorCode);
            object obj = mcs.Get(key);
            if (obj == null || ((CollectorDayData)obj).id == 0)
                return  _powerDayDataDao.getCollectorDayData(collectorID, monitorCode, day, year + month.ToString("00"));
            else
                return (CollectorDayData)obj;
        }

        /// <summary>
        /// 判读设备和此天的数据是否已经存在，存在后续就要做更新操作了，而非插入
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="day"></param>
        /// <param name="yearmonth"></param>
        /// <returns></returns>
        public IList<int> getCollectorDayDataMonitorCodeList(int collectorID, int day, int year, int month, int mtcount)
        {
            string key = "cddmc_" + collectorID + "_" + day;
            object obj = mcs.Get(key);
            IList<int> mtList;
            if(obj == null){
                mtList = _powerDayDataDao.getCollectorDayDataNums(collectorID, day, year + month.ToString("00"));
                mcs.Add(key, mtList, DateTime.Now.AddDays(1));
            }else{
                mtList = (List<int>)obj;
                if(mtList.Count != mtcount){
                    mtList = _powerDayDataDao.getCollectorDayDataNums(collectorID, day, year + month.ToString("00"));
                    mcs.Set(key, mtList);
                }
            }
            return mtList;
        }
    }
}
