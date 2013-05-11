using System;
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
        protected static string bank_url = System.Configuration.ConfigurationSettings.AppSettings["bank_url"];

        private static DeviceService _instance;
        private IDaoManager _daoManager = null;
        private IDeviceDao _deviceDao = null;
        //add by qhb int 2013-03-23 for取得采集器所在单元
        private IPlantUnitDao _plantUnitDao = null;
        public static Hashtable deviceCodeIdHash = new Hashtable();
        private DeviceService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _deviceDao = _daoManager.GetDao(typeof(IDeviceDao)) as IDeviceDao;
            _plantUnitDao = _daoManager.GetDao(typeof(IPlantUnitDao)) as IPlantUnitDao;
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
            //add by qhb in 20130323 for 发现有设备新增有要将没有plantunitid字段值的设备，plantUnitId附上所属单元
            //add by qhb in 20130428 for 放在前面处理，这样不管是新增和修改都能保证没有设备单元关系的设备都可以有保证有正确关系，这个是为了解决
            //出现解析程序的关系有了的情况下，后面又被冲掉了，可能是被设备修改冲掉了
            if (device.plantUnitId == null || device.plantUnitId == 0)
            {
                PlantUnit plantUnit = _plantUnitDao.GetPlantUnitByCollectorId(device.collectorID);
                if (plantUnit != null)
                    device.plantUnitId = plantUnit.id;
            }
            if (device.id > 0)
            {
                //确保设备类型不会被冲掉
                if (device.deviceModelCode > 0 && device.deviceModel.code == 0) {
                    device.deviceModel.code = device.deviceModelCode;
                }
                return _deviceDao.Update(device);
            }
            else{
                return _deviceDao.Insert(device);
            }
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
            //add by qhb in 20130428 for 放在前面处理，这样不管是新增和修改都能保证没有设备单元关系的设备都可以有保证有正确关系，这个是为了解决
            //出现解析程序的关系有了的情况下，后面又被冲掉了，可能是被设备修改冲掉了
            if (device.plantUnitId == null || device.plantUnitId == 0)
            {
                PlantUnit plantUnit = _plantUnitDao.GetPlantUnitByCollectorId(device.collectorID);
                if (plantUnit != null)
                    device.plantUnitId = plantUnit.id;
            }
            return _deviceDao.UpdateDeviceById(device);
        }


        /// <summary>
        /// 批量持久化更新设备信息到数据库
        /// add by qhb in 20120715 for
        /// </summary>
        /// <param name="plantInfos"></param>
        public void batchSave(IDictionary<int, DeviceInfo> deviceInfoMap)
        {
            Device device = null;
            foreach (DeviceInfo deviceInfo in deviceInfoMap.Values)
            {
                device = this.get(deviceInfo.deviceid);
                if (device == null) continue;

                //将临时对象的值付给正式的设备业务对象
                device.name = deviceInfo.name;
                device.deviceModelCode = deviceInfo.typemodel;
                device.deviceModel = new DeviceModel() { code = deviceInfo.typemodel };
                this.Save(device);

                //有新设备要更新bank缓存
                HttpClientUtil.requestUrl(bank_url);
            }
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

        public IList<Device> getDeviceListLikeName(string name)
        {
            return _deviceDao.getDeviceListLikeName(name);
        }
    }
}
