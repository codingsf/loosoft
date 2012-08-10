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
    public class NewController : BaseController
    {
        //
        // GET: /New/

        public ActionResult Index()
        {
            return View();
        }


        public ActionResult Register()
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

        [HttpPost]
        public ActionResult Save(User user)
        {
            int localZont = 0;
            int.TryParse(Request.Form["localZone"], out localZont);
            //创建语言服务
            LanguageService languageservice = LanguageService.GetInstance();
            //获取所有语言信息
            IList<Language> languages = languageservice.GetList();
            ViewData["languages"] = languages;
            User regUser = UserService.GetInstance().GetUserByName(user.username);
            if (regUser == null)
            {
                int uid = 0;
                user.password = EncryptUtil.EncryptDES(user.password, EncryptUtil.defaultKey);
                uid = UserService.GetInstance().save(user);
                //注册用户默认管理员权限
                UserRoleService.GetInstance().Insert(new UserRole() { userId = uid, roleId = 3 });

                TempData[ComConst.User] = user;
                UserUtil.ResetLogin(user);
                //记录登录记录
                string ip = WebUtil.getClientIp(Request);
                LoginRecordService.GetInstance().Save(user.id, user.username, ip, localZont);

                return RedirectToAction("addplant", "new");

            }
            else
            {

                ModelState.AddModelError("UserName", Resources.SunResource.REG_USERNAME_ERROR_INFO);
                return View();
            }
        }

        public ActionResult AddPlant()
        {
            return View();
        }

        public ActionResult AddPlantControl()
        {
            return View();
        }

        public ActionResult AddUnit()
        {
            return View();
        }
    }
}
