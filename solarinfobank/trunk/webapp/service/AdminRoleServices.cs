using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class AdminRoleServices
    {
        private static AdminRoleServices _instance = new AdminRoleServices();
        private IDaoManager _daoManager = null;
        private IAdminRoleDao _adminRoleDao = null;
        private AdminRoleServices()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _adminRoleDao = _daoManager.GetDao(typeof(IAdminRoleDao)) as IAdminRoleDao;
        }

        public static AdminRoleServices GetInstance()
        {
            return _instance;
        }


        public int Save(AdminRole adminRole)
        {
            if (adminRole.id > 0)
                return _adminRoleDao.Update(adminRole);
            return _adminRoleDao.Insert(adminRole);
        }

        public AdminRole Get(int id)
        {
            return _adminRoleDao.Get(new AdminRole() {  id=id});
        }

        public IList<AdminRole> GetList()
        {
            return _adminRoleDao.Getlist(new AdminRole());
        }

        public int Remove(int id)
        {
            return _adminRoleDao.Remove(new AdminRole { id = id });
        }
    }
}
