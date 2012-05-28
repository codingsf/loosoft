using System;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    /// <summary>
    /// 功能：获取静态服务器地址
    /// 作者：钱厚兵
    /// 时间：2011年3月4日 16:31:48
    /// </summary>
    public class StaticController : Controller
    {
        //静态服务器地址
        private const string STATICURL = "staticUrl";

        //
        // GET: /Static/

        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// 加载今天头部包含页面
        /// js and css
        /// 并动态取得当前访问ip对应的静态服务器地址，输出到包含页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Include()
        {
            if (Session[STATICURL]!=null)
            {
                string staticUrl = Session[STATICURL].ToString();
                if (String.IsNullOrEmpty(staticUrl))
                {
                    string userIp = Request.ServerVariables.Get("REMOTE_ADDR");//自动获取用户IP
                    staticUrl = StaticService.GetStaticUrl(userIp);
                    Session[STATICURL] = staticUrl;
                }
                ViewData[STATICURL] = staticUrl;
            }
            else
            {
                ViewData[STATICURL] = "../../";//默认的
            }
            return View();
        }



    }
}
