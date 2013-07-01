using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Text.RegularExpressions;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class AuthController : BaseController
    {
        UserService userService = UserService.GetInstance();
        //
        // GET: /User/

        /// <summary>
        /// 修改用户信息
        /// </summary>
        /// <param name="collectorInfo">用户信息字段</param>
        /// <returns>转到显示页面</returns>
        //public ActionResult Update(User userInfo)
        //{
        //    int id = int.Parse(Request.QueryString["id"].ToString());
        //    UserService userinfoservice = UserService.GetInstance();
        //    userInfo = userinfoservice.GetUserById(id);
        //    return View(userInfo);
        //}

        /// <summary>
        /// 修改用户信息
        /// </summary>
        /// <param name="userInfo">用户信息字段</param>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult UpdateUser(User user)
        {
            if (ModelState.IsValid)
            {
                UserService userservice = UserService.GetInstance();
                user.password = EncryptUtil.EncryptDES(user.password, EncryptUtil.defaultKey);
                try
                {
                    userservice.save(user);
                }
                catch
                {
                    //如果已经存在该采集器
                    ModelState.AddModelError("Code", "the email is used");
                }
            }
            return RedirectToAction("Plants", "user");
        }

        public ActionResult LoginOut()
        {
            base.logout();

            System.Web.HttpContext.Current.Response.Cookies["a_login"].Expires = DateTime.Now.AddDays(-1);
            System.Web.HttpContext.Current.Response.Cookies["uinside"].Expires = DateTime.Now.AddDays(-1);
            System.Web.HttpContext.Current.Response.Cookies["inside"].Expires = DateTime.Now.AddDays(-1);
            return RedirectToAction("index", "home");
        }

        #region 作者：鄢睿
        /// <summary>
        /// 作者：鄢睿
        /// 功能：显示用户所具有的电站数量
        /// 创建时间：2011-02-18 19:42
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult Profile()
        {
            PlantService plangInfoService = PlantService.GetInstance();
            if (Session[ComConst.User] != null)
            {
                User userInfo = UserUtil.getCurUser(); ;
                ViewData["userInfo"] = userInfo;
                ModelState.AddModelError("Message", userInfo.username + "welcome");
                //IList<PlantInfo> plangInfoList = plangInfoService.GetPlantInfoListByUserId(userInfo.Id); ViewData["plantInfo"] = plangInfoList;
                return View();
            }
            else if (Session["Manager"] != null)
            {
                Manager manager = (Manager)Session["Manager"];
                ViewData["manager"] = manager;
                ModelState.AddModelError("Message", manager.username + "welcome");
                return View();
            }
            else
            {

                return RedirectToAction("Login");
            }
        }
        #endregion
        /// <summary>
        /// 当前用户的所有电站
        /// </summary>
        /// <returns>返回页面</returns>
        [IsLoginAttribute]
        public ActionResult AllPlant()
        {
            User user = null;
            PlantService plantInfoService = PlantService.GetInstance();
            if (Session[ComConst.User] != null)
            {
                user = UserUtil.getCurUser(); ;
                ViewData["plantInfo"] = null;
                return View();
            }
            else
            {
                return RedirectToAction("login", "auth");
            }

        }

        /// <summary>
        /// 添加电站
        /// </summary>
        /// <returns>添加页面</returns>
        public ActionResult AddPlant()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddPlant(string code, string password, string plantName)
        {
            CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();
            PlantService plantInfoService = PlantService.GetInstance();
            if (Session[ComConst.User] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("login", "auth");
            }
        }


        public ActionResult Reg()
        {
            //创建语言服务
            LanguageService languageservice = LanguageService.GetInstance();
            //获取所有语言信息
            IList<Language> languages = languageservice.GetList();
            string langName = "en-us";
            if (Request.UserLanguages != null && Request.UserLanguages.Length != 0)
            {
                langName = Request.UserLanguages[0];
            }
            languages = languages.OrderByDescending(lang => lang.codename.ToLower().Equals(langName)).ToList<Language>();
            ViewData["languages"] = languages;
            IList<CommonInfo> currencies = CommonInfoService.GetInstance().GetList(new CommonInfo() { pid = CommonInfo.Currency });
            IList<SelectListItem> items = new List<SelectListItem>();
            foreach (CommonInfo currency in currencies)
            {
                items.Add(new SelectListItem() { Text = string.Format("{0}:{1}", currency.code, currency.name), Value = currency.code });
            }
            ViewData["currencies"] = items;
            base.GetLanguage();
            return View();
        }

        public ActionResult Success()
        {
            return View();
        }


        /// <summary>
        /// 注册用户信息
        /// </summary>
        /// <param name="userInfo">用户字段</param>
        /// <returns>注册成功 跳转</returns>
        [HttpPost]
        public ActionResult Reg(User user)
        {
            int localZont = 0;
            int.TryParse(Request.Form["localZone"], out localZont);
            //创建语言服务
            LanguageService languageservice = LanguageService.GetInstance();
            //获取所有语言信息
            IList<Language> languages = languageservice.GetList();
            ViewData["languages"] = languages;
            User regUser = userService.GetUserByName(user.username);
            if (regUser == null)
            {
                int uid = 0;
                user.password = EncryptUtil.EncryptDES(user.password, EncryptUtil.defaultKey);
                uid = userService.save(user);
                //注册用户默认管理员权限
                UserRoleService.GetInstance().Insert(new UserRole() { userId = uid, roleId = Role.ROLE_SYSMANAGER });

                TempData[ComConst.User] = user;
                UserUtil.ResetLogin(user);
                //记录登录记录
                string ip = WebUtil.getClientIp(Request);
                LoginRecordService.GetInstance().Save(user.id, user.username, ip, localZont);

                return RedirectToAction("success", "auth");

            }
            else
            {

                ModelState.AddModelError("UserName", Resources.SunResource.REG_USERNAME_ERROR_INFO);
                return View();
            }

        }



        public ActionResult Email()
        {
            return View();
        }

        public ActionResult Deny()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CheckUser(string uname, string oldname)
        {
            User use = UserService.GetInstance().GetUserByName(uname);
            if (use != null && (uname.Equals(oldname) == false))
            {
                return Content("false");
            }
            return Content("true");
        }

        public ActionResult Expired()
        {
            return View();
        }
    }
}
