using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
   public class ManagerService
    {
       private static ManagerService _instance;
        private IDaoManager _daoManager = null;
        private IManager _managerDao = null;

        private ManagerService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _managerDao = _daoManager.GetDao(typeof(IManager)) as IManager;
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
            return _managerDao.Getlist(new Manager());
        }
        public Manager Get(int id)
        {
            return _managerDao.Get(new Manager() {id=id});
        }

        public Manager Get(string uname)
        {
            return _managerDao.Get(uname);
        }

        public int Save(Manager manager)
        {
            if (manager.id > 0)
                return _managerDao.Update(manager);
            return _managerDao.Insert(manager);
        }
        public int Remove(int id)
        {
            return _managerDao.Remove(new Manager() {   id = id });
        }



    }
}
