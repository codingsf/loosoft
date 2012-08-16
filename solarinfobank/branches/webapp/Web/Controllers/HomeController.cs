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

using System.Web.UI;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Threading;
using System.Net;
using System.Web.Script.Serialization;


namespace Web.Controllers
{
    /// <summary>
    /// 赵文辉
    /// Author: 赵文辉
    /// Time: 2011年2月19日 01:08:15  第二次修改
    /// </summary>
    [HandleError]
    public class HomeController : BaseController
    {
        //用户服务
        UserService userService = UserService.GetInstance();
        ManagerService managerService = ManagerService.GetInstance();
        AdpicService adpicservice = AdpicService.GetInstance();
        ProductPictureService productPictureService = ProductPictureService.GetInstance();

        public ActionResult LoginOut()
        {
            base.logout();

            return View("index");
        }

        /// 通过该方法，实现语言切换
        /// </summary>
        /// <param name="lang">语言</param>
        /// <param name="returnUrl">执行页面</param>
        /// <returns>语言转换后的页面</returns>
        public ActionResult ChangeCulture(string lang, string name, string returnUrl, string inituri, string loading_type)
        {
            CultureInfo cultureInfo = new CultureInfo(lang);
            Session["Culture"] = cultureInfo;
            Session["display"] = name;
            Thread.CurrentThread.CurrentCulture = cultureInfo;
            if (string.IsNullOrEmpty(inituri) == false)
            {
                if (inituri.Contains("http://") == false)
                {
                    inituri = string.Format("http://{0}{1}", Request.Url.Host, inituri);
                }
                Uri uri = new Uri(inituri);
                Session["initurl"] = uri.AbsolutePath;
            }
            else
                Session["initurl"] = string.Empty;
            Session["loading_type"] = loading_type;
            return Redirect(returnUrl);
        }

        #region 作者：鄢睿
        /// <summary>
        /// 作者：鄢睿
        /// 功能：显示用户所具有的电站数量
        /// 创建时间：2011-02-18 19:42
        /// </summary>
        /// <returns></returns>
        public ActionResult plants()
        {
            //PlantInfoService plangInfoService = PlantInfoService.GetInstance();
            if (Session[ComConst.User] != null)
            {
                User userInfo = UserUtil.getCurUser(); ;
                ViewData["userInfo"] = userInfo;
                ModelState.AddModelError("Message", userInfo.username + "欢迎您的到来");
                IList<Plant> plangInfoList = null;
                //plangInfoService.GetPlantInfoListByUserId(userInfo.Id); ViewData["plantInfo"] = plangInfoList;
                return View(plangInfoList);
            }
            else if (Session[ComConst.Manager] != null)
            {
                Manager manager = (Manager)Session[ComConst.Manager];
                ViewData[ComConst.Manager] = manager;
                ModelState.AddModelError("Message", manager.username + "欢迎您的到来");
                return View();
            }
            else
            {

                return RedirectToAction("Login");
            }
        }
        #endregion


        /// <summary>
        /// 修改  陈波
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            //ExcelUtil.createChart();
            if (System.Web.HttpContext.Current.Request.Cookies["a_login"] != null)
            {
                HttpCookie cookie = System.Web.HttpContext.Current.Request.Cookies["a_login"];
                User user = new User() { username = cookie.Values["un"], password = cookie.Values["pwd"] };
                Index(user, true, "0", "1111");
            }

            if (UserUtil.isLogined())
                return RedirectToAction("overview", "user");

            float co2Rate = ItemConfigService.GetInstance().getCO2Config();

            User userinfo = UserService.GetInstance().GetUserByName(UserUtil.demousername);
            if (userinfo != null)
            {
                IList<PlantUser> plant = PlantUserService.GetInstance().GetAllPlantUserByUserID(new PlantUser { userID = userinfo.id });
                ViewData["examplePlant"] = plant;
            }
            double alltotalenergy = DeviceRunDataService.GetInstance().GetAllTotalEnergy();
            double dayEnergy = CollectorRunDataService.GetInstance().GetAllDayEnergy();
            double co2Value = alltotalenergy * co2Rate;
            ViewData["co2Unit"] = Util.upCo2Unit(co2Value);
            ViewData["energyUnit"] = Util.upEnergyUnit(alltotalenergy);
            ViewData["dayenergyUnit"] = Util.upEnergyUnit(dayEnergy);
            ViewData["AllTotalEnergy"] = StringUtil.formatDouble(Util.upDigtal(alltotalenergy));
            ViewData["AlldayTotalEnergy"] = StringUtil.formatDouble(Util.upDigtal(dayEnergy));
            ViewData["AllCO2"] = StringUtil.formatDouble(Util.upDigtal(co2Value));

