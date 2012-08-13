using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class CollectorRunDataService : BaseService
    {

        //采集器实时缓存中key列表
        private static IList<string> persistentListKey = new List<string>();
        private static CollectorRunDataService _instance = new CollectorRunDataService();
        private IDaoManager _daoManager = null;
        private ICollectorRunDataDao _plantRunDataDao = null;
        //保持存在的采集器id，因为设备不能删除所以可以list保持
        private static IList<int> collectorIdList = new List<int>();

        private CollectorRunDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _plantRunDataDao = _daoManager.GetDao(typeof(ICollectorRunDataDao)) as ICollectorRunDataDao;
        }

        public static CollectorRunDataService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new CollectorRunDataService();
            }
            return _instance;
        }

        /// <summary>
        /// 取得采集器的实时数据
        /// </summary>
        /// <param name="collectorID"></param>
        /// <returns></returns>
        public CollectorRunData Get(int collectorID)
        {
            string cacheKey = CacheKeyUtil.buildCollectorRunDataKey(collectorID);
            object obj  = MemcachedClientSatat.getInstance().Get(cacheKey);
            if (obj == null)
            {
                return _plantRunDataDao.Get(new CollectorRunData() { collectorID = collectorID });
            }
            else {
                return (CollectorRunData)obj;
            }
        }

        /// <summary>
        /// 判断采集器对应的实时数据是否存在
        /// </summary>
        /// <param name="rundata"></param>
        /// <returns></returns>
        private bool ExistCollectorRunData(CollectorRunData rundata)
        {
            if (collectorIdList.Contains(rundata.collectorID))
                return true;
            else
            {
                //LogUtil.writeline("get  collector Run Data" + rundata.collectorID);
                CollectorRunData tmp = _plantRunDataDao.Get(rundata);
                if (tmp == null) return false;
                collectorIdList.Add(tmp.collectorID);
                return true;
            }
        }

        /// <summary>
        /// 保存采集器实时数据
        /// </summary>
        /// <param name="runData"></param>
        public void save(CollectorRunData runData)
        {
            if (runData == null) return;
            if (ExistCollectorRunData(runData))
            {
                _plantRunDataDao.Update(runData);
            }
            else {
                _plantRunDataDao.Insert(runData);
            }
        }


        /// <summary>
        /// 从缓存中批量持久化实时数据
        /// </summary>
        public void batchSave()
        {
            CollectorRunData runData;
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = mcs.Get(key);
                if (obj == null)
                {
                    LogUtil.warn(key+"in cache is empty of collector run data ");
                    continue;
                }
                runData = (CollectorRunData)obj;
                try
                {
                    if (ExistCollectorRunData(runData))
                    {
                        LogUtil.writeline("update  collector Run Data" + runData.collectorID + ",数据发送时间：" + runData.sendTime);
                        _plantRunDataDao.Update(runData);
                    }
                    else
                    {
                        _plantRunDataDao.Insert(runData);
                        LogUtil.writeline("insert  collector Run Data" + runData.collectorID + ",数据发送时间：" + runData.sendTime);
                    }
                }
                catch (Exception e) {
                    LogUtil.error("save collector run data error:" + e.Message);
                }
            }
        }

        /// <summary>
        /// 保存采集器实时数据到缓存
        /// 实时数据直接放入缓存即可
        /// </summary>
        /// <param name="runData"></param>
        public void batchCache(ICollection<CollectorRunData> runDatas)
        {
            //float todayTotalEnergy = 0;          放到设备实时数据那里计算
            int curDay = DateTime.Now.Day;
            LogUtil.writeline("run data num:" + runDatas.Count);
            foreach (CollectorRunData runData in runDatas)
            {
                try{
                    //if (!runData.changed) continue;
                    string key = CacheKeyUtil.buildCollectorRunDataKey(runData.collectorID);
                    //object obj = mcs.Get(key);
                    //CollectorRunData dsrd = runData;
                    //if (obj != null && !string.IsNullOrEmpty(obj.ToString()))//存在即修改
                    //{
                    //    dsrd = (CollectorRunData)obj;
                    //}
                    //else
                    //{
                    //    CollectorRunData crd = CollectorRunDataService.GetInstance().Get(runData.collectorID);
                    //    if (crd != null)
                    //    {
                    //        dsrd = crd;
                    //        mcs.Add(key, crd);
                    //    }
                    //}

                    //实时数据只更新日期为新的
                    //if (runData.sendTime < dsrd.sendTime) return;

                    //bool isSameDay = runData.sendTime.Day == dsrd.sendTime.Day;

                    //float dayEnergy = runData.dayEnergy;
                    //if (!isSameDay || dayEnergy > dsrd.dayEnergy)
                    //    dsrd.dayEnergy = dayEnergy;

                    //float totalEnergy = runData.totalEnergy;
                    //if (totalEnergy > dsrd.totalEnergy)
                    //    dsrd.totalEnergy = totalEnergy;

                    //if (runData.sendTime > dsrd.sendTime)
                    //{
                    //dsrd.sendTime = runData.sendTime;
                    //dsrd.power = runData.power;
                    //}

                    //dsrd.collectorID = runData.collectorID;
                    //dsrd.windSpeed = runData.windSpeed;
                    //dsrd.windDirection = runData.windDirection;
                    //dsrd.temperature = runData.temperature;
                    //dsrd.sunStrength = runData.sunStrength;

                    mcs.Set(key, runData);
                    if (key!=null && !persistentListKey.Contains(key))
                    {
                        //LogUtil.writeline("put key into persistentListKey" + key);
                        persistentListKey.Add(key);
                    }
                    //if (runData.sendTime.Day == curDay)
                    //    todayTotalEnergy += runData.dayEnergy;
                   // runData.changed = false;
                }
                catch (Exception onee)
                {
                    LogUtil.writeline("handle one collector runData of " + runData.collectorID + "error:" + onee.Message);
                }
            }
            //mcs.Set(CacheKeyUtil.buildTodayTotalEnergy(), todayTotalEnergy.ToString());
            //LogUtil.writeline("todayTotalEnergy is :" + todayTotalEnergy.ToString());
        }


        /// <summary>
        /// 功能：查询所有的电站单元日发电量
        /// 作者：陈波
        /// 时间：2011年3月21日 
        /// </summary>
        /// <returns></returns>
        public float GetAllDayEnergy()
        {
            object todayTotalEnergyObj = mcs.Get(CacheKeyUtil.buildTodayTotalEnergy());
            if (todayTotalEnergyObj != null)
            {
                String todayTotalEnergyStr = todayTotalEnergyObj.ToString();
                if (todayTotalEnergyStr.StartsWith(""))
                    todayTotalEnergyStr = todayTotalEnergyStr.Substring(1);
                return float.Parse(todayTotalEnergyStr);
            }
            else
            {
                return _plantRunDataDao.GetAllDayEnergy(DateTime.Now.ToString("yyyyMMdd"));
            }
        }
        /// <summary>
        /// 取得所有电站的实时功率之和
        /// </summary>
        /// <returns></returns>
        public float getAllPower()
        {
            return _plantRunDataDao.GetAllPower(DateTime.Now.ToString("yyyyMMdd"));
        }

    }
}
