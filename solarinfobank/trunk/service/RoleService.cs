using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class RoleService
    {
        private static RoleService _instance = new RoleService();
        private IDaoManager _daoManager = null;
        private IRoleDao _roleDao = null;


        private RoleService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _roleDao = _daoManager.GetDao(typeof(IRoleDao)) as IRoleDao;
        }

        public static RoleService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new RoleService();
            }

            return _instance;
        }

        public int Insert(Role role)
        {
            return _roleDao.Insert(role);
        }

        public int Save(Role role)
        {
            if (role.id > 0)
            {
                _roleDao.Update(role);
                return role.id;
            }
            return _roleDao.Insert(role);
        }

        public int Remove(int id)
        {
            return _roleDao.Remove(new Role() { id = id });
        }
        public IList<Role> GetRole_Uid(int uid)
        {
            return _roleDao.GetRole_Uid(uid);
        }

        public Role Get(int id)
        {
            return _roleDao.Get(new Role { id = id });
        }
    }
}
