using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;


namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    
    /// <summary>
    /// 作者：鄢睿
    /// 功能：设备实时数据业务逻辑
    /// 创建时间：2011年02月22日
    /// </summary>
    public class DeviceRunDataService:BaseService
    {
        //采集器天数据缓存中key列表
        private static IList<string> persistentListKey = new List<string>();
        private static DeviceRunDataService _instance = new DeviceRunDataService();
        private IDaoManager _daoManager = null;
        private IDeviceRunDataDao _deviceRunDataDao = null;
        //保持存在的设备id，因为设备不能删除所以可以list保持
        private static IList<int> deviceIdList = new List<int>();
    
        private DeviceRunDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _deviceRunDataDao = _daoManager.GetDao(typeof(IDeviceRunDataDao)) as IDeviceRunDataDao;
        }

        public static DeviceRunDataService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new DeviceRunDataService();
            }
            return _instance;
        }

        /// <summary>
        /// 判断设备对应的实时数据是否存在
        /// </summary>
        /// <param name="rundata"></param>
        /// <returns></returns>
        private bool ExistDeviceRunData(DeviceRunData rundata){
            if(deviceIdList.Contains(rundata.deviceID))
                return true;
            else{
                DeviceRunData tmp = _deviceRunDataDao.Get(rundata);
                if(tmp == null)return false;
                deviceIdList.Add(tmp.deviceID);
                return true;
            }
        }

        /// <summary>
        /// 批量保存设备实时数据到缓存
        /// 同时累计今日发电量
        /// </summary>
        /// <param name="deviceRunDatas"></param>
        public void BatchCache(ICollection<DeviceRunData> deviceRunDatas)
        {
            string key;
            float todayTotalEnergy = 0;
            int curDay = DateTime.Now.Day;
            foreach (DeviceRunData runData in deviceRunDatas)
            {
                try
                {
                    //统计所有的，不管值是否有变化
                    if (runData.updateTime.Day == curDay)
                        todayTotalEnergy += runData.todayEnergy;

                    if (!runData.changed) continue;
                    key = CacheKeyUtil.buildDeviceRunDataKey(runData.deviceID);
                    //直接更新缓存即可
                    mcs.Set(key, runData);

                    //要放到缓存后面，避免持久化线程持久化一个空对象
                    if (key != null && !persistentListKey.Contains(key)) persistentListKey.Add(key);
                    runData.changed = false;
                }
                catch (Exception onee)
                {
                    LogUtil.writeline("handle one runData of " + runData.deviceID + "error:" + onee.Message);
                }
            }
            mcs.Set(CacheKeyUtil.buildTodayTotalEnergy(), todayTotalEnergy.ToString());
            LogUtil.writeline("todayTotalEnergy is :" + todayTotalEnergy.ToString());
        }

        /// <summary>
        /// 判断采集器对应的实时数据是否存在
        /// </summary>
        /// <param name="rundata"></param>
        /// <returns></returns>
        private bool ExistRunData(DeviceRunData rundata)
        {
            if (deviceIdList.Contains(rundata.deviceID))
                return true;
            else
            {
                //LogUtil.writeline("get  collector Run Data" + rundata.collectorID);
                DeviceRunData tmp = _deviceRunDataDao.Get(rundata);
                if (tmp == null) return false;
                deviceIdList.Add(tmp.deviceID);
                return true;
            }
        }

        /// <summary>
        /// 保存设备实时数据
        /// </summary>
        /// <param name="runData"></param>
        public void save(DeviceRunData runData)
        {
            if (runData == null) return;
            if (ExistRunData(runData))
            {
                _deviceRunDataDao.Update(runData);
            }
            else
            {
                _deviceRunDataDao.Insert(runData);
            }
        }

        /// <summary>
        /// 从缓存中批量持久化实时数据
        /// </summary>
        public void batchSave()
        {
            DeviceRunData runData;
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = mcs.Get(key);
                if (obj == null)
                {
                    LogUtil.warn(key + "in cache is empty of device run data ");
                    continue;
                }
                runData = (DeviceRunData)obj;
                try
                {
                    if (ExistDeviceRunData(runData))
                    {
                        _deviceRunDataDao.Update(runData);
                    }
                    else
                    {
                        _deviceRunDataDao.Insert(runData);
                        mcs.Set(key, runData);
                    }
                }
                catch (Exception e) {
                    LogUtil.error("save device run data:" + e.Message);
                }
            }
        }
        /// <summary>
        /// 取得所有设备总发电量
        /// </summary>
        /// <returns></returns>
        public float GetAllTotalEnergy() {
            return _deviceRunDataDao.GetAllTotalEnergy();
        }

    }
}
