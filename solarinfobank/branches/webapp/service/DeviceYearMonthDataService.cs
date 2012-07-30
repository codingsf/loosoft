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
    public  class DeviceYearMonthDataService
    {

        private static IList<string> persistentListKey = new List<string>();
        private static DeviceYearMonthDataService _instance;
        private IDaoManager _daoManager = null;
        private IDeviceYearMonthDataDao _DeviceYearDataDao = null;

        private DeviceYearMonthDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _DeviceYearDataDao = _daoManager.GetDao(typeof(IDeviceYearMonthDataDao)) as IDeviceYearMonthDataDao;
        }

        public static DeviceYearMonthDataService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new DeviceYearMonthDataService();
            }
            return _instance;
        }

        /// <summary>
        /// 取得单个设备的跨月度发电量
        /// </summary>
        /// <param name="device"></param>
        /// <param name="startYear"></param>
        /// <param name="endYear"></param>
        /// <returns></returns>
        public Hashtable GetDeviceBetweenYearData(Device device, int startYear, int endYear)
        {
            return this.GetDeviceBetweenYearData(new List<Device>() { device }, startYear, endYear, new List<float>() { 1.0F});
        }

        /// <summary>
        /// 取得多个设备的跨月度累加发电量
        /// </summary>
        /// <param name="devices">设备列表</param>
        /// <param name="startYear"></param>
        /// <param name="endYear"></param>
        /// <returns></returns>
        public Hashtable GetDeviceBetweenYearData(IList<Device> devices, int startYear, int endYear, IList<float> rates)
        {
            Hashtable monthDataMap = new Hashtable();
            Device device;
            for (int i=0;i<devices.Count;i++)
            {
                device = devices[i];
                IList<DeviceYearMonthData> inverterYearDatas = this._DeviceYearDataDao.GetDeviceBetweenYearData(device.id, startYear, endYear);
                DeviceYearMonthData cacheDymd;
                foreach (DeviceYearMonthData inverterYearData in inverterYearDatas)
                {
                    cacheDymd = getDeviceYearMonthDataWithCache(inverterYearData.deviceID, inverterYearData.year);
                    if (cacheDymd == null)
                        putMonthMap(monthDataMap, inverterYearData, rates[i]);
                    else
                        putMonthMap(monthDataMap, cacheDymd, rates[i]);
                }
            }
            
            return monthDataMap;
        }


        //从缓存中取得对象
        private DeviceYearMonthData getDeviceYearMonthDataWithCache(int deviceId, int year)
        {
            string cacheKey = CacheKeyUtil.buildDeviceEnergyYearCountKey(deviceId, year);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            if (obj != null)
            {
                return (DeviceYearMonthData)obj;
            }
            return null;
        }

        /// <summary>
        /// 将各个月度数据付给map
        /// </summary>
        /// <param name="monthDataMap"></param>
        /// <param name="inverterYearData"></param>
        private void putMonthMap(Hashtable monthDataMap, DeviceYearMonthData yearData ,float rate)
        {
            string yyyy = yearData.year.ToString();
            for (int i = 1; i <= 12; i++)
            {
                string key = yyyy + TableUtil.convertIntToMnthStr(i);
                System.Object obj = monthDataMap[key];

                object tmpvalue = yearData.GetType().GetProperty("m_" + i).GetValue(yearData, null);
                float value = tmpvalue == null ? 0 : StringUtil.stringtoFloat(tmpvalue.ToString());
                if (obj != null || tmpvalue != null)
                    monthDataMap[key] = (obj == null ? 0 : StringUtil.stringtoFloat(obj.ToString())) + value * rate;
            }
        }


        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站Id获得工作年份
        /// 创建时间：2011-02-25
        /// </summary>
        /// <param name="plantId"></param>
        /// <returns></returns>
        public IList<int> GetWorkYears(Device device)
        {
            IList<int> yearList = new List<int>();
      
            int minYear = _DeviceYearDataDao.GetStartWorkYear(device.id);
            for (int year = minYear; year <= DateTime.Now.Year; year++)
            {
                yearList.Add(year);
            }
            return yearList;
        }

        /// <summary>
        /// 保存设备年月数据
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        public void SaveDeviceYearMonthData( string d_Column, double d_Value, int deviceID, int year)
        {
            DeviceYearMonthData deviceYearMonthData = GetDeviceYearMonthData(deviceID, year);
            if (deviceYearMonthData != null)
            {
                _DeviceYearDataDao.UpdateDeviceYearMonthData(d_Column, d_Value, deviceYearMonthData.id);
            }
            else
            {
                _DeviceYearDataDao.InsertDeviceYearMonthData(d_Column, d_Value, deviceID, year);
            }
        }

        /// <summary>
        /// 取得年月发电量数据，经过缓存
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public DeviceYearMonthData GetDeviceYearMonthData(int deviceID, int year)
        {
            string cacheKey = CacheKeyUtil.buildDeviceEnergyYearCountKey(deviceID, year);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);

            DeviceYearMonthData deviceYearMonthData;
            if (obj == null)
            {//从数据库中取得
                deviceYearMonthData = _DeviceYearDataDao.GetDeviceYearMonthData(deviceID, year);
                if (deviceYearMonthData == null)//构造一个新实例
                    deviceYearMonthData = new DeviceYearMonthData() {  year = year, deviceID = deviceID};
                deviceYearMonthData.localAcceptTime = DateTime.Now;
                MemcachedClientSatat.getInstance().Set(cacheKey, deviceYearMonthData);
            }
            else
                deviceYearMonthData = (DeviceYearMonthData)obj;

            return deviceYearMonthData;
        }

        /// <summary>
        /// 放入缓存
        /// </summary>
        /// <param name="deviceYearMonthData"></param>
        public void Cache(DeviceYearMonthData deviceYearMonthData)
        {
            string cacheKey = CacheKeyUtil.buildDeviceEnergyYearCountKey(deviceYearMonthData.deviceID, deviceYearMonthData.year);

            if (!persistentListKey.Contains(cacheKey)) persistentListKey.Add(cacheKey);
            //一年3天后过期
            MemcachedClientSatat.getInstance().Set(cacheKey, deviceYearMonthData, DateTime.Now.AddYears(1).AddDays(3));
        }

        /// <summary>
        /// 从缓存中批量持久化数据
        /// </summary>
        public void batchSave()
        {
            DeviceYearMonthData energyData;
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = MemcachedClientSatat.getInstance().Get(key);
                if (obj == null)
                {
                    LogUtil.warn(key + "in cache is empty of dvice year month data ");
                    continue;
                }
                energyData = (DeviceYearMonthData)obj;
                string _Column = "m_" + energyData.curMonth;
                float _value = (float)ReflectionUtil.getProperty(energyData, _Column);
                if (energyData.id >0)
                {
                    _DeviceYearDataDao.UpdateDeviceYearMonthData(_Column, _value, energyData.id);
                }
                else
                {
                    _DeviceYearDataDao.InsertDeviceYearMonthData(_Column, _value, energyData.deviceID, energyData.year);
                    energyData.id = _DeviceYearDataDao.GetDeviceYearMonthData(energyData.deviceID, energyData.year).id;
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