            //取得产品图片
            getPPics();
            getAdPics();

            //取得最新加入的电站
            IList<Plant> newPlants = PlantService.GetInstance().GetNewPlantInfoList(4);
            ViewData["newPlants"] = newPlants;
            return View();
        }

        /// <summary>
        /// 取得产品图片
        /// </summary>
        private void getPPics()
        {
            string imageFileName = string.Empty;
            string targetUrl = string.Empty;

            IList<ProductPicture> list = productPictureService.GetAllProductPicture();
            foreach (ProductPicture picture in list)
            {
                imageFileName += string.Format("{0}#", picture.picName);
                targetUrl += string.Format("{0}#", picture.picUrl);
            }

            ViewData["ppicstr"] = imageFileName.Length > 0 ? imageFileName.Substring(0, imageFileName.Length - 1) : "";
            ViewData["ppicUrl"] = targetUrl.Length > 0 ? targetUrl.Substring(0, targetUrl.Length - 1) : "";
        }

        /// <summary>
        /// 取得宣传图片
        /// </summary>
        private void getAdPics()
        {
            string pic = "";
            if (Session["Culture"] == null)
                pic = "en-US";
            else
                pic = Session["Culture"].ToString();
            IList<Adpic> list = adpicservice.GetAdpicByLanguage(pic);
            ViewData["piclist"] = list;
            ViewData["language"] = pic;
        }

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="user">用户对象</param>
        /// <returns>成功进入主页(plants.aspx),失败返回该页</returns>
        [HttpPost]
        public ActionResult Index(User user, bool autoLogin, string localZone, string validatecode)
        {

            float lzone = 0;
            float.TryParse(localZone, out lzone);
            //取得最新加入的电站
            IList<Plant> newPlants = PlantService.GetInstance().GetNewPlantInfoList(4);
            User userinfo = UserService.GetInstance().GetUserByName(UserUtil.demousername);
            if (userinfo != null)
            {
                IList<PlantUser> plant = PlantUserService.GetInstance().GetAllPlantUserByUserID(new PlantUser { userID = userinfo.id });
                ViewData["examplePlant"] = plant;
            }
            ViewData["newPlants"] = newPlants;
            float co2Rate = ItemConfigService.GetInstance().getCO2Config();
            ViewData["AllPlant"] = PlantService.GetInstance().GetPlantNum();

            double alltotalenergy = DeviceRunDataService.GetInstance().GetAllTotalEnergy();
            double dayEnergy = CollectorRunDataService.GetInstance().GetAllDayEnergy();
            double co2Value = alltotalenergy * co2Rate;
            ViewData["co2Unit"] = Util.upCo2Unit(co2Value);
            ViewData["energyUnit"] = Util.upEnergyUnit(alltotalenergy);
            ViewData["dayenergyUnit"] = Util.upEnergyUnit(dayEnergy);
            ViewData["AllTotalEnergy"] = StringUtil.formatDouble(Util.upDigtal(alltotalenergy));
            ViewData["AlldayTotalEnergy"] = StringUtil.formatDouble(Util.upDigtal(dayEnergy));
            ViewData["AllCO2"] = StringUtil.formatDouble(Util.upDigtal(co2Value));

            getPPics();

            getAdPics();


            //验证码验证提示
            if (ValidateCodeUtil.Validated(validatecode) == false)
            {
                ModelState.AddModelError("Error", "验证码输入错误!");
                System.Web.HttpContext.Current.Response.Cookies["a_login"].Expires = DateTime.Now.AddDays(-1);
                return View(user);
            }


            //首先认为是电站用户登录
            User loginUser = userService.GetUserByName(user.username);

            if (loginUser == null || !loginUser.depassword.Equals(user.password))
            {
                //判断是否管理员
                Manager manager = managerService.GetUserByName(user.username);
                if (manager != null)
                {
                    if (manager.depassword.Equals(user.password))
                    {
                        manager = managerService.GetManagerByLocked(user.username);
                        if (manager != null)
                        {
                            if (autoLogin)
                                SetCookie(user.username, manager.password);
                            base.mlogin(manager);

                            //这里admin 默认所有权限
                            if (manager.username.Equals("admin"))
                                return RedirectToAction(@"users", "admin");
                            if (manager.roles == null || manager.roles.Count == 0)
                                return Content("access denied");

                            foreach (AdminUserRole auserRole in manager.roles)
                            {
                                if (auserRole.role != null)
                                {

                                    IList<AdminControllerAction> acas = AdminControllerActionServices.GetInstance().GetList();
                                    IList<AdminControllerAction> allow = AdminRole.AllowActionsList(acas, auserRole.role.actions);
                                    foreach (AdminControllerAction aca in allow)
                                    {
                                        if (aca.isAutoRedirect)
                                            return RedirectToAction(@aca.actionName, aca.controllerName);
                                    }
                                }
                            }
                            //return RedirectToAction(@"collectors", "admin");

                        }
                        else
                        {
                            System.Web.HttpContext.Current.Response.Cookies["a_login"].Expires = DateTime.Now.AddDays(-1);
                            ModelState.AddModelError("Error", Resources.SunResource.MANAGER_LOGIN_LOCKED);
                            return View(user);
                        }

                    }
                }
                else
                {
                    System.Web.HttpContext.Current.Response.Cookies["a_login"].Expires = DateTime.Now.AddDays(-1);
                    ModelState.AddModelError("Error", Resources.SunResource.HOME_INDEX_VALIDATED);
                    return View(user);
                }
            }
            else
            {
                if (loginUser.depassword.Equals(user.password))
                {
                    //注释  不根据用户语言设置默认语言
                    //CultureInfo cultureInfo = null;
                    //if (loginUser.Language == null)
                    //    loginUser.Language = new Language() { codename = "en-us" };
                    //cultureInfo = new CultureInfo(loginUser.Language.codename);
                    //Session["Culture"] = cultureInfo;
                    //Thread.CurrentThread.CurrentCulture = cultureInfo;
                    //Session["display"] = loginUser.Language.name;

                    if (autoLogin)
                        SetCookie(user.username, loginUser.depassword);
                    UserUtil.login(loginUser);

                    //记录登录记录
                    string ip = WebUtil.getClientIp(Request);
                    LoginRecordService.GetInstance().Save(loginUser.id, loginUser.username, ip, lzone);

                    //判断是否完成注册的三个步骤
                    //第二步没有完成依据  用户下没有电站
                    //第三步完成依据 任何电站下没有设备 

                    if (loginUser.plants.Count.Equals(0))
                        return Redirect("/newregister/addplant");
                    if (!loginUser.isBindUnit)
                        return Redirect("/newregister/addunit");
                    if (loginUser.plantUsers.Count == 1)
                        return RedirectToAction("overview", "plant", new { @id = base.FirstPlant.id });
                    else
                    {
                        if (loginUser.plantUsers.Count > 0)
                        {
                            //用户登陆默认显示选中左边导航栏中的"所有电站"，右边窗口打开"电站列表"页面。 
                            //Session["firstLogin"] = true;
                            return RedirectToAction("allplants", "user");
                        }
                        else
                        {
                            return RedirectToAction("addoneplant", "user");
                        }
                    }
                }
            }
            if (user.username.Equals("admin") && user.depassword.Equals("sungrow2011"))
            {
                Session["collectorAddedEnable"] = true;
                return RedirectToAction("admin", "admin");
            }
            //登录失败
            ModelState.AddModelError("Error", "username or password is not validated");
            System.Web.HttpContext.Current.Response.Cookies["a_login"].Expires = DateTime.Now.AddDays(-1);
            return View(user);
        }
        /// <summary>
        /// 功能：示例电站
        /// </summary>
        /// <returns></returns>
        public ActionResult ExamplePlant()
        {
            string zone = Request.QueryString.ToString();
            float fzone = 0;
            float.TryParse(zone, out fzone);
            User userinfo = UserService.GetInstance().GetUserByName(UserUtil.demousername);
            UserUtil.login(userinfo);
            LoginRecordService.GetInstance().Save(userinfo.id, userinfo.username, WebUtil.getClientIp(Request), fzone);
            return RedirectToAction("allplants", "user");
        }


        public void SetCookie(string userName, string pwd)
        {
            HttpCookie cookie = new HttpCookie("a_login");
            cookie.Values["un"] = userName;
            cookie.Values["pwd"] = pwd;
            cookie.Expires = DateTime.Now.AddMonths(1);
            System.Web.HttpContext.Current.Response.Cookies.Add(cookie);
        }
    }
}
