using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 用户信息服务
    /// </summary>
    public class UserService
    {
        private static UserService _instance = new UserService();
        private IDaoManager _daoManager = null;
        private IUserDao _userDao = null;

        //保存用户名和id键值对 以便用key查询提供查询速度
        private static Hashtable usernameIdMap = new Hashtable();

        private UserService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _userDao = _daoManager.GetDao(typeof(IUserDao)) as IUserDao;
        }

        public static UserService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 保存用户
        /// </summary>
        /// <param name="user">用户对象</param>
        public int save(User user)
        {
            if (user.id == 0)//新增
            {
                user.sysName = ComConst.defaultSysName;
                int success = _userDao.Insert(user);
                if (success > 0)//创建系统报表
                    ReportService.GetInstance().batchCreateSysRunReport(user.id, 0);
                return success;
            }
            else
            {
                return _userDao.Update(user);
            }
        }

        /// <summary>
        /// function：删除用户
        /// business：
        /// author：hbqian
        /// </summary>
        /// <param name="userId"></param>
        /// <returns>是否成功</returns>
        public bool Delete(int userId)
        {
            // 删除电站对应门户用户
            PlantPortalUserService.GetInstance().DelPlantUserByUserId(userId);
            // 删除电站对应一般用户
            PlantUserService.GetInstance().DelPlantUserByUserId(userId);
            return _userDao.Remove(new User { id = userId }) > 0 ? true : false;
        }

        /// <summary>
        /// function：根据用户名查询用户信息
        /// business：
        /// author：hbqian
        /// </summary>
        /// <param name="userName">用户名</param>
        /// <returns>用户</returns>
        public User GetUserByName(string userName)
        {
            Object id = null;
            if(usernameIdMap.ContainsKey(userName))
                id = usernameIdMap[userName];
            User user = null;
            if (id == null)
            {
                user = _userDao.GetUserByName(userName);
            }
            else
            {
                user = this.Get((int)id);
            }
            return user;
        }

        /// <summary>
        /// 获取所有用户信息
        /// </summary>
        /// <returns>返回所有用户信息</returns>
        public IList<User> GetUserList()
        {
            return _userDao.GetUserList();
        }

        /// <summary>
        /// 根据用户id取得用户对象
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public User Get(int userId)
        {
            return _userDao.Get(new User { id = userId });
        }

        /// <summary>
        /// 根据语言编号查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int GetLanguageIdById(int id)
        {
            return _userDao.GetLanguageIdById(id);
        }

        public User GerUserbyUserName(string username, string uname)
        {
            return _userDao.GerUserbyUserName(username, uname);
        }

        public IList<User> GetUsersByPage(Pager page)
        {
            return _userDao.GetUsersByPage(page);
        }
        public IList<User> GetChildUser(int parentUserId)
        {
            return _userDao.GetChildUser(parentUserId);
        }

        public int UpdatePassword(int uid, string password)
        {
            return _userDao.UpdatePassword(uid, password);

        }
        public int UpdateApplyCollectorCount(User user)
        {
            return _userDao.UpdateApplyCollectorCount(user);
        }
        public IList<User> GetUsersLikeuname(string uname)
        {
            return _userDao.GetUsersLikeuname(uname);
        }


        public int UpdateBigCustomer(int uid, bool status)
        {
            Hashtable table = new Hashtable();
            table.Add("id", uid);
            table.Add("isBigCustomer", status);
            return _userDao.UpdateBigCustomer(table);
        }
    }
}
