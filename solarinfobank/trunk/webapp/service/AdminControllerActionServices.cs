using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class AdminControllerActionServices
    {
        private static AdminControllerActionServices _instance = new AdminControllerActionServices();
        private IDaoManager _daoManager = null;
        private IAdminControllerActionDao _adminControllerActionDao = null;
        private AdminControllerActionServices()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _adminControllerActionDao = _daoManager.GetDao(typeof(IAdminControllerActionDao)) as IAdminControllerActionDao;
        }

        public static AdminControllerActionServices GetInstance()
        {
            return _instance;
        }


        public int Save(AdminControllerAction adminControllerAction)
        {
            if (adminControllerAction.id > 0)
                return _adminControllerActionDao.Update(adminControllerAction);
            return _adminControllerActionDao.Insert(adminControllerAction);
        }


        public IList<AdminControllerAction> GetList()
        {
            return _adminControllerActionDao.Getlist(new AdminControllerAction());
        }


    }
}
