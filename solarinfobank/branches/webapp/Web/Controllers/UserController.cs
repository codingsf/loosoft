using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Common;
using Dimac.JMail;
using EmailService;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class UserController : BaseController
    {
        FaultService logService = FaultService.GetInstance();
        CollectorRunDataService plantRunDataService = CollectorRunDataService.GetInstance();
        PlantService plantService = PlantService.GetInstance();
        ItemConfigService itemConfigService = ItemConfigService.GetInstance();
        UserService userservice = UserService.GetInstance();
        ReportConfigService reportConfigService = ReportConfigService.GetInstance();
        PlantUserService plantUserService = PlantUserService.GetInstance();
        // GET: /User/

        [HandleError]
        [IsLoginAttribute]
        public ActionResult Index()
        {

            UserService userservice = UserService.GetInstance();
            IList<User> userinfos = null;// userinfoservice.GetUserList();
            return View(userinfos);
        }

        /// <summary>
        /// 显示正在建设中的页面
        /// </summary>
        /// <returns></returns>
        public ActionResult StaticPage()
        {
            return View();
        }

        /// <summary>
        /// 显示所有电站框架下的自定义图表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult CustomChart()
        {
            User user = UserUtil.getCurUser();
            base.FillAllPlantYears(user);
            return View();
        }

        /// <summary>
        /// 进入自定义报表
        /// </summary>
        /// <returns>自定义报表页面</returns>
        [HttpGet]
        public ActionResult ViewCustomChart(int id)
        {
            User user = UserUtil.getCurUser();
            base.FillAllPlantYears(user);
            ViewData["id"] = id;
            return View();
        }

        /// <summary>
        /// 修改用户信息
        /// </summary>
        /// <param name="collectorInfo">用户信息字段</param>
        /// <returns>转到显示页面</returns>
        //public ActionResult Update()
        //{
        //    int id = int.Parse(Request.QueryString["id"].ToString());
        //    UserService userinfoservice = UserService.GetInstance();
        //    User userInfo = userinfoservice.GetUserById(id);
        //    return View(userInfo);
        //}

        /// <summary>
        /// 修改用户信息
        /// </summary>
        /// <param name="userInfo">用户信息字段</param>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult save(User user)
        {

            if (ModelState.IsValid)
            {
                UserService userservice = UserService.GetInstance();
                try
                {
                    userservice.save(user);
                }
                catch
                {
                    //如果已经存在该采集器
                    ModelState.AddModelError("Code", Resources.SunResource.USER_CODE_SAVE_ERROR);
                }
            }

            //注册后
            return RedirectToAction("Plants", "user");
        }

        /// <summary>
        /// 跳转到修改用户信息页面
        /// </summary>
        /// <returns></returns>
        public ActionResult edit()
        {
            UserService userService = UserService.GetInstance();
            int languageId = userService.GetLanguageIdById(UserUtil.getCurUser().id);
            //创建语言服务
            LanguageService languageservice = LanguageService.GetInstance();
            //获取所有语言信息
            Language language = languageservice.GetNameByLanguageId(languageId);
            IList<Language> languages = languageservice.GetList();
            ViewData["lang"] = language;
            ViewData["languages"] = languages;
            UserService userservice = UserService.GetInstance();
            ViewData["langs"] = LanguageService.GetInstance().GetList();
            base.GetLanguage();

            IList<CommonInfo> currencies = CommonInfoService.GetInstance().GetList(new CommonInfo() { pid = CommonInfo.Currency });
            IList<SelectListItem> items = new List<SelectListItem>();
            foreach (CommonInfo currency in currencies)
            {
                items.Add(new SelectListItem() { Text = string.Format("{0}:{1}", currency.code, currency.name), Value = currency.code });
            }


            ViewData["currencies"] = items;
            return View("edit", userservice.Get(UserUtil.getCurUser().id));
        }

        /// <summary>
        /// 修改用户信息
        /// </summary>
        /// <param name="user">用户信息</param>
        /// <returns>电站页面</returns>
        [HttpPost]
        public ActionResult edit(User user)
        {
            if (ModelState.IsValid)
            {
                //创建用户服务

                if (string.IsNullOrEmpty(user.password))
                {
                    userservice.save(user);
                    UserUtil.ResetLogin(user);
                }
                else
                    userservice.save(user);

                ViewData["error"] = "<em><span id=\"serverError\" class='success'>" + Resources.SunResource.AUTH_REG_SUCCESS + "</span></em>";

                //Language language = LanguageService.GetInstance().Get((int)user.languageId);
                //CultureInfo cultureInfo = new CultureInfo(language.codename);
                //Session["Culture"] = cultureInfo;
                //Session["display"] = language.name;
            }
            return edit();
        }

        /// <summary>
        /// 跳转到修改用户密码页面
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult changepassword(string oldPassword, string password, string confirmPassword)
        {
            if (!password.Equals(confirmPassword))
            {
                ViewData["error"] = "<em><span id=\"serverError\" class='error'>" + Resources.SunResource.USER_CHANGEPASSWORD_NOTICE + "</span></em>";
                return View();
            }
            User user = UserUtil.getCurUser();
            if (user.depassword.Equals(oldPassword))
            {
                userservice.UpdatePassword(user.id, EncryptUtil.EncryptDES(password, EncryptUtil.defaultKey));
                ViewData["error"] = "<em><span id=\"serverError\" class='success'>" + Resources.SunResource.USER_CHANGEPASSWORD_NOTICE1 + "</span></em>";
            }
            else
            {
                ViewData["error"] = "<em><span id=\"serverError\" class='error'>" + Resources.SunResource.USER_CHANGEPASSWORD_NOTICE2 + "</span></em>";
            }
            return View(); ;
        }

        public ActionResult changepassword()
        {
            return View(); ;
        }


        /// <summary>
        /// 用户主页
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult Portal()
        {
            if (UserUtil.isLogined() == false)
                return RedirectToAction("index", "home");
            //取得用户年度发电量图表数据
            string startYM = (DateTime.Now.Year - 1) + "" + DateTime.Now.Month;
            string endYM = DateTime.Now.Year + "" + DateTime.Now.Month;
            ChartData chartData = PlantChartService.GetInstance().YearMMChartBypList(UserUtil.getCurUser().plants, startYM, endYM, ChartType.line, "kWh");
            string reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            ViewData[ComConst.ReportCode] = reportData;
            ItemConfig itemConfig = itemConfigService.GetItemConfigByName(ItemConfig.CO2);
            User user = UserUtil.getCurUser();
            return View(user);
        }

        private const double EARTH_RADIUS = 6378.137;//地球半径

        private static double rad(double d)
        {
            return d * Math.PI / 180.0;
        }

        public static double GetDistance(double lat1, double lng1, double lat2, double lng2)
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

        /// <summary>
        /// 功能：显示用户电站地图
        /// 描述：根据电站id获取电站的经度纬度
        /// 作者：张月
        /// 时间：2011年3月12日 16:38:08
        /// </summary>
        /// <returns>电站id</returns>
        public ActionResult Map()
        {
            double[] point = { 1960, 980, 490, 245, 120, 60, 30, 15, 7.5, 3.7, 1.90 };
            IList<Plant> plants = UserUtil.getCurUser().plants;
            IList<double> values = new List<double>();
            if (plants.Count > 1)
            {
                for (int i = 1; i < plants.Count; i++)
                {
                    values.Add(GetDistance(plants[0].latitude, plants[0].longitude, plants[i].latitude, plants[i].longitude));
                }
            }
            double max = values.Count > 0 ? values.Max() : 0;
            ViewData["point"] = 2;
            for (int i = point.Length - 1; i >= 0; i--)
            {
                if (point[i] > max / 8)
                {
                    ViewData["point"] = i;
                    break;
                }
            }

            ViewData["plant"] = plants;

            return View();
        }
        /// <summary>
        /// 电站总览页面壳
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult OverView()
        {
            if (UserUtil.isLogined() == false)
                return RedirectToAction("index", "home");
            User user = UserUtil.getCurUser();
            if (user.plants.Count < 1)
                return RedirectToAction("addoneplant", "user");

            return View(user);
        }

        /// <summary>
        /// 实际的电站总览页面
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        [IsHavaPlant]
        public ActionResult IncludeOverView()
        {
            if (UserUtil.isLogined() == false)
                return RedirectToAction("index", "home");
            User user = UserUtil.getCurUser();
            base.FillAllPlantYears(user);

            ViewData["plant"] = UserUtil.getCurUser().plants;
            Pager page = new Pager();
            page.PageIndex = 1;
            page.PageSize = user.overviewDisplayCount;
            page.RecordCount = user.plants.Count;
            ViewData["page"] = page;
            return View(user);
        }


        public ActionResult Plantspage(int index)
        {
            User user = UserUtil.getCurUser();
            Pager page = new Pager();
            page.PageIndex = index;
            page.RecordCount = user.plants.Count;
            page.PageSize = user.overviewDisplayCount;
            ViewData["page"] = page;
            IList<Plant> plants = user.plants;
            plants = plants.Skip((page.PageIndex - 1) * page.PageSize).Take(page.PageSize).ToList<Plant>();
            return View(plants);
        }
        /// <summary>
        /// 功能：跳转到添加页面
        /// 作者：张月
        /// 时间：2011年3月12日 17:02:25
        /// </summary>
        /// <returns>添加页面</returns>
        public ActionResult AddPlant()
        {
            return View();
        }

        /// <summary>
        /// 功能：注册后到添加页面
        /// 作者：张月
        /// 时间：2011年3月12日 17:02:25
        /// </summary>
        /// <returns>添加页面</returns>
        public ActionResult AddOnePlant()
        {
            return View();
        }

        /// <summary>
        /// 功能：删除图片
        /// 描述：根据图片名称删除图片
        /// 作者：张月
        /// 时间：2011年3月12日 15:50:35
        /// </summary>
        /// <param name="id">电站id</param>
        /// <param name="picName">图片名称</param>
        /// <returns>电站信息页面</returns>
        [IsLoginAttribute]
        public ActionResult DeletePic(string picName)
        {
            try
            {
                System.IO.File.Delete(HttpContext.Server.MapPath("/ufile/" + picName));
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return RedirectToAction("addplant", "user");
        }
        /// <summary>
        /// 功能：添加电站信息
        /// 描述：根据电站信息编辑电站
        /// 获取上传图片的名称修改图片
        /// </summary>
        /// <param name="plantInfo">电站信息</param>
        /// <param name="uploadFile">图片的名称</param>
        /// <returns>电站信息页面</returns>
        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Post)]
        [IsLoginAttribute]
        public ActionResult SavePlant(Plant plant)
        {
            string long1 = Request.Form["long1"];
            string long2 = Request.Form["long2"];
            string long3 = Request.Form["long3"];
            double value = 0;
            double longValue = 0;
            double.TryParse(long1, out longValue);
            value += longValue;
            double.TryParse(long2, out longValue);
            value += (longValue / 60);

            double.TryParse(long3, out longValue);
            value += (longValue / 3600);

            plant.longitude = value;
            value = 0;
            longValue = 0;
            string lat1 = Request.Form["lat1"];
            double.TryParse(lat1, out longValue);
            value += longValue;

            string lat2 = Request.Form["lat2"];
            double.TryParse(lat2, out longValue);
            value += (longValue / 60);

            string lat3 = Request.Form["lat3"];
            double.TryParse(lat3, out longValue);
            value += (longValue / 3600);
            plant.latitude = value;

            plant.longitudeString = string.Format("{0},{1},{2}", long1, long2, long3);
            plant.latitudeString = string.Format("{0},{1},{2}", lat1, lat2, lat3);


            if (string.IsNullOrEmpty(plant.pic))
                plant.pic = string.Empty;
            plant.userID = UserUtil.getCurUser().id;
            CountryCity area = CountryCityService.GetInstance().GetCity(plant.country);
            plant.area = area == null ? string.Empty : area.weather_code;
            int plantid = plantService.AddPlantInfo(plant);
            plantUserService.AddPlantUser(new PlantUser { plantID = plantid, userID = int.Parse(plant.userID.ToString()) });//添加电站时，向电站用户关系表中加记录
            UserUtil.ResetLogin(UserUtil.getCurUser());
            return RedirectToAction("allplants", "user");
        }
        /// <summary>
        /// 功能：删除电站
        /// 描述：根据电站id删除电站信息
        /// </summary>
        /// <returns>返回页面</returns>
        [IsLoginAttribute]
        public ActionResult Detele(int id)
        {
            Plant plant = FindPlant(id);//根据电站id获取电站
            if (!string.IsNullOrEmpty(plant.pic))
            {
                string[] s = plant.pic.Split(',');
                for (int i = 1; i < s.Length; i++)
                {
                    System.IO.File.Delete(HttpContext.Server.MapPath("/ufile/" + s[i]));
                }
            }

            foreach (PlantUnit unit in plant.plantUnits)
            {
                unit.collector.isUsed = false;
                CollectorInfoService.GetInstance().Save(unit.collector);
            }
            //reportConfigService.DeletePlantReports(plant.id.ToString());

            plantUserService.ClosePlant(id, int.Parse(plant.userID.ToString()));//删除电站时，把用户和电站关系对应表中的删除
            plantService.DeletePlantById(id);
            UserUtil.ResetLogin(UserUtil.getCurUser());
            return RedirectToAction("AllPlants", "user");
        }

        [IsLoginAttribute]
        public ActionResult AllPlants()
        {
            User curUser = UserUtil.getCurUser();
            //UserUtil.ResetLogin(curUser);
            //ViewData["plantList"] = curUser.plants;
            return View(curUser);
        }

        [IsLoginAttribute]
        public ActionResult IncludeAllPlants()
        {
            User curUser = UserUtil.getCurUser();
            //UserUtil.ResetLogin(curUser);
            //ViewData["plantList"] = curUser.plants;
            return View(curUser);
        }

        private string convertArrtoStr(string[] arr)
        {
            StringBuilder sb = new StringBuilder();
            string temp;
            for (int i = 0; i < arr.Length; i++)
            {
                temp = arr[i];
                sb.Append(",").Append(temp);
            }
            return sb.ToString();
        }


        [IsLoginAttribute]
        public ActionResult AllPlants_Output()
        {
            User curUser = UserUtil.getCurUser();
            CsvStreamWriter scvWriter = new CsvStreamWriter();
            IList<string> dataList = new List<string>();
            dataList.Add(string.Format("{0},{1},{2},{3}", Resources.SunResource.USER_ALLPLANTS_NAME,
                Resources.SunResource.USER_ALLPLANTS_COUNTRY,
                Resources.SunResource.USER_ALLPLANTS_CITY,
                Resources.SunResource.USER_ALLPLANTS_ENERGY));
            foreach (Plant plant in curUser.plants)
            {
                dataList.Add(string.Format("{0},{1},{2},{3}", plant.name,
           plant.country,
           plant.city,
           string.Format("{0}({1})", plant.DisplayTotalEnergy, plant.TotalEnergyUnit)));
            }

            scvWriter.AddStrDataList(dataList);

            string fullFile = Server.MapPath("/") + "tempexportfile\\" + Resources.SunResource.USER_PLANT_LIST_FILENAME + ".csv";
            scvWriter.Save(fullFile);
            //转化为csv格式的字符串
            ActionResult tmp = File(fullFile, "text/csv; charset=UTF-8", urlcode(Resources.SunResource.USER_PLANT_LIST_FILENAME) + ".csv");
            return tmp;
        }



        public ActionResult ReportView()
        {
            string pid = Request.QueryString["pid"];//电站id
            string type = Request.QueryString["type"];//  所有电站  单个电站
            string model = Request.QueryString["index"];//报告类型 日 月 年 总量
            string reportName = Request.QueryString["name"];//报告名称

            string plantNames = string.Empty;//所有报告的电站名称
            string content = string.Empty;//发送报告内容
            double dayEnergy = 0.0;//日发电量
            double dayRevenue = 0.0;//日收益
            double dayco2 = 0.0;
            double totalco2 = 0.0;


            double totalEnergy = 0.0;//日发电量
            double totalRevenue = 0.0;//日收益


            string[] ids = pid.Split(',');
            User user = UserUtil.getCurUser();

            #region 统计选择电站
            float reductRate = ItemConfigService.GetInstance().getCO2Config();


            foreach (Plant plant in user.plants)
            {
                foreach (string id in ids)
                {
                    if (id.Equals(plant.id.ToString()))
                    {
                        plantNames += string.Format("{0},", plant.name);
                        dayEnergy += plant.TotalDayEnergy;
                        dayRevenue += plant.TotalDayEnergy * plant.revenueRate;

                        totalEnergy += plant.TotalEnergy;
                        totalRevenue += plant.revenue;
                    }
                }
            }
            dayco2 = dayEnergy * reductRate;
            totalco2 = totalEnergy * reductRate;

            #endregion

            ViewData["plantName"] = plantNames.Length > 0 ? plantNames.Substring(0, plantNames.Length - 1) : string.Empty;
            ViewData["user"] = user.fullname;
            ViewData["reportName"] = reportName;
            ViewData["title"] = string.Format(Resources.SunResource.REPORT_CONFIG_PLANT_NAME, reportName);

            switch (type.ToLower())
            {
                case "user":
                    {
                        switch (model)
                        {
                            //日报表
                            case "0":
                                #region 今日发电量

                                if (dayEnergy > 1000)
                                    content = string.Format(Resources.SunResource.REPORT_CONFIG_TODAY_ENERGY, (dayEnergy / 1000).ToString("0"), "mWh");
                                else
                                    content = string.Format(Resources.SunResource.REPORT_CONFIG_TODAY_ENERGY, dayEnergy, "kWh");
                                #endregion
                                content += string.Format(Resources.SunResource.REPORT_CONFIG_TODAY_REVENUE, dayRevenue.ToString("0"), user.currencies);
                                #region 二氧化碳减排

                                if (dayco2 >= 1000000000)
                                    content += string.Format(Resources.SunResource.REPORT_CONFIG_TODAY_CO2, (dayco2 / 1000000000).ToString("0.00"), "G");
                                else
                                    if (dayco2 >= 1000000)
                                        content += string.Format(Resources.SunResource.REPORT_CONFIG_TODAY_CO2, (dayco2 / 1000000).ToString("0.00"), "M");
                                    else
                                        if (dayco2 >= 1000)
                                            content += string.Format(Resources.SunResource.REPORT_CONFIG_TODAY_CO2, (dayco2 / 1000).ToString("0.00"), "T");
                                        else
                                            content += string.Format(Resources.SunResource.REPORT_CONFIG_TODAY_CO2, dayco2.ToString("0.00"), "Kg");
                                #endregion
                                ViewData["content"] = content;
                                break;
                            //总报表
                            case "1":

                                #region 总发电量

                                if (totalEnergy > 1000)
                                    content = string.Format(Resources.SunResource.REPORT_CONFIG_TOTAL_ENERGY, (totalEnergy / 1000).ToString("0.000"), "mWh");
                                else
                                    content = string.Format(Resources.SunResource.REPORT_CONFIG_TOTAL_ENERGY, totalEnergy, "kWh");
                                #endregion

                                content += string.Format(Resources.SunResource.REPORT_CONFIG_TOTAL_REVENUE, totalRevenue.ToString("0"), user.currencies);

                                #region 二氧化碳减排

                                if (totalco2 >= 1000000000)
                                    content += string.Format(Resources.SunResource.REPORT_CONFIG_TOTAL_CO2, (totalco2 / 1000000000).ToString("0.00"), "G");
                                else
                                    if (totalco2 >= 1000000)
                                        content += string.Format(Resources.SunResource.REPORT_CONFIG_TOTAL_CO2, (totalco2 / 1000000).ToString("0.00"), "M");
                                    else
                                        if (totalco2 >= 1000)
                                            content += string.Format(Resources.SunResource.REPORT_CONFIG_TOTAL_CO2, (totalco2 / 1000).ToString("0.00"), "T");
                                        else
                                            content += string.Format(Resources.SunResource.REPORT_CONFIG_TOTAL_CO2, totalco2.ToString("0.00"), "Kg");
                                #endregion

                                ViewData["content"] = content;
                                break;

                            default:
                                break;
                        }
                    }
                    break;
                default:
                    break;
            }

            return PartialView("report");
        }
        /// <summary>
        /// 加载功率发电量图表页面
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult DayCompare()
        {
            User user = UserUtil.getCurUser();
            base.FillAllPlantYears(user);
            return View();
        }

        /// <summary>
        /// 加载功率发电量图表页面
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult EnergyYearCompare()
        {
            User user = UserUtil.getCurUser();
            base.FillAllPlantYears(user);
            return View();
        }

        /// <summary>
        /// 加载某个电站发电量月度比较图表页面
        /// 废弃
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult EnergyMonthCompare()
        {
            User user = UserUtil.getCurUser();
            base.FillAllPlantYears(user);
            return View();
        }

        /// <summary>
        /// 加载个电站性能图表页面
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult PerformanceCompare()
        {
            User user = UserUtil.getCurUser();
            base.FillAllPlantYears(user);
            return View();
        }

        /// <summary>
        /// 加载各电站kwp发电量比较图表页面
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult PEnergyCompare()
        {
            User user = UserUtil.getCurUser();
            base.FillAllPlantYears(user);
            return View();
        }

        //[IsLoginAttribute]
        //public ActionResult ReportConfig()
        //{
        //    IList<ReportConfig> configs=reportConfigService.GetUserReportList(getCurUser().id);
        //    ViewData["reportList"] = configs;
        //    return View();

        //}

        //[HttpPost]
        //[IsLoginAttribute]
        //public ActionResult ReportSaves(string errorType, string reportType, string interval, string reportEmail, string errorEmail, string[] plants, string data_format)
        //{
        //    if (plants == null)
        //        plants = new string[0];
        //    ReportConfig config = new ReportConfig();
        //    config.user = getCurUser();
        //    string pids = string.Empty;
        //    foreach (string plant in plants)
        //    {
        //        pids += string.Format("{0},", plant);
        //    }
        //    if (!reportType.Equals("-1"))
        //    {
        //        config.interval = int.Parse(interval);
        //        config.plantIds = pids.Length > 0 ? pids.Substring(0, pids.Length - 1) : "";
        //        config.receiveEmail = reportEmail;
        //        config.intervalFormat = data_format;
        //        config.type = reportType;
        //        reportConfigService.Save(config);
        //        config.id = 0;

        //    }

        //    if (!errorType.Equals("-1"))
        //    {
        //        config.interval = 0;
        //        config.plantIds = pids.Length > 0 ? pids.Substring(0, pids.Length - 1) : "";
        //        config.receiveEmail = errorEmail;
        //        config.type = errorType;
        //        reportConfigService.Save(config);
        //        config.id = 0;
        //        config.intervalFormat = string.Empty;

        //    }
        //    return RedirectToAction("reportconfig", "user");

        //}

        //[HttpPost]
        //[IsLoginAttribute]
        //public ActionResult ReportSave(ReportConfig config)
        //{
        //    reportConfigService.Save(config);
        //    return Content("Edit success");
        //}

        //[HttpPost]
        //[IsLoginAttribute]
        //public ActionResult DelReport(int id)
        //{
        //    reportConfigService.Delete(new ReportConfig() { id = id });
        //    return Content("success");
        //}

        /// <summary>
        /// 陈波
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Log()
        {
            ICollection<ErrorType> errorTypes = ErrorType.getErrorList();
            ViewData["errorTypes"] = errorTypes;
            return View();
        }

        /// <summary>
        /// 陈波
        /// </summary>
        /// <param name="t">时间范围</param>
        /// <param name="state">日志状态</param>
        /// <param name="plant">电站编号</param>
        /// <param name="pindex">当前页索引</param>
        /// <param name="errorCode">错误编码</param>
        /// <param name="logList">选取日志列表</param>
        /// <param name="ctype">确认操作类型</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Log(string userId, string year, string startDate, string endDate, string state, int plant, int pindex, string errorType, string logList, string ctype)
        {

            #region 将查询时间设为23点59分59秒
            DateTime startTime = Convert.ToDateTime(startDate);
            DateTime endTime = Convert.ToDateTime(endDate).AddDays(1);
            #endregion

            Hashtable table = new Hashtable();
            table.Add("user", userservice.Get(int.Parse(userId)));
            table.Add("plants", plant == -1 ? null : new List<Plant> { PlantService.GetInstance().GetPlantInfoById(plant) });
            table.Add("startTime", startDate);
            table.Add("endTime", endDate);
            table.Add("items", errorType);
            table.Add("state", state);
            Pager page = new Pager() { PageIndex = pindex, PageSize = ComConst.PageSize };
            table.Add("page", page);
            ViewData["page"] = table["page"];
            IList<Fault> logs = null;
            try
            {
                logService.GetAllLogs(table);
                if (table.ContainsKey("source") && table["source"] != null)
                    logs = table["source"] as IList<Fault>;
            }
            catch
            {
                logs = new List<Fault>();
            }
            return View("logajax", logs);
        }


        public ActionResult TestLog()
        {
            //2720
            //6100
            Hashtable table = new Hashtable();
            Pager page = new Pager() { PageIndex = 28, PageSize = 20 };
            table.Add("user", UserUtil.getCurUser());
            table.Add("plants", null);
            table.Add("startTime", DateTime.Now.AddYears(-2));
            table.Add("endTime", DateTime.Now);
            table.Add("items", "-1");
            table.Add("state", "-1");
            table.Add("page", page);
            FaultService.GetInstance().GetAllLogs(table);
            return Content("");
        }



        /// <summary>
        /// 初始数据加载  电站日志
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult LogLoad()
        {
            Hashtable table = new Hashtable();
            string collectorString = string.Empty;
            foreach (Plant plnat in UserUtil.getCurUser().plants)
            {
                foreach (PlantUnit unit in plnat.plantUnits)
                {
                    collectorString += string.Format("{0},", unit.id);
                }
            }
            collectorString = collectorString.Substring(0, collectorString.Length - 1);
            Pager page = new Pager() { PageIndex = 1, PageSize = ComConst.PageSize };
            Fault log = new Fault() { sendTime = DateTime.Now, confirmed = "0", inforank = "1,2,3", collectorString = (collectorString) };
            table.Add("page", page);
            table.Add("fault", log);
            IList<Fault> logs = logService.GetPlantLoglist(table);
            ViewData["page"] = page;
            return View("logajax", logs);
        }

        [HttpPost]
        public ActionResult LogConfirm(string plantId, string type, string logList, string year)
        {
            string result = "fail";
            DateTime now;
            DateTime.TryParse(year, out now);
            switch (type)
            {
                case "1":
                    if ((logList.Equals("-1,")))
                        result = LanguageUtil.getDesc("USER_LOG_CONFIRM_RECORD");
                    else
                    {
                        logService.ConfirmSelectedRecord(now.Year.ToString(), logList.Substring(0, logList.Length - 1));
                        result = LanguageUtil.getDesc("ADMIN_DBCONFIG_EDIT_SUCCESS_EM");
                    }
                    break;
                case "2":
                    logService.ConfirmRecord(now.Year.ToString(), "");
                    result = LanguageUtil.getDesc("ADMIN_DBCONFIG_EDIT_SUCCESS_EM");
                    break;
                default:
                    result = LanguageUtil.getDesc("PLANT_LOG_ERROR");
                    break;
            }
            return Content(result);
        }

        /// <summary>
        /// 功能：跳转到编辑页面
        /// 描述：根据电站id获取电站
        /// 作者：张月
        /// 时间：2011年3月12日 14:59:10
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns>电站编辑页面</returns>
        [IsLoginAttribute]
        public ActionResult PlantEdit(int id)
        {
            Plant plant = FindPlant(id);//根据电站id获取电站
            try
            {
                if (!string.IsNullOrEmpty(plant.pic))
                {
                    string[] s = plant.pic.Split(',');
                    ViewData["pic"] = s;
                    ViewData["username"] = UserUtil.getCurUser().username;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return View(plant);
        }

        /// <summary>
        /// 功能：编辑电站信息
        /// 描述：根据电站信息编辑电站
        /// 获取上传图片的名称修改图片
        /// </summary>
        /// <param name="plantInfo">电站信息</param>
        /// <returns>电站信息页面</returns>
        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Post)]
        [IsLoginAttribute]
        public ActionResult Save(Plant plant)
        {
            plant.description = Server.HtmlDecode(Request.Form["ctl00$MainContent$description"]);
            plantService.UpdatePlantInfo(plant);
            UserUtil.ResetLogin(UserUtil.getCurUser());
            return RedirectToAction("Includeallplants", "user");
        }
        /// <summary>
        /// 功能：把电站开放给其他用户
        /// 作者：张月
        /// 时间：2011年4月24日
        /// </summary>
        /// <param name="id">电站ID</param>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult OpenPlant(int id)
        {
            PlantUser plantUser = new PlantUser();
            plantUser.plantID = id;
            IList<PlantUser> plantsUser = plantUserService.GetOpenPlant(id);
            ViewData["data"] = plantsUser;
            return View(plantUser);
        }

        [IsLoginAttribute]
        [HttpPost]
        public ActionResult OpenPlant(PlantUser plantUser)
        {
            bool exists = false;
            IList<PlantUser> plantsUser = plantUserService.GetOpenPlant(plantUser.plantID);
            ViewData["data"] = plantsUser;
            User user = userservice.GetUserByName(plantUser.username);//查询是否存在该用户
            if (user == null)
            {
                ModelState.AddModelError("Error", Resources.SunResource.USER_OPENPLANT_DIDNT_FIND);
                return View(plantUser);
            }
            else
            {
                User tmpUser;
                foreach (PlantUser pUser in plantsUser)
                {
                    tmpUser = UserService.GetInstance().Get(pUser.userID);
                    if (tmpUser.username.Equals(plantUser.username))
                    {
                        exists = true;
                        break;
                    }
                }

                if (exists)
                {
                    ModelState.AddModelError("Error", "The user has the plant station");
                    return View(plantUser);
                }
                else
                {
                    plantUser.userID = user.id;
                    plantUserService.AddPlantUser(plantUser);
                    return RedirectToAction("IncludeAllplants", "user");
                }
            }
        }

        [IsLoginAttribute]
        public ActionResult ClosePlant(int id)
        {
            string uid = Request.QueryString["uid"];
            plantUserService.ClosePlant(id, int.Parse(uid));
            return RedirectToAction("openplant", new { id = id });
        }
        [IsLoginAttribute]
        public ActionResult PlantUser()
        {
            return View();
        }

        public ActionResult AllPlantsReport(string id, string reportId, string type, string cTime)
        {
            if (!string.IsNullOrEmpty(reportId) && type == "edit")
            {
                ViewData["plantId"] = id;
                ViewData["reportId"] = reportId;
                ViewData["type"] = type;
            }
            else if (!string.IsNullOrEmpty(id) && type == "add")
            {
                ViewData["plantId"] = id;
                ViewData["type"] = type;
            }
            else if (!string.IsNullOrEmpty(id) && type == "load")
            {
                ViewData["plantId"] = id;
                ViewData["type"] = type;
                ViewData["dTime"] = cTime;
            }
            else
            {
                ViewData["plantId"] = id;
                ViewData["reportId"] = "";
                ViewData["type"] = "";
            }
            return View();
        }

        [IsLoginAttribute]
        public ActionResult Users()
        {
            User user = UserUtil.getCurUser();
            return View(user);
        }
        [IsLoginAttribute]
        public ActionResult AddUser()
        {
            return View();
        }

        [HttpPost]
        [IsLoginAttribute]
        public ActionResult AddUser(User user, bool mail, string role)
        {
            string plants = Request.Form["plants"];
            user.ParentUserId = UserUtil.getCurUser().id;
            user.TemperatureType = "C";
            user.currencies = "$";
            user.languageId = 1;
            user.sex = "0";
            string password = user.password;
            user.password = EncryptUtil.EncryptDES(user.password, EncryptUtil.defaultKey);
            int id = userservice.save(user);
            if (string.IsNullOrEmpty(plants) == false)
                foreach (string p in plants.Split(','))
                {
                    if (string.IsNullOrEmpty(p))
                        continue;
                    plantUserService.AddPlantUser(new PlantUser() { userID = id, plantID = int.Parse(p) });
                }
            UserRoleService.GetInstance().Insert(new UserRole() { userId = id, roleId = int.Parse(role) });

            if (mail)
            {
                try
                {
                    EmailQueue queue = new EmailQueue();
                    queue.content = string.Format(Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_EMAIL_BODY, user.username, password);
                    queue.receiver = user.email;
                    queue.title = Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_EMAIL_SUBJECT;
                    SendUserMail(queue);
                }
                catch { }

            }
            return Redirect("/user/plantuser");
        }
        [IsLoginAttribute]
        public ActionResult UserAdd()
        {
            return View();
        }
        [IsLoginAttribute]
        public ActionResult UserEdit()
        {
            string uid = Request.QueryString["uid"];
            int id = 0;
            int.TryParse(uid, out id);
            User user = userservice.Get(id);
            ViewData["roleId"] = Request.QueryString["role"].Trim();
            return View(user);
        }
        [HttpPost]
        [IsLoginAttribute]
        public ActionResult UserEdit(User user, string role, bool mail)
        {
            user.password = EncryptUtil.EncryptDES(user.password, EncryptUtil.defaultKey);
            int roleId = 0;
            int.TryParse(role, out roleId);
            UserRoleService.GetInstance().Save(new UserRole() { userId = user.id, roleId = roleId });
            user.TemperatureType = "C";
            user.currencies = "$";
            user.languageId = 1;
            user.sex = "0";
            userservice.save(user);
            userservice.UpdatePassword(user.id, user.password);

            if (mail)
            {
                try
                {
                    EmailQueue queue = new EmailQueue();
                    queue.content = string.Format(Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_EMAIL_BODY, user.username, user.depassword);
                    queue.receiver = user.email;
                    queue.title = Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_EMAIL_SUBJECT;
                    SendUserMail(queue);
                }
                catch { }
            }
            return Redirect("/user/plantuser");

        }

        private void SendUserMail(EmailQueue queue)
        {
            MailServerPoolObject obj = EmailService.EmailConnectionPool.getMailServerPoolObject();

            try
            {
                Message message = new Message();
                message.BodyText = queue.content;
                message.From.Email = obj.accountName;
                message.To.Add(queue.receiver);
                message.Subject = queue.title;
                obj.SendMail(message);
                obj.close();
            }
            catch
            {
                obj.close();
            }
        }

        public ActionResult UserPlants()
        {
            string uid = Request.QueryString["uid"];
            int id = 0;
            int.TryParse(uid, out id);
            IList<PlantUser> userPlants = plantUserService.GetAllPlantUserByUserID(new PlantUser() { userID = id });
            return View(userPlants);
        }

        [HttpPost]
        [IsLoginAttribute]
        public ActionResult UserPlantEdit()
        {
            string str = Request.Form["plants"];
            string uid = Request.Form["uid"];
            int id = 0;
            int.TryParse(uid, out id);
            plantUserService.DelPlantUserByUserId(id);
            if (string.IsNullOrEmpty(str) == false)
                foreach (string p in str.Split(','))
                {
                    if (string.IsNullOrEmpty(p))
                        break;
                    plantUserService.AddPlantUser(new PlantUser() { plantID = int.Parse(p), userID = id });
                }

            return Redirect("/user/plantuser");
        }

        [IsLoginAttribute]
        public ActionResult DeleteUser()
        {
            string uid = Request.QueryString["uid"];
            int id = 0;
            int.TryParse(uid, out id);
            userservice.Delete(id);
            return Redirect("/user/plantuser");
        }

        [HttpPost]
        [IsLoginAttribute]
        public ActionResult Check(string pname)
        {
            foreach (Plant plant in UserUtil.getCurUser().plants)
            {
                if (plant.name.Equals(pname.Trim()))
                {
                    return Content("false");
                }
            }
            return Content("true");
        }

        [HttpPost]
        public ActionResult CheckUser(string uname, string oldname)
        {
            User use = userservice.GetUserByName(uname);
            if (use != null && (uname.Equals(oldname) == false))
            {
                return Content("false");
            }
            return Content("true");
        }

        public ActionResult ViewInfo(string id)
        {
            int uid = 0;
            int.TryParse(id, out uid);
            User user = userservice.Get(uid);
            return View(user);
        }

        public ActionResult RegSource(string t, string id)
        {
            User user = UserUtil.getCurUser();
            IList<Collector> collectors = CollectorInfoService.GetInstance().GetCollectorsByUid(user.id);
            int days = (int)itemConfigService.GetItemConfig(ItemConfig.maxexpiredDaysId).value;
            int count = (int)itemConfigService.GetItemConfig(ItemConfig.maxCollectorCountId).value;
            foreach (Collector item in collectors)
            {
                if (item.plantID.Equals(0) == false)
                    item.plant = plantService.GetPlantInfoById(item.plantID);
                else
                {
                    if ((DateTime.Now - item.importDate).TotalDays > days)
                    {
                        CollectorInfoService.GetInstance().Delete(item.id);
                    }
                    item.plant = null;
                }
            }

            //此处说明隔天  今天统计数据清零
            if ((DateTime.Now - user.lastApplyCollectorDate).TotalDays > 1)
            {
                user.lastApplyCollectorDate = DateTime.Now;
                user.todayApplyCollectorCount = 0;
                userservice.UpdateApplyCollectorCount(user);
            }


            ViewData["applyed"] = user.todayApplyCollectorCount;
            ViewData["available"] = count - user.todayApplyCollectorCount < 0 ? 0 : count - user.todayApplyCollectorCount;

            if (t != null && t.Equals("create"))
            {
                if (user.todayApplyCollectorCount < count)
                {
                    Collector collector = new Collector();
                    collector.code = string.Format("DT{0}", Util.RandomString());
                    collector.importDate = DateTime.Now;
                    collector.limitDate = DateTime.Now.AddDays(days);
                    collector.password = new Random().Next(100000000, 999999999).ToString();
                    collector.userId = user.id;

                    while (CollectorInfoService.GetInstance().CheckCollectorExists(collector.code) > 0)
                    {
                        collector.code = string.Format("DT{0}", Util.RandomString());
                    }
                    CollectorInfoService.GetInstance().Add(collector);
                    user.lastApplyCollectorDate = DateTime.Now;
                    user.todayApplyCollectorCount++;
                    userservice.UpdateApplyCollectorCount(user);
                    // return Content("true");
                    TempData["message"] = string.Format(Resources.SunResource.REG_SOURCE_NOTICE + "{0}", collector.code);
                    return Redirect("/user/regsource");
                }
                else
                {
                    TempData["message"] = string.Format(Resources.SunResource.APPLY_RESOURCE_ERROR_MSG, count);
                    return Redirect("/user/regsource");
                }
            }

            if (t != null && t.Equals("del"))
            {
                int tint = 0;
                int.TryParse(id, out tint);
                Collector item = collectors.Single(m => m.id.Equals(tint));
                if (item != null && item.plantID > 0)
                    return Content("false");
                CollectorInfoService.GetInstance().Delete(tint);
                return Content("true");
            }

            collectors = collectors.Where(model => (DateTime.Now - model.importDate).TotalDays < days || model.plant != null).ToList<Collector>();

            return View(collectors);
        }


        public ActionResult PRchart()
        {
            User user = UserUtil.getCurUser();
            base.FillAllPlantYears(user);
            return View();
        }

        public void WarningList(string id, string dtype)
        {
            int pageSize = 10;
            int pno = 0;
            int.TryParse(id, out pno);
            pno = pno < 1 ? 1 : pno;
            IList<Device> devices = new List<Device>();
            User user = UserUtil.getCurUser();

            #region 变量

            ArrayList invArray = new ArrayList();
            ArrayList enArray = new ArrayList();
            ArrayList cabArray = new ArrayList();
            ArrayList hlxArray = new ArrayList();
            ArrayList dbArray = new ArrayList();//电表

            double beforeYesterdayEnergy = 0;
            double yesterdayEnergy = 0;
            double todayEnergy = 0;
            double thisMonthEnergy = 0;
            double thisYearEnergy = 0;
            #endregion

            #region

            Hashtable table = null;
            foreach (Plant pnt in user.plants)
            {
                if (pnt.plantUnits != null && pnt.plantUnits.Count > 0)
                    foreach (PlantUnit unit in pnt.plantUnits)
                    {
                        if (unit.devices != null && unit.devices.Count > 0)
                        {
                            foreach (Device dce in unit.devices)
                            {
                                if (dce.isFault() == false)
                                    continue;
                                table = new Hashtable();
                                table.Add("plant", pnt.name);
                                table.Add("unit", unit.displayname);
                                table.Add("device", string.IsNullOrEmpty(dce.name) ? dce.fullName : dce.name);
                                table.Add("status", dce.getStatus());
                                switch (dce.deviceTypeCode)
                                {
                                    #region 逆变器

                                    case DeviceData.INVERTER_CODE:
                                        DeviceMonthDayData deviceMonthDayData = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, dce.id, DateTime.Now.Month);
                                        beforeYesterdayEnergy = deviceMonthDayData.getDayData(DateTime.Now.AddDays(-2).Day);


                                        deviceMonthDayData = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, dce.id, DateTime.Now.Month);
                                        yesterdayEnergy = deviceMonthDayData.getDayData(DateTime.Now.AddDays(-1).Day);


                                        todayEnergy = dce.TodayEnergy(pnt.timezone);


                                        DeviceYearMonthData deviceYearMonthData = DeviceYearMonthDataService.GetInstance().GetDeviceYearMonthData(dce.id, DateTime.Now.Year);
                                        thisMonthEnergy = deviceYearMonthData.getMonthData(DateTime.Now.Month);


                                        DeviceYearData deviceYearData = DeviceYearDataService.GetInstance().GetDeviceYearData(dce.id, DateTime.Now.Year);
                                        thisYearEnergy = deviceYearData.dataValue;

                                        table.Add("beforeYesterdayEnergy", plantService.getDayPr(pnt, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-2).Day, beforeYesterdayEnergy));
                                        table.Add("yesterdayEnergy", plantService.getDayPr(pnt, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-1).Day, beforeYesterdayEnergy));
                                        table.Add("todayEnergy", plantService.getDayPr(pnt, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, todayEnergy).ToString("0.00"));
                                        table.Add("thisMonthEnergy", plantService.getMonthPr(pnt, DateTime.Now.Year, DateTime.Now.Month, thisMonthEnergy).ToString("0.00"));
                                        table.Add("thisYearEnergy", plantService.getYearPr(pnt, DateTime.Now.Year, thisYearEnergy).ToString("0.00"));
                                        invArray.Add(table);
                                        break;
                                    #endregion

                                    case DeviceData.ENVRIOMENTMONITOR_CODE:
                                        enArray.Add(table);
                                        break;
                                    case DeviceData.HUILIUXIANG_CODE:
                                        hlxArray.Add(table);
                                        break;
                                    case DeviceData.CABINET_CODE:
                                        cabArray.Add(table);
                                        break;
                                    case DeviceData.AMMETER_CODE:
                                        table.Add("zxygdd", dce.getMonitorValue(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE));
                                        dbArray.Add(table);
                                        break;
                                }

                            }

                        }
                    }
            }

            #endregion

            Hashtable[] topinv = new Hashtable[pageSize];
            Hashtable[] topenv = new Hashtable[pageSize];
            Hashtable[] topcab = new Hashtable[pageSize];
            Hashtable[] tophlx = new Hashtable[pageSize];
            Hashtable[] topdb = new Hashtable[pageSize];
            int length = invArray.Count - ((pno - 1) * pageSize);
            invArray.CopyTo((pno - 1) * pageSize > invArray.Count ? invArray.Count : (pno - 1) * pageSize, topinv, 0, length > pageSize ? pageSize : (length < 0 ? 0 : length));

            length = enArray.Count - ((pno - 1) * pageSize);
            enArray.CopyTo((pno - 1) * pageSize > enArray.Count ? enArray.Count : (pno - 1) * pageSize, topenv, 0, length > pageSize ? pageSize : (length < 0 ? 0 : length));

            length = cabArray.Count - ((pno - 1) * pageSize);
            cabArray.CopyTo((pno - 1) * pageSize > cabArray.Count ? cabArray.Count : (pno - 1) * pageSize, topcab, 0, length > pageSize ? pageSize : (length < 0 ? 0 : length));

            length = hlxArray.Count - ((pno - 1) * pageSize);
            hlxArray.CopyTo((pno - 1) * pageSize > hlxArray.Count ? hlxArray.Count : (pno - 1) * pageSize, tophlx, 0, length > pageSize ? pageSize : (length < 0 ? 0 : length));

            length = dbArray.Count - ((pno - 1) * pageSize);
            dbArray.CopyTo((pno - 1) * pageSize > dbArray.Count ? dbArray.Count : (pno - 1) * pageSize, topdb, 0, length > pageSize ? pageSize : (length < 0 ? 0 : length));

            ViewData["inv"] = topinv;
            ViewData["env"] = topenv;
            ViewData["cab"] = topcab;
            ViewData["hlx"] = tophlx;
            ViewData["db"] = topdb; ;


            #region 逆变器分页

            Pager invpage = new Pager();
            invpage.PageIndex = pno;
            invpage.PageSize = pageSize;
            invpage.RecordCount = invArray.Count;
            ViewData["invpage"] = invpage;
            #endregion

            #region 分页

            Pager envpage = new Pager();
            envpage.PageIndex = pno;
            envpage.PageSize = pageSize;
            envpage.RecordCount = enArray.Count;
            ViewData["envpage"] = envpage;
            #endregion

            #region 分页

            Pager cabpage = new Pager();
            cabpage.PageIndex = pno;
            cabpage.PageSize = pageSize;
            cabpage.RecordCount = cabArray.Count;
            ViewData["cabpage"] = cabpage;
            #endregion

            #region 汇流箱分页

            Pager hlxpage = new Pager();
            hlxpage.PageIndex = pno;
            hlxpage.PageSize = pageSize;
            hlxpage.RecordCount = hlxArray.Count;
            ViewData["hlxpage"] = hlxpage;
            #endregion

            #region 电表

            Pager dbpage = new Pager();
            dbpage.PageIndex = pno;
            dbpage.PageSize = pageSize;
            dbpage.RecordCount = dbArray.Count;
            ViewData["hlxpage"] = dbpage;
            #endregion


        }

        public ActionResult WarningFilter(string id, string dtype)
        {
            WarningList(id, dtype);
            return View();
        }


        public ActionResult WarningAjax(string id, string t)
        {
            WarningList(id, t);
            ViewData["t"] = t;
            return View();
        }

        public ActionResult Pageconfig()
        {
            return View(UserUtil.getCurUser());
        }

        [HttpPost]
        public ActionResult Pageconfig(User user)
        {
            User cur = UserUtil.getCurUser();
            cur.menuDisplayCount = user.menuDisplayCount;
            cur.overviewDisplayCount = user.overviewDisplayCount;
            userservice.save(cur);
            ViewData["error"] = "<script>window.parent.location.reload();</script>";
            return View(cur);

        }

        public ActionResult RecordList(string localZone, string pageIndex)
        {
            float lzone = 0;
            float.TryParse(localZone, out lzone);
            Pager page = new Pager();
            int index = 0;
            int.TryParse(pageIndex, out index);
            page.PageIndex = index < 1 ? 1 : index;

            int uid = UserUtil.getCurUser().id;
            IList<LoginRecord> record = LoginRecordService.GetInstance().LoginRecords(uid);
            page.RecordCount = record.Count;
            page.PageSize = ComConst.PageSize;
            record = record.OrderByDescending(d => d.loginTime.AddHours(d.localZone)).Skip((page.PageIndex - 1) * page.PageSize).Take(page.PageSize).ToList<LoginRecord>();
            foreach (var item in record)
            {
                item.loginTime = item.loginTime.AddHours(item.localZone).AddHours(lzone);
            }
            ViewData["page"] = page;
            return View("recordlist", record);
        }

        public ActionResult Record()
        {
            int uid = UserUtil.getCurUser().id;
            IList<LoginRecord> record = LoginRecordService.GetInstance().LoginRecords(uid);
            ViewData["loginCount"] = record.Count;
            return View();
        }

    }
}