using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class AdminControllerActionRoleServices
    {

        private static AdminControllerActionRoleServices _instance = new AdminControllerActionRoleServices();
        private IDaoManager _daoManager = null;
        private IAdminControllerActionRoleDao _adminControllerActionRoleDao = null;
        private AdminControllerActionRoleServices()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _adminControllerActionRoleDao = _daoManager.GetDao(typeof(IAdminControllerActionRoleDao)) as IAdminControllerActionRoleDao;
        }

        public static AdminControllerActionRoleServices GetInstance()
        {
            return _instance;
        }


        public int Save(AdminControllerActionRole adminControllerActionRole)
        {
            if (adminControllerActionRole.id > 0)
                return _adminControllerActionRoleDao.Update(adminControllerActionRole);
            return _adminControllerActionRoleDao.Insert(adminControllerActionRole);
        }

        public int Remove(int roleId)
        {
            return _adminControllerActionRoleDao.Remove(new AdminControllerActionRole { roleId = roleId });
        }

        public IList<AdminControllerActionRole> GetList()
        {
            return _adminControllerActionRoleDao.Getlist(new AdminControllerActionRole());
        }

    }
}
