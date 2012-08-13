using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：电站年统计业务逻辑类
    /// 创建时间：2011-02-25
    /// </summary>
    public class CollectorYearMonthDataService
    {

        private static IList<string> persistentListKey = new List<string>();
        private static CollectorYearMonthDataService _instance = new CollectorYearMonthDataService();
        private IDaoManager _daoManager = null;
        private ICollectorYearMonthDataDao _plantYearDataDao = null;


        private CollectorYearMonthDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _plantYearDataDao = _daoManager.GetDao(typeof(ICollectorYearMonthDataDao)) as ICollectorYearMonthDataDao;
        }

        public static CollectorYearMonthDataService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new CollectorYearMonthDataService();
            }
            return _instance;
        }

        /// <summary>
        /// 取得多个单元跨月度数据报表
        /// </summary>
        /// <param name="has">unitid,startYear,endYear</param>
        /// <returns>年度数据列表</returns>
        public Hashtable GetUnitBetweenYearData(IList<PlantUnit> units, int startYear, int endYear){
            return unionYearList(units, startYear, endYear);
        }

        /// <summary>
        /// 将所有电站的单元的月度发电量累计
        /// </summary>
        /// <param name="plantList"></param>
        /// <returns></returns>
        private Hashtable unionYearList(IList<PlantUnit> units, int startYear, int endYear)
        {
            Hashtable  monthDataMap = new Hashtable();
            foreach (PlantUnit unit in units)
            {
                IList<CollectorYearMonthData> unitYearDatas = this.GetUnitBetweenYearData(unit, startYear, endYear);
                CollectorYearMonthData cacheCymd;
                foreach (CollectorYearMonthData unitYearData in unitYearDatas)
                {
                    cacheCymd = getCollectorYearMonthDataWithCache(unitYearData.collectorID, unitYearData.year);
                    if (cacheCymd == null)
                        putMonthMap(monthDataMap, unitYearData);
                    else
                        putMonthMap(monthDataMap, cacheCymd);
                }
            }
            return monthDataMap;
        }

        //从缓存中取得对象
        private CollectorYearMonthData getCollectorYearMonthDataWithCache(int collectorId, int year)
        {
            string cacheKey = CacheKeyUtil.buildCollectorEnergyYearCountKey(collectorId, year);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            if (obj != null)
            {
                return (CollectorYearMonthData)obj;
            }
            return null;
        }

        /// <summary>
        /// 将各个月度数据付给map
        /// </summary>
        /// <param name="monthDataMap"></param>
        /// <param name="unitYearData"></param>
        private void putMonthMap(Hashtable monthDataMap, CollectorYearMonthData yearData)
        {
            string yyyy = yearData.year.ToString();
            for (int i = 1; i <= 12; i++)
            {
                string key = yyyy + TableUtil.convertIntToMnthStr(i);
                System.Object obj = monthDataMap[key];

                object tmpvalue = yearData.GetType().GetProperty("m_" + i).GetValue(yearData, null);
                float value = tmpvalue == null ? 0 : float.Parse(tmpvalue.ToString());
                if (obj != null || tmpvalue != null)
                    monthDataMap[key] = (obj == null ? 0 : float.Parse(obj.ToString())) + value;
            }
        }

        /// <summary>
        /// 取得单元跨月度数据报表
        /// </summary>
        /// <param name="has">unitid,startYear,endYear</param>
        /// <returns>年度数据列表</returns>
        public IList<CollectorYearMonthData> GetUnitBetweenYearData(PlantUnit unit, int startYear, int endYear)
        {
            return _plantYearDataDao.GetUnitBetweenYearData(unit, startYear, endYear);
        }

        /// <summary>
        /// 保存设备年月数据
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        public void SaveCollectorYearMonthData(string d_Column, float d_Value, int collectorID, int year)
        {
            CollectorYearMonthData deviceYearMonthData = GetCollectorYearMonthData(collectorID, year);
            if (deviceYearMonthData != null)
            {
                _plantYearDataDao.UpdateCollectorYearMonthData(d_Column, d_Value, deviceYearMonthData.id);
            }
            else
            {
                _plantYearDataDao.InsertCollectorYearMonthData(d_Column, d_Value, collectorID, year);
            }
        }


        /// <summary>
        /// 取得采集器的年月数据对象，经过缓存
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public CollectorYearMonthData GetCollectorYearMonthData(int collectorID, int year)
        {
            string cacheKey = CacheKeyUtil.buildCollectorEnergyYearCountKey(collectorID,year);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);

            CollectorYearMonthData deviceYearMonthData;
            if (obj == null)
            {//从数据库中取得
                deviceYearMonthData = _plantYearDataDao.GetCollectorYearMonthData(collectorID, year);
                if (deviceYearMonthData == null)//构造一个新实例
                    deviceYearMonthData = new CollectorYearMonthData() {  year = year, collectorID =collectorID};
                deviceYearMonthData.localAcceptTime = DateTime.Now;
                MemcachedClientSatat.getInstance().Set(cacheKey, deviceYearMonthData);
            }
            else
                deviceYearMonthData = (CollectorYearMonthData)obj;

            return deviceYearMonthData;
        }

        /// <summary>
        /// 放入缓存
        /// </summary>
        /// <param name="collectorYearMonthData"></param>
        public void Cache(CollectorYearMonthData collectorYearMonthData)
        {
            string cacheKey = CacheKeyUtil.buildCollectorEnergyYearCountKey(collectorYearMonthData.collectorID, collectorYearMonthData.year);

            if (!persistentListKey.Contains(cacheKey)) persistentListKey.Add(cacheKey);
            //一年3天后过期
            MemcachedClientSatat.getInstance().Set(cacheKey, collectorYearMonthData, DateTime.Now.AddYears(1).AddDays(3));

        }

        /// <summary>
        /// 从缓存中批量持久化数据
        /// </summary>
        public void batchSave()
        {
            CollectorYearMonthData energyData;
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = MemcachedClientSatat.getInstance().Get(key);
                if (obj == null)
                {
                    LogUtil.warn(key + "in cache is empty of collector year month data ");
                    continue;
                }
                energyData = (CollectorYearMonthData)obj;
                string m_Column = "m_" + energyData.curMonth;
                float m_value = (float)ReflectionUtil.getProperty(energyData, m_Column);
                try
                {
                    if (energyData.id > 0)
                    {
                        _plantYearDataDao.UpdateCollectorYearMonthData(m_Column, m_value, energyData.id);
                    }
                    else
                    {
                        _plantYearDataDao.InsertCollectorYearMonthData(m_Column, m_value, energyData.collectorID, energyData.year);
                        energyData.id = _plantYearDataDao.GetCollectorYearMonthData(energyData.collectorID, energyData.year).id;
                        MemcachedClientSatat.getInstance().Set(key, energyData);
                    }
                }
                catch (Exception ee) {
                    LogUtil.error("save collector year month data error:" + ee.Message);
                }

                //判断是否不在持久化
                if (energyData.localAcceptTime.Year != DateTime.Now.Year)
                {
                    energyData.dontPersitent = true;
                    persistentListKey.Remove(key);
                }
            }
        }
    }
}
