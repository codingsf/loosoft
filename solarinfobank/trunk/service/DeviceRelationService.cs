using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class DeviceRelationService
    {
        private static DeviceRelationService _instance = new DeviceRelationService();
        private IDaoManager _daoManager = null;
        private IDeviceRelationDao _deviceRelationDao = null;

        private DeviceRelationService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _deviceRelationDao = _daoManager.GetDao(typeof(IDeviceRelationDao)) as IDeviceRelationDao;
        }

        public static DeviceRelationService GetInstance()
        {
            return _instance;
        }

        public int Save(DeviceRelation relation)
        {
            if (relation.id > 0)
                return _deviceRelationDao.Update(relation);
            return _deviceRelationDao.Insert(relation);
        }

        public IList<DeviceRelation> GetList(int plantId)
        {
            return _deviceRelationDao.Getlist(new DeviceRelation { plantId = plantId });
        }

        public IList<DeviceRelation> getFirstDeviceRelation(int plantId, string name)
        {
            return _deviceRelationDao.getFirstDeviceRelation(plantId, name);
        }

        public IList<DeviceRelation> getListbyparentDeviceId(int parentDeviceId)
        {
            return _deviceRelationDao.getListbyparentDeviceId(parentDeviceId);
        }
        public IList<DeviceRelation> getNamesPlantId(int plantId)
        {
            return _deviceRelationDao.getNamesPlantId(plantId);
        }
        public DeviceRelation Get(DeviceRelation rolation)
        {
            return _deviceRelationDao.Get(rolation);
        }

        public int Remove(DeviceRelation rolation)
        {
            return _deviceRelationDao.Remove(rolation);
        }

        public int RemoveRelations(string ids,string name)
        {
            return _deviceRelationDao.RemoveRelations(ids,name);
        }
    }
}
