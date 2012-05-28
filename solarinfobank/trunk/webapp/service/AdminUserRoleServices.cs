using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class AdminUserRoleServices
    {
        private static AdminUserRoleServices _instance = new AdminUserRoleServices();
        private IDaoManager _daoManager = null;
        private IAdminUserRoleDao _adminUserRoleDao = null;
        private AdminUserRoleServices()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _adminUserRoleDao = _daoManager.GetDao(typeof(IAdminUserRoleDao)) as IAdminUserRoleDao;
        }

        public static AdminUserRoleServices GetInstance()
        {
            return _instance;
        }


        public int Save(AdminUserRole adminUserRole)
        {
            if (adminUserRole.id > 0)
                return _adminUserRoleDao.Update(adminUserRole);
            return _adminUserRoleDao.Insert(adminUserRole);
        }

        public int Remove(int uid)
        {
            return _adminUserRoleDao.Remove(new AdminUserRole { userId = uid });
        }

        public IList<AdminUserRole> GetList()
        {
            return _adminUserRoleDao.Getlist(new AdminUserRole());
        }

    }
}
