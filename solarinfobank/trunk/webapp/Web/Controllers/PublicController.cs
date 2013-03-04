using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Globalization;
using System.Text.RegularExpressions;
using Cn.Loosoft.Zhisou.SunPower.Web.Controllers;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Timers;
using System.Text;
using Dimac.JMail;

namespace Web.Controllers
{
    /// <summary>
    /// 赵文辉
    /// Author: 赵文辉
    /// Time: 2011年2月19日 01:08:15  第二次修改
    /// </summary>
    [HandleError]
    public class PublicController : BaseController
    {
        UserService userservice = UserService.GetInstance();
        ManagerService managerService = ManagerService.GetInstance();
        AdpicService adpicservice = AdpicService.GetInstance();
        ProductPictureService productPictureService = ProductPictureService.GetInstance();

        /// <summary>
        /// 显示正在建设中的页面
        /// </summary>
        /// <returns></returns>
        public ActionResult StaticPage()
        {
            return View();
        }

        /// <summary>
        /// 维护页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Maintain()
        {
            return View();
        }
        public ActionResult Agree()
        {
            return View();
        }

        public ActionResult FindPassword()
        {
            return View();
        }

        /// <summary>
        /// 手工更新缓存
        /// </summary>
        /// <returns></returns>
        public ActionResult flushCache()
        {
            //更新设备缓存
            CacheService.GetInstance().flushCaches();
            return Content("");
        }

        [HttpPost]
        public ActionResult FindPassword(string email, string uname)
        {
            User user = userservice.GerUserbyUserName(email, uname);
            if (user == null)
            {
                ViewData["error"] = "<em><span id=\"serverError\" class='error'>" + Resources.SunResource.USER_FINDPASSWORD_EMAIL_NOT_REGISTERED + "</span></em>";
                //显示错误信息,不存在此账号
            }
            else
            {
                MailServerPoolObject obj = EmailConnectionPool.getMailServerPoolObject();
                if (obj == null)
                {
                    ViewData["error"] = "<em><span id=\"serverError\" class='error'>" + Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_ERROR + "</span></em>";
                }
                else
                {
                    Message message = new Message();
                    message.BodyText = string.Format(Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_EMAIL_BODY, user.username, user.depassword);
                    message.From.Email = obj.accountName;
                    message.To.Add(user.email);
                    message.Subject = Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_EMAIL_SUBJECT;
                    if (obj.SendMail(message))
                    {
                        ViewData["error"] = "<em><span id=\"serverError\" class='success'>" + Resources.SunResource.USER_FINDPASSWORD_CHECK_EMAIL + "</span></em>";
                        //userservice.UpdatePassword(user.id, user.password);
                    }
                    else
                        ViewData["error"] = "<em><span id=\"serverError\" class='error'>" + Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_EMAIL_ERROR1 + "</span></em> ";
                    obj.close();
                }

            }


            return View();
        }


        public ActionResult App()
        {
            return View();
        }


        public ActionResult ContactUs()
        {
            return View();
        }

        public ActionResult Solarinfobank_Android()
        {
            string path = Server.MapPath("/app/SolarInfo bank_v1.0.apk");
            return File(path, "apk File; charset=UTF-8", urlcode("SolarInfo bank_v1.0.apk"));
        }
    }
}
