using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Globalization;
using Common;


namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    /// <summary>
    /// 功能：电站管理控制器
    /// 作者：张月
    /// 时间：2011年3月12日 17:09:49
    /// </summary>
    public class PlantController : BaseController
    {
        //
        // GET: /Plant/()
        VideoMonitorService monitorService = VideoMonitorService.GetInstance();
        FaultService logService = FaultService.GetInstance();
        ReportConfigService reportConfigService = ReportConfigService.GetInstance();
        PlantService plantService = PlantService.GetInstance();          //电站信息服务
        PlantUnitService plantUnitService = PlantUnitService.GetInstance();  //电站单元服务
        ItemConfigService itemConfigService = ItemConfigService.GetInstance();
        PlantUserService plantUserService = PlantUserService.GetInstance();
        UserService userService = UserService.GetInstance();
        CollectorYearDataService collectorYearDataService = CollectorYearDataService.GetInstance();
        [IsLoginAttribute]
        public ActionResult Index()
        {
            return View();
        }


        [IsLoginAttribute]
        public ActionResult NewGroup()
        {
            return View();
        }

        [IsLoginAttribute]
        public ActionResult Loglist()
        {
            DeviceService iservice = DeviceService.GetInstance();
            IList<Device> inverters = new List<Device>();
            List<SelectListItem> items = new List<SelectListItem>();
            foreach (Device inver in inverters)
                items.Add(new SelectListItem() { Text = inver.deviceAddress, Value = inver.id.ToString(), Selected = false });
            items.Add(new SelectListItem() { Text = "123", Value = "1" });
            ViewData["plants"] = items;
            FaultService service = FaultService.GetInstance();
            Pager page = new Pager() { PageIndex = 1, PageSize = ComConst.PageSize };
            ViewData["page"] = page;
            return View(service.Getlist(page));
        }

        /// <summary>
        /// 获取电站年份
        /// </summary>
        /// <param name="plantId">电站Id</param>
        private void FillPlantYears(string plantId)
        {
            Plant plant = FindPlant(int.Parse(plantId));
            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);
            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData["plantYear"] = plantYearsList;

        }
        /// <summary>
        /// 功能：电站概览
        /// 描述：大电站的概览，每个小电站的实时数据累加
        /// 作者：张月
        /// 时间：2011年3月10日 21:45:13
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns>电站概览页面</returns>
        [IsLoginAttribute]
        public ActionResult Overview(int id)
        {
            User curUser = UserUtil.getCurUser();
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            return View(plant);
        }
        /// <summary>
        /// 功能：电站概览
        /// 描述：大电站的概览，每个小电站的实时数据累加
        /// 作者：张月
        /// 时间：2011年3月10日 21:45:13
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns>电站概览页面</returns>
        [IsLoginAttribute]
        public ActionResult IncludeOverview(int id)
        {
            User curUser = UserUtil.getCurUser();
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            if (plant == null)
                return RedirectToAction("portal", "user");
            else if (plant.plantUnits.Count == 0)
                return RedirectToAction("bind", "unit", new { @id = id });

            string startYM = (DateTime.Now.Year - 1) + "" + DateTime.Now.Month.ToString("00");
            string endYM = DateTime.Now.Year + "" + DateTime.Now.Month.ToString("00");
            //int monitorCode = 0;//发电量测点
            //string reportCode = PlantChartService.GetInstance().YearMMChartBypList(base.getCurUser().plants, startYM, endYM, ChartType.line, "kWh", monitorCode);
            //ViewData[ComConst.ReportCode] = reportCode;

            ViewData[ComConst.PlantName] = plant.name;
            plant.currencies = curUser.currencies;
            ViewData["temp"] = Math.Round(plant.Temperature,1);
            if (plant.Temperature == 0.0)
            {
                CityCodeService codeService = CityCodeService.GetInstance();
                ViewData["temp"] = Math.Round(codeService.GetTemperature(plant.city), 1) ;
            }
            if (!double.IsNaN(((double)ViewData["temp"])) && (double)ViewData["temp"]!=0)
            {
                User user = UserUtil.getCurUser();
                if (user != null && !user.TemperatureType.ToLower().Equals("c"))
                {
                    ViewData["temp"] = Math.Round(32 + ((double)ViewData["temp"] * 1.8),1);
                }
            }
            else
                ViewData["temp"] = "";

            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);

            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);

            ViewData["plantYear"] = plantYearsList;
            return View(plant);

        }
        /// <summary>
        /// 功能：电站详细信息
        /// 描述：根据电站id获取电站信息
        /// 作者：张月
        /// 时间：2011年3月12日 14:31:50
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns>电站信息页面</returns>
        [IsLoginAttribute]
        public ActionResult IncludeProfile(int id)
        {
            Plant plant = FindPlant(id);//根据电站id获取电站
            ViewData["pic"] = plant.pic;
            ViewData["username"] = UserUtil.getCurUser().username;
            FillPlantYears(id.ToString());
            return View(plant);
        }


        public ActionResult Profile(int id)
        {
            User curUser = UserUtil.getCurUser();
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            return View(plant);
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
        public ActionResult Edit(int id)
        {
            Plant plant = FindPlant(id);//根据电站id获取电站
            if (string.IsNullOrEmpty(plant.startDate) || string.IsNullOrEmpty(plant.endDate))
            {
                string code = string.Empty;

                IList<CountryCity> countries = CountryCityService.GetInstance().GetList();
                foreach (CountryCity country in countries)
                {
                    if (country.name.Trim().Equals(plant.country))
                    {
                        code = country.code;
                        break;
                    }
                }
                code = string.IsNullOrEmpty(code) ? "&" : code;
                string[] codes = code.Split('&');
                if (codes.Length >= 3)
                {
                    plant.startDate = codes[0];
                    plant.endDate = codes[1];
                    plant.hours = int.Parse(codes[2]);
                }
            }
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
        /// 当前用户的电站列表
        /// </summary>
        /// <returns>返回页面</returns>
        [IsLoginAttribute]
        public ActionResult list()
        {
            User curUser = UserUtil.getCurUser();
            ViewData["plantList"] = curUser.plants;
            Plant plant = curUser.firstPlant;
            return View(plant);
        }

        /// <summary>
        /// 功能：跳转到添加页面
        /// 作者：张月
        /// 时间：2011年3月12日 17:02:25
        /// </summary>
        /// <returns>添加页面</returns>
        [IsLoginAttribute]
        public ActionResult AddPlant(int id)
        {
            Plant plant = new Plant();
            plant.id = id;
            plant.userID = UserUtil.getCurUser().id;
            return View(plant);
        }
        /// <summary>
        /// 功能：编辑电站信息
        /// 描述：根据电站信息编辑电站
        /// 获取上传图片的名称修改图片
        /// </summary>
        /// <param name="plantInfo">电站信息</param>
        /// <param name="uploadFile">图片的名称</param>
        /// <returns>电站信息页面</returns>
        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Post)]
        [IsLoginAttribute]
        public ActionResult Save(Plant plant)
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

            CountryCity area = CountryCityService.GetInstance().GetCity(plant.country);
            plant.area = area == null ? string.Empty : area.weather_code;
            plantService.UpdatePlantInfo(plant);
            UserUtil.ResetLogin(UserUtil.getCurUser());
            return RedirectToAction("profile", "plant", new { @id = plant.id });
        }

        private ActionResult RenderView()
        {
            throw new NotImplementedException();
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
            plant.userID = UserUtil.getCurUser().id;
            int plantid = plantService.AddPlantInfo(plant);
            plantUserService.AddPlantUser(new PlantUser { plantID = plantid, userID = int.Parse(plant.userID.ToString()) });//添加电站时，向电站用户关系表中加记录
            UserUtil.ResetLogin(UserUtil.getCurUser());
            return RedirectToAction("profile", "plant", new { @id = plant.id });
        }
        /// <summary>
        /// 功能：删除图片
        /// 描述：根据id删除图片
        /// 作者：张月
        /// 时间：2011年3月12日 15:50:35
        /// </summary>
        /// <param name="id">电站id</param>
        /// <param name="picName">图片名称</param>
        /// <returns>电站信息页面</returns>
        [IsLoginAttribute]
        public ActionResult DeletePic(int id, string picName)
        {
            Plant plantInfo = FindPlant(id);//获取电站信息
            plantInfo.pic = plantInfo.pic != null ? plantInfo.pic.Replace("," + picName, "") : "";
            plantService.UpdatePlantInfo(plantInfo);
            try
            {
                System.IO.File.Delete(HttpContext.Server.MapPath("/ufile/" + picName));
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return RedirectToAction("Edit", "plant", new { @id = id });
        }
        /// <summary>
        /// 功能：删除图片
        /// 描述：根据id删除图片
        /// 作者：张月
        /// 时间：2011年3月12日 15:50:35
        /// </summary>
        /// <param name="id">电站id</param>
        /// <param name="picName">图片名称</param>
        /// <returns>电站信息页面</returns>
        [IsLoginAttribute]
        public ActionResult DeleteImg(int id, string picName)
        {
            try
            {
                System.IO.File.Delete(HttpContext.Server.MapPath("/ufile/" + picName));
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return RedirectToAction("Edit", "plant", new { @id = id });
        }

        [IsLoginAttribute]
        public ActionResult Energy(int id)
        {
            CollectorRunDataService service = CollectorRunDataService.GetInstance();
            CollectorRunData data = service.Get(id);
            return View(data);
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
            plantService.DeletePlantById(id);
            return RedirectToAction("list", "plant");
        }
        /// <summary>
        /// 电站实时环境条件
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult Environment(int id)
        {
            User user = null;
            PlantService plantInfoService = PlantService.GetInstance();
            CollectorRunDataService runDataService = CollectorRunDataService.GetInstance();
            if (Session[ComConst.User] != null)
            {
                user = UserUtil.getCurUser(); ;

                IList<Plant> plantInfo = UserUtil.getCurUser().plants;
                ViewData["plantList"] = plantInfo;
                return View(runDataService.Get(id));
            }
            else
            {
                return RedirectToAction("index", "home");
            }
        }

        //[IsLoginAttribute]
        //public ActionResult Report(int id)
        //{
        //    //PlantUserService userService = PlantUserService.GetInstance();
        //    //IList<PlantUser> userList = userService.GetPlantsByUserId(new PlantUser() { PlantID = 120 });
        //    ViewData["plantInfo"] = null;// userList;

        //    ReportConfigService service = ReportConfigService.GetInstance();
        //    //IList<ReportConfig> configs = service.List();
        //    return View(configs);
        //}

        /// <summary>
        /// 功能：显示电站地图
        /// 描述：根据电站id获取电站的经度纬度
        /// 作者：张月
        /// 时间：2011年3月12日 16:38:08
        /// </summary>
        /// <returns>电站id</returns>
        public ActionResult Map(int id)
        {
            return View(FindPlant(id));
        }
        /// <summary>
        /// 功能：电站地图修改时保存电站信息
        /// 作者：张月
        /// 时间：2011年3月13日 21:18:04
        /// </summary>
        /// <param name="plant"></param>
        /// <returns></returns>
        [HttpPost]
        [IsLoginAttribute]
        public ActionResult SaveMap(Plant plant)
        {

            Plant newplant = FindPlant(plant.id);

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

            newplant.longitude = value;
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
            newplant.latitude = value;

            newplant.longitudeString = string.Format("{0},{1},{2}", long1, long2, long3);
            newplant.latitudeString = string.Format("{0},{1},{2}", lat1, lat2, lat3);


            plantService.UpdatePlantInfo(newplant);
            return RedirectToAction("map", "plant", new { @id = plant.id });
        }

        /// <summary>
        /// 陈波
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Log(int id)
        {
            ICollection<ErrorType> errorTypes = ErrorType.getErrorList();
            ViewData["errorTypes"] = errorTypes;
            return View(FindPlant(id));
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
        public ActionResult Log(DateTime t, int state, int plant, int pindex, string errorCode, string logList, string ctype)
        {
            string collectorString = string.Empty;
            if (plant == -1)
            {
                foreach (Plant p in UserUtil.getCurUser().plants)
                {
                    foreach (PlantUnit unit in p.plantUnits)
                    {
                        collectorString += string.Format("{0},", unit.collector.id);
                    }
                }
            }
            else
            {
                foreach (PlantUnit unit in FindPlant(plant).plantUnits)
                {
                    collectorString += string.Format("{0},", unit.collector.id);
                }
            }
            if (collectorString.Length > 1)
                collectorString = collectorString.Substring(0, collectorString.Length - 1);
            string stateStr = string.Empty;
            if (state == -1)
                stateStr = "1,0";
            else
                stateStr = state.ToString();
            Hashtable table = new Hashtable();
            Pager page = new Pager() { PageIndex = pindex, PageSize = ComConst.PageSize };
            Fault fault = new Fault() { sendTime = t, confirmed = null, inforank = errorCode.Substring(0, errorCode.Length - 1), collectorString = collectorString };
            table.Add("page", page);
            table.Add("fault", fault);
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
            return View("logajax", logs);
        }
        /// <summary>
        /// 初始数据加载  电站日志
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult LogLoad(string plant)
        {
            Hashtable table = new Hashtable();
            Pager page = new Pager() { PageIndex = 1, PageSize = ComConst.PageSize };
            Fault log = new Fault() { sendTime = DateTime.Now, confirmed = null, inforank = "1,2,3", collectorID = int.Parse(plant) };
            table.Add("page", page);
            table.Add("fault", log);
            IList<Fault> logs = logService.GetPlantLoglist(table);
            ViewData["page"] = page;
            return View("logajax", logs);
        }

        [HttpPost]
        public ActionResult LogConfirm(string plantId, string type, string logList, string startDate, string endDate)
        {
            int startYear = DateTime.Parse(startDate).Year;
            int endYear = DateTime.Parse(endDate).Year;

            string result = "fail";
            switch (type)
            {
                case "1":
                    if ((logList.Equals("-1,")))
                        result = LanguageUtil.getDesc("USER_LOG_CONFIRM_RECORD");
                    else
                    {
                        while (startYear <= endYear)
                        {
                            logService.ConfirmSelectedRecord(startYear.ToString(), logList.Substring(0, logList.Length - 1));
                            startYear++;
                        }
                        result = "successed";

                    }
                    break;
                case "2":
                    string collectorString = string.Empty;
                    IList<Plant> plants = null;
                    if (plantId.Equals("-1"))
                        plants = UserUtil.getCurUser().plants;
                    else
                    {
                        plants = new List<Plant>();
                        plants.Add(FindPlant(int.Parse(plantId)));
                    }
                    foreach (Plant plant in plants)
                    {
                        if (plant.plantUnits != null)
                        {
                            foreach (PlantUnit plantUnit in plant.plantUnits)
                            {
                                collectorString += string.Format("{0},", plantUnit.collector.id);
                            }
                        }
                    }
                    if (collectorString.EndsWith(","))
                    {
                        collectorString = collectorString.Substring(0, collectorString.Length - 1);
                    }
                    while (startYear <= endYear)
                    {
                        logService.ConfirmRecord(startYear.ToString(), collectorString);
                        startYear++;
                    }
                    result = "successed";
                    break;
                default:
                    result = "fail";
                    break;
            }
            return Content(result);
        }



        //[IsLoginAttribute]
        //public ActionResult ReportConfig(string id)
        //{
        //    int pid = 0;
        //    int.TryParse(id, out pid);
        //    Plant plant = FindPlant(pid);
        //    if (plant == null)
        //        return Redirect("/");
        //    ViewData["reportList"] = reportConfigService.GetPlantReportList(pid);
        //    return View(plant);

        //}

        //[HttpPost]
        //[IsLoginAttribute]
        //public ActionResult ReportSaves(string errorType, string reportType, string interval, string reportEmail, string errorEmail, string []plants, string data_format)
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
        //        if (!reportType.Equals("-1"))
        //        {
        //            config.interval = int.Parse(interval);
        //            config.plantIds = pids.Length > 0 ? pids.Substring(0, pids.Length - 1) : "";

        //            config.receiveEmail = reportEmail;
        //            config.intervalFormat = data_format;
        //            config.type = reportType;
        //            reportConfigService.Save(config);
        //            config.id = 0;

        //        }

        //        if (!errorType.Equals("-1"))
        //        {
        //            config.interval = 0;
        //            config.plantIds = pids.Length > 0 ? pids.Substring(0, pids.Length - 1) : "";

        //            config.receiveEmail = errorEmail;
        //            config.type = errorType;
        //            reportConfigService.Save(config);
        //            config.id = 0;
        //            config.intervalFormat = string.Empty;

        //        }
        //    return RedirectToAction("reportconfig", "plant", new {@id=plants[0]});

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
        /// 加载某个电站某个设备信息的页面
        /// </summary>
        /// <param name="plantId"></param>
        /// <param name="uintId"></param>
        /// <returns></returns>
        public ActionResult Device(int plantId, int deviceId, int unitId)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(plantId);

            ViewData["deviceID"] = deviceId;
            ViewData["device"] = DeviceService.GetInstance().get(deviceId); ;
            ViewData["plantID"] = plantId;
            ViewData["unitID"] = unitId;
            FillPlantYears(plantId.ToString());
            return View(plant);
        }

        /// <summary>
        /// 保留，废弃
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeviceModel(int id)
        {
            StringBuilder sbuilder = new StringBuilder();
            sbuilder.AppendFormat("<select name=\"deviceModelId\" id=\"deviceModelId\" class=\"textsy02\">");
            sbuilder.Append("<option value=\"-1\">Device Model</option>");
            IList<DeviceModel> models = DeviceModelService.GetInstance().getXhbyDeviceType(id);
            foreach (DeviceModel model in models)
            {
                sbuilder.AppendFormat(" <option value=\"{0}\">{1}</option>", model.code, model.name);
            }
            sbuilder.AppendFormat("</select>");
            return Content(sbuilder.ToString());

        }

        [IsLoginAttribute]
        public ActionResult Information(int id)
        {
            Plant plant = FindPlant(id);
            User user = UserUtil.getCurUser();
            plant.currencies = user.currencies;
            ViewData["temp"] = plant.Temperature;
            if (plant.Temperature == 0.0)
            {
                CityCodeService codeService = CityCodeService.GetInstance();
                ViewData["temp"] = codeService.GetTemperature(plant.city);
            }
            if (!double.IsNaN(((double)ViewData["temp"])))
            {
                if (user != null && !user.TemperatureType.ToLower().Equals("c"))
                {
                    ViewData["temp"] = (32 + (ViewData["temp"] as float?)) * 1.8;
                }
            }
            else
                ViewData["temp"] = "";

            return View(plant);
        }


        public ActionResult Monitor(int id)
        {
            //ViewData["data"] = monitorService.GetList(new VideoMonitor() { plantId = id });
            return View(FindPlant(id));
        }

        public ActionResult IncludeMonitor(int id)
        {
            ViewData["data"] = monitorService.GetList(new VideoMonitor() { plantId = id });
            return View(FindPlant(id));
        }
        [HttpPost]
        public ActionResult Monitor_Delete(int key)
        {
            monitorService.Delete(key);
            return Content(key.ToString());
        }

        [HttpPost]
        public ActionResult Monitor_Add(VideoMonitor monitor)
        {
            monitorService.Save(monitor);
            return Content("success");
        }

        /// <summary>
        /// 加载电站日功率统计数据
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult PowerCount(int id, string startYYYYMMDDHH, string endYYYYMMDDHH)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            int year = int.Parse(startYYYYMMDDHH.Substring(0, 4));
            int month = int.Parse(startYYYYMMDDHH.Substring(4, 2));
            int day1 = int.Parse(startYYYYMMDDHH.Substring(6, 2));
            int day2 = int.Parse(endYYYYMMDDHH.Substring(6, 2));
            DeviceDataCount ddc1 = new DeviceDataCount() { deviceId = id, deviceTable = TableUtil.PLANT, monitorCode = MonitorType.PLANT_MONITORITEM_POWER_CODE, year = year, day = day1, month = month };
            DeviceDataCount ddc2 = new DeviceDataCount() { deviceId = id, deviceTable = TableUtil.PLANT, monitorCode = MonitorType.PLANT_MONITORITEM_POWER_CODE, year = year, day = day2, month = month };

            DeviceDataCount dayddc1 = DeviceDataCountService.GetInstance().Get(ddc1);
            DeviceDataCount dayddc2 = DeviceDataCountService.GetInstance().Get(ddc2);
            DeviceDataCount ddc = ddc1;
            DeviceDataCount dayddc = dayddc1;
            if (dayddc1 != null && dayddc2 != null)
            {
                //取最大一天的
                if (dayddc1.maxValue >= dayddc2.maxValue)
                {
                    ddc = ddc1;
                    dayddc = dayddc1;
                }
                else
                {
                    ddc = ddc2;
                    dayddc = dayddc2;
                }
            }
            else if (dayddc1 != null && dayddc2 == null)
            {
                ddc = ddc1;
                dayddc = dayddc1;
            }
            else if (dayddc1 == null && dayddc2 != null)
            {
                ddc = ddc2;
                dayddc = dayddc2;
            }

            DeviceDataCount monthddc = DeviceDataCountService.GetInstance().GetMonthMax(ddc);
            DeviceDataCount yearddc = DeviceDataCountService.GetInstance().GetYearMax(ddc);
            ViewData["dayddc"] = dayddc;
            ViewData["monthddc"] = monthddc;
            ViewData["yearddc"] = yearddc;
            ViewData["plant"] = plant;
            FillPlantYears(id.ToString());
            return View();
        }


        /// <summary>
        /// 跳转到修改用户信息页面
        /// </summary>
        /// <returns></returns>
        public ActionResult UserInfo(int id)
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
            ViewData["langs"] = Cn.Loosoft.Zhisou.SunPower.Service.LanguageService.GetInstance().GetList();
            base.GetLanguage();
            ViewData["data"] = userservice.Get(UserUtil.getCurUser().id);
            return View("Userinfo", FindPlant(id));
        }

        /// <summary>
        /// 修改用户信息
        /// </summary>
        /// <param name="user">用户信息</param>
        /// <returns>电站页面</returns>
        [HttpPost]
        public ActionResult UserInfo(User user)
        {
            if (ModelState.IsValid)
            {
                //创建用户服务

                if (string.IsNullOrEmpty(user.password))
                {
                    userService.save(user);
                    UserUtil.ResetLogin(user);
                }
                else
                    userService.save(user);
                Language language = LanguageService.GetInstance().Get((int)user.languageId);
                CultureInfo cultureInfo = new CultureInfo(language.codename);
                Session["Culture"] = cultureInfo;
                Session["display"] = language.name;



            }
            return RedirectToAction("overview", "user");
        }


        /// <summary>
        /// 跳转到修改用户密码页面
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult changepassword(string oldPassword, string password, string confirmPassword, string pid)
        {
            if (!password.Equals(confirmPassword))
            {
                ViewData["error"] = "<em><span id=\"serverError\" class='error'>" + Resources.SunResource.USER_CHANGEPASSWORD_NOTICE + "</span></em>";
                return View();
            }
            User user = UserUtil.getCurUser();
            if (user.depassword.Equals(oldPassword))
            {
                userService.UpdatePassword(user.id, EncryptUtil.EncryptDES(password, EncryptUtil.defaultKey));
                ViewData["error"] = "<em><span id=\"serverError\" class='success'>" + Resources.SunResource.USER_CHANGEPASSWORD_NOTICE1 + "</span></em>";
            }
            else
            {
                ViewData["error"] = "<em><span id=\"serverError\" class='error'>" + Resources.SunResource.USER_CHANGEPASSWORD_NOTICE2 + "</span></em>";
            }
            int temp = 0;
            int.TryParse(pid, out temp);
            return View(FindPlant(temp));
        }

        public ActionResult changepassword(int id)
        {
            return View(FindPlant(id)); ;
        }

        /// <summary>
        /// 显示所有电站框架下的自定义图表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult CustomChart(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            return View(plant);
        }
        /// <summary>
        /// 显示所有电站框架下的自定义图表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult CustomCharts(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            return View(plant);
        }

        /// <summary>
        /// 显示所有电站框架下的自定义图表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult IncludeCustomCharts(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            return View(plant);
        }

        /// <summary>
        /// 进入自定义报表
        /// </summary>
        /// <returns>自定义报表页面</returns>
        [HttpGet]
        public ActionResult ViewCustomChart(int pId, int cId)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            ViewData["id"] = cId.ToString();
            Session["customID"] = cId;
            return View(plant);
        }

        /// <summary>
        /// 进入自定义报表
        /// </summary>
        /// <returns>自定义报表页面</returns>
        [HttpGet]
        public ActionResult IncludeViewCustomChart(int pId, int cId)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            ViewData["id"] = cId.ToString();
            Session["customID"] = cId;
            FillPlantYears(pId.ToString());
            return View(plant);
        }

        public ActionResult DeviceMonitor(string id)
        {
            int pid = 0;
            int.TryParse(id, out  pid);
            Plant plant = FindPlant(pid);
            ViewData["data"] = SortPlantDevice(pid);
            FillPlantYears(id.ToString());
            return View(plant);
        }

        public ActionResult Inverter_Output(string id)
        {
            CsvStreamWriter csvWriter = new CsvStreamWriter();
            IList<string> dataList = new List<string>();
            dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},", Resources.SunResource.PLANT_DEVICEMONITOR_UNIT, Resources.SunResource.PLANT_DEVICEMONITOR_NAME,
                Resources.SunResource.PLANT_DEVICEMONITOR_INSTAL_POWER + "(kWh)",
                Resources.SunResource.PLANT_DEVICEMONITOR_CURRENT_POWER + "(W)",
                Resources.SunResource.PLANT_DEVICEMONITOR_DEVICE_STATUS, Resources.SunResource.PLANT_OVERVIEW_TODAY_ENERGRY1 + "(kWh)",
                Resources.SunResource.PLANT_UNIT_LIST_MONTH_ENERGY + "(kWh)",
                Resources.SunResource.PLANT_UNIT_LIST_MONTH_ENERGY_KWP + "(kWh/kWp)",
                Resources.SunResource.PLANT_UNIT_LIST_TOTAL_ENERGY + "(kWh)",
                Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME
                ));
            int pid = 0;
            int.TryParse(id, out  pid);
            Plant plant = FindPlant(pid);
            IList<Device> deviceList = SortPlantDevice(pid);
            bool fault = false;
            float curMonthEnergy = 0L;
            PlantUnit plantUnit;

            #region 异常
            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (fault)
                {
                    object value = ReflectionUtil.getProperty(DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month), string.Format("d_{0}", DateTime.Now.Day));

                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},", plantUnit.displayname, string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
         device.designPower.ToString("0.0"),
         fault ? "0" : device.getMonitorValue(MonitorType.MIC_INVERTER_TOTALYGPOWER).ToString(),
         device.getMonitorValue(MonitorType.MIC_INVERTER_DEVICESTATUS),
         value == null ? "0" : value.ToString(),
         curMonthEnergy.ToString("0.00"),
         Math.Round(curMonthEnergy / device.chartPower, 2).ToString(),
         device.TotalEnergy.ToString(),
         device.runData.updateTime.ToString("MM-dd HH:mm:ss")
         ));
                }
            }

            #endregion

            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    object value = ReflectionUtil.getProperty(DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month), string.Format("d_{0}", DateTime.Now.Day));

                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},", plantUnit.displayname, string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
                     device.designPower.ToString("0.0"),
                     fault ? "0" : device.getMonitorValue(MonitorType.MIC_INVERTER_TOTALYGPOWER).ToString(),
                     device.getMonitorValue(MonitorType.MIC_INVERTER_DEVICESTATUS),
                     value == null ? "0" : value.ToString(),
                     curMonthEnergy.ToString("0.00"),
                     Math.Round(curMonthEnergy / device.chartPower, 2).ToString(),
                     device.TotalEnergy.ToString(),
                     device.runData.updateTime.ToString("MM-dd HH:mm:ss")
                     ));

                }
            }

            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (!device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    object value = ReflectionUtil.getProperty(DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month), string.Format("d_{0}", DateTime.Now.Day));

                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},", plantUnit.displayname, string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
                     device.designPower.ToString("0.0"),
                     fault ? "0" : device.getMonitorValue(MonitorType.MIC_INVERTER_TOTALYGPOWER).ToString(),
                     device.getMonitorValue(MonitorType.MIC_INVERTER_DEVICESTATUS),
                     value == null ? "0" : value.ToString(),
                     curMonthEnergy.ToString("0.00"),
                     Math.Round(curMonthEnergy / device.chartPower, 2).ToString(),
                     device.TotalEnergy.ToString(),
                     device.runData.updateTime.ToString("MM-dd HH:mm:ss")
                     ));

                }
            }
            csvWriter.AddStrDataList(dataList);
            string fullFile = Server.MapPath("/") + "tempexportfile\\" + Resources.SunResource.DEVICE_MONITOR_INVERTER + ".csv";
            csvWriter.Save(fullFile);
            //转化为csv格式的字符串
            ActionResult tmp = File(fullFile, "text/csv; charset=UTF-8", urlcode(Resources.SunResource.DEVICE_MONITOR_INVERTER) + ".csv");
            return tmp;
        }


        public ActionResult EM_Output(string id)
        {
            CsvStreamWriter csvWriter = new CsvStreamWriter();
            IList<string> dataList = new List<string>();
            dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},", Resources.SunResource.PLANT_DEVICEMONITOR_UNIT,
                Resources.SunResource.PLANT_DEVICEMONITOR_NAME, Resources.SunResource.DEVICE_MONITOR_SUNSHINE,
                Resources.SunResource.DEVICE_MONITOR_WIND_SPEED, Resources.SunResource.DEVICE_MONITOR_TEMPERATURE,
                Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME
                ));

            int pid = 0;
            int.TryParse(id, out  pid);
            Plant plant = FindPlant(pid);
            IList<Device> deviceList = SortPlantDevice(pid);
            bool fault = false;
            float curMonthEnergy = 0L;
            PlantUnit plantUnit;

            #region 异常
            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.ENVRIOMENTMONITOR_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (fault)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},", plantUnit.displayname,
              string.IsNullOrEmpty(device.name) ? device.fullName : device.name, device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT),
             device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED), device.getMonitor(MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE),
              device.runData.updateTime.ToString("MM-dd HH:mm:ss")
              ));
                }
            }

            #endregion

            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.ENVRIOMENTMONITOR_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},", plantUnit.displayname,
             string.IsNullOrEmpty(device.name) ? device.fullName : device.name, device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT),
            device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED), device.getMonitor(MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE),
             device.runData.updateTime.ToString("MM-dd HH:mm:ss")
             ));

                }
            }

            foreach (Device device in deviceList)
            {

                if (!device.deviceTypeCode.Equals(DeviceData.ENVRIOMENTMONITOR_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (!device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},", plantUnit.displayname,
                     string.IsNullOrEmpty(device.name) ? device.fullName : device.name, device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT),
                    device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED), device.getMonitor(MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE),
                     device.runData.updateTime.ToString("MM-dd HH:mm:ss")
                     ));

                }
            }
            csvWriter.AddStrDataList(dataList);

            string fullFile = Server.MapPath("/") + "tempexportfile\\" + Resources.SunResource.DEVICE_MONITOR_EM + ".csv";
            csvWriter.Save(fullFile);
            //转化为csv格式的字符串
            ActionResult tmp = File(fullFile, "text/csv; charset=UTF-8", urlcode(Resources.SunResource.DEVICE_MONITOR_EM) + ".csv");
            return tmp;

        }


        public ActionResult HLX_Output(string id)
        {
            CsvStreamWriter csvWriter = new CsvStreamWriter();
            IList<string> dataList = new List<string>();
            dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},",
                Resources.SunResource.PLANT_DEVICEMONITOR_UNIT,
                Resources.SunResource.PLANT_DEVICEMONITOR_NAME,
                Resources.SunResource.DEVICEMONITORITEM_321,
                Resources.SunResource.DEVICEMONITORITEM_325,
                Resources.SunResource.DEVICEMONITORITEM_326,
                Resources.SunResource.MONITORITEM_TEMPERATURE,
                Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME
                ));
            int pid = 0;
            int.TryParse(id, out  pid);
            Plant plant = FindPlant(pid);
            IList<Device> deviceList = SortPlantDevice(pid);
            bool fault = false;
            float curMonthEnergy = 0L;
            PlantUnit plantUnit;

            #region 异常
            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.HUILIUXIANG_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (fault)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},",
           plantUnit.displayname,
           string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
           device.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM),
           device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT),
           device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT),
          device.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE),
           device.runData.updateTime.ToString("MM-dd HH:mm:ss")
           ));

                }
            }

            #endregion

            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.HUILIUXIANG_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},",
                      plantUnit.displayname,
                      string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
                      device.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM),
                      device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT),
                      device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT),
                     device.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE),
                      device.runData.updateTime.ToString("MM-dd HH:mm:ss")
                      ));

                }
            }

            foreach (Device device in deviceList)
            {

                if (!device.deviceTypeCode.Equals(DeviceData.HUILIUXIANG_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (!device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},",
                    plantUnit.displayname,
                    string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
                    device.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM),
                    device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT),
                    device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT),
                    device.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE),
                    device.runData.updateTime.ToString("MM-dd HH:mm:ss")
                    ));
                }
            }

            csvWriter.AddStrDataList(dataList);

            string fullFile = Server.MapPath("/") + "tempexportfile\\" + Resources.SunResource.DEVICE_MONITOR_HLX + ".csv";
            csvWriter.Save(fullFile);
            //转化为csv格式的字符串
            ActionResult tmp = File(fullFile, "text/csv; charset=UTF-8", urlcode(Resources.SunResource.DEVICE_MONITOR_HLX) + ".csv");
            return tmp;

        }


        public ActionResult CMB_Output(string id)
        {
            CsvStreamWriter csvWriter = new CsvStreamWriter();
            IList<string> dataList = new List<string>();
            dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},",
                Resources.SunResource.PLANT_DEVICEMONITOR_UNIT,
                Resources.SunResource.PLANT_DEVICEMONITOR_NAME,
                Resources.SunResource.DEVICEMONITORITEM_321,
                Resources.SunResource.DEVICEMONITORITEM_325,
                Resources.SunResource.DEVICEMONITORITEM_326,
                Resources.SunResource.MONITORITEM_TEMPERATURE,
                Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME
                ));
            int pid = 0;
            int.TryParse(id, out  pid);
            Plant plant = FindPlant(pid);
            IList<Device> deviceList = SortPlantDevice(pid);
            bool fault = false;
            float curMonthEnergy = 0L;
            PlantUnit plantUnit;

            #region 异常
            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (fault)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},",
           plantUnit.displayname,
           string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
           device.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM),
           device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT),
           device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT),
          device.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE),
           device.runData.updateTime.ToString("MM-dd HH:mm:ss")
           ));
                }
            }
            #endregion
            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},",
      plantUnit.displayname,
      string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
      device.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM),
      device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT),
      device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT),
     device.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE),
      device.runData.updateTime.ToString("MM-dd HH:mm:ss")
      ));

                }
            }

            foreach (Device device in deviceList)
            {

                if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (!device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},",
plantUnit.displayname,
string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
device.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM),
device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT),
device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT),
device.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE),
device.runData.updateTime.ToString("MM-dd HH:mm:ss")
));
                }
            }


            string fullFile = Server.MapPath("/") + "tempexportfile\\" + Resources.SunResource.DEVICE_MONITOR_HLX + ".csv";
            csvWriter.Save(fullFile);
            //转化为csv格式的字符串
            ActionResult tmp = File(fullFile, "text/csv; charset=UTF-8", urlcode(Resources.SunResource.DEVICE_MONITOR_HLX) + ".csv");
            return tmp;

        }

        public ActionResult Ammeter_Output(string id)
        {
            CsvStreamWriter csvWriter = new CsvStreamWriter();
            IList<string> dataList = new List<string>();
            dataList.Add(string.Format("{0},{1},{2},{3}",
                Resources.SunResource.PLANT_DEVICEMONITOR_UNIT,
                Resources.SunResource.PLANT_DEVICEMONITOR_NAME,
                Resources.SunResource.DEVICEMONITORITEM_924,
                Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME
                ));
            int pid = 0;
            int.TryParse(id, out  pid);
            Plant plant = FindPlant(pid);
            IList<Device> deviceList = SortPlantDevice(pid);
            bool fault = false;
            float curMonthEnergy = 0L;
            PlantUnit plantUnit;

            #region 异常
            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.AMMETER_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (fault)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3}",
                       plantUnit.displayname,
                       string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
                       device.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE),
                       device.runData.updateTime.ToString("MM-dd HH:mm:ss")
                       ));
                }
            }
            #endregion
            foreach (Device device in deviceList)
            {
                if (!device.deviceTypeCode.Equals(DeviceData.AMMETER_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3}",
                  plantUnit.displayname,
                  string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
                 device.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE),
                  device.runData.updateTime.ToString("MM-dd HH:mm:ss")
      ));

                }
            }

            foreach (Device device in deviceList)
            {

                if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE) || device.runData == null || device.isHidden)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                fault = device.runData.isFault();
                if (!device.Over1Day(plant.timezone) && device.runData.isFault() == false)
                {
                    dataList.Add(string.Format("{0},{1},{2},{3}",
                    plantUnit.displayname,
                    string.IsNullOrEmpty(device.name) ? device.fullName : device.name,
                    device.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE),
                    device.runData.updateTime.ToString("MM-dd HH:mm:ss")
                    ));
                }
            }


            string fullFile = Server.MapPath("/") + "tempexportfile\\" + Resources.SunResource.DEVICE_MONITOR_AMMETER + ".csv";
            csvWriter.Save(fullFile);
            //转化为csv格式的字符串
            ActionResult tmp = File(fullFile, "text/csv; charset=UTF-8", urlcode(Resources.SunResource.DEVICE_MONITOR_AMMETER) + ".csv");
            return tmp;

        }


        [HttpPost]
        public ActionResult SavePower(string did, string power)
        {
            DeviceService.GetInstance().SaveCurrentPower(did, power);
            return Content("success");
        }

        [HttpPost]

        public ActionResult HiddenDevice(string id, string status)
        {
            DeviceService.GetInstance().SetDeviceStatus(id, status);
            return Content("success");
        }
        public ActionResult ModifyDeviceMonitor(int id)
        {
            return View(DeviceService.GetInstance().get(id));
        }
        [HttpPost]
        public ActionResult UpdateDeviceMonitor(Device device, string pid)
        {
            if (device.name.Equals(device.comFullName)) device.name = "";//组合名称不保存到name字段，避免自定义被修改
            DeviceService.GetInstance().UpdateDeviceById(device);
            return RedirectToAction("DeviceMonitor", "plant", new { @id = pid });
        }

        public ActionResult PlantReport(string id, string reportId, string type, string cTime)
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
            Plant plant = PlantService.GetInstance().GetPlantInfoById(int.Parse(id));
            return View(plant);
        }

        public ActionResult PlantUser(string id)
        {
            int pid = 0;
            int.TryParse(id, out pid);
            return View(FindPlant(pid));
        }

        [HttpPost]
        [IsLoginAttribute]
        public ActionResult Check(string pid, string pname)
        {
            int id = 0;
            int.TryParse(pid, out id);
            foreach (Plant plant in UserUtil.getCurUser().plants)
            {
                if (plant.name.Equals(pname.Trim()) && (plant.id.Equals(id) == false))
                    return Content("false");

            }
            return Content("true");
        }


        public ActionResult InverterEdit(string id)
        {
            string didStr = Request.QueryString.ToString();
            int pid;
            int did;
            int.TryParse(id, out pid);
            int.TryParse(didStr, out did);
            Plant plant = FindPlant(pid);
            ViewData["device"] = new Device();
            foreach (PlantUnit unit in plant.plantUnits)
            {
                foreach (Device device in unit.devices)
                {
                    if (device.id.Equals(did))
                    {
                        ViewData["device"] = device;
                        break;
                    }
                }
            }
            return View(plant);
        }
        [HttpPost]
        public ActionResult InverterEdit(string pid, string didStr, string name, string currentPower)
        {
            int did = 0;
            int.TryParse(didStr, out did);
            Device device = DeviceService.GetInstance().get(did);
            if (name.Equals(device.comFullName)) device.name = "";//组合名称不保存到name字段，避免自定义被修改
            else
                device.name = name;
            device.currentPower = currentPower; ;
            DeviceService.GetInstance().UpdateDeviceById(device);
            return Redirect("/plant/devicemonitor/" + pid);
        }


        public ActionResult InverterList(string pid)
        {
            int id = 0;
            int.TryParse(pid, out  id);
            Plant plant = FindPlant(id);
            IList<Device> devices = new List<Device>();

            ViewData["data"] = SortPlantDevice(id);
            return View(plant);

        }

        private IList<Device> SortPlantDevice(int pid)
        {

            Plant plant = plantService.GetPlantInfoById(pid);
            IList<Device> devices = new List<Device>();
            foreach (PlantUnit unit in plant.plantUnits)
            {
                foreach (Device device in unit.devices)
                {
                    device.collectorID = unit.collectorID;
                    devices.Add(device);
                }
            }
            IEnumerable<Device> sortDevices = devices.OrderBy(model => model.getMonitorValue(MonitorType.MIC_INVERTER_TOTALYGPOWER));
            return sortDevices.ToList<Device>();
        }

        public ActionResult EmList(string pid)
        {
            int id = 0;
            int.TryParse(pid, out  id);
            Plant plant = FindPlant(id);
            ViewData["data"] = SortPlantDevice(id);
            return View(plant);
        }

        public ActionResult AmmeterList(string pid)
        {
            int id = 0;
            int.TryParse(pid, out  id);
            Plant plant = FindPlant(id);
            ViewData["data"] = SortPlantDevice(id);
            return View(plant);
        }


        public ActionResult EMEdit(string id)
        {
            string didStr = Request.QueryString.ToString();
            int pid;
            int did;
            int.TryParse(id, out pid);
            int.TryParse(didStr, out did);
            Plant plant = FindPlant(pid);
            ViewData["device"] = new Device();
            foreach (PlantUnit unit in plant.plantUnits)
            {
                foreach (Device device in unit.devices)
                {
                    if (device.id.Equals(did))
                    {
                        ViewData["device"] = device;
                        break;
                    }
                }
            }
            return View(plant);
        }


        [HttpPost]
        public ActionResult EMEdit(string pid, string didStr, string name)
        {
            int did = 0;
            int.TryParse(didStr, out did);
            Device device = DeviceService.GetInstance().get(did);
            if (name.Equals(device.comFullName)) device.name = "";//组合名称不保存到name字段，避免自定义被修改
            else
                device.name = name;
            DeviceService.GetInstance().UpdateDeviceById(device);
            
            return Redirect("/plant/devicemonitor/" + pid);
        }

        public ActionResult Ammeteredit(string id)
        {
            string didStr = Request.QueryString.ToString();
            int pid;
            int did;
            int.TryParse(id, out pid);
            int.TryParse(didStr, out did);
            Plant plant = FindPlant(pid);
            ViewData["device"] = new Device();
            foreach (PlantUnit unit in plant.plantUnits)
            {
                foreach (Device device in unit.devices)
                {
                    if (device.id.Equals(did))
                    {
                        ViewData["device"] = device;
                        break;
                    }
                }
            }
            return View(plant);
        }

        public ActionResult HLXEdit(string id)
        {
            string didStr = Request.QueryString.ToString();
            int pid;
            int did;
            int.TryParse(id, out pid);
            int.TryParse(didStr, out did);
            Plant plant = FindPlant(pid);
            ViewData["device"] = new Device();
            foreach (PlantUnit unit in plant.plantUnits)
            {
                foreach (Device device in unit.devices)
                {
                    if (device.id.Equals(did))
                    {
                        ViewData["device"] = device;
                        break;
                    }
                }
            }
            return View(plant);
        }
        /// <summary>
        /// 配电柜编辑
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult CabinetEdit(string id)
        {
            string didStr = Request.QueryString.ToString();
            int pid;
            int did;
            int.TryParse(id, out pid);
            int.TryParse(didStr, out did);
            Plant plant = FindPlant(pid);
            ViewData["device"] = new Device();
            foreach (PlantUnit unit in plant.plantUnits)
            {
                foreach (Device device in unit.devices)
                {
                    if (device.id.Equals(did))
                    {
                        ViewData["device"] = device;
                        break;
                    }
                }
            }
            return View(plant);
        }

        public ActionResult HLXList(string pid)
        {
            int id = 0;
            int.TryParse(pid, out  id);
            Plant plant = FindPlant(id);
            ViewData["data"] = SortPlantDevice(id);
            return View(plant);
        }
        /// <summary>
        /// 配电柜列表
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public ActionResult CabinetList(string pid)
        {
            int id = 0;
            int.TryParse(pid, out  id);
            Plant plant = FindPlant(id);
            ViewData["data"] = SortPlantDevice(id);
            return View(plant);
        }

        public ActionResult dst_init(string city)
        {
            CountryCity cy = CountryCityService.GetInstance().GetCity(city);
            return Json(cy);
        }

        public ActionResult WarningFilter(string pid, string uid)
        {
            #region 自动登录
            if (string.IsNullOrEmpty(uid) == false)
            {
                User loginUser = userService.Get(int.Parse(uid));
                UserUtil.login(loginUser);
            }
            #endregion

            int id = 0;
            int.TryParse(pid, out id);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            ArrayList invarray = new ArrayList();
            ArrayList cabArray = new ArrayList();
            ArrayList envArray = new ArrayList();
            ArrayList hlxArray = new ArrayList();
            ArrayList dbArray = new ArrayList();

            #region 变量

            double beforeYesterdayEnergy = 0;
            double yesterdayEnergy = 0;
            double todayEnergy = 0;
            double thisMonthEnergy = 0;
            double thisYearEnergy = 0;
            #endregion

            Hashtable table = null;
            IList<PlantUnit> units = plant.plantUnits;
            foreach (PlantUnit unit in units)
            {
                IList<Device> devices = unit.devices;
                foreach (Device dce in devices)
                {
                    if (dce.isFault() == false)
                        continue;
                    table = new Hashtable();
                    table.Add("plantname", plant.name);
                    table.Add("Unit", unit.displayname);
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


                            todayEnergy = dce.TodayEnergy(plant.timezone);


                            DeviceYearMonthData deviceYearMonthData = DeviceYearMonthDataService.GetInstance().GetDeviceYearMonthData(dce.id, DateTime.Now.Year);
                            thisMonthEnergy = deviceYearMonthData.getMonthData(DateTime.Now.Month);


                            DeviceYearData deviceYearData = DeviceYearDataService.GetInstance().GetDeviceYearData(dce.id, DateTime.Now.Year);
                            thisYearEnergy = deviceYearData.dataValue;

                            table.Add("beforeYesterdayEnergy", plantService.getDayPr(plant, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-2).Day, beforeYesterdayEnergy));
                            table.Add("yesterdayEnergy", plantService.getDayPr(plant, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-1).Day, beforeYesterdayEnergy));
                            table.Add("todayEnergy", plantService.getDayPr(plant, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, todayEnergy).ToString("0.00"));
                            table.Add("thisMonthEnergy", plantService.getMonthPr(plant, DateTime.Now.Year, DateTime.Now.Month, thisMonthEnergy).ToString("0.00"));
                            table.Add("thisYearEnergy", plantService.getYearPr(plant, DateTime.Now.Year, thisYearEnergy).ToString("0.00"));
                            invarray.Add(table);
                            break;
                        #endregion

                        case DeviceData.CABINET_CODE:
                            cabArray.Add(table);
                            break;
                        case DeviceData.ENVRIOMENTMONITOR_CODE:
                            envArray.Add(table);

                            break;
                        case DeviceData.HUILIUXIANG_CODE:
                            hlxArray.Add(table);
                            break;
                        case DeviceData.AMMETER_CODE:
                            double mvalue = dce.getMonitorValue(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE);
                            table.Add("zxygdd", mvalue);
                            dbArray.Add(table);
                            break;
                        default:
                            break;
                    }
                    //PR性能

                }

            }
            ViewData["inv"] = invarray;
            ViewData["cab"] = cabArray;
            ViewData["env"] = envArray;
            ViewData["hlx"] = hlxArray;
            ViewData["db"] = dbArray;
            return View();
        }

        /// <summary>
        /// 电站的设备数据
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public ActionResult deviceData(int id)
        {
            User user = UserUtil.getCurUser();
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);

            string startYM = (DateTime.Now.Year - 1) + "" + DateTime.Now.Month.ToString("00");
            string endYM = DateTime.Now.Year + "" + DateTime.Now.Month.ToString("00");

            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);

            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData["plantYear"] = plantYearsList;
            return View(plant);
        }

        /// <summary>
        /// 电站设备树
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult deviceStructTree(string id)
        {
            int pid = 0;
            int.TryParse(id, out pid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            string jsstr = base.createDeviceContructTree(plant, -1);
            ViewData["jsstr"] = jsstr;
            return View();
        }
    }
}
