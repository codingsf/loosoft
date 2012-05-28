using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao;

using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 设备型号业务类
    /// 作者：houbing.qian
    /// </summary>
    public class DeviceModelService
    {
        private static DeviceModelService _instance = new DeviceModelService();
        private IDaoManager _daoManager = null;
        private IDeviceModelDao _DeviceModelDao = null;

        private DeviceModelService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _DeviceModelDao = _daoManager.GetDao(typeof(IDeviceModelDao)) as IDeviceModelDao;
        }

        public static DeviceModelService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new DeviceModelService();
            }
            return _instance;
        }

        public IList<DeviceModel> GetList()
        {
            return _DeviceModelDao.Getlist(new DeviceModel());
        }

        public void Delete(int code)
        {
            _DeviceModelDao.Remove(new DeviceModel() { code = code });
        }

        public DeviceModel Get(int code) {
            return _DeviceModelDao.Get(new DeviceModel() { code = code });
        }

        /// <summary>
        /// 保存设备型号
        /// </summary>
        /// <param name="deviceModel"></param>
        /// <returns></returns>
        public int Save(DeviceModel deviceModel)
        {
            DeviceModel tmp = _DeviceModelDao.Get(deviceModel);
            if (tmp != null)
            {
                return _DeviceModelDao.Update(deviceModel);
            }
            else
                return _DeviceModelDao.Insert(deviceModel);

        }


        public IList<DeviceModel> getXhbyDeviceType(int type) {
         return  _DeviceModelDao.getXhbyDeviceType(type);
        }

        public IList<DeviceModel> GetDevicemodelsByPage(Pager page)
        {
            return _DeviceModelDao.GetDevicemodelsByPage(page);
        }


    }
}
