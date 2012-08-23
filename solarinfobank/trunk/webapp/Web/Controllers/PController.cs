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
    public class PController : Controller
    {
        public ActionResult Index(string username)
        {
            if (username.IndexOf(".") > -1) return null;

            User loginUser = UserService.GetInstance().GetUserByName(username);
            Session[Common.ComConst.portalautoLogin] = true;
            UserUtil.login(loginUser);
            return View();
        }

      

    }
}
