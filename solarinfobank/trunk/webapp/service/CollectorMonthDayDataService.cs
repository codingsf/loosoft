using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 单元月天发电量数据业务类
    /// 作者:陈波
    /// 时间:2011-2-25
    /// 
    /// </summary>
    public class CollectorMonthDayDataService
    {

        //设备天数据缓存中key列表
        private static IList<string> persistentListKey = new List<string>();
        private static CollectorMonthDayDataService _instance = new CollectorMonthDayDataService();
        private IDaoManager _daoManager = null;
        private ICollectorMonthDayDataDao _unitMonthDataDao = null;

        private CollectorMonthDayDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _unitMonthDataDao = _daoManager.GetDao(typeof(ICollectorMonthDayDataDao)) as ICollectorMonthDayDataDao;
        }

        public static CollectorMonthDayDataService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 获取电站月数据
        /// 需要传递一个Year 年份
        /// plantId 电站编号
        /// month  月份
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public CollectorMonthDayData Get(CollectorMonthDayData data)
        {
            return _unitMonthDataDao.Get(data);
        }

        /// <summary>
        /// 取得多个单元跨天数据报表
        /// </summary>
        /// <param name="has">unitid,startYear,endYear</param>
        /// <returns>年度数据列表</returns>
        public Hashtable GetUnitBetweenMonthData(IList<PlantUnit> units, string startYearMMDD, string endYearMMDD)
        {
            return unionYearMMDDList(units, startYearMMDD, endYearMMDD);
        }

        /// <summary>
        /// 取得某天的发电量
        /// </summary>
        /// <param name="units"></param>
        /// <param name="yearMMDD"></param>
        /// <returns></returns>
        public float getDayData(IList<PlantUnit> units, string yearMMDD)
        {
            float dayData = 0;
            string day = yearMMDD.Substring(6,2);
            Hashtable dataHash = GetUnitBetweenMonthData(units, yearMMDD, yearMMDD);
            if (dataHash.Count > 0) {
                foreach (object key in dataHash.Keys) {
                    if (key.ToString().EndsWith(day)) {
                        dayData = (float)dataHash[key];
                        break;
                    }
                }
            }
            return dayData;
        }

        /// <summary>
        /// 将所有电站的单元的天发电量累计
        /// </summary>
        /// <param name="plantList"></param>
        /// <param name="startYearMMDD"></param>
        /// <param name="endYearMMDD"></param>
        /// <returns></returns>
        private Hashtable unionYearMMDDList(IList<PlantUnit> units, string startYearMM, string endYearMM)
        {
            Hashtable monthDayDataMap = new Hashtable();
            int startYear = int.Parse(startYearMM.Substring(0, 4));
            int endYear = int.Parse(endYearMM.Substring(0, 4));
            int startMM = int.Parse(startYearMM.Substring(4, 2));
            int endMM = int.Parse(endYearMM.Substring(4, 2));

            foreach (PlantUnit unit in units)
            {
                IList<CollectorMonthDayData> unitMonthDatas = this.GetCollectorBetweenMonthData(unit.collector.id, startYear, endYear, startMM, endMM);

                foreach (CollectorMonthDayData unitMonthData in unitMonthDatas)
                {

                    putMonthDayMap(monthDayDataMap, unitMonthData);
                }
            }
            return monthDayDataMap;
        }

        //从缓存中取得对象
        private CollectorMonthDayData getCollectorMonthDayDataWithCache(int collectorId, int year, int month)
        {
            string cacheKey = CacheKeyUtil.buildCollectorEnergyMonthCountKey(collectorId, year, month);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            if (obj != null)
            {
                return (CollectorMonthDayData)obj;
            }
            return null;
        }
        
        /// <summary>
        /// 将各个月度数据付给map
        /// </summary>
        /// <param name="monthDataMap"></param>
        /// <param name="unitYearData"></param>
        private void putMonthDayMap(Hashtable monthDataMap, CollectorMonthDayData unitMonthData)
        {
            int month = unitMonthData.month;
            int year = unitMonthData.year;

            //使用反射获得对象的号到最后一天的属性值
            int days = CalenderUtil.getMonthDays(year, month);
            for (int i = 1; i <= days; i++)
            {
                string key = year + TableUtil.convertIntToMnthStr(month)+TableUtil.convertIntToMnthStr(i);
                System.Object obj = monthDataMap[key];
                if (obj == null) { obj = 0; }
                object curValue = unitMonthData.GetType().GetProperty("d_" + i).GetValue(unitMonthData, null);
                if(curValue == null)continue;
                float value = float.Parse(curValue.ToString());
                monthDataMap[key] = float.Parse(obj.ToString()) + value;
            }
        }

        /// <summary>
        /// 取得跨月度的月天发电量
        /// </summary>
        /// <param name="unitId">单元id</param>
        /// <param name="startYear">开始年份</param>
        /// <param name="endYear">截至年份</param>
        /// <param name="startMM">开始月</param>
        /// <param name="endMM">截至月</param>
        /// <returns></returns>
        private IList<CollectorMonthDayData> GetCollectorBetweenMonthData(int collectorID, int startYear, int endYear, int startMM, int endMM)
        {
            IList<CollectorMonthDayData> joinres = new List<CollectorMonthDayData>();
            for(int i=0;i<(endYear-startYear+1);i++){
                int tmpYear = startYear+i;
                int tmpStartMM = 1;
                int tmpEndMM = 12;
                if(tmpYear==startYear){
                    tmpStartMM = startMM;
                }
                if(tmpYear == endYear){
                    tmpEndMM = endMM;
                }
                IList<CollectorMonthDayData> unitMonthDatas = _unitMonthDataDao.GetMonthBetweenData(collectorID, tmpYear, tmpStartMM, tmpEndMM);
                CollectorMonthDayData cachecmdd;
                foreach (CollectorMonthDayData unitMonthData in unitMonthDatas)
                {
                    //从缓存中取得数据
                    cachecmdd = this.getCollectorMonthDayDataWithCache(unitMonthData.collectorID, startYear, unitMonthData.month);
                    if (cachecmdd != null)
                    {
                        cachecmdd.year = tmpYear;
                        joinres.Add(cachecmdd);
                    }
                    else
                    {
                        unitMonthData.year = tmpYear;
                        joinres.Add(unitMonthData);
                    }
                }
            }
            return joinres;
        }

        /// <summary>
        /// 保存单个采集器的月天数据
        /// </summary>
        /// <param name="year"></param>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="collectorID"></param>
        /// <param name="month"></param>
        public void SaveCollectorMonthDayData(int year, string d_Column, double d_Value, int collectorID, int month)
        {
            CollectorMonthDayData collectorMonthDayData = GetCollectorMonthDayData(year, collectorID, month);
            if (collectorMonthDayData != null)
            {
                _unitMonthDataDao.UpdateCollectorMonthDayData(year, d_Column, d_Value, collectorMonthDayData.id);
            }
            else
            {

                _unitMonthDataDao.InsertCollectorMonthDayData(d_Column, d_Value, collectorID, year, month);
            }
        }

        /// <summary>
        /// 取得采集器的某个年度和月度的对象
        /// </summary>
        /// <param name="year"></param>
        /// <param name="collectorID"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public CollectorMonthDayData GetCollectorMonthDayData(int year, int collectorID, int month)
        {
            string cacheKey = CacheKeyUtil.buildCollectorEnergyMonthCountKey(collectorID, year, month);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);

            CollectorMonthDayData deviceMonthDayData;
            if (obj != null && !string.IsNullOrEmpty(obj.ToString()))//存在即修改
            {
                deviceMonthDayData = (CollectorMonthDayData)obj;
            }
            else {
                //从数据库中取得
                deviceMonthDayData = _unitMonthDataDao.GetCollectorMonthDayData(year, collectorID, month);
                if (deviceMonthDayData == null)//构造一个新实例
                    deviceMonthDayData = new CollectorMonthDayData() { collectorID = collectorID, year = year, month = month };
                deviceMonthDayData.localAcceptTime = DateTime.Now;
                deviceMonthDayData.year = year;
                MemcachedClientSatat.getInstance().Set(cacheKey, deviceMonthDayData);
            }

            return deviceMonthDayData;
        }

        /// <summary>
        /// 放入缓存
        /// </summary>
        /// <param name="deviceYearData"></param>
        public void Cache(CollectorMonthDayData collectorMonthDayData)
        {
            string cacheKey = CacheKeyUtil.buildCollectorEnergyMonthCountKey(collectorMonthDayData.collectorID, collectorMonthDayData.year, collectorMonthDayData.month);

            if (!persistentListKey.Contains(cacheKey)) persistentListKey.Add(cacheKey);
            //一个月3天后过期
            MemcachedClientSatat.getInstance().Set(cacheKey, collectorMonthDayData, DateTime.Now.AddMonths(1).AddDays(3));

        }

        /// <summary>
        /// 从缓存中批量持久化数据
        /// </summary>
        public void batchSave()
        {
            CollectorMonthDayData energyData;
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = MemcachedClientSatat.getInstance().Get(key);
                if (obj == null)
                {
                    LogUtil.warn(key + "in cache is empty of collector month day  data ");
                    continue;
                }
                energyData = (CollectorMonthDayData)obj;
                string d_Column = "d_" + energyData.curDay;
                float d_value = (float)ReflectionUtil.getProperty(energyData, d_Column);
                try
                {
                    if (energyData.id > 0)
                    {
                        _unitMonthDataDao.UpdateCollectorMonthDayData(energyData.year, d_Column, d_value, energyData.id);
                    }
                    else
                    {
                        _unitMonthDataDao.InsertCollectorMonthDayData(d_Column, d_value, energyData.collectorID, energyData.year, energyData.month);
                        energyData.id = _unitMonthDataDao.GetCollectorMonthDayData(energyData.year, energyData.collectorID, energyData.month).id;
                        MemcachedClientSatat.getInstance().Set(key, energyData);
                    }
                }
                catch (Exception ee) {
                    LogUtil.error("save collector Month day data error:" + ee.Message);
                }
                //判断是否不在持久化
                if (energyData.localAcceptTime.Month != DateTime.Now.Month)
                {
                    energyData.dontPersitent = true;
                    persistentListKey.Remove(key);
                }
            }
        }
    }
}
