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
using System.IO;
using System.Drawing;
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
        private static string singlemark_true = "1";//是分配单个电站
        private static string singlemark_false = "0";//分配多个电站

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
            ChartData chartData = PlantChartService.GetInstance().YearMMChartBypList(UserUtil.getCurUser().displayPlants, startYM, endYM, ChartType.line, "kWh");
            string reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            ViewData[ComConst.ReportCode] = reportData;
            ItemConfig itemConfig = itemConfigService.GetItemConfigByName(ItemConfig.CO2);
            User user = UserUtil.getCurUser();
            return View(user);
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
            IList<Plant> plants = UserUtil.getCurUser().displayPlants;
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
            if (user.displayPlants.Count < 1)
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

            ViewData["plant"] = UserUtil.getCurUser().displayPlants;
            Pager page = new Pager();
            page.PageIndex = 1;
            page.PageSize = user.overviewDisplayCount;
            page.RecordCount = user.displayPlants.Count;
            ViewData["page"] = page;

            double userTotal = 0;
            foreach (Plant plant in user.displayPlants) { 
                userTotal+=CompensationService.GetInstance().getPlantTotalCompensations(plant.id);
            }
            //add by qhb 添加补偿设置
            ViewData["totalEnergy"] = StringUtil.formatDouble(Util.upDigtal(user.TotalEnergy + userTotal), "0.00");
            return View(user);
        }


        public ActionResult Plantspage(int index)
        {
            User user = UserUtil.getCurUser();
            Pager page = new Pager();
            page.PageIndex = index;
            page.RecordCount = user.displayPlants.Count;
            page.PageSize = user.overviewDisplayCount;
            ViewData["page"] = page;
            IList<Plant> plants = user.displayPlants;
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
            User user = UserUtil.getCurUser();
            ViewData["currency"] = user.currencies;
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
            plant.structPic = Request["sutpic"];
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

            string start = Request.Form["fstart"];
            string end = Request.Form["fend"];
            string price = Request.Form["fprice"];
            ElecPriceService.GetInstance().Insert(new ElecPrice { fromHm = start, toHm = end, ptype = ElecPrice.Feng, plantId = plantid, price = price });

            start = Request.Form["pstart"];
            end = Request.Form["pend"];
            price = Request.Form["pprice"];
            ElecPriceService.GetInstance().Insert(new ElecPrice { fromHm = start, toHm = end, ptype = ElecPrice.Ping, plantId = plantid, price = price });

            start = Request.Form["gstart"];
            end = Request.Form["gend"];
            price = Request.Form["gprice"];
            ElecPriceService.GetInstance().Insert(new ElecPrice { fromHm = start, toHm = end, ptype = ElecPrice.Gu, plantId = plantid, price = price });

            start = Request.Form["jstart"];
            end = Request.Form["jend"];
            price = Request.Form["jprice"];
            ElecPriceService.GetInstance().Insert(new ElecPrice { fromHm = start, toHm = end, ptype = ElecPrice.Jian, plantId = plantid, price = price });

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
            //如果是组合电站，批量更新原来被组合电站的父id
            if (plant.isVirtualPlant)
            {
                plantService.UpdateParentId(id);
            }

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

            //删除电站时，把用户和电站关系对应表中的删除
            //plantUserService.ClosePlant(id, int.Parse(plant.userID.ToString()));


            //将该电站下的子电站和当前操作人重新建立关联
            foreach (Plant subplant in plant.childs)
            {
                plantUserService.AddPlantUser(new PlantUser() { plantID = subplant.id, userID = (int)plant.userID });
            }

            //实际电站删除单元

            plantService.DeletePlantById(id);

            UserUtil.ResetLogin(UserUtil.getCurUser());

            string fromurl = Request["fromurl"];
            return Redirect(fromurl);
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
            string width = "100"; string height = "30";
            Cn.Loosoft.Zhisou.SunPower.Domain.RelationConfig config = curUser.configs.Where(m => m.relationType.Equals(Cn.Loosoft.Zhisou.SunPower.Domain.RelationConfig.AllPlant) && m.relationId.Equals(0)).FirstOrDefault<Cn.Loosoft.Zhisou.SunPower.Domain.RelationConfig>();
            if (config == null) config = new RelationConfig { width = "100", height = "30", config3 = "20", config4 = "15" };
            if (config != null)
            {
                width = config.width;
                height = config.height;
            }
            string jsStr = base.createPlantContructTree(curUser.displayPlants, -1, width, height);
            ViewData["config"] = config;
            TempData["jsstr"] = jsStr;
            TempData["iSubtreeSeparation"] = config.config3;
            TempData["iSiblingSeparation"] = config.config4;
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
            foreach (Plant plant in curUser.displayPlants)
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


            foreach (Plant plant in user.displayPlants)
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
            foreach (Plant plnat in UserUtil.getCurUser().displayPlants)
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
        /// <summary>
        /// 某个用户创建管理的用户还是电站分配了那些用户？问陈波
        /// modify by qhb in 20120422
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult Users()
        {
            User user = UserUtil.getCurUser();
            //string ids = string.Empty;
            //IList<Plant> vplants = user.
            //foreach (Plant vplant in vplants)
            //    ids += vplant.id + ",";
            //foreach (var plant in user.displayPlants)
            //    ids += string.Format("{0},", plant.id);
            //ids += "-1";
            //IList<User> users = plantUserService.GetusersByplantid(ids);
            //if (users == null) users = new List<User>();
            //foreach (User u in user.ChildUsers)
            //{
            //    if (users.Where(m => m.id.Equals(u.id)).Count() == 0)
            //        users.Add(u);
            //}
            //users = users.Where(m => m.username != user.username && m.username != "demo").ToList<User>();
            ViewData["users"] = user.ChildUsers;
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
            {
                foreach (string p in plants.Split(','))
                {
                    if (string.IsNullOrEmpty(p))
                        continue;
                    bool shared = user.ParentUserId > 0 ? true : false;
                    plantUserService.AddPlantUser(new PlantUser() { userID = id, plantID = int.Parse(p), shared = shared });
                }
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
            User user = UserUtil.getCurUser();
            ViewData["displayPlants"] = user.createToplevelPlants;
            ViewData["cando"] = "true";
            Protal portal = ProtalService.GetInstance().GetByUser(user.id);
            if (portal == null)
                ViewData["cando"] = "false";
            return View();
        }
        /// <summary>
        /// 编辑被创建的用户
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult UserEdit()
        {
            string uid = Request.QueryString["uid"];
            int id = 0;
            int.TryParse(uid, out id);
            User user = userservice.Get(id);
            //废弃
            ViewData["roleId"] = Request.QueryString["role"].Trim();
            return View(user);
        }
        /// <summary>
        /// 保存被传教的用户
        /// </summary>
        /// <param name="user"></param>
        /// <param name="role"></param>
        /// <param name="mail"></param>
        /// <returns></returns>
        [HttpPost]
        [IsLoginAttribute]
        public ActionResult UserEdit(User user, string role, bool mail)
        {
            user.password = EncryptUtil.EncryptDES(user.password, EncryptUtil.defaultKey);
            int roleId = 0;
            int.TryParse(role, out roleId);
            //废弃，用户不在具有独立权限，具体权限需要和分配的电站绑定
            //UserRoleService.GetInstance().Save(new UserRole() { userId = user.id, roleId = roleId });
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

        /// <summary>
        /// 邮件
        /// </summary>
        /// <param name="queue"></param>
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

        /// <summary>
        /// 用户分配的电站
        /// </summary>
        /// <returns></returns>
        public ActionResult UserPlants()
        {
            User user = UserUtil.getCurUser();
            //当前用户创建的电站
            ViewData["plants"] = user.createToplevelPlants;
            string uid = Request.QueryString["uid"];
            int id = 0;
            int.TryParse(uid, out id);
            //该用户已分配电站
            IList<PlantUser> userPlants = plantUserService.GetAllPlantUserByUserID(new PlantUser() { userID = id });
            userPlants = userPlants.Where(m => m.shared).ToList<PlantUser>();
            ViewData["roles"] = user.Roles;
            user = userservice.Get(id);
            ViewData["uname"] = user.username;
            ViewData["pwd"] = user.depassword;
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
            foreach (Plant plant in UserUtil.getCurUser().displayPlants)
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
        /// <summary>
        /// 浏览创建的用户信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult ViewInfo(string id)
        {
            int uid = 0;
            int.TryParse(id, out uid);
            User user = userservice.Get(uid);
            return View(user);
        }
        /// <summary>
        /// 申请数据源
        /// </summary>
        /// <param name="t"></param>
        /// <param name="id"></param>
        /// <returns></returns>
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
            foreach (Plant pnt in user.displayPlants)
            {
                if (pnt.plantUnits != null && pnt.allFactUnits.Count > 0)
                    foreach (PlantUnit unit in pnt.allFactUnits)
                    {
                        if (unit.devices != null && unit.devices.Count > 0)
                        {
                            foreach (Device dce in unit.devices)
                            {
                                if (dce.isFault() == false)
                                    continue;
                                table = new Hashtable();
                                table.Add("plant", plantService.GetPlantInfoById(unit.plantID).name);
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

                                        table.Add("beforeYesterdayEnergy", plantService.getDayPr(pnt, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-2).Day, beforeYesterdayEnergy).ToString("0%"));
                                        table.Add("yesterdayEnergy", plantService.getDayPr(pnt, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-1).Day, beforeYesterdayEnergy).ToString("0%"));
                                        table.Add("todayEnergy", plantService.getDayPr(pnt, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, todayEnergy).ToString("0%"));
                                        table.Add("thisMonthEnergy", plantService.getMonthPr(pnt, DateTime.Now.Year, DateTime.Now.Month, thisMonthEnergy).ToString("0%"));
                                        table.Add("thisYearEnergy", plantService.getYearPr(pnt, DateTime.Now.Year, thisYearEnergy).ToString("0%"));
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
            ViewData["dbpage"] = dbpage;
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

        public ActionResult Auth(string id)
        {
            int tid = 0;
            int.TryParse(id, out tid);

            ViewData["roleName"] = string.Empty;
            ViewData["rids"] = string.Empty;
            Dictionary<string, Hashtable> items = new Dictionary<string, Hashtable>();
            Dictionary<int, string> dics = UserControllerActionType.dictionaries;
            Hashtable table = null;
            foreach (KeyValuePair<int, string> item in dics)
            {
                table = new Hashtable();
                string key = UserControllerActionType.TypeName(item.Key);
                Dictionary<int, ControllerAction> cactions = AuthorizationCode.GetTypeRoles(item.Key);
                foreach (KeyValuePair<int, ControllerAction> cation in cactions)
                {
                    if (cation.Value.IsUsered == false)
                        continue;
                    table.Add(cation.Key, cation.Value.displayName);
                }
                items.Add(key, table);
            }
            ViewData["items"] = items;
            if (tid > 0)
            {
                string rids = string.Empty;
                ViewData["roleName"] = RoleService.GetInstance().Get(tid).name;
                IList<RoleFunction> funcs = RoleFunctionService.GetInstance().GetFunctions(tid);
                foreach (RoleFunction rf in funcs)
                    rids += string.Format("{0},", rf.functionCode);
                ViewData["rids"] = rids;

            }
            ViewData["id"] = id;
            return View();
        }


        public ActionResult Roles()
        {
            int uid = UserUtil.getCurUser().id;
            IList<Role> roles = RoleService.GetInstance().GetRole_Uid(uid);
            return View(roles);
        }

        [HttpPost]
        public ActionResult SaveRoles(string id, string roleName, string roles)
        {
            int rId = 0;
            int.TryParse(id, out rId);
            User curUser = UserUtil.getCurUser();
            int roleId = RoleService.GetInstance().Save(new Role { id = rId, uid = curUser.id, name = roleName, descr = roleName });
            //UserRoleService.GetInstance().Insert(new UserRole { userId = curUser.id, roleId = roleId });
            IList<string> rids = roles.Split(',').ToList<string>();
            RoleFunctionService.GetInstance().Remove(roleId);
            foreach (string rid in rids)
                if (string.IsNullOrEmpty(rid) == false)
                    RoleFunctionService.GetInstance().Insert(new RoleFunction { roleId = roleId, functionCode = int.Parse(rid) });
            return Content("ok");
        }

        public ActionResult DelRole(int id)
        {
            RoleService.GetInstance().Remove(id);
            RoleFunctionService.GetInstance().Remove(id);
            UserRoleService.GetInstance().DeleteRoleId(id);
            return Redirect("/user/roles");
        }

        /// <summary>
        /// 新增组合电站
        /// </summary>
        /// <returns></returns>
        public ActionResult AddVirtualPlant()
        {
            User user = UserUtil.getCurUser();
            return View(user);
        }

        /// <summary>
        /// 保存组合电站，其实就是等同保存一个实际电站，只是多了一个清楚原有被组合电站的parentid和置新被组合电站的parentid
        /// modify by qhb in 20120422
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Savevirtualplant()
        {
            User user = UserUtil.getCurUser();

            #region 变量
            string id = Request["id"];
            string pids = Request.Form["pids"];
            string country = Request.Form["s1"];
            string city = Request.Form["s2"];
            string name = Request.Form["vname"];
            string descr = Request.Form["descr"];
            string[] pid = pids.Split(',');
            string guid = Request["guid"];
            string structPic = Request["structPic"];
            string file = Request["file"];
            if (string.IsNullOrEmpty(file) == false && file.Equals(structPic) == false)
                removeStructPicConfig(id);
            if (string.IsNullOrEmpty(guid))
            {
                guid = "npr.jpg";
            }
            int vid = 0;
            int.TryParse(id, out vid);
            if (vid > 0)//更新虚拟电站
            {
                Plant vplant = plantService.GetPlantInfoById(vid);
                foreach (Plant pnt in vplant.childs)
                {
                    if (pid.Contains(string.Format("{0},", pnt.id)) == false)
                    {
                        plantUserService.AddPlantUser(new PlantUser() { plantID = pnt.id, userID = user.id });
                    }
                }
            }
            city = (city == null || city.ToLower().Equals("null")) ? string.Empty : city;
            #endregion

            //先取得当前电站
            vid = plantService.Save(new Plant { id = vid, name = name, plantIds = pids, description = descr, userID = user.id, parentId = 0, country = country, city = city, pic = guid, isVirtualPlant = true, structPic = structPic });
            if (string.IsNullOrEmpty(id))
                ReportService.GetInstance().batchCreateSysRunReport(0, vid);
            //先批量清楚原有父id
            plantService.UpdateParentId(vid);
            //删除组合电站的用户和电站对应关系
            plantUserService.ClosePlant(vid, user.id);
            //建立创建的
            plantUserService.AddPlantUser(new PlantUser() { plantID = vid, userID = user.id });

            string[] array = pids.Split(',');

            foreach (string item in array)
            {
                if (string.IsNullOrEmpty(item) == false)
                {
                    int temp = 0;
                    int.TryParse(item, out temp);
                    Plant plant = plantService.GetPlantInfoById(temp);
                    plant.parentId = vid;
                    plantService.Save(plant);

                    //删除被组合电站的用户和电站对应关系
                    plantUserService.DelPlantUserByPlantID(plant.id);
                }

            }


            return Content("ok");
        }

        /// <summary>
        /// 分配电站给用户
        /// </summary>
        /// <returns></returns>
        public ActionResult SharePlant()
        {
            ViewData["cando"] = "true";
            User user = UserUtil.getCurUser();
            ViewData["roles"] = user.Roles;
            Protal protal = ProtalService.GetInstance().GetByUser(user.id);
            if (protal == null)
                ViewData["cando"] = "false";
            return View(user.createToplevelPlants);
        }

        /// <summary>
        /// 保存分配给用户分配的电站
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult SaveSharePlant()
        {
            User curr = UserUtil.getCurUser();
            string pids = Request.Form["pids"];
            string ut = Request.Form["ut"];
            string role = Request.Form["role"];
            //将角色转换为整形，由于先保留角色功能，所以目前是取不到值的
            int roleId = 0;
            int.TryParse(role, out roleId);
            string uname = Request.Form["uname"];
            string upwd = Request.Form["upwd"];
            string email = Request.Form["email"];
            string sendmail = Request.Form["sendmail"];
            int uid = 0;
            User user = userservice.GetUserByName(uname.Trim());
            switch (ut)
            {
                case "1"://已有用户
                    if (user == null) return Content("error:该用户不存在");
                    if (user.depassword.Equals(upwd) == false)
                        return Content("error:用户名密码不正确");
                    if (user.ParentUserId.Equals(curr.id) == false)
                        return Content("error:该用户不是您创建的用户，不能分配电站");

                    uid = user.id;

                    break;
                case "2"://新建用户
                    if (user != null)
                        return Content("error:已存在此用户");
                    else
                        uid = userservice.save(new User { ParentUserId = curr.id, username = uname, password = EncryptUtil.EncryptDES(upwd, EncryptUtil.defaultKey), email = email, sex = "1" });

                    if (sendmail.ToLower().Equals("true"))
                    {
                        try
                        {
                            EmailQueue queue = new EmailQueue();
                            queue.content = string.Format(Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_EMAIL_BODY, user.username, upwd);
                            queue.receiver = user.email;
                            queue.title = Resources.SunResource.USER_CONTROLLER_FINDPASSWORD_EMAIL_SUBJECT;
                            SendUserMail(queue);
                        }
                        catch { }
                    }


                    break;
                default:
                    break;
            }
            string singlemark = Request.Form["singlemark"];
            //如果不是报仇分配单个电站，那么要先清空改用户的已分配电站
            if (singlemark_false.Equals(singlemark))
            {
                plantUserService.DelPlantUserByUserId(uid);
            }

            string[] pid_array = pids.Split(',');
            for (int i = 0; i < pid_array.Length; i++)
            {

                if (string.IsNullOrEmpty(pid_array[i])) continue;
                int pid = int.Parse(pid_array[i]);
                //如果关系已经存在即不在建立关系
                PlantUser pu = plantUserService.GetPlantUserByPlantIDUserID(new PlantUser() { plantID = pid, userID = uid });
                if (pu == null)
                    plantUserService.AddPlantUser(new PlantUser { RoleId = roleId, userID = uid, plantID = pid, shared = true });
            }
            return Content("ok");
        }

        public ActionResult Addpic(HttpPostedFileBase pic, string guid)
        {
            try
            {
                if (!Directory.Exists(Server.MapPath("/protalimg/")))
                {
                    Directory.CreateDirectory(Server.MapPath("/protalimg/"));
                }
                string filename = string.Format("{0}.", guid) + pic.FileName.Substring(pic.FileName.LastIndexOf('.') + 1);
                string filePath = Path.Combine(HttpContext.Server.MapPath("../protalimg/"), filename);
                if (pic != null && pic.ContentLength > 0)
                {
                    pic.SaveAs(filePath);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return Content("");
            }
            return Content("");
        }


        public ActionResult PlantRelationStruct()
        {
            return View();
        }

        public ActionResult RelationConfig(RelationConfig config)
        {
            if (config.uid == 0)
            {
                User user = UserUtil.getCurUser();
                config.uid = user.id;
            }
            RelationConfigService.GetInstance().Save(config);
            return Content("ok");
        }

        public ActionResult StructConfig(string id)
        {
            int uid = 0;
            int.TryParse(id, out uid);
            User user = userservice.Get(uid);
            Protal protal = ProtalService.GetInstance().GetByUser(UserUtil.getCurUser().id);
            string width = "100"; string height = "30";
            Cn.Loosoft.Zhisou.SunPower.Domain.RelationConfig config = user.configs.Where(m => m.relationType.Equals(Cn.Loosoft.Zhisou.SunPower.Domain.RelationConfig.AllPlant) && m.relationId.Equals(0)).FirstOrDefault<Cn.Loosoft.Zhisou.SunPower.Domain.RelationConfig>();
            if (config == null) config = new RelationConfig { width = "100", height = "30", config3 = "20", config4 = "15" };
            if (config != null)
            {
                width = config.width;
                height = config.height;
            }
            string jsstr = base.createPortalContructTree(user.assignedPlants, -1, protal.name, width, height);
            ViewData["config"] = config;
            TempData["jsstr"] = jsstr;
            TempData["iSubtreeSeparation"] = config.config3;
            TempData["iSiblingSeparation"] = config.config4;
            ViewData["id"] = id;
            return View();
        }

        public ActionResult portalStructChart(string id)
        {
            ViewData["jsstr"] = TempData["jsstr"];
            return View();
        }

        /// <summary>
        /// 筛选出用户电站非隐藏，工作正常的逆变器的发电量比率大于或者小于设定比率系数的逆变器
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="pid"></param>
        /// <param name="yyyyMMdd"></param>
        /// <param name="?"></param>
        /// <returns></returns>
        public ActionResult EnergyFilter(int id, int? pid, string yyyyMMdd)
        {
            User user = UserService.GetInstance().Get(id);

            IList<Plant> plants = user.allOwnFactPlants;
            ViewData["plants"] = plants;
            IList<Plant> handlePlants = null;
            int timezone = 0;
            if (pid != null && pid.Value != 0)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(pid.Value);
                timezone = plant.timezone;
                handlePlants = new List<Plant>();
                handlePlants.Add(plant);
            }
            else
            {
                handlePlants = plants;
                timezone = plants[0].timezone;
            }

            if (yyyyMMdd == null) yyyyMMdd = CalenderUtil.curDateWithTimeZone(timezone, "yyyy-MM-dd");
            int year = int.Parse(yyyyMMdd.Split('-')[0]);
            int month = int.Parse(yyyyMMdd.Split('-')[1]);
            int day = int.Parse(yyyyMMdd.Split('-')[2]);
            ViewData["yyyyMMdd"] = yyyyMMdd;
            //循环处理多个电站
            IList<Hashtable> datas = new List<Hashtable>();
            Hashtable data = null;
            DeviceMonthDayData dmdd = null;
            foreach (Plant plant in handlePlants)
            {
                if (plant.energyRate == null || double.IsNaN(plant.energyRate.Value))
                    continue;

                //找出电站非隐藏的逆变器
                IList<Device> devices = plant.typeDevices(DeviceData.INVERTER_CODE);

                //逐个判断逆变器设备是否有发电量比例告警，并将有告警的设备放入Hashtable中
                //首先取得电站设备的平均发电量
                double totalEnergy = 0;
                int deviceNum = 0;
                foreach (Device device in devices)
                {
                    if (device.isWork(plant.timezone))
                    {
                        dmdd = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(year, device.id, month);
                        totalEnergy += dmdd.getDayData(day);
                        deviceNum++;
                    }
                }
                double aveageEnergy = 0;
                //有设备才计算平均值
                if (deviceNum > 0)
                {
                    aveageEnergy = totalEnergy / deviceNum;
                }
                //获取每个设备的发电量比率
                double rate = 0;
                foreach (Device device in devices)
                {
                    if (device.isWork(plant.timezone))
                    {
                        data = new Hashtable();
                        dmdd = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(year, device.id, month);
                        if (aveageEnergy == 0)
                            rate = 0;
                        else
                            rate = (dmdd.getDayData(day) - aveageEnergy) / aveageEnergy;
                        if (Math.Abs(rate) < plant.energyRate) continue;

                        rate = Math.Round(rate, 2);
                        data["plantName"] = plant.name;
                        data["deviceName"] = device.fullName;
                        data["energy"] = Math.Round(dmdd.getDayData(day), 2);
                        data["average"] = Math.Round(aveageEnergy, 2);
                        data["rate"] = plant.energyRate;
                        data["prate"] = rate + "/" + plant.energyRate;
                        datas.Add(data);
                    }
                }
            }
            ViewData["datas"] = datas;
            return View();
        }



        public ActionResult UploadLogo()
        {
            return View();
        }
        [HttpPost]
        public ActionResult UploadLogo(HttpPostedFileBase logopic)
        {
            User user = UserUtil.getCurUser();
            try
            {
                if (logopic != null && logopic.ContentLength > 0)
                {
                    string extensionName = logopic.FileName.Substring(logopic.FileName.LastIndexOf('.'));
                    if (extensionName.ToLower().Equals(".jpg"))
                    {
                        Bitmap myImage = new Bitmap(logopic.InputStream);
                        if (myImage.Width > 169)
                        {
                            ViewData["error"] = "图片宽度不能大于169px";
                        }
                        else if (myImage.Height > 40)
                            ViewData["error"] = "图片高度不能大于40px";
                        else
                        {
                            string path = Server.MapPath("~");
                            path = string.Format("{0}/ufile/logo", path);
                            if (System.IO.Directory.Exists(path) == false)
                                Directory.CreateDirectory(path);
                            string logoName = user.id + "logo.jpg";
                            string filePath = Path.Combine(path, logoName);
                            logopic.SaveAs(filePath);
                            user = userservice.GetUserByName(user.username);
                            user.logo = logoName;
                            userservice.save(user);

                        }
                    }

                }
                else
                    ViewData["error"] = "请选择一个jpg扩展名的图片";
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return Content(e.Message);
            }
            return View();
        }
    }
}