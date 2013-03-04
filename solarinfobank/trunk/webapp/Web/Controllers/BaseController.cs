using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Configuration;
using System.Threading;
using System.Globalization;
using System.Linq;
using System;
using System.Text;
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
            //如果是注册用户 直接返回 不做权限判断
            var user = filterContext.HttpContext.Session[ComConst.User] as User;
            var controller = filterContext.RouteData.Values["controller"].ToString().ToLower();
            var action = filterContext.RouteData.Values["action"].ToString().ToLower();
            if (user != null)
            {
                foreach (RoleFunction function in user.userRole.roleFunctions)
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

    public class SetLanguage : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            string language = filterContext.HttpContext.Request["language"];
            if (string.IsNullOrEmpty(language))
            {
                language = Language.enUS;
                CultureInfo cultureInfo = new CultureInfo(language);
                filterContext.HttpContext.Session["Culture"] = cultureInfo;
                Thread.CurrentThread.CurrentCulture = cultureInfo;
            }

            base.OnActionExecuting(filterContext);
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
            IList<int> yearList = collectorYearDataService.GetWorkYears(user.displayPlants);
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

        /// <summary>
        /// 当前用户的第一个电站
        /// </summary>
        protected Plant FirstPlant
        {
            get
            {
                IList<Plant> plants = UserUtil.getCurUser().displayPlants;
                return plants.Count > 0 ? plants[0] : null;
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
        /// 创建门户电站结构图
        /// </summary>
        /// <param name="topLevelPlants">顶层电站集合</param>
        /// <param name="level">当前电站层次</param>
        /// <param name="uplevel">上级电站层次,必须传入-1</param>
        /// <returns></returns>
        public string createPortalContructTree(IList<Plant> topLevelPlants, int uplevel, string topname, string width, string height)
        {
            string jsstr = "";
            if (uplevel == -1 && topLevelPlants.Count > 1)
            {
                jsstr += "myTree.add(" + "0" + "," + "-1" + ",'<div style=\"width:100%; text-align:center;\" title=\"" + topname + "\">" + StringUtil.cutStr(topname, 15, "...") + "</div>'," + width + "," + height + ",'#FFDFAE','#F18216');";
                uplevel++;
            }
            //有下级那么就递归调用下级生成脚本。进行累计
            if (topLevelPlants != null && topLevelPlants.Count > 0)
            {
                Plant tmpplant = null;
                int curLevel = 0;
                for (int i = 0; i < topLevelPlants.Count; i++)
                {
                    tmpplant = topLevelPlants[i];
                    curLevel = ((uplevel + 1) * 100 + i);
                    // tmpplant.name = string.Format("<div style=\"width:100%; text-align:center;\">{0}</div>", tmpplant.name);
                    jsstr += "myTree.add(" + curLevel + "," + uplevel + ",'<a target=\"_blank\" href=" + (tmpplant.isVirtualPlant ? string.Format("\"/portal/virtual/{0}\"", tmpplant.id) : string.Format("\"/portal/plant/{0}\"", tmpplant.id)) + "><div style=\"width:100%; text-align:center;\" title=\"" + tmpplant.name + "\">" + StringUtil.cutStr(tmpplant.name, 15, "...") + "</div></a>'," + width + "," + height + ",'#FFDFAE','#F18216');";
                    if (tmpplant.childs != null && tmpplant.childs.Count > 0)
                        jsstr += createPortalContructTree(tmpplant.childs, curLevel, "", width, height);
                }
            }
            return jsstr;
        }

        /// <summary>
        /// 创建页面js结构树的脚本
        /// </summary>
        /// <param name="topLevelPlants">顶层电站集合</param>
        /// <param name="level">当前电站层次</param>
        /// <param name="uplevel">上级电站层次,必须传入-1</param>
        /// <returns></returns>
        public string createPlantContructTree(IList<Plant> topLevelPlants, int uplevel, string width, string height)
        {
            string jsstr = "";
            if (uplevel == -1 && topLevelPlants.Count > 1)
            {
                jsstr += "myTree.add(" + "0" + "," + "-1" + ",'<a target=\"_blank\" href=" + "/user/allplants" + "><div style=\"width:100%; text-align:center;\">" + "所有电站" + "</div></a>'," + width + "," + height + ",'#FFDFAE','#F18216');";
                uplevel++;
            }
            //有下级那么就递归调用下级生成脚本。进行累计
            if (topLevelPlants != null && topLevelPlants.Count > 0)
            {
                Plant tmpplant = null;
                int curLevel = 0;
                for (int i = 0; i < topLevelPlants.Count; i++)
                {
                    tmpplant = topLevelPlants[i];
                    curLevel = ((uplevel + 1) * 100 + i);
                    // tmpplant.name = string.Format("<div style=\"width:100%; text-align:center;\">{0}</div>", tmpplant.name);
                    jsstr += "myTree.add(" + curLevel + "," + uplevel + ",'<a target=\"_blank\" href=" + (tmpplant.isVirtualPlant ? string.Format("\"/virtual/plantrelationstruct/{0}\"", tmpplant.id) : string.Format("\"/plant/overview/{0}\"", tmpplant.id)) + "><div style=\"width:100%; text-align:center;\" title=\"" + tmpplant.name + "\">" + StringUtil.cutStr(tmpplant.name, 15, "...") + "</div></a>'," + width + "," + height + ",'#FFDFAE','#F18216');";
                    if (tmpplant.childs != null && tmpplant.childs.Count > 0)
                        jsstr += createPlantContructTree(tmpplant.childs, curLevel, width, height);
                }
            }
            return jsstr;
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
                unitLevel = unitLevel * 100 + i;
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
                    jsstr += generateDeviceNode(devices, deviceLevel, unitLevel, DeviceData.getDeviceTypeByCode(DeviceData.HUILIUXIANG_CODE).name, "/images/tree/hlx.png");
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
                    jsstr += generateDeviceNode(devices, deviceLevel, unitLevel, DeviceData.getDeviceTypeByCode(DeviceData.ENVRIOMENTMONITOR_CODE).name, "/images/tree/hjjcy.png");
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
        /// 创建页面js结构树的脚本
        /// </summary>
        /// <param name="topLevelPlants">顶层电站集合</param>
        /// <param name="level">当前电站层次</param>
        /// <param name="uplevel">上级电站层次,必须传入-1</param>
        /// <returns></returns>
        public string createInverterContructTree(Plant plant, int uplevel)
        {
            string jsstr = string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '/images/tree/folder.gif');", 1, -1, "选择设备", "javascript:void(0);");
            //
            int topLevel = 1;
            int deviceLevel = 1;
            string firstRun = "";
            int unitLevel = 1;
            //遍历单元，先显示单元层级
            PlantUnit pu = null;
            for (int i = 0; i < plant.plantUnits.Count; i++)
            {
                pu = plant.plantUnits[i];
                unitLevel = unitLevel * 100 + i;
                jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '/images/tree/unit.gif');", unitLevel, topLevel, pu.displayname, "javascript:void(0);");

                //先装机逆变器类型设备节点
                IList<Device> devices = pu.typeDevices(DeviceData.INVERTER_CODE, false);
                if (devices != null && devices.Count > 0)
                {
                    deviceLevel = unitLevel + 10;
                    firstRun = ";";
                    jsstr += firstRun;
                    jsstr += generateInterverNode(devices, deviceLevel, unitLevel, DeviceData.getDeviceTypeByCode(DeviceData.INVERTER_CODE).name);
                }
            }
            jsstr += ";d.closeAll();";
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
        private string generateInterverNode(IList<Device> devices, int deviceLevel, int topLevel, string typeName)
        {
            string jsstr = string.Empty;
            // jsstr += "myTree.add(" + deviceLevel + "," + topLevel + ",'" + typeName + "',80,20,'#FFDFAE','#F18216');";
            // jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '/images/tree/folder.gif');", deviceLevel, topLevel, typeName, "javascript:void(0);");

            if (devices != null && devices.Count > 0)
            {
                Device device = null;
                for (int i = 0; i < devices.Count; i++)
                {
                    device = devices[i];
                    int tmpLevel = deviceLevel * 100 + i;
                    //jsstr += "myTree.add(" + tmpLevel + "," + deviceLevel + ",'" + device.fullName + "',80,20,'#FFDFAE','#F18216','javascript:parent.loadRunData(" + device.id + ")');";
                    jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '/images/tree/inverter.png');", tmpLevel, topLevel, device.fullName, "javascript:parent.loadRunData(" + string.Format("{0}", device.id) + ")");

                }
            }
            return jsstr;
        }

        private const double EARTH_RADIUS = 6378.137;//地球半径

        private double rad(double d)
        {
            return d * Math.PI / 180.0;
        }

        protected double GetDistance(double lat1, double lng1, double lat2, double lng2)
        {
            double radLat1 = rad(lat1);
            double radLat2 = rad(lat2);
            double a = radLat1 - radLat2;
            double b = rad(lng1) - rad(lng2);

            double s = 2 * Math.Asin(Math.Sqrt(Math.Pow(Math.Sin(a / 2), 2) +
             Math.Cos(radLat1) * Math.Cos(radLat2) * Math.Pow(Math.Sin(b / 2), 2)));
            s = s * EARTH_RADIUS;
            s = Math.Round(s * 10000) / 10000;
            return s;
        }

        public void removeStructPicConfig(string id)
        {
            string path = Server.MapPath("~") + "/config/";
            path = string.Format("{1}structPointConfig{0}.xml", id, path);
            if (System.IO.File.Exists(path))
            {
                System.IO.File.Delete(path);
            }
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

        public string generateDeviceRelation(Plant plant)
        {
            string jsstr = string.Empty;
            int curLevel = 1;
            int uplevel = -1;
            jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '{4}');", curLevel, uplevel, plant.name, "javascript:void(0);", "");
            int topLevel = 1;
            int deviceLevel = 1;
            int unitLevel = 1;
            //遍历单元，先显示单元层级
            PlantUnit pu = null;
            for (int i = 0; i < plant.plantUnits.Count; i++)
            {
                pu = plant.plantUnits[i];
                unitLevel = unitLevel * 100 + i;
                jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '');", unitLevel, topLevel, pu.displayname, string.Format("javascript:setPara({0},{1},{2});",pu.id,"true",pu.id));

                //先装机逆变器类型设备节点
                IList<Device> devices = pu.logicalDevices;
                if (devices != null && devices.Count > 0)
                {
                    deviceLevel = unitLevel + 10;
                    jsstr += generateDeviceRelation(devices, deviceLevel, unitLevel, pu.id);
                }
            }
            return jsstr;
        }

        public string generateDeviceRelation(IList<Device> devices, int deviceLevel, int uplevel,int unitId)
        {
            string jsstr = string.Empty;
            //有下级那么就递归调用下级生成脚本。进行累计
            if (devices != null && devices.Count > 0)
            {
                Device device = null;
                int curLevel = 0;
                for (int i = 0; i < devices.Count; i++)
                {
                    device = devices[i];
                    curLevel = ((uplevel + 1) * 100 + i);
                    jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '');", curLevel, uplevel, device.fullName, string.Format("javascript:setPara({0},{1},{2});", device.id, "false", unitId));
                    if (device.child != null && device.child.Count > 0)
                    {
                        int tmpLevel =((uplevel + 1) * 100 + i);
                        jsstr += generateDeviceRelation(device.child, tmpLevel, curLevel, unitId);
                    }
                }
            }
            return jsstr;
        }
    }
}