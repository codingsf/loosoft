using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{

    public class AdminAuthorizeAttribute : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            var user = filterContext.HttpContext.Session[ComConst.Manager] as Manager;
            var controller = filterContext.RouteData.Values["controller"].ToString().ToLower();
            var action = filterContext.RouteData.Values["action"].ToString().ToLower();
            if (user != null)
            {
                if (AuthService.isAllow(controller, action) == false)
                {
                    filterContext.RequestContext.HttpContext.Response.Write("非法访问 <a href=\"/\">首页</a> ");
                    filterContext.RequestContext.HttpContext.Response.End();
                }
            }
        }
    }


    [AdminAuthorizeAttribute]
    public class AdminBaseController : Controller
    {
        /// <summary>
        /// 编码字符串，火狐不处理
        /// </summary>
        /// <param name="strname"></param>
        /// <returns></returns>
        protected string urlcode(string strname)
        {
            //火狐不处理

            string btype = Request.UserAgent;
            if (btype.IndexOf("MSIE") > 0)
                return Server.UrlEncode(strname);
            else
            {
                return strname;
            }
        }
        protected Plant FirstPlant
        {
            get
            {
                return UserUtil.getCurUser().plants.Count > 0 ? UserUtil.getCurUser().plants[0] : null;
            }
        }


    }
}
