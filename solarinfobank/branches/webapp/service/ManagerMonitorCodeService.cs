using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class ManagerMonitorCodeService
    {
        private static ManagerMonitorCodeService _instance = new ManagerMonitorCodeService();
        private IDaoManager _daoManager = null;
        private IManagerMonitorCodeSqlMapDao _managerMonitorCode = null;
        private ManagerMonitorCodeService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _managerMonitorCode = _daoManager.GetDao(typeof(IManagerMonitorCodeSqlMapDao)) as IManagerMonitorCodeSqlMapDao;
        }

        public static ManagerMonitorCodeService GetInstance()
        {
            return _instance;
        }

        public IList<ManagerMonitorCode> GetList()
        {
            return _managerMonitorCode.Getlist(new ManagerMonitorCode());
        }

        public int SetEnable(int id)
        {
            return _managerMonitorCode.Update(new ManagerMonitorCode() { id = id });
        }
        public int HideItemByTid(string tid)
        {
            return _managerMonitorCode.HideItemByTid(tid);
        }

    }
}
