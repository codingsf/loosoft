using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Globalization;
using System.Web.Script.Serialization;
using System.Text.RegularExpressions;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Wap
{
    public class IsLoginAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {

            string sid = filterContext.HttpContext.Request.QueryString["sid"];
            if (filterContext.HttpContext.Session[sid] == null)
                filterContext.HttpContext.Response.Redirect("/wap");
            base.OnActionExecuting(filterContext);
        }
    }


    public class WapController : Controller
    {
        UserService userService = UserService.GetInstance();
        PlantService plantService = PlantService.GetInstance();
        ItemConfigService itemConfigService = ItemConfigService.GetInstance();
        FaultService logService = FaultService.GetInstance();
        //
        // GET: /Wap/

        public ActionResult Index()
        {
            float co2Rate = ItemConfigService.GetInstance().getCO2Config();

            float alltotalenergy = DeviceRunDataService.GetInstance().GetAllTotalEnergy();
            double totalEnergy = Math.Round(Convert.ToDouble(alltotalenergy), 2);
            double dayEnergy = Math.Round(Convert.ToDouble(CollectorRunDataService.GetInstance().GetAllDayEnergy()), 2);

            double co2Value = Math.Round((alltotalenergy * co2Rate), 2);
            ViewData["co2Unit"] = "Kg";
            ViewData["energyUnit"] = "kWh";
            ViewData["dayenergyUnit"] = "kWh";


            if (co2Value >= 1000000000)
            {
                co2Value = Math.Round(co2Value / 1000000000, 2);
                ViewData["co2Unit"] = "G";
            }
            else
                if (co2Value >= 1000000)
                {
                    co2Value = Math.Round(co2Value / 1000000, 2);
                    ViewData["co2Unit"] = "M";

                }
                else
                    if (co2Value >= 1000)
                    {
                        co2Value = Math.Round(co2Value / 1000, 2);
                        ViewData["co2Unit"] = "T";

                    }

            if (totalEnergy >= 1000000)
            {
                totalEnergy = totalEnergy / 1000000;
                ViewData["energyUnit"] = "GWh";
            }
            else
                if (totalEnergy >= 1000)
                {
                    totalEnergy = totalEnergy / 1000;
                    ViewData["energyUnit"] = "MWh";
                }
            if (dayEnergy >= 1000000)
            {
                dayEnergy = dayEnergy / 1000000;
                ViewData["dayenergyUnit"] = "GWh";
            }
            else
                if (dayEnergy >= 1000)
                {
                    dayEnergy = dayEnergy / 1000;
                    ViewData["dayenergyUnit"] = "MWh";
                }
            totalEnergy = Math.Round(totalEnergy, 2);
            dayEnergy = Math.Round(dayEnergy, 2);
            ViewData["AllTotalEnergy"] = totalEnergy.ToString();
            ViewData["AlldayTotalEnergy"] = dayEnergy.ToString();
            ViewData["AllCO2"] = co2Value;

            return View();
        }
        /// <summary>
        /// 登陆ACTION
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Login(User user)
        {
            if (string.IsNullOrEmpty(user.username) == false)
            {
                User loginUser = userService.GetUserByName(user.username);
                Session["Culture"] = new CultureInfo("en-us");

                if (loginUser != null && loginUser.depassword.Equals(user.password))
                {
                    if (loginUser.Language != null && string.IsNullOrEmpty(loginUser.Language.codename) == false)
                    {
                        Session["Culture"] = new CultureInfo(loginUser.Language.codename.ToLower());
                        Session["lang"] = loginUser.Language.codename.ToLower();
                    }
                    string sid = Session.SessionID;
                    Session[sid] = loginUser.id;
                    return Redirect(string.Format("/wap/overview/?sid={0}", sid));

                }

            }
            ViewData["error"] = "Username or password is not validated";
            return PartialView("index");
        }
        public ActionResult Example()
        {

            User userinfo = UserService.GetInstance().GetUserByName(UserUtil.demousername);
            string sid = Session.SessionID;
            Session[sid] = userinfo.id;
            Session["Culture"] = new CultureInfo("en-us");
            Session["lang"] = "en-us";
            if (userinfo.Language != null && string.IsNullOrEmpty(userinfo.Language.codename) == false)
            {
                Session["Culture"] = new CultureInfo(userinfo.Language.codename.ToLower());
                Session["lang"] = userinfo.Language.codename.ToLower();
            }
            return Redirect(string.Format("/wap/overview/?sid={0}", sid));

        }

        /// <summary>
        /// 所有电站ACTION
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult Overview()
        {
            string sid = Request.QueryString["sid"];

            User user = UserService.GetInstance().Get(int.Parse(Session[sid].ToString()));
            float co2Rate = itemConfigService.getCO2Config();
            ViewData["plant"] = user.displayPlants;

            return View(user);

        }

        /// <summary>
        /// 电站资料
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult Profile()
        {
            string pid = Request.QueryString["pid"];
            string sid = Request.QueryString["sid"];
            int id = 0;
            int.TryParse(pid, out id);
            User user = userService.Get(int.Parse(Session[sid].ToString()));
            Plant plant = plantService.GetPlantInfoById(id);
            if (plant != null)
            {
                plant.currencies = user.currencies;
                return View(plant);
            }
            else
                return View("OverView");
        }

        [IsLoginAttribute]
        public ActionResult Logs()
        {
            string pageIndexStr = Request.QueryString["page"];
            int pageindex = 0;
            int.TryParse(pageIndexStr, out pageindex);
            string pidStr = Request.QueryString["pid"];
            int pid = 0;
            int.TryParse(pidStr, out pid);
            #region 将查询时间设为23点59分59秒
            DateTime startTime = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            DateTime endTime = Convert.ToDateTime(DateTime.Now.AddDays(1).ToShortDateString());
            #endregion

            #region 获取电站所有采集器ID字符串
            string collectorString = string.Empty;
            {
                Plant curPlant = PlantService.GetInstance().GetPlantInfoById(pid);
                foreach (PlantUnit unit in curPlant.plantUnits)
                {
                    collectorString += string.Format("{0},", unit.collector.id);
                }
            }
            if (collectorString.Length > 1)
                collectorString = collectorString.Substring(0, collectorString.Length - 1);
            #endregion

            //错误项目字符串
            string inforank = ErrorType.ERROR_TYPE_INFORMATRION + "," + ErrorType.ERROR_TYPE_FAULT + "," + ErrorType.ERROR_TYPE_ERROR + "," + ErrorType.ERROR_TYPE_WARN;

            Hashtable table = new Hashtable();
            Pager page = new Pager() { PageIndex = pageindex, PageSize = 10 };
            Fault fault = new Fault() { sendTime = startTime, confirmed = "0", inforank = inforank, collectorString = collectorString };
            table.Add("page", page);
            table.Add("fault", fault);
            table.Add("endTime", endTime);
            ViewData["page"] = table["page"];
            IList<Fault> logs = null;
            try
            {
                logs = logService.GetPlantLoglist(table);
            }
            catch
            {
                logs = new List<Fault>();
            }
            return View(logs);
        }



        /// <summary>
        /// 单个电站OVERVIEW
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult Poverview()
        {
            NextPreProcess();
            string id = Request.QueryString["pid"];
            string sid = Request.QueryString["sid"];
            int pid = 0;
            int.TryParse(id, out pid);
            User user = userService.Get(int.Parse(Session[sid].ToString()));
            Plant plant = null;
            foreach (Plant pnt in user.displayPlants)
            {
                if (pnt.id.ToString().Equals(id))
                {
                    plant = pnt;
                    break;
                }
            }
            plant.currencies = user.currencies;
            return View(plant);
        }

        [IsLoginAttribute]
        public ActionResult Device()
        {
            String pid = Request.QueryString["pid"];
            Plant plant = PlantService.GetInstance().GetPlantInfoById(Convert.ToInt32(pid));
            return View(plant);
        }

        [IsLoginAttribute]
        public ActionResult RunData(int did)
        {
            Device device = DeviceService.GetInstance().get(did);
            IList<IList<KeyValuePair<MonitorType, string>>> rundatas = device.runData.convertRunstrToList(true);

            ViewData["rundatas"] = rundatas;
            ViewData["device"] = device;
            PlantUnit plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(plantUnit.plantID);
            ViewData["plant"] = plant;
            return View();
        }


        [IsLoginAttribute]
        public ActionResult Logout()
        {
            string sid = Request.QueryString["sid"];
            Session[sid] = null;
            return RedirectToAction("index");
        }

        private void DeserializeChartData(string url)
        {
            JavaScriptSerializer jserializer = new JavaScriptSerializer();
            string output = JsonUtil.loadJsonStr(url, Session["lang"].ToString());
            IList<KeyValuePair<string, float?>> outputData = new List<KeyValuePair<string, float?>>();
            ChartData data = null;
            try
            {
                data = jserializer.Deserialize<ChartData>(output);
            }
            catch
            {
                data = null;
            }
            if (data == null || data.isHasData == false)
            {
                ViewData["name"] = Resources.SunResource.NODATA;
                ViewData["unit"] = "";
                ViewData["Chart"] = outputData;
                return;
            }
            for (int i = 0; i < data.categories.Length; i++)
            {
                outputData.Add(new KeyValuePair<string, float?>(data.categories[i], data.series[0].data[i]));
            }

            ViewData["name"] = data.name;
            ViewData["unit"] = data.units[0];
            ViewData["Chart"] = outputData;
            string name = ViewData["name"].ToString();
            if (name.Contains("&"))
            {
                name = name.Substring(0, name.IndexOf("&"));
                ViewData["name"] = name;

            }
        }


        public void NextPreProcess()
        {

            if ((Request.QueryString["next"] != null && Request.QueryString["next"].ToLower().Equals("true")) ||
          Request.QueryString["pre"] != null && Request.QueryString["pre"].ToLower().Equals("true"))
            {
                DateTime paraDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                string t = Request.QueryString["t"];
                string date = Request.QueryString["date"];
                if (string.IsNullOrEmpty(t))
                    t = "d";
                try
                {
                    if (date.Length >= 10)
                        paraDate = new DateTime(int.Parse(date.Substring(0, 4)), int.Parse(date.Substring(5, 2)), int.Parse(date.Substring(8, 2)));
                    else
                        if (date.Length >= 7)
                            paraDate = new DateTime(int.Parse(date.Substring(0, 4)), int.Parse(date.Substring(5, 2)), 1);
                        else
                            if (date.Length >= 4)
                                paraDate = new DateTime(int.Parse(date.Substring(0, 4)), 1, 1);
                }
                catch
                {
                    paraDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                }

                if (Request.QueryString["next"] != null && Request.QueryString["next"].ToLower().Equals("true"))
                {
                    switch (t)
                    {
                        case "d":
                            paraDate = paraDate.AddDays(1);
                            break;
                        case "m":
                            paraDate = paraDate.AddMonths(1);
                            break;
                        case "y":
                            paraDate = paraDate.AddYears(1);

                            break;
                        default:
                            break;
                    }
                }

                if (Request.QueryString["pre"] != null && Request.QueryString["pre"].ToLower().Equals("true"))
                {
                    switch (t)
                    {
                        case "d":
                            paraDate = paraDate.AddDays(-1);
                            break;
                        case "m":
                            paraDate = paraDate.AddMonths(-1);
                            break;
                        case "y":
                            paraDate = paraDate.AddYears(-1);
                            break;
                        default:
                            break;
                    }
                }
                if (paraDate > new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day))
                    paraDate = DateTime.Now;
                string dateStr = dateStr = paraDate.ToString("yyyy-MM-dd");
                if (t.Equals("m"))
                    dateStr = paraDate.ToString("yyyy-MM");
                if (t.Equals("y"))
                    dateStr = paraDate.ToString("yyyy");

                Response.Redirect(Request.Url.ToString().Replace(date, dateStr).Replace("true", string.Empty), true);

            }
        }

        private const string DOMAIN = "http://www.solarinfobank.com/";

        //private const string DOMAIN = "http://60.166.14.38:8002/";


        public ActionResult PlantDayChart(string day, string pid)
        {
            day = day.Replace("-", string.Empty);
            DeserializeChartData(string.Format(DOMAIN + "plantchart/PlantDayChart?chartType=area&endYYYYMMDDHH={0}23&startYYYYMMDDHH={0}00&intervalMins=5&pid={1}", day, pid));
            IList<KeyValuePair<string, float?>> outputData = null;
            if (ViewData["Chart"] is List<KeyValuePair<string, float?>>)
                outputData = ViewData["Chart"] as List<KeyValuePair<string, float?>>;
            ViewData["Chart"] = outputData.Skip(60).Take(180).ToList<KeyValuePair<string, float?>>();
            return PartialView(@"chart/plantday");

        }

        [IsLoginAttribute]
        public ActionResult PlantMonthChart(string month, string pid)
        {
            month = month.Replace("-", string.Empty);

            string maxDay = "31";
            switch (month)
            {
                case "2":
                    maxDay = "28";
                    break;
                case "4":
                case "6":
                case "9":
                case "11":
                    maxDay = "30";
                    break;
                default:
                    break;
            }
            DeserializeChartData(string.Format(DOMAIN + "plantchart/PlantMonthDDChart?chartType=column&endYYYYMMDD={2}{1}&startYYYYMMDD={2}01&id={0}", pid, maxDay, month));
            return PartialView(@"chart/month");
        }

        [IsLoginAttribute]
        public ActionResult PlantYearChart(string pid, string year)
        {
            DeserializeChartData(string.Format(DOMAIN + "plantchart/PlantYearMMChart?chartType=column&year={1}&id={0}", pid, year));
            return PartialView(@"chart/year");
        }

        [IsLoginAttribute]
        public ActionResult PlantTotalChart(string pid)
        {
            DeserializeChartData(string.Format(DOMAIN + "plantchart/PlantYearChart?chartType=column&id={0}", pid));
            return PartialView(@"chart/total");
        }

        [IsLoginAttribute]

        public ActionResult EnergyChart(string date, string sid, string t)
        {
            NextPreProcess();
            if (string.IsNullOrEmpty(date) == false)
            {
                switch (t)
                {
                    case "m":
                        if (!Regex.IsMatch(date, @"^[1-9]\d{3}-(1[0-2]|0[1-9])$"))
                            return Content("日期不对");
                        break;
                    case "y":
                        if (!Regex.IsMatch(date, @"^\d{4}$"))
                            return Content("日期不对");
                        break;
                    default:
                        break;
                }
            }
            return View();
        }

        [IsLoginAttribute]
        public ActionResult EnergyMonthChart(string month)
        {
            month = month.Replace("-", string.Empty);
            DeserializeChartData(string.Format(DOMAIN + "plantchart/UserMonthDDChart?chartType=column&endYYYYMMDD={0}31&startYYYYMMDD={0}01&userId={1}", month, Session[Session.SessionID].ToString()));
            return PartialView(@"chart/month");
        }

        [IsLoginAttribute]
        public ActionResult EnergyYearChart(string year)
        {
            DeserializeChartData(string.Format(DOMAIN + "plantChart/UserYearMMChart?chartType=column&startYM={1}01&endYM={1}12&userId={0}", Session[Session.SessionID].ToString(), year));
            return PartialView(@"chart/year");
        }

        [IsLoginAttribute]
        public ActionResult EnergyTotalChart()
        {
            DeserializeChartData(string.Format(DOMAIN + "plantChart/UserYearChart?userId={0}&chartType=column", Session[Session.SessionID].ToString()));
            return PartialView(@"chart/total");
        }

        [IsLoginAttribute]
        public ActionResult DeviceChart()
        {
            NextPreProcess();
            return View();
        }

        [IsLoginAttribute]
        public ActionResult DeviceDayChart(string did, string day)
        {
            day = day.Replace("-", string.Empty);
            DeserializeChartData(string.Format(DOMAIN + "DeviceChart/CompareDayChart?chartType=line,line&dId={0}&endYYYYMMDDHH={1}23&intervalMins=5,5&startYYYYMMDDHH={1}00", did, day));
            IList<KeyValuePair<string, float?>> outputData = null;
            if (ViewData["Chart"] is List<KeyValuePair<string, float?>>)
                outputData = ViewData["Chart"] as List<KeyValuePair<string, float?>>;
            ViewData["Chart"] = outputData.Skip(60).Take(180).ToList<KeyValuePair<string, float?>>();
            return PartialView(@"chart/deviceday");
        }

        [IsLoginAttribute]
        public ActionResult DeviceMonthChart(string did, string month)
        {
            month = month.Replace("-", string.Empty);

            string maxDay = "31";
            switch (month)
            {
                case "2":
                    maxDay = "28";
                    break;
                case "4":
                case "6":
                case "9":
                case "11":
                    maxDay = "30";
                    break;
                default:
                    break;
            }

            DeserializeChartData(string.Format(DOMAIN + "DeviceChart/DeviceMonthDayChart?chartType=column&dId={0}&startYYYYMMDD={1}01&endYYYYMMDD={1}{2}", did, month, maxDay));
            return PartialView(@"chart/month");
        }

        [IsLoginAttribute]
        public ActionResult DeviceYearChart(string did, string year)
        {

            DeserializeChartData(string.Format(DOMAIN + "DeviceChart/DeviceYearMMChart?chartType=column&dId={0}&startYM={1}01&endYM={1}12", did, year));
            return PartialView(@"chart/year");
        }

        [IsLoginAttribute]
        public ActionResult DeviceTotalChart(string did)
        {
            DeserializeChartData(string.Format(DOMAIN + "DeviceChart/DeviceYearChart?chartType=column&dId={0}", did));
            return PartialView(@"chart/total");
        }

        [IsLoginAttribute]
        public ActionResult MonitorChart()
        {
            NextPreProcess();
            return View();
        }

        [IsLoginAttribute]
        public ActionResult MonitorDayChart(string mCode, string did, string day)
        {
            day = day.Replace("-", string.Empty);
            string url = string.Format(DOMAIN + "DeviceChart/MonitorDayChart?dId={0}&startYYYYMMDDHH={1}00&endYYYYMMDDHH={1}23&chartType=line&monitorCode={2}&intervalMins=5", did, day, mCode);
            DeserializeChartData(url);
            IList<KeyValuePair<string, float?>> outputData = null;
            if (ViewData["Chart"] is List<KeyValuePair<string, float?>>)
                outputData = ViewData["Chart"] as List<KeyValuePair<string, float?>>;
            ViewData["Chart"] = outputData.Skip(60).Take(180).ToList<KeyValuePair<string, float?>>();
            if (mCode.Equals("125"))
                return PartialView(@"chart/plantday");
            return PartialView(@"chart/RunData");
        }
    }
}
