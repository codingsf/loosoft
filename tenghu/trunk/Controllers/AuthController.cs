using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.Tenghu.Domain;
using Cn.Loosoft.Zhisou.Tenghu.Service;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace Cn.Loosoft.Zhisou.Tenghu.Web.Controllers
{
    public class AuthController : Controller
    {
        //
        // GET: /Auth/

        public ActionResult Logout()
        {
            Session["alogin"] = null;
            return Redirect("/auth/login");
        }

        public ActionResult Login()
        {
            ViewData["error"] = string.Empty;
            return View();
        }
        [HttpPost]
        public ActionResult Login(Manager manager)
        {
            ViewData["error"] = string.Empty;
            Manager m = ManagerService.GetInstance().Get(manager.username);
            if (m != null && m.password.Trim().Equals(manager.password) && m.islocked == false)
            {
                Session["alogin"] = m;
                return RedirectToAction("index", "admin");
            }
            else
                ViewData["error"] = "用户名或者密码错误";
            return View();
        }


    }
}
