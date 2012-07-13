using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Configuration;
using System.Threading;
using System.Globalization;
using System;
using System.Linq;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{


    public class IsLoginAttribute : ActionFilterAttribute
    {
        static string autologinName = ConfigurationSettings.AppSettings["autologinName"];

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session[ComConst.User] == null)
            {
                if (string.IsNullOrEmpty(autologinName))
                {
                    filterContext.HttpContext.Response.Write("<script>if(parent!=null) parent.window.location.href='/?t'; else window.location.href='/?t';</script>");
                    filterContext.HttpContext.Response.End();
                    return;
                }
                else
                {
                    User user = UserService.GetInstance().GetUserByName(autologinName);
                    UserUtil.login(user);

                    //记录登录记录
                    string ip = WebUtil.getClientIp(filterContext.HttpContext.Request);
                    LoginRecordService.GetInstance().Save(user.id, autologinName, ip, 0);

                    base.OnActionExecuting(filterContext);
                }
            }
            else
            {
                base.OnActionExecuting(filterContext);
            }
        }
    }

    public class IsLoginAttributeAdmin : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session[ComConst.Manager] == null)
                filterContext.HttpContext.Response.Redirect("/");
            base.OnActionExecuting(filterContext);
        }
    }

    public class IsHavaPlant : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session[ComConst.User] != null && (UserUtil.getCurUser()).plantUsers.Count <= 0)
            {
                filterContext.HttpContext.Response.Redirect("/user/addplant");
            }
            base.OnActionExecuting(filterContext);
        }
    }

    public class UserAuthorizeAttribute : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            var user = filterContext.HttpContext.Session[ComConst.User] as User;
            var controller = filterContext.RouteData.Values["controller"].ToString().ToLower();
            var action = filterContext.RouteData.Values["action"].ToString().ToLower();
            if (user != null)
            {

                foreach (RoleFunction function in user.UserRole.RoleFunctions)
                {
                    var role = AuthorizationCode.GetRole(function.functionCode);
                    if (role != null && role.action.Equals(action) && role.controller.Equals(controller))
                    {
                        filterContext.RequestContext.HttpContext.Response.Redirect("/auth/deny", true);
                    }
                }
            }

        }
    }

    /// <summary>
    /// 根据session设置线程语言
    /// </summary>
    public class SetLanAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            object obj = filterContext.HttpContext.Session["Culture"];
            if (obj != null)
            {
                Thread.CurrentThread.CurrentCulture = (CultureInfo)obj;
            }
            else {//取得浏览器语言 modify by qhb in 2012 session 过期就浏览器语言
                if (HttpContext.Current.Request.UserLanguages != null && HttpContext.Current.Request.UserLanguages.Length != 0)
                {
                    string langName = HttpContext.Current.Request.UserLanguages[0].ToLower();
                    if (langName.StartsWith("de", StringComparison.OrdinalIgnoreCase))
                        langName = "de-de";//德文
                    else
                        if (langName.StartsWith("it", StringComparison.OrdinalIgnoreCase))
                            langName = "it-ch";//意大利
                        else if (langName.StartsWith("zh", StringComparison.OrdinalIgnoreCase))
                            langName = "zh-cn";
                        else
                            langName = "en-us";//默认英文

                    CultureInfo cultureInfo = new CultureInfo(langName);
                    Thread.CurrentThread.CurrentCulture = cultureInfo;
                    filterContext.HttpContext.Session["Culture"] = cultureInfo;

                    LanguageService languageservice = LanguageService.GetInstance();
                    IList<Language> languages = languageservice.GetList();
                    string displayName = languages.OrderByDescending(lang => lang.codename.ToLower().Equals(langName)).First<Language>().name;
                    filterContext.HttpContext.Session["display"] = displayName;
                }
            }
            base.OnActionExecuting(filterContext);
        }
    }

    /// <summary>
    /// web 工具
    /// </summary>
    public static class WebUtil
    {

        public static string getClientIp(HttpRequestBase request)
        {
            string ip = "";
            if (request.ServerVariables["HTTP_VIA"] != null) // using proxy
            {
                ip = request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();  // Return real client IP.
            }
            else// not using proxy or can't get the Client IP
            {
                ip = request.ServerVariables["REMOTE_ADDR"].ToString(); //While it can't get the Client IP, it will return proxy IP.
            }
            return ip;
        }


    }

    /// <summary>
    /// 基类控制器
    /// author:hbqian
    /// </summary>
    [UserAuthorizeAttribute]
    [SetLanAttribute]
    public abstract class BaseController : Controller
    {
        protected CollectorYearDataService collectorYearDataService = CollectorYearDataService.GetInstance();
        public BaseController() { }

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
        /// <summary>
        /// 单个电站的工作年份
        /// </summary>
        /// <param name="plantId"></param>
        protected void FillPlantYears(int plantId)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(plantId);
            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);
            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData[ComConst.WorkYears] = plantYearsList;
        }

        /// <summary>
        /// 所有当前用户的电站工作年份
        /// </summary>
        /// <param name="userId"></param>
        protected void FillAllPlantYears(User user)
        {
            IList<int> yearList = collectorYearDataService.GetWorkYears(user.plants);
            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData[ComConst.WorkYears] = plantYearsList;
        }


        /// <summary>
        /// 
        /// 设置管理员登录状态
        /// author:hbqian
        /// </summary>
        /// <param name="user"></param>
        protected void mlogin(Manager manager)
        {
            Session[ComConst.Manager] = manager;
        }

        /// <summary>
        /// 
        /// 退出
        /// author: hbqian
        /// </summary>
        protected void logout()
        {
            Session[ComConst.User] = null;
            Session[ComConst.Manager] = null;
            System.Web.HttpContext.Current.Application.Remove(Session.SessionID);
        }

        /// <summary>
        /// 查找指定的电站
        /// author :chen bo 
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        protected Plant FindPlant(int id)
        {
            return PlantService.GetInstance().GetPlantInfoById(id);
        }

        protected Plant FirstPlant
        {
            get
            {
                return UserUtil.getCurUser().plants.Count > 0 ? UserUtil.getCurUser().plants[0] : null;
            }
        }

        //根据当前所选国家对应当前语言
        public void GetLanguage()
        {
            string language = "";
            if (Session["Culture"] == null)
                language = "en-US";
            else
                language = Session["Culture"].ToString();
            ViewData["language"] = language;
        }

        /// <summary>
        /// 取得当前url的应用程序部分
        /// </summary>
        /// <param name="request"></param>
        public string getCurWebContext()
        {
            return Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port;
        }

        /// <summary>
        /// 创建页面js结构树的脚本
        /// </summary>
        /// <param name="topLevelPlants">顶层电站集合</param>
        /// <param name="level">当前电站层次</param>
        /// <param name="uplevel">上级电站层次,必须传入-1</param>
        /// <returns></returns>
        public string createDeviceContructTree(Plant plant, int uplevel)
        {
            string jsstr = "";
            
            int topLevel = -1;
            int deviceLevel = 1;
            string firstRun = "";
            int unitLevel = 1;
            //(string.IsNullOrEmpty(plant.firstPic) ? "/ufile/small/nopic/nopico02/gif" : "/ufile/small/"+plant.firstPic
            //增加电站节点
            jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '{4}');", unitLevel, topLevel, plant.name, "javascript:void(0);", "");
            topLevel = 1;
            //遍历单元，先显示单元层级
            PlantUnit pu = null;
            for (int i = 0; i < plant.plantUnits.Count; i++)
            {
                pu = plant.plantUnits[i];
                unitLevel = unitLevel * 10 + i;
                jsstr += string.Format("d.add({0}, {1}, '{2}', '{3}', '', '', '');", unitLevel, topLevel, pu.displayname, "javascript:void(0);");

                //先装机逆变器类型设备节点
                IList<Device> devices = pu.typeDevices(DeviceData.INVERTER_CODE, false);
                if (devices != null && devices.Count > 0)
                {
                    deviceLevel = unitLevel + 1;
                    firstRun = "parent.loadRunData(" + devices[0].id + ");";
                    jsstr += firstRun;
                    jsstr += generateDeviceNode(devices, deviceLevel, unitLevel, DeviceData.getDeviceTypeByCode(DeviceData.INVERTER_CODE).name, "/images/tree/inverter.png");
                }

                //汇流箱类型设备节点
                devices = pu.typeDevices(DeviceData.HUILIUXIANG_CODE, false);
                if (devices != null && devices.Count > 0)
                {
                    deviceLevel = unitLevel + 2;
                    if (string.IsNullOrEmpty(firstRun))
                    {
                        firstRun = "parent.loadRunData(" + devices[0].id + ");";
                        jsstr += firstRun;
                    }
                    jsstr += generateDeviceNode(devices, deviceLevel, unitLevel, DeviceData.getDeviceTypeByCode(DeviceData.HUILIUXIANG_CODE).name,"/images/tree/hlx.png");
                }

                //环境监测仪类型设备节点
                devices = pu.typeDevices(DeviceData.ENVRIOMENTMONITOR_CODE, false);
                if (devices != null && devices.Count > 0)
                {
                    deviceLevel = unitLevel + 3;
                    if (string.IsNullOrEmpty(firstRun))
                    {
                        firstRun = "parent.loadRunData(" + devices[0].id + ");";
                        jsstr += firstRun;
                    }
                    jsstr += generateDeviceNode(devices, deviceLevel, unitLevel, DeviceData.getDeviceTypeByCode(DeviceData.ENVRIOMENTMONITOR_CODE).name,"/images/tree/hjjcy.png");
                }
                //配电柜类型设备节点
                devices = pu.typeDevices(DeviceData.CABINET_CODE, false);
                if (devices != null && devices.Count > 0)
                {
                    deviceLevel = unitLevel + 4;
                    if (string.IsNullOrEmpty(firstRun))
                    {
                        firstRun = "parent.loadRunData(" + devices[0].id + ");";
                        jsstr += firstRun;
                    }
                    jsstr += generateDeviceNode(devices, deviceLevel, unitLevel, DeviceData.getDeviceTypeByCode(DeviceData.CABINET_CODE).name, "");
                }
                //电表
                devices = pu.typeDevices(DeviceData.AMMETER_CODE, false);
                if (devices != null && devices.Count > 0)
                {
                    deviceLevel = unitLevel + 5;
                    if (string.IsNullOrEmpty(firstRun))
                    {
                        firstRun = "parent.loadRunData(" + devices[0].id + ");";
                        jsstr += firstRun;
                    }
                    jsstr += generateDeviceNode(devices, deviceLevel, unitLevel, DeviceData.getDeviceTypeByCode(DeviceData.AMMETER_CODE).name, "/images/tree/dianbiao.png");
                }
            }
            return jsstr;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="devices">设备列表</param>
        /// <param name="deviceLevel">设备层级</param>
        /// <param name="topLevel">上层级别</param>
        /// <param name="typeName">设备类型</param>
        /// <returns></returns>
        private string generateDeviceNode(IList<Device> devices, int deviceLevel, int topLevel, string typeName, string pic)
        {
            string jsstr = string.Empty;
            // jsstr += "myTree.add(" + deviceLevel + "," + topLevel + ",'" + typeName + "',80,20,'#FFDFAE','#F18216');";
            jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '{4}');", deviceLevel, topLevel, typeName, "javascript:void(0);", pic);

            if (devices != null && devices.Count > 0)
            {
                Device device = null;
                for (int i = 0; i < devices.Count; i++)
                {
                    device = devices[i];
                    int tmpLevel = deviceLevel * 10 + i;
                    //jsstr += "myTree.add(" + tmpLevel + "," + deviceLevel + ",'" + device.fullName + "',80,20,'#FFDFAE','#F18216','javascript:parent.loadRunData(" + device.id + ")');";
                    jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '');", tmpLevel, deviceLevel, device.fullName, "javascript:parent.loadRunData(" + device.id + ")");

                }
            }
            return jsstr;
        }
    }
}
