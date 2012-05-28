using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 用户信息接口的实现类
    /// Author: 赵文辉
    /// Time: 2011年2月15日 14:35:20
    /// </summary>
    public class UserSqlMapDao : BaseSqlDao<User>, IUserDao
    {

        public UserSqlMapDao()
            : base()
        {

        }
        #region IUserInfoDao 成员

        /// <summary>
        /// 根据用户名查询用户信息
        /// </summary>
        /// <param name="userName">用户名</param>
        /// <returns>用户信息</returns>
        public User GetUserByName(string userName)
        {
            return ExecuteQueryForObject<User>("get_user_by_name", userName);
        }

        /// <summary>
        /// 查询所有用户信息
        /// </summary>
        /// <returns>所有用户信息</returns>
        public IList<User> GetUserList()
        {
            return ExecuteQueryForList<User>("user_get_list", null);
        }

        /// <summary>
        /// 添加用户信息
        /// </summary>
        /// <param name="user">用户信息字段</param>
        public void AddUser(User user)
        {
            ExecuteQueryForObject("user_insert", user);
        }

        /// <summary>
        /// 修改除密码外的其他用户信息字段
        /// </summary>
        /// <param name="user">用户信息字段</param>
        public void update(User user)
        {
            ExecuteUpdate<User>("user_update_pass", user);
        }
        #endregion

        #region IUserDao 成员


        public User GerUserbyUserName(string username, string uname)
        {
            Hashtable table = new Hashtable();
            table.Add("email", username);
            table.Add("uname", uname);
            return (User)ExecuteQueryForObject("user_get_by_email", table);
        }

        public IList<User> GetUsersByPage(Pager page)
        {
            page.RecordCount = (int)ExecuteQueryForObject("loading_users_page_count", page);
            return ExecuteQueryForList<User>("loading_users_page_list", page);
        }

        public int GetLanguageIdById(int id)
        {
            return (int)ExecuteQueryForObject("user_get_languageId_by_id", id);
        }

        #endregion

        #region IUserDao 成员


        public int UpdatePassword(int uid, string password)
        {
            Hashtable table = new Hashtable();
            table.Add("uid", uid);
            table.Add("pwd", password);
            return ExecuteUpdate("password_update_by_id", table);

        }

        public int UpdateApplyCollectorCount(User user)
        {
            return ExecuteUpdate("update_todayapplycollector_count", user);

        }


        public IList<User> GetChildUser(int parentUserId)
        {
            return ExecuteQueryForList<User>("get_child_user_by_userid", parentUserId);
        }
        #endregion

        #region IUserDao 成员


        public IList<User> GetUsersLikeuname(string uname)
        {
            return ExecuteQueryForList<User>("load_user_like_uname", uname);
        }

        public int UpdateBigCustomer(Hashtable table)
        {
            return ExecuteUpdate("update_bigcustomer_enable", table);
        }

        #endregion
    }
}
