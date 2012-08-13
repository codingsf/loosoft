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
    /// 功能：设备年度统计数据业务逻辑层
    /// 创建时间：2011-02-22
    /// </summary>
    public class DeviceYearDataService
    {
        //采集器实时缓存中key列表
        private static IList<string> persistentListKey = new List<string>();
        private static DeviceYearDataService _instance = new DeviceYearDataService();
        private IDaoManager _daoManager = null;
        private IDeviceYearDataDao _deviceTotalDataDao = null;

        private DeviceYearDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _deviceTotalDataDao = _daoManager.GetDao(typeof(IDeviceYearDataDao)) as IDeviceYearDataDao;
        }

        public static DeviceYearDataService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 取得单个设备的每个年度的发电量
        /// </summary>
        /// <param name="device"></param>
        /// <returns></returns>
        public Hashtable GetTotalDatasByDevice(Device device)
        {
            return this.GetTotalDatasByDevices(new List<Device>(){device});
        }


        /// <summary>
        /// 根据取得年度发电量包括，逆变器发电量和换检测仪的增量日照强度
        /// </summary>
        /// <param name="devices">设备类别</param>
        /// <returns></returns>
        public Hashtable GetTotalDatasByDevices(IList<Device> devices)
        {

            Hashtable yearDataMap = new Hashtable();
            foreach (Device device in devices)
            {
                IList<DeviceYearData> unitTotalDatas = _deviceTotalDataDao.GetListByDeviceID(device.id);
                foreach (DeviceYearData unitTotalData in unitTotalDatas)
                {
                    System.Object obj = yearDataMap[unitTotalData.year];
                    if (obj == null)
                    {
                        obj = 0;
                    }
                    yearDataMap[unitTotalData.year.ToString()] = (int)obj + unitTotalData.dataValue;
                }
            }
            return yearDataMap;
        }

        //从缓存中取得对象
        private DeviceYearData getDeviceYearDataWithCache(int deviceId, int year)
        {
            string cacheKey = CacheKeyUtil.buildDeviceEnergyTotalCountKey(deviceId, year);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            if (obj != null)
            {
                return (DeviceYearData)obj;
            }
            return null;
        }

        /// <summary>
        /// 保存年度数据
        /// </summary>
        /// <param name="yeardata"></param>
        public void SaveTotalData(DeviceYearData yeardata)
        {
            DeviceYearData data = GetDeviceYearData(yeardata.deviceID, yeardata.year);
            if (null == data)
            {
                _deviceTotalDataDao.Insert(yeardata);
            }
            else
            {
                yeardata.id = data.id;
                _deviceTotalDataDao.Update(yeardata);
            }
        }

        /// <summary>
        /// 判断
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public DeviceYearData GetDeviceYearData(int deviceID, int year)
        {
            string cacheKey = CacheKeyUtil.buildDeviceEnergyTotalCountKey(deviceID, year);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);

            DeviceYearData deviceYearData;
            if (obj == null)
            {//从数据库中取得
                deviceYearData = _deviceTotalDataDao.Get(deviceID, year);
                if (deviceYearData == null)//构造一个新实例
                    deviceYearData = new DeviceYearData() { year = year, deviceID = deviceID , dataValue=0 };
                deviceYearData.localAcceptTime = DateTime.Now;
                MemcachedClientSatat.getInstance().Set(cacheKey, deviceYearData);
            }
            else
                deviceYearData = (DeviceYearData)obj;

            return deviceYearData;
        }

        /// <summary>
        /// 放入缓存
        /// </summary>
        /// <param name="deviceYearData"></param>
        public void Cache(DeviceYearData deviceYearData)
        {
            string cacheKey = CacheKeyUtil.buildDeviceEnergyTotalCountKey(deviceYearData.deviceID, deviceYearData.year);

            if (!persistentListKey.Contains(cacheKey)) persistentListKey.Add(cacheKey);

            MemcachedClientSatat.getInstance().Set(cacheKey, deviceYearData);
            
        }

        /// <summary>
        /// 从缓存中批量持久化数据
        /// </summary>
        public void batchSave()
        {
            DeviceYearData energyData;
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = MemcachedClientSatat.getInstance().Get(key);
                if (obj == null)
                {
                    LogUtil.warn(key + "in cache is empty of collector year data ");
                    continue;
                }
                energyData = (DeviceYearData)obj;
                try
                {
                    if (energyData.id > 0)
                    {
                        _deviceTotalDataDao.Update(energyData);
                    }
                    else
                    {
                        _deviceTotalDataDao.Insert(energyData);
                        MemcachedClientSatat.getInstance().Set(key, energyData);
                    }
                }
                catch (Exception ee) {
                    LogUtil.error("save device year data error:" + ee.Message);
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
