using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class UserUtil
    {
        /// <summary>
        /// demo账号用户名
        /// </summary>
        public static string demousername = "demo";
        /// <summary>
        /// 旧demo账号，以便app能兼容
        /// </summary>
        public static string olddemousername = "exampleuser@solarinfobank.com";
        /// <summary>
        /// 
        /// 取得当前用户
        /// author: hbqian
        /// </summary>
        /// <returns></returns>
        public static User getCurUser() 
        {
            if (System.Web.HttpContext.Current.Session[ComConst.User] == null)
            {
                // if (System.Web.HttpContext.Current.Application[ComConst.User] == null)
                //return null;
                System.Web.HttpContext.Current.Application[System.Web.HttpContext.Current.Session.SessionID] = "timeout";
                return null;
                //else
                //{
                //int userId = int.Parse(System.Web.HttpContext.Current.Application[ComConst.User].ToString());
                //return UserService.GetInstance().Get(userId);
                //}
            }
            else
            {
                int userId = int.Parse(System.Web.HttpContext.Current.Session[ComConst.User].ToString());
                return UserService.GetInstance().Get(userId);
            }
        }


        /// <summary>
        /// 
        /// 用户是否登录
        /// author: hbqian
        /// </summary>
        /// <returns></returns>

        public static bool isLogined()
        {
            if (System.Web.HttpContext.Current.Session[ComConst.User] == null) return false;
            return true;
        }


        /// <summary>
        /// 
        /// 设置用户登录状态
        /// author:hbqian
        /// </summary>
        /// <param name="user"></param>
        public static void login(User user)
        {
            System.Web.HttpContext.Current.Session[ComConst.User] = user.id;
            System.Web.HttpContext.Current.Application[ComConst.User] = user.id;
        }

        public static void ResetLogin(User user)
        {
            login(user);
        }
    }
}
