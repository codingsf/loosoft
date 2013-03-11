using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{

    public class ProtalUtil
    {
        public const string allowBigCustomer = "1";//启用全部用户可以使用大客户
        public const string allBigcustomer = "0";//禁用全部用户可以使用大客户
        /// <summary>
        /// 判断当前用户是否大客户
        /// </summary>
        /// <returns></returns>
        public static bool isBigCustomer()
        {
            string customerEnable = System.Configuration.ConfigurationManager.AppSettings["bigCustomer"];
            if (customerEnable.Equals(allowBigCustomer))
                return true;
            User user = UserUtil.getCurUser();
            if (user != null)
                return user.isBigCustomer;
            return false;
        }
        /// <summary>
        /// 门户用户是否自动登录,如果标识为自动登录用户标识为门户的访客，没有输入密码验证
        /// 如果用密码登录那么标识为null
        /// </summary>
        public static bool isAutoLogin
        {
            get
            {
                return (System.Web.HttpContext.Current.Session[Common.ComConst.portalautoLogin] != null);
            }
        }
    }
}
