using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
  public  class VirtualPlantService
    {
        private static VirtualPlantService _instance = new VirtualPlantService();
        private IDaoManager _daoManager = null;
        private IVirtualPlantDao _virtualPlantDao = null;

        private VirtualPlantService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _virtualPlantDao = _daoManager.GetDao(typeof(IVirtualPlantDao)) as IVirtualPlantDao;
        }

        public static VirtualPlantService GetInstance()
        {
            return _instance;
        }
    }
}
