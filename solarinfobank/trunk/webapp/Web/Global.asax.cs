using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Globalization;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Timers;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Configuration;
using System.Threading;
namespace Web
{

    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801
    public class MvcApplication : System.Web.HttpApplication
    {
        static string isDebug = ConfigurationSettings.AppSettings["isDebug"];
        static string energywarn = ConfigurationSettings.AppSettings["energywarn"];
        static string wap = ConfigurationSettings.AppSettings["isWap"];
        string syndata = ConfigurationSettings.AppSettings["syndata"];//是否同步数据
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "PortalIndex", // Route name
                "p/{username}", // URL with parameters
                new { controller = "p", action = "index" }
            );

            if (wap.Equals("true"))
            {
                routes.MapRoute(
                    "Default", // Route name
                    "{controller}/{action}/{id}", // URL with parameters
                    new { controller = "Wap", action = "Index", id = UrlParameter.Optional } // Parameter defaults
                );
            }
            else
            {
                routes.MapRoute(
                    "Default", // Route name
                    "{controller}/{action}/{id}", // URL with parameters
                    new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
                );
            }

            routes.MapRoute(
               "DeviceUnit", // Route name
               "{controller}/{action}/{plantId}/{deviceId}/{unitId}", // URL with parameters
               new { controller = "Plant", action = "Device" },// Parameter defaults
               new { plantId = @"\d+?", deviceId = @"\d+?", unitId = @"\d+?" }

            );
            routes.MapRoute(
               "Device", // Route name
               "{controller}/{action}/{plantId}/{deviceId}", // URL with parameters
               new { controller = "Plant", action = "Device" },// Parameter defaults
               new { plantId = @"\d+?", deviceId = @"\d+?" }
            );

            routes.MapRoute(
               "CustomChart", // Route name
               "plant/ViewCustomChart/{pId}/{cId}", // URL with parameters
               new { controller = "Plant", action = "ViewCustomChart" },// Parameter defaults
               new { pId = @"\d+?", cId = @"\d+?" }
            );
            routes.MapRoute(
                "DeviceChart", // Route name
                "{controller}/{action}/{pId}/{dId}", // URL with parameters
                new { controller = "DeviceChart", action = "Chart" },// Parameter defaults
                new { pId = @"\d+?", dId = @"\d+?" }
            );

        }


        protected void Application_AcquireRequestState(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session != null)
            {
                CultureInfo cultureInfo = (CultureInfo)Session["Culture"];
                // 判断Session中是否有值，没有就设置默认值
                if (cultureInfo == null)
                {
                    string langName = "en-us";
                    if (HttpContext.Current.Request.UserLanguages != null && HttpContext.Current.Request.UserLanguages.Length != 0)
                    {
                        langName = HttpContext.Current.Request.UserLanguages[0].ToLower();
                        if (langName.StartsWith("de", StringComparison.OrdinalIgnoreCase))
                            langName = "de-de";//德文
                        else
                            if (langName.StartsWith("it", StringComparison.OrdinalIgnoreCase))
                                langName = "it-ch";//意大利
                            else if (langName.StartsWith("zh", StringComparison.OrdinalIgnoreCase))
                                langName = "zh-cn";//日语
                            else if (langName.StartsWith("ja", StringComparison.OrdinalIgnoreCase))
                                langName = "ja-jp";//法语
                            else if (langName.StartsWith("fr", StringComparison.OrdinalIgnoreCase))
                                langName = "fr-fr";
                            else
                                langName = "en-us";//默认英文

                        cultureInfo = new CultureInfo(langName);
                        this.Session["Culture"] = cultureInfo;

                        LanguageService languageservice = LanguageService.GetInstance();
                        IList<Language> languages = languageservice.GetList();
                        string displayName = languages.OrderByDescending(lang => lang.codename.ToLower().Equals(langName)).First<Language>().name;
                        Session["display"] = displayName;
                    }
                    else
                    {
                        //强制使用英语作为默认语言
                        cultureInfo = new CultureInfo(langName);
                        this.Session["Culture"] = cultureInfo;
                    }
                }

                System.Threading.Thread.CurrentThread.CurrentCulture = cultureInfo;
                System.Threading.Thread.CurrentThread.CurrentUICulture = cultureInfo;
            }
        }

        protected void Application_Start()
        {
            //默认模板
            Application[ComConst.Templete] = TemplateService.GetInstance().getDefault();

            AreaRegistration.RegisterAllAreas();
            RegisterRoutes(RouteTable.Routes);
            ViewEngines.Engines.Clear();
            ViewEngines.Engines.Add(new MvcViewEngine());
            //初始化用户实体的减排系数
            float c2 = ItemConfigService.GetInstance().getCO2Config();
            float tree = ItemConfigService.GetInstance().getTreeConfig();
            ItemConfig.treeConvert = tree;
            ItemConfig.reductionRate = c2;
            if (syndata != null && syndata.Equals("true"))
            {
                SynDataService.GetInstance().startupforWeb();
            }

            //从后台维护数据表中设置错误码静态数据
            ErrorcodeService.GetInstance().setErrorStaticData();

            //add by hbqian in 20130504 for 启动生成电站发电量告警表数据线程
            if (energywarn != null && energywarn.Equals("true"))
            {
                EnergywarnProcesser dataProcess = new EnergywarnProcesser();
                Thread m_thread = new Thread(new ThreadStart(dataProcess.Processing));
                m_thread.Start();
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            if (isDebug == null || isDebug.Equals("false"))
            {
                if (Session[ComConst.User] == null)
                {
                    object lastLoginTime = Application[Session.SessionID];
                    if (lastLoginTime != null)
                    {
                        Application.Remove(Session.SessionID);
                    }
                }

                Response.Clear();
                Response.Write("<script>if (window.parent != null) {window.parent.document.location.href = '/?t';}else {window.document.href = '/?t';}</script>");
                Response.End();
                return;
            }
        }
    }
}