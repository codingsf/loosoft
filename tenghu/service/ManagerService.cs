using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using IBatisNet.DataAccess;
using DataLinq;
using LinqDAO;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class ManagerService
    {
        private static ManagerService _instance;
        // private IDaoManager _daoManager = null;
        private ManagerDAO _managerDao = null;

        private ManagerService()
        {
            //  _daoManager = ServiceConfig.GetInstance().DaoManager;
            //  _managerDao = _daoManager.GetDao(typeof(IManager)) as IManager;
            _managerDao = new ManagerDAO();
        }

        public static ManagerService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new ManagerService();
            }
            return _instance;
        }



        public IList<Manager> GetList()
        {
            return _managerDao.GetList();
        }
        public Manager Get(int id)
        {
            return _managerDao.Get(id);
        }

        public Manager Get(string uname)
        {
            return _managerDao.Get(uname);
        }

        public void Save(Manager manager)
        {
            if (manager.id > 0)
                _managerDao.Update(manager);
            _managerDao.Insert(manager);
        }
        public void Remove(int id)
        {
             _managerDao.Remove(id);
        }



    }
}
