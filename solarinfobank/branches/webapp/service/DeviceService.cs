﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class DeviceService
    {
        private static DeviceService _instance;
        private IDaoManager _daoManager = null;
        private IDeviceDao _deviceDao = null;
        private static Hashtable deviceCodeIdHash = new Hashtable();
        private DeviceService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _deviceDao = _daoManager.GetDao(typeof(IDeviceDao)) as IDeviceDao;
        }
        /// <summary>
        /// 初始化所有设备
        /// </summary>
        public void init()
        {
            string key = "";
            foreach (Device device in this._deviceDao.getAllList())
            {
                key = device.collectorID + "_" + device.deviceAddress;//设备的采集器数据id和设备地址能唯一识别设备

                deviceCodeIdHash[key] = device.id;
            }

        }
        public static DeviceService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new DeviceService();
            }
            return _instance;
        }

        public IList<Device> List(Device device)
        {
            return _deviceDao.Getlist(device);
        }

        public Device get(int id)
        {
            return _deviceDao.Get(new Device(id));
        }


        public int Save(Device device)
        {
            if (device.id > 0)
            {
                return _deviceDao.Update(device);
            }
            else
                return _deviceDao.Insert(device);
        }

        /// <summary>
        /// 设备不存在就新增一个设备，返回设备id
        /// </summary>
        /// <param name="device"></param>
        /// <returns></returns>
        public int getDeviceId(int collectorID, string deviceAddress)
        {
            string key = collectorID + "_" + deviceAddress;//设备的采集器数据id和设备地址能唯一识别设备
            object id = deviceCodeIdHash[key];
            if (id == null)
            {
                Device tmp = _deviceDao.GetDeviceByCollector2Address(collectorID, deviceAddress);
                if (tmp == null)
                {
                    return 0;
                }
                else
                {
                    id = tmp.id;
                    deviceCodeIdHash[key] = id;
                }
            }
            return int.Parse(id.ToString());
        }

        /// <summary>
        /// 通过采集器和地址从数据库取得
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="deviceAddress"></param>
        /// <returns></returns>
        public Device getDevice(int collectorID, string deviceAddress)
        {
            return _deviceDao.GetDeviceByCollector2Address(collectorID, deviceAddress);
        }
        public IList<Device> GetDevicesListPage(Hashtable table)
        {
            return _deviceDao.GetDevicesListPage(table);
        }


        public int SaveCurrentPower(string id, string power)
        {
            return _deviceDao.SaveCurrentPower(id, power);
        }

        public int SetDeviceStatus(string id, string status)
        {
            return _deviceDao.SetDeviceStatus(id, status);
        }
        public int UpdateDeviceById(Device device)
        {
            return _deviceDao.UpdateDeviceById(device);
        }

        public double GetEnergy(int did, string startyyyyMMdd, string endyyyyMMdd)
        {
            //20111130    20111130
            double returnValue = 0;
            DateTime startTime = DateTime.Parse(startyyyyMMdd);
            DateTime endTime = DateTime.Parse(endyyyyMMdd);
            IList<DeviceYearMonthData> dymds = new List<DeviceYearMonthData>();
            int yyyy = startTime.Year;
            while (yyyy <= endTime.Year)//计算开始到结束时间的所在年发电量
            {
                dymds.Add(DeviceYearMonthDataService.GetInstance().GetDeviceYearMonthData(did, yyyy));
                yyyy++;
            }
            //计算开始到结束时间内的所有发电量
            foreach (DeviceYearMonthData dymd in dymds)
            {
                if (dymd.year.Equals(startTime.Year) && startTime.AddMonths(1) < endTime)
                    returnValue += dymd.count(startTime.Month + 1, 12);
                else
                    if (dymd.year.Equals(endTime.Year) && endTime.AddMonths(-1) > startTime)
                        returnValue += dymd.count(1, endTime.Month - 1);
                    else
                        if (startTime.Year.Equals(endTime.Year) == false)
                            returnValue += dymd.count();
            }
            DeviceMonthDayData dmdd = null;
            //计算边缘月的发电量 
            if (!(startTime.Year.Equals(endTime.Year) && startTime.Month.Equals(endTime.Month)))
            {
                dmdd = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(startTime.Year, did, startTime.Month);
                returnValue += dmdd.count(startTime.Day, 31);

                dmdd = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(startTime.Year, did, endTime.Month);
                returnValue += dmdd.count(1, endTime.Day);
            }
            else
            {
                dmdd = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(startTime.Year, did, endTime.Month);
                returnValue += dmdd.count(startTime.Day, endTime.Day);
            }
            return returnValue;
        }
    }
}