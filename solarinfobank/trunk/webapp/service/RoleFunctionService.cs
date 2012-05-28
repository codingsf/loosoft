using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class RoleFunctionService
    {
        private static RoleFunctionService _instance = new RoleFunctionService();
        private IDaoManager _daoManager = null;
        private IRoleFunctionDao _roleFunctionDao = null;


        private RoleFunctionService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _roleFunctionDao = _daoManager.GetDao(typeof(IRoleFunctionDao)) as IRoleFunctionDao;
        }

        public static RoleFunctionService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new RoleFunctionService();
            }

            return _instance;
        }

        public int Insert(RoleFunction roleFunction)
        {
            return _roleFunctionDao.Insert(roleFunction);
        }

        public int Save(RoleFunction roleFunction)
        {
            return _roleFunctionDao.Update(roleFunction);
        }

        public int Remove(int id)
        {
            return _roleFunctionDao.Remove(new RoleFunction() { roleId = id });
        }

        public IList<RoleFunction> GetFunctions(int roleId)
        {
            return _roleFunctionDao.Getlist(new RoleFunction { roleId = roleId });
        }
    }
}
