using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：单元各测点年度数据统计
    /// 创建时间：2011-02-22
    /// </summary>
    public class CollectorYearDataService
    {
        private static IList<string> persistentListKey = new List<string>();
        private static CollectorYearDataService _instance = new CollectorYearDataService();
        private IDaoManager _daoManager = null;
        private ICollectorYearDataDao _plantTotalDataDao = null;

        private CollectorYearDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _plantTotalDataDao = _daoManager.GetDao(typeof(ICollectorYearDataDao)) as ICollectorYearDataDao;
        }

        public static CollectorYearDataService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 作者：张月
        /// 功能：通过单元取得各年度的发电量
        /// 时间：2011年2月22日 20:11:33
        /// </summary>
        /// <param name="plantUnit">单元</param>
        /// <returns>电站总量列表</returns>
        public Hashtable GetYearDatasByUnits(IList<PlantUnit> plantUnits)
        {
            Hashtable yearDataMap = new Hashtable();
            string key = "";
            foreach (PlantUnit unit in plantUnits)
            {
                IList<CollectorYearData> unitTotalDatas = _plantTotalDataDao.GetListByCollectorID(unit.collector.id);
                foreach (CollectorYearData unitTotalData in unitTotalDatas)
                {
                    key = unitTotalData.year.ToString();
                    System.Object obj = yearDataMap[key];
                    if (obj == null)
                    {
                        obj = 0;
                    }
                    yearDataMap[key] = StringUtil.stringtoFloat(obj.ToString()) + unitTotalData.dataValue;
                }
            }
            return yearDataMap;
        }



        /// <summary>
        /// 取得电站列表的所有单元列表
        /// </summary>
        /// <param name="plantList"></param>
        /// <returns></returns>
        private IList<PlantUnit> getUnitsByPlantList(IList<Plant> plantList)
        {
            IList<PlantUnit> units = new List<PlantUnit>();
            foreach (Plant plant in plantList)
            {
                IList<PlantUnit> tmpunits = plant.plantUnits;
                if (tmpunits == null)
                    break;
                foreach (PlantUnit unit in tmpunits)
                {
                    units.Add(unit);
                }
            }
            return units;
        }

        public IList<int> GetWorkYears(Plant plant)
        {
            return this.GetWorkYears(new List<Plant>{plant});
        }


        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站Id获得工作年份
        /// 创建时间：2011-02-25
        /// </summary>
        /// <param name="plantId"></param>
        /// <returns></returns>
        public IList<int> GetWorkYears(IList<Plant> plantList)
        {
            IList<int> yearList = new List<int>();
            IList<PlantUnit> units = getUnitsByPlantList(plantList);

            if (units.Count < 1) return yearList;
            int minYear = _plantTotalDataDao.GetStartWorkYear(units);
            if (minYear == 0) return yearList;
            for (int year = minYear; year <= DateTime.Now.Year; year++)
            {
                yearList.Add(year);
            }
            return yearList;
        }

        /// <summary>
        /// 保存年度数据
        /// </summary>
        /// <param name="yeardata"></param>
        public void SaveTotalData(CollectorYearData yeardata)
        {
            CollectorYearData data = GetCollectorYearData(yeardata.collectorID, yeardata.year);
            if (null == data)
            {
                _plantTotalDataDao.Insert(yeardata);
            }
            else
            {
                yeardata.id = data.id;
                _plantTotalDataDao.Update(yeardata);
            }
        }

        /// <summary>
        /// 判断
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public CollectorYearData GetCollectorYearData(int collectorID, int year)
        {
            string cacheKey = CacheKeyUtil.buildCollectorEnergyTotalCountKey(collectorID, year);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);

            CollectorYearData deviceYearData;
            if (obj == null)
            {//从数据库中取得
                deviceYearData = _plantTotalDataDao.GetCollectorYearData(collectorID, year);
                if (deviceYearData == null)//构造一个新实例
                    deviceYearData = new CollectorYearData() { year = year, collectorID = collectorID, dataValue = 0 };
                deviceYearData.localAcceptTime = DateTime.Now;
                MemcachedClientSatat.getInstance().Set(cacheKey, deviceYearData);
            }
            else
                deviceYearData = (CollectorYearData)obj;

            return deviceYearData;
        }

        /// <summary>
        /// 放入缓存
        /// </summary>
        /// <param name="collectorYearData"></param>
        public void Cache(CollectorYearData collectorYearData)
        {
            string cacheKey = CacheKeyUtil.buildCollectorEnergyTotalCountKey(collectorYearData.collectorID, collectorYearData.year);

            if (!persistentListKey.Contains(cacheKey)) persistentListKey.Add(cacheKey);
            MemcachedClientSatat.getInstance().Set(cacheKey, collectorYearData);
        }

        /// <summary>
        /// 从缓存中批量持久化数据
        /// </summary>
        public void batchSave()
        {
            CollectorYearData energyData;
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = MemcachedClientSatat.getInstance().Get(key);
                if (obj == null)
                {
                    LogUtil.warn(key + "in cache is empty of collector year data ");
                    continue;
                }
                energyData = (CollectorYearData)obj;
                if (energyData.id > 0)
                {
                    _plantTotalDataDao.Update(energyData);
                }
                else
                {
                    _plantTotalDataDao.Insert(energyData);
                    MemcachedClientSatat.getInstance().Set(key, energyData);
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
