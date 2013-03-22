using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 用户信息接口
    /// Author: 赵文辉
    /// Time: 2011年2月15日 15:01:10
    /// </summary>
    public interface IUserDao : IBaseDao<User>
    {
        /// <summary>
        /// 根据用户名查询用户信息
        /// </summary>
        /// <param name="userName">用户名</param>
        /// <returns>用户信息</returns>
        User GetUserByName(string userName);

        /// <summary>
        /// 查询所有用户信息
        /// </summary>
        /// <returns>所有用户信息</returns>
        IList<User> GetUserList();

        /// <summary>
        /// 修改除密码外的用户信息
        /// </summary>
        /// <param name="user">用户字段</param>
        void update(User user);

        int GetLanguageIdById(long id);

        User GerUserbyUserName(string username, string uname);

        IList<User> GetUsersByPage(Pager page);

        int UpdatePassword(long uid, string password);

        int UpdateApplyCollectorCount(User user);

        IList<User> GetChildUser(long parentUserId);

        IList<User> GetUsersLikeuname(string uname);

        int UpdateBigCustomer(Hashtable table);

        int UpdateBigScreen(Hashtable table);

        int UpdateBigScreenLogo(Hashtable table);

    }
}