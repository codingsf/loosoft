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

        public static string UserLogo
        {
            get
            {
                string defaultPath = "/images/logo.jpg";
                User user = getCurUser();
                if (user == null)
                    return defaultPath;
                string userPath = string.Format("/ufile/logo/{0}", user.logo);
                string domainPath = System.Web.HttpContext.Current.Server.MapPath("~");
                if (System.IO.File.Exists(string.Format("{0}{1}", domainPath, userPath)) == false)
                    return defaultPath;
                return userPath;
            }
        }

        /// <summary>
        /// 获取用户模板如果未设置模板则用系统默认模板
        /// </summary>
        public static Templete curTemplete
        {
            get
            {
                User user = getCurUser();
                //当前用户没有模板
                if (user.templete == null)
                {
                    Templete defaultTemplete = System.Web.HttpContext.Current.Application[ComConst.Templete] as Templete;
                    if (defaultTemplete == null)
                        System.Web.HttpContext.Current.Application[ComConst.Templete] = TempleteService.GetInstance().getDefault();
                    return System.Web.HttpContext.Current.Application[ComConst.Templete] as Templete;
                }
                return user.templete;
            }
        }

    }
}
