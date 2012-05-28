using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class UserRoleService
    {
        private static UserRoleService _instance = new UserRoleService();
        private IDaoManager _daoManager = null;
        private IUserRoleDao _userRoleDao = null;


        private UserRoleService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _userRoleDao = _daoManager.GetDao(typeof(IUserRoleDao)) as IUserRoleDao;
        }


        public static UserRoleService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new UserRoleService();
            }

            return _instance;
        }

        public int Insert(UserRole userRole)
        {
            return _userRoleDao.Insert(userRole);
        }

        public int Save(UserRole userRole)
        {
            return _userRoleDao.Update(userRole);
        }

        public int Remove(int id)
        {
            return _userRoleDao.Remove(new UserRole() {  id = id  });
        }

    }
}
