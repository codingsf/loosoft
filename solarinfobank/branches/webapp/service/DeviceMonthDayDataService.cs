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
    public class DeviceMonthDayDataService
    {
        //设备天数据缓存中key列表
        private static IList<string> persistentListKey = new List<string>();

        private static DeviceMonthDayDataService _instance;
        private IDaoManager _daoManager = null;
        private IDeviceMonthDayDataDao _DeviceMonthDataDao = null;

        private DeviceMonthDayDataService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _DeviceMonthDataDao = _daoManager.GetDao(typeof(IDeviceMonthDayDataDao)) as IDeviceMonthDayDataDao;
        }

        public static DeviceMonthDayDataService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new DeviceMonthDayDataService();
            }
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
        public DeviceMonthDayData Get(DeviceMonthDayData data)
        {
            return _DeviceMonthDataDao.Get(data);
        }

        /// <summary>
        /// 取得设备跨月度发电量数据
        /// </summary>
        /// <param name="device"></param>
        /// <param name="startYearMM"></param>
        /// <param name="endYearMM"></param>
        /// <returns></returns>
        public Hashtable DeviceYearMMDDList(Device device, string startYearMMDD, string endYearMMDD)
        {
            return this.unionYearMMDDList(new List<Device>() { device }, startYearMMDD, endYearMMDD,new List<float>(){1.0F});
        }

        /// <summary>
        /// 取得多个设备的月天累计值，比如发电量或者增量日照强度
        /// </summary>
        /// <param name="devices"></param>
        /// <param name="startYearMM"></param>
        /// <param name="endYearMM"></param>
        /// <returns></returns>
        public Hashtable unionYearMMDDList(IList<Device> devices, string startYearMM, string endYearMM, IList<float> rates)
        {
            Hashtable monthDayDataMap = new Hashtable();
            int startYear = int.Parse(startYearMM.Substring(0, 4));
            int endYear = int.Parse(endYearMM.Substring(0, 4));
            int startMM = int.Parse(startYearMM.Substring(4, 2));
            int endMM = int.Parse(endYearMM.Substring(4, 2));
            Device device;
            for (int i =0;i<devices.Count;i++)
            {
                device = devices[i];
                IList<DeviceMonthDayData> monthDatas = this.GetDeviceBetweenMonthData(device.id, startYear, endYear, startMM, endMM);

                foreach (DeviceMonthDayData monthData in monthDatas)
                {

                    putMonthDayMap(monthDayDataMap, monthData, rates[i]);
                }
            }
            return monthDayDataMap;
        }


        /// <summary>
        /// 将各个月度数据付给map
        /// </summary>
        /// <param name="monthDataMap"></param>
        /// <param name="deviceMonthData"></param>
        /// <param name="rate">每个设备的rate可能不一样，所以要单独计算</param>
        private void putMonthDayMap(Hashtable monthDataMap, DeviceMonthDayData deviceMonthData,float rate)
        {
            int month = deviceMonthData.month;
            int year = deviceMonthData.year;

            //使用反射获得对象的号到最后一天的属性值
            int days = CalenderUtil.getMonthDays(year, month);
            for (int i = 1; i <= days; i++)
            {
                string key = year + TableUtil.convertIntToMnthStr(month) + TableUtil.convertIntToMnthStr(i);
                System.Object obj = monthDataMap[key];

                object tmpvalue = deviceMonthData.GetType().GetProperty("d_" + i).GetValue(deviceMonthData, null);
                float value = tmpvalue == null ? 0 : StringUtil.stringtoFloat(tmpvalue.ToString());
                if (obj != null || tmpvalue != null)
                    monthDataMap[key] = (obj == null ? 0 : StringUtil.stringtoFloat(obj.ToString())) + value * rate;
            }
        }

        /// <summary>
        /// 取得设备跨月度的月天发电量
        /// </summary>
        /// <param name="unitId">单元id</param>
        /// <param name="startYear">开始年份</param>
        /// <param name="endYear">截至年份</param>
        /// <param name="startMM">开始月</param>
        /// <param name="endMM">截至月</param>
        /// <returns></returns>
        private IList<DeviceMonthDayData> GetDeviceBetweenMonthData(int deviceId, int startYear, int endYear, int startMM, int endMM)
        {
            IList<DeviceMonthDayData> joinres = new List<DeviceMonthDayData>();
            for (int i = 0; i < (endYear - startYear + 1); i++)
            {
                int tmpYear = startYear + i;
                int tmpStartMM = 1;
                int tmpEndMM = 12;
                if (tmpYear == startYear)
                {
                    tmpStartMM = startMM;
                }
                if (tmpYear == endYear)
                {
                    tmpEndMM = endMM;
                }
                IList<DeviceMonthDayData> unitMonthDatas = _DeviceMonthDataDao.GetMonthBetweenData(deviceId, tmpYear, tmpStartMM, tmpEndMM);
                DeviceMonthDayData cacheDmdd;
                foreach (DeviceMonthDayData unitMonthData in unitMonthDatas)
                {
                    //从缓存中取得数据
                    cacheDmdd = this.getDeviceMonthDayDataWithCache(deviceId, tmpYear, unitMonthData.month);
                    if (cacheDmdd != null)
                    {
                        cacheDmdd.year = tmpYear;
                        joinres.Add(cacheDmdd);
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

        //从缓存中取得对象
        private DeviceMonthDayData getDeviceMonthDayDataWithCache(int deviceId, int year, int month){
            string cacheKey = CacheKeyUtil.buildDeviceEnergyMonthCountKey(deviceId, year, month);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
            if (obj != null) {
                return (DeviceMonthDayData)obj;
            }
            return null;
        }

        /// <summary>
        /// 保存单个设备的月天数据
        /// </summary>
        /// <param name="year"></param>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="month"></param>
        public void SaveDeviceMonthDayData(int year, string d_Column, double d_Value, int deviceID, int month)
        {
            DeviceMonthDayData deviceMonthDayData = GetDeviceMonthDayData(year, deviceID, month);
            if (deviceMonthDayData != null)
            {
                _DeviceMonthDataDao.UpdateDeviceMonthDayData(year, d_Column, d_Value, deviceMonthDayData.id);
            }
            else
            {
                _DeviceMonthDataDao.InsertDeviceMonthDayData(d_Column, d_Value, deviceID, year, month);
            }
        }

        /// <summary>
        /// 根据年度，月份，和设备id取得相应的月天发电量统计信息
        /// 经过缓存处理
        /// </summary>
        /// <param name="year"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public DeviceMonthDayData GetDeviceMonthDayData(int year, int deviceID, int month)
        {
            string cacheKey = CacheKeyUtil.buildDeviceEnergyMonthCountKey(deviceID, year, month);
            object obj = MemcachedClientSatat.getInstance().Get(cacheKey);

            DeviceMonthDayData deviceMonthDayData;
            if (obj == null)
            {//从数据库中取得
                deviceMonthDayData = _DeviceMonthDataDao.GetDeviceMonthDayData(deviceID, year, month);
                if (deviceMonthDayData == null)//构造一个新实例
                    deviceMonthDayData = new DeviceMonthDayData() { month = month, year = year, deviceID = deviceID };
                deviceMonthDayData.localAcceptTime = DateTime.Now;
                deviceMonthDayData.year = year;
                MemcachedClientSatat.getInstance().Set(cacheKey, deviceMonthDayData);
            }
            else
            {
                deviceMonthDayData = (DeviceMonthDayData)obj;
            }

            return deviceMonthDayData;
        }
        /// <summary>
        /// 放入缓存
        /// </summary>
        /// <param name="deviceMonthDayData"></param>
        public void Cache(DeviceMonthDayData deviceMonthDayData)
        {
            string cacheKey = CacheKeyUtil.buildDeviceEnergyMonthCountKey(deviceMonthDayData.deviceID, deviceMonthDayData.year, deviceMonthDayData.month);

            if (!persistentListKey.Contains(cacheKey)) persistentListKey.Add(cacheKey);
            //一个月3天后过期
            MemcachedClientSatat.getInstance().Set(cacheKey, deviceMonthDayData, DateTime.Now.AddMonths(1).AddDays(3));
        }

        /// <summary>
        /// 从缓存中批量持久化数据
        /// </summary>
        public void batchSave()
        {
            DeviceMonthDayData energyData;
            String[] keyArr = persistentListKey.ToArray();
            foreach (string key in keyArr)
            {
                object obj = MemcachedClientSatat.getInstance().Get(key);
                if (obj == null)
                {
                    LogUtil.warn(key + "in cache is empty of device day data ");
                    continue;
                }
                energyData = (DeviceMonthDayData)obj;
                string _Column = "d_" + energyData.curDay;
                float _value = 0;
                try
                {
                    _value = (float)ReflectionUtil.getProperty(energyData, _Column);
                }
                catch (Exception e1) {
                    LogUtil.error(e1.Message);
                }
                try
                {
                    if (energyData.id > 0)
                    {
                        _DeviceMonthDataDao.UpdateDeviceMonthDayData(energyData.year, _Column, _value, energyData.id);
                    }
                    else
                    {
                        try
                        {
                            _DeviceMonthDataDao.InsertDeviceMonthDayData(_Column, _value, energyData.deviceID, energyData.year, energyData.month);
                        }
                        catch (Exception e) {
                            LogUtil.error("insert device mOnth day error:" + e.Message);
                        }
                        DeviceMonthDayData tmp = _DeviceMonthDataDao.GetDeviceMonthDayData(energyData.deviceID, energyData.year, energyData.month);
                        if(tmp==null)
                            tmp = _DeviceMonthDataDao.GetDeviceMonthDayData(energyData.deviceID, energyData.year, energyData.month);
                        energyData.id = tmp==null?0:tmp.id;
                        MemcachedClientSatat.getInstance().Set(key, energyData);
                    }
                }
                catch (Exception e2)
                {
                    LogUtil.error(e2.Message);
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
