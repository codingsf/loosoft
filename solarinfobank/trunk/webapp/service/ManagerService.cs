using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 
    /// 管理员业务层
    /// </summary>
    public class ManagerService
    {
        private static ManagerService _instance = new ManagerService();
        private IDaoManager _daoManager = null;
        private IManagerDao _managerDao = null;

        //保存用户名和id键值对 以便用key查询提供查询速度
        private static Hashtable usernameIdMap = new Hashtable();

        private ManagerService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _managerDao = _daoManager.GetDao(typeof(IManagerDao)) as IManagerDao;
        }

        /// <summary>
        /// function：根据用户名查询用户信息
        /// business：
        /// author：hbqian
        /// </summary>
        /// <param name="userName">用户名</param>
        /// <returns>用户</returns>
        public Manager GetUserByName(string userName)
        {

            Object id = usernameIdMap[userName];
            Manager manager = null;
            if (id == null)
            {
                manager = _managerDao.GetManagerByUsername(userName);
                if (manager != null)
                    usernameIdMap[userName] = manager.id;
            }
            else
            {
                manager = this.Get((int)id);
            }

            return manager;
        }

        public static ManagerService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new ManagerService();
            }
            return _instance;
        }

        /// <summary>
        /// 判断管理员是否锁定
        /// </summary>
        /// <returns>管理员信息</returns>
        public Manager GetManagerByLocked(string username)
        {
            return _managerDao.GetManagerByLocked(username);
        }

        /// <summary>
        /// 保存管理员
        /// </summary>
        /// <param name="manager"></param>
        /// <returns></returns>
        public int Save(Manager manager)
        {
            int resultValue = 0;
            if (manager.id > 0)
                resultValue = _managerDao.Update(manager);
            else
                resultValue = _managerDao.Insert(manager);
            return resultValue;
        }

        /// <summary>
        /// 根据id删除一个管理员
        /// </summary>
        /// <param name="mid"></param>
        /// <returns></returns>
        public bool Remove(int mid)
        {
            return _managerDao.Remove(new Manager { id = mid }) > 0 ? true : false;
        }
        /// <summary>
        /// 
        /// 根据id取得一个管理员
        /// </summary>
        /// <param name="mid"></param>
        /// <returns></returns>
        public Manager Get(int mid)
        {
            return _managerDao.Get(new Manager { id = mid });
        }

        public IList<Manager> Getlist(Manager manager)
        {
            return _managerDao.Getlist(manager);
        }

        public IList<Manager> GetManagersByPara(Hashtable table)
        {
            return _managerDao.GetManagersByPara(table);

        }
    }
}
