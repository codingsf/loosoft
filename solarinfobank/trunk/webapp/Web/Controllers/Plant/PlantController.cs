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
            else if (!plant.isVirtualPlant && plant.allFactUnits.Count == 0)
                return RedirectToAction("bind", "unit", new { @id = id });

            string startYM = (DateTime.Now.Year - 1) + "" + DateTime.Now.Month.ToString("00");
            string endYM = DateTime.Now.Year + "" + DateTime.Now.Month.ToString("00");
            //int monitorCode = 0;//发电量测点
            //string reportCode = PlantChartService.GetInstance().YearMMChartBypList(base.getCurUser().plants, startYM, endYM, ChartType.line, "kWh", monitorCode);
            //ViewData[ComConst.ReportCode] = reportCode;

            ViewData[ComConst.PlantName] = plant.name;
            plant.currencies = curUser.currencies;
            ViewData["temp"] = plant.Temperature;
            if (double.IsNaN(plant.Temperature))
            {
                CityCodeService codeService = CityCodeService.GetInstance();
                ViewData["temp"] = codeService.GetTemperature(plant.city);
            }
            //修正了温度不存在显示0的问题
            if (!double.IsNaN(((double)ViewData["temp"])) && ViewData["temp"] != null)
            {
                User user = UserUtil.getCurUser();
                if (user != null && !user.TemperatureType.ToLower().Equals("c"))
                {
                    ViewData["temp"] = Math.Round(32 + ((double)ViewData["temp"] * 1.8), 1);
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
            ViewData["currency"] = UserUtil.getCurUser().currencies;
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
            ViewData["plantList"] = curUser.displayPlants;
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
            plant.predictivedata = Request.Form["predictivedata"];
            plant.structPic = Request["sutpic"];

            if (string.IsNullOrEmpty(Request["structPic"]) == false && Request["structPic"].Equals(plant.structPic) == false)
                removeStructPicConfig(plant.id + "");
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
            string start = Request.Form["fstart"];
            string end = Request.Form["fend"];
            string price = Request.Form["fprice"];
            ElecPriceService.GetInstance().Insert(new ElecPrice { fromHm = start, toHm = end, ptype = ElecPrice.Feng, plantId = plant.id, price = price });

            start = Request.Form["pstart"];
            end = Request.Form["pend"];
            price = Request.Form["pprice"];
            ElecPriceService.GetInstance().Insert(new ElecPrice { fromHm = start, toHm = end, ptype = ElecPrice.Ping, plantId = plant.id, price = price });

            start = Request.Form["gstart"];
            end = Request.Form["gend"];
            price = Request.Form["gprice"];
            ElecPriceService.GetInstance().Insert(new ElecPrice { fromHm = start, toHm = end, ptype = ElecPrice.Gu, plantId = plant.id, price = price });

            start = Request.Form["jstart"];
            end = Request.Form["jend"];
            price = Request.Form["jprice"];
            ElecPriceService.GetInstance().Insert(new ElecPrice { fromHm = start, toHm = end, ptype = ElecPrice.Jian, plantId = plant.id, price = price });


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
            if (plant.energyRate == null || plant.energyRate.Value == 0) plant.energyRate = 1;
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

                IList<Plant> plantInfo = UserUtil.getCurUser().displayPlants;
                ViewData["plantList"] = plantInfo;
                return View(runDataService.Get(id));
            }
            else
            {
                return RedirectToAction("index", "home");
            }
        }

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
                foreach (Plant p in UserUtil.getCurUser().displayPlants)
                {
                    foreach (PlantUnit unit in p.allFactUnits)
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
                        plants = UserUtil.getCurUser().displayPlants;
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
                    if (string.IsNullOrEmpty(collectorString)) collectorString = "-1";
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
         fault ? "0" : device.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_TOTALYGPOWER),
         device.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS),
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
         fault ? "0" : device.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_TOTALYGPOWER),
         device.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS),
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
         fault ? "0" : device.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_TOTALYGPOWER),
         device.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS),
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
            if (device.name == device.comFullName) device.name = "";//组合名称不保存到name字段，避免自定义被修改

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
            foreach (Plant plant in UserUtil.getCurUser().displayPlants)
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
            foreach (PlantUnit unit in plant.allFactUnits)
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
            if (name == device.comFullName) device.name = "";//组合名称不保存到name字段，避免自定义被修改
            device.currentPower = currentPower;
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
            foreach (PlantUnit unit in plant.allFactUnits)
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
            foreach (PlantUnit unit in plant.allFactUnits)
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
            if (name == device.comFullName) device.name = "";//组合名称不保存到name字段，避免自定义被修改
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
            foreach (PlantUnit unit in plant.allFactUnits)
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
            foreach (PlantUnit unit in plant.allFactUnits)
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
            foreach (PlantUnit unit in plant.allFactUnits)
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
        /// <summary>
        /// 设备告警列表
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="uid"></param>
        /// <returns></returns>
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
            IList<PlantUnit> units = plant.allFactUnits;
            foreach (PlantUnit unit in units)
            {
                IList<Device> devices = unit.devices;
                foreach (Device dce in devices)
                {
                    if (dce.isFault() == false)
                        continue;
                    table = new Hashtable();
                    table.Add("plantname", plantService.GetPlantInfoById(unit.plantID).name);
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

                            table.Add("beforeYesterdayEnergy", plantService.getDayPr(plant, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-2).Day, beforeYesterdayEnergy).ToString("0%"));
                            table.Add("yesterdayEnergy", plantService.getDayPr(plant, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-1).Day, beforeYesterdayEnergy).ToString("0%"));
                            table.Add("todayEnergy", plantService.getDayPr(plant, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, todayEnergy).ToString("0%"));
                            table.Add("thisMonthEnergy", plantService.getMonthPr(plant, DateTime.Now.Year, DateTime.Now.Month, thisMonthEnergy).ToString("0%"));
                            table.Add("thisYearEnergy", plantService.getYearPr(plant, DateTime.Now.Year, thisYearEnergy).ToString("0%"));
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
                            table.Add("zxygdd", dce.getMonitorValue(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE));
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
        /// 筛选出用户电站非隐藏，工作正常的逆变器的发电量比率大于或者小于设定比率系数的逆变器
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="pid"></param>
        /// <param name="yyyyMMdd"></param>
        /// <param name="?"></param>
        /// <returns></returns>
        public ActionResult EnergyFilter(int? id, int? uid, string yyyyMMdd)
        {
            User user = uid==null?null:UserService.GetInstance().Get(uid.Value);
            IList<Plant> handlePlants = null;
            int timezone = 0;
            Plant curPlant = null;
            if (id!=null && id.Value != 0)
            {
                curPlant = PlantService.GetInstance().GetPlantInfoById(id.Value);
                timezone = curPlant.timezone;
                handlePlants = new List<Plant>();
                handlePlants.Add(curPlant);
            }
            else
            {
                IList<Plant> plants = user.allOwnFactPlants;
                ViewData["plants"] = plants;
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
                        data["prate"] = rate+"/"+plant.energyRate;
                        datas.Add(data);
                    }
                }
            }
            ViewData["datas"] = datas;
            return View(curPlant);
        }

        /// <summary>
        /// 分配单个电站给用户
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Share(int id)
        {
            Plant plant = plantService.GetPlantInfoById(id);
            User user = UserUtil.getCurUser();
            ViewData["roles"] = user.Roles;
            IList<User> users = plantUserService.GetusersByplantid(id);
            ViewData["users"] = users;
            Hashtable roleTable = new Hashtable();
            foreach (User u in users)
            {
                int roleId = plantUserService.GetPlantUserByPlantIDUserID(new PlantUser { plantID = id, userID = u.id }).RoleId;
                if (roleId == 0)
                    roleTable.Add(u.username, string.Empty);
                else
                    roleTable.Add(u.username, RoleService.GetInstance().Get(roleId).name);
            }
            ViewData["roleNames"] = roleTable;
            return View(plant);
        }
        /// <summary>
        /// 删除电站和用户分配关系
        /// </summary>
        /// <param name="id"></param>
        /// <param name="uid"></param>
        /// <returns></returns>
        public ActionResult Seal(int id, int uid)
        {
            plantUserService.ClosePlant(id, uid);
            return Redirect("/plant/share/" + id);
        }

        /// <summary>
        /// 编辑组合电站
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Virtualedit(int id)
        {
            IList<SelectListItem> itemList = new List<SelectListItem>();
            User curUser = UserUtil.getCurUser();
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);


            //取得可被修改的供分配的电站，所有顶层的电站，但是要排除被修改的组合电站所在的最顶层上级电站

            //先包括自己的下级电站，并选中
            foreach (Plant p in plant.childs)
            {
                itemList.Add(new SelectListItem() { Selected = true, Text = p.name, Value = p.id.ToString() });
            }
            //再取得该用户创建的所有顶层电站，只有顶层电站才会被用于组合，因为电站只能被组合过一次
            IList<Plant> plants = curUser.createToplevelPlants;
            //从所有顶层电站中剔除当前要修改的电站的最高一级的电站
            foreach (Plant tmpplant in plants)
            {
                if (tmpplant.id != id)
                {
                    itemList.Add(new SelectListItem() { Selected = false, Text = tmpplant.name, Value = tmpplant.id.ToString() });
                }
            }

            ViewData["comPlants"] = itemList;

            return View(plant);
        }


        public ActionResult DeviceRelation(string id)
        {
            string groupName = string.Empty;
            int pid = 0;
            int.TryParse(id, out pid);
            IList<DeviceRelation> groupRelations = DeviceRelationService.GetInstance().getNamesPlantId(pid);
            ViewData["group"] = groupRelations;
            if (string.IsNullOrEmpty(Request["name"]))
                groupName = groupRelations.Count > 0 ? groupRelations[0].name : string.Empty;
            else
                groupName = Request["name"];
            IList<Device> devices = plantService.GetPlantInfoById(pid).displayDevices();
            IList<SelectListItem> items = new List<SelectListItem>();
            IList<SelectListItem> parentItems = new List<SelectListItem>();
            IList<DeviceRelation> relations = DeviceRelationService.GetInstance().GetList(pid);
            foreach (Device device in devices)
            {
                if (relations.Where(m => m.deviceId.Equals(device.id)).Count() == 0)
                    items.Add(new SelectListItem { Selected = false, Text = device.fullName, Value = device.id + "" });
                parentItems.Add(new SelectListItem { Selected = false, Text = device.fullName, Value = device.id + "" });
            }
            ViewData["dces"] = items;
            ViewData["parentdces"] = parentItems;
            ViewData["pid"] = id;

            User curUser = UserUtil.getCurUser();
            string width = "100"; string height = "30";
            RelationConfig config = curUser.configs.Where(m => m.relationType.Equals(RelationConfig.DeviceType) && m.relationId.Equals(pid) && m.config5.Equals(groupName)).FirstOrDefault<RelationConfig>();
            if (config == null) config = new RelationConfig { width = "100", height = "100", config3 = "20", config4 = "15" };
            if (config != null)
            {
                width = config.width;
                height = config.height;
            }
            ViewData["config"] = config;
            TempData["iSubtreeSeparation"] = config.config3;
            TempData["iSiblingSeparation"] = config.config4;
            return View();
        }

        public ActionResult getDeviceMonitor(int id)
        {
            Device device = DeviceService.GetInstance().get(id);
            StringBuilder sb = new StringBuilder("<select id='monitorCode' name='monitorCode' multiple='multiple' style='width:90px;'>");
            IList<MonitorType> mtypes = MonitorType.getMonitorTypesByTypeCode(device.deviceTypeCode);
            foreach (MonitorType mtype in mtypes)
                sb.AppendFormat("<option value='{1}'>{0}</option>", mtype.name, mtype.code);
            sb.Append("</select>");
            return Content(sb.ToString());
        }

        private string childDeviceIds(IList<DeviceRelation> relations)
        {
            return childDeviceIds(relations, string.Empty);
        }

        private string childDeviceIds(IList<DeviceRelation> relations, string name)
        {
            string ids = "";
            //有下级那么就递归调用下级生成脚本。进行累计
            if (relations != null && relations.Count > 0)
            {
                DeviceRelation tmprelation = null;
                for (int i = 0; i < relations.Count; i++)
                {

                    tmprelation = relations[i];
                    if (string.IsNullOrEmpty(name) == false && tmprelation.name.Equals(name) == false)
                        continue;
                    ids += tmprelation.deviceId + ",";
                    if (tmprelation.childRelation != null && tmprelation.childRelation.Count > 0)
                        ids += childDeviceIds(tmprelation.childRelation, name);
                }
            }
            return ids;
        }

        [HttpPost]
        public ActionResult SaveDeviceRelation(DeviceRelation relation, string plantId)
        {
            relation.monitorCode = Request["monitorCode"] == null ? "," : Request["monitorCode"];
            TempData["hdndid"] = relation.parentDeviceId;
            TempData["name"] = relation.name;
            if (relation.deviceId.Equals(relation.parentDeviceId))
                TempData["error"] = "相关联的设备是同一设备";
            else
            {
                //查询当前设备的下级设备

                var drs = DeviceRelationService.GetInstance().getListbyparentDeviceId(relation.deviceId);
                string ids = childDeviceIds(drs);
                if (ids.Contains(relation.parentDeviceId + ","))
                {
                    TempData["error"] = "同一设备不能循环关联";
                }
                else
                {
                    DeviceRelationService.GetInstance().Save(relation);
                    IList<DeviceRelation> tmpRelations = DeviceRelationService.GetInstance().getListbyparentDeviceId(relation.parentDeviceId);
                    tmpRelations = tmpRelations.Where(m => m.name.Equals(relation.name)).ToList<DeviceRelation>();
                    if (tmpRelations.Count == 0 || DeviceRelationService.GetInstance().getNamesPlantId(relation.plantId).Count == 0)
                    {
                        relation.deviceId = relation.parentDeviceId;
                        relation.parentDeviceId = 0;
                        DeviceRelationService.GetInstance().Save(relation);
                    }
                }
            }

            return Redirect("/plant/devicerelation/" + plantId + "?name=" + relation.name);


        }

        private string getjsStr(IList<DeviceRelation> relations, int uplevel, string width, string height)
        {
            string jsstr = "";
            //有下级那么就递归调用下级生成脚本。进行累计
            if (relations != null && relations.Count > 0)
            {
                DeviceRelation tmpplant = null;
                int curLevel = 0;
                for (int i = 0; i < relations.Count; i++)
                {

                    tmpplant = relations[i];
                    string dataname = MonitorType.getMonitorTypeByCode(int.Parse(tmpplant.monitorCode)).name;
                    string datavalue = (((tmpplant.device == null)) ? "0"
                        : tmpplant.device.getMonitor(int.Parse(tmpplant.monitorCode)));
                    curLevel = ((uplevel + 1) * 100 + i);
                    jsstr += "myTree.add(" + curLevel + "," + uplevel + ",'" + tmpplant.device.fullName + "<a href=\"#\" onclick=\"deleterelations(" + tmpplant.deviceId + ")\" class=\"closeimg\"><img src=\"/img/plus0.gif\"/></a><img style=\"margin-left:10px;\" src=\"/images/tec/ico" + tmpplant.device.deviceTypeCode + ".jpg\"/><div>" + dataname + ":" + datavalue + "</div>'," + width + "," + height + ",'white','white');";
                    if (tmpplant.childRelation != null && tmpplant.childRelation.Count > 0)
                        jsstr += getjsStr(tmpplant.childRelation, curLevel, width, height);
                }
            }
            return jsstr;
        }

        private string getNamejsStr(IList<DeviceRelation> relations, int uplevel, string width, string height, string name)
        {
            string jsstr = "";
            //有下级那么就递归调用下级生成脚本。进行累计
            if (relations != null && relations.Count > 0)
            {
                DeviceRelation tmpplant = null;
                int curLevel = 0;
                for (int i = 0; i < relations.Count; i++)
                {

                    tmpplant = relations[i];
                    if (tmpplant.name.Equals(name) == false) continue;
                    string content = string.Empty;
                    foreach (string str in tmpplant.monitorCode.Split(','))
                    {
                        if (string.IsNullOrEmpty(str) == false)
                        {
                            string dataname = MonitorType.getMonitorTypeByCode(int.Parse(str)).name;
                            string datavalue = (((tmpplant.device == null)) ? "0"
                                : tmpplant.device.getMonitor(int.Parse(str)));
                            content += string.Format("<div>{0} : {1}</div>", dataname, datavalue);
                        }
                    }

                    curLevel = ((uplevel + 1) * 100 + i);
                    jsstr += "myTree.add(" + curLevel + "," + uplevel + ",'" + tmpplant.device.fullName + "<a href=\"#\" ref=\"" + tmpplant.name + "\" onclick=\"deleterelations(" + tmpplant.deviceId + ",this)\" class=\"closeimg\"><img src=\"/img/plus0.gif\"/></a><img style=\"margin-left:10px;\" src=\"/images/tec/ico" + tmpplant.device.deviceTypeCode + ".jpg\"/>" + content + "'," + width + "," + height + ",'white','white');";
                    if (tmpplant.childRelation != null && tmpplant.childRelation.Count > 0)
                        jsstr += getNamejsStr(tmpplant.childRelation, curLevel, width, height, name);
                }
            }
            return jsstr;
        }

        private string getPortaljsStr(IList<DeviceRelation> relations, int uplevel, string width, string height)
        {
            string jsstr = "";
            //有下级那么就递归调用下级生成脚本。进行累计
            if (relations != null && relations.Count > 0)
            {
                DeviceRelation tmpplant = null;
                int curLevel = 0;
                for (int i = 0; i < relations.Count; i++)
                {

                    tmpplant = relations[i];
                    string dataname = MonitorType.getMonitorTypeByCode(int.Parse(tmpplant.monitorCode)).name;
                    string datavalue = (((tmpplant.device == null)) ? "0"
                        : tmpplant.device.getMonitor(int.Parse(tmpplant.monitorCode)));
                    curLevel = ((uplevel + 1) * 100 + i);
                    jsstr += "myTree.add(" + curLevel + "," + uplevel + ",'" + tmpplant.device.fullName + "<img style=\"margin-left:10px;\" src=\"/images/tec/ico" + tmpplant.device.deviceTypeCode + ".jpg\"/><div>" + dataname + ":" + datavalue + "</div>'," + width + "," + height + ",'white','white');";
                    if (tmpplant.childRelation != null && tmpplant.childRelation.Count > 0)
                        jsstr += getPortaljsStr(tmpplant.childRelation, curLevel, width, height);
                }
            }
            return jsstr;
        }

        private string getPortalNamejsStr(IList<DeviceRelation> relations, int uplevel, string width, string height, string name)
        {
            string jsstr = "";
            //有下级那么就递归调用下级生成脚本。进行累计
            if (relations != null && relations.Count > 0)
            {
                DeviceRelation tmpplant = null;
                int curLevel = 0;
                for (int i = 0; i < relations.Count; i++)
                {

                    tmpplant = relations[i];
                    if (tmpplant.name.Equals(name) == false) continue;
                    string content = string.Empty;
                    foreach (string str in tmpplant.monitorCode.Split(','))
                    {
                        if (string.IsNullOrEmpty(str) == false)
                        {
                            string dataname = MonitorType.getMonitorTypeByCode(int.Parse(str)).name;
                            string datavalue = (((tmpplant.device == null)) ? "0"
                                : tmpplant.device.getMonitor(int.Parse(str)));
                            content += string.Format("<div>{0} : {1}</div>", dataname, datavalue);
                        }
                    }

                    curLevel = ((uplevel + 1) * 100 + i);
                    jsstr += "myTree.add(" + curLevel + "," + uplevel + ",'" + tmpplant.device.fullName + "<img style=\"margin-left:10px;\" src=\"/images/tec/ico" + tmpplant.device.deviceTypeCode + ".jpg\"/>" + content + "'," + width + "," + height + ",'white','white');";
                    if (tmpplant.childRelation != null && tmpplant.childRelation.Count > 0)
                        jsstr += getPortalNamejsStr(tmpplant.childRelation, curLevel, width, height, name);
                }
            }
            return jsstr;
        }

        /// <summary>
        /// 电站设备接线图
        /// </summary>
        /// <returns></returns>
        public ActionResult RelationChart(string id, string portal, string name)
        {

            int pid = 0;
            int.TryParse(id, out pid);
            User curUser = UserUtil.getCurUser();
            RelationConfig config = curUser.configs.Where(m => m.relationType.Equals(RelationConfig.DeviceType) && m.relationId.Equals(pid) && m.config5.Equals(name)).FirstOrDefault<RelationConfig>();
            if (portal != null && portal.ToLower().Equals("true"))
                config = RelationConfigService.GetInstance().GetConfig(curUser.ParentUserId, pid, RelationConfig.DeviceType, name);
            if (config == null) config = new RelationConfig { width = "100", height = "100", config3 = "20", config4 = "15" };
            string jsstr = string.Empty;
            IList<DeviceRelation> relations = DeviceRelationService.GetInstance().getFirstDeviceRelation(pid, name);
            if (string.IsNullOrEmpty(portal) == false && portal.Equals("true"))
                jsstr += getPortalNamejsStr(relations, -1, config.width, config.height, name);
            else
                jsstr += getNamejsStr(relations, -1, config.width, config.height, name);
            ViewData["jsstr"] = jsstr;

            return View();
        }

        /// <summary>
        /// 门户用户电站结构图
        /// </summary>
        /// <returns></returns>
        public ActionResult portalStructChart()
        {
            User curUser = UserUtil.getCurUser();
            RelationConfig config = curUser.configs.Where(m => m.relationType.Equals(RelationConfig.AllPlant) && m.uid.Equals(curUser.id)).FirstOrDefault<RelationConfig>();
            if (config == null) config = new RelationConfig() { width = "100", height = "30", config3 = "20", config4 = "15" };
            Protal protal = ProtalService.GetInstance().GetByUser(curUser.ParentUserId);
            string jsstr = base.createPortalContructTree(curUser.assignedPlants, -1, protal.name, config.width, config.height);
            ViewData["jsstr"] = jsstr;
            TempData["iSubtreeSeparation"] = config.config3;
            TempData["iSiblingSeparation"] = config.config4;

            return View();
        }

        /// <summary>
        /// 电站设备结构图
        /// </summary>
        /// <returns></returns>
        public ActionResult deviceStructChart(int id)
        {
            Plant plant = plantService.GetPlantInfoById(id);
            string jsstr = base.createDeviceContructTree(plant, -1);
            ViewData["jsstr"] = jsstr;
            return View();
        }

        /// <summary>
        /// bank用户电站结构图
        /// </summary>
        /// <returns></returns>
        public ActionResult structChart()
        {
            User curUser = UserUtil.getCurUser();
            string jsstr = base.createPlantContructTree(curUser.relatedPlants, -1, "100", "30");
            ViewData["jsstr"] = jsstr;
            return View();
        }


        /// <summary>
        /// 获取子设别列表
        /// </summary>
        /// <param name="id"></param>
        /// <param name="pid"></param>
        /// <returns></returns>
        public ActionResult GetchildDevice(string id, string pid)
        {
            StringBuilder sb = new StringBuilder("<select id='parentDeviceId' name='parentDeviceId'>");
            int did = 0; int.TryParse(id, out did);
            var drs = DeviceRelationService.GetInstance().getListbyparentDeviceId(did);
            string ids = childDeviceIds(drs);//当前设备所有子设备id
            IList<Device> devices = plantService.GetPlantInfoById(int.Parse(pid)).displayDevices();
            foreach (Device device in devices)
            {
                if (ids.Contains(device.id + ",") == false)
                    sb.AppendFormat("<option value='{0}'>{1}</option>", device.id, device.fullName);
            }
            sb.Append("</select>");
            return Content(sb.ToString());
        }



        public ActionResult RemoveRelations(string did, string name)
        {
            IList<DeviceRelation> relations = DeviceRelationService.GetInstance().getListbyparentDeviceId(int.Parse(did));
            relations = relations.Where(m => m.name.Equals(name)).ToList<DeviceRelation>();
            if (relations == null || relations.Count == 0)
                return Content("");
            string ids = relations[0].deviceId + ",";
            if (relations[0].parentDeviceId.Equals(0))
            {
                ids = childDeviceIds(relations, name);
            }
            DeviceRelationService.GetInstance().RemoveRelations(ids, name);
            return Content("ok");
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
        /// 电站的设备历史数据
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public ActionResult deviceHistoryData(int id)
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


        public ActionResult StructPic(string id)
        {
            string path = Server.MapPath("~") + "/config/";
            int pid = 0;
            int.TryParse(id, out pid);
            path = string.Format("{1}structPointConfig{0}.xml", pid, path);

            Plant plant = plantService.GetPlantInfoById(pid);

            List<StructPoint> points = new List<StructPoint>();
            XmlHelper.DeserializerXML(path, ref points);

            List<StructPoint> tmppoints = new List<StructPoint>();
            if (plant.isVirtualPlant)
            {
                foreach (Plant pnt in plant.childs)
                {
                    StructPoint point = points.Where(m => m.id.Equals(pnt.id.ToString())).FirstOrDefault<StructPoint>();
                    if (point != null)
                        tmppoints.Add(point);
                }
                points = tmppoints;
                XmlHelper.SerializerXML(path, points);
            }

            else
            {
                foreach (PlantUnit unit in plant.plantUnits)
                {
                    StructPoint point = points.Where(m => m.id.Equals(unit.id.ToString())).FirstOrDefault<StructPoint>();
                    if (point != null)
                        tmppoints.Add(point);
                }
                points = tmppoints;
                XmlHelper.SerializerXML(path, points);
            }

            foreach (StructPoint point in points)
            {
                if (plant.isVirtualPlant)
                {
                    Plant tplant = PlantService.GetInstance().GetPlantInfoById(int.Parse(point.id));
                    point.displayName = tplant.name;
                }
                else
                {
                    foreach (PlantUnit unit in plant.plantUnits)
                        if (unit.id.Equals(int.Parse(point.id)))
                        {
                            point.displayName = unit.displayname;
                            break;
                        }
                }
            }
            ViewData["points"] = points;
            return View(plant);
        }

        public ActionResult SaveStructPic(string x, string y, string id, string cat, string pid)
        {
            string path = Server.MapPath("~") + "/config/";
            List<StructPoint> points = new List<StructPoint>();
            XmlHelper.DeserializerXML(string.Format("{1}structPointConfig{0}.xml", pid, path), ref points);
            StructPoint searchPoint = points.Where(m => m.id.Equals(id) && m.type.Equals(cat)).FirstOrDefault<StructPoint>();
            if (searchPoint != null)
            {
                searchPoint.x = x;
                searchPoint.y = y;
            }
            else
                points.Add(new StructPoint { x = x, y = y, id = id, type = cat });
            XmlHelper.SerializerXML(string.Format("{1}structPointConfig{0}.xml", pid, path), points);
            return Content("ok");
        }


        public ActionResult deviceStructTree(string id)
        {
            int pid = 0;
            int.TryParse(id, out pid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            string jsstr = base.createDeviceContructTree(plant, -1);
            ViewData["jsstr"] = jsstr;
            return View();
        }
        /// <summary>
        /// 补偿设置
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Compensation(string id)
        {
            User user = UserUtil.getCurUser();
            int plantid = 0;
            int.TryParse(id, out plantid);
            return View(plantService.GetPlantInfoById(plantid));
        }

        public ActionResult SearchCompensation()
        {
            Pager pager = new Pager();
            ViewData["page"] = pager;
            pager.PageSize = ComConst.PageSize;
            string page = Request["page"];
            int ipage = 0;
            int.TryParse(page, out ipage);
            ipage = ipage <= 0 ? 1 : ipage;
            pager.PageIndex = ipage;
            User user = UserUtil.getCurUser();

            #region

            Hashtable table = new Hashtable();

            string plantname = Request.Form["plantname"];
            ViewData["plantname"] = plantname;
            if (string.IsNullOrEmpty(plantname) == false)
            {
                string plantids = string.Empty;
                IList<Plant> plants = plantService.Getplantlikepname(plantname);
                foreach (Plant plant in plants)
                {
                    if (plant.userID.Equals(user.id))
                        plantids += string.Format("{0},", plant.id);
                }
                if (plantids.LastIndexOf(',') > 0) plantids = plantids.Substring(0, plantids.Length - 1);
                plantids = string.IsNullOrEmpty(plantids) ? "-1" : plantids;
                table["plantids"] = plantids;

            }

            string datetype = Request.Form["datetype"];
            if (string.IsNullOrEmpty(datetype) == false)
            {
                if (!datetype.Equals("0"))
                {
                    table["datefilter"] = "true";

                    if (datetype.Equals("1"))//最近七天
                    {
                        table["datefilter"] = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd"); ;
                        table["datefilter"] = DateTime.Now.ToString("yyyy-MM-dd");
                    }
                    else//指定日期
                    {
                        table["startDate"] = Request.Form["startDate"];
                        table["endDate"] = Request.Form["endDate"];
                    }
                }
            }

            string devicename = Request.Form["devicename"];
            if (string.IsNullOrEmpty(devicename) == false)
            {
                string deviceids = string.Empty;
                IList<Device> devices = DeviceService.GetInstance().getDeviceListLikeName(devicename);
                foreach (Device device in devices)
                {
                    deviceids += string.Format("{0},", device.id);
                }
                if (deviceids.LastIndexOf(',') > 0) deviceids = deviceids.Substring(0, deviceids.Length - 1);
                deviceids = string.IsNullOrEmpty(deviceids) ? "-1" : deviceids;
                table["deviceids"] = deviceids;
            }

            #endregion
            IList<Compensation> compensations = CompensationService.GetInstance().searchCompensation(table);
            pager.RecordCount = compensations.Count;
            compensations = compensations.Skip((ipage - 1) * pager.PageSize).Take(pager.PageSize).ToList<Compensation>();
            ViewData["compensations"] = compensations;
            return View();

        }
        public ActionResult DelCompensation(int id)
        {
            CompensationService.GetInstance().Remove(id);
            return Content("ok");
        }



        public ActionResult SaveCompensation(int id, int plantid, int type, string value, string date, bool isplant)
        {
            double dtemp = 0;
            double.TryParse(value, out dtemp);
            if (date.Length.Equals(4))
                date = string.Format("{0}-01-01", date);
            else
                if (date.Length.Equals(7))
                    date = string.Format("{0}-01", date);

            DateTime? dttemp = null;
            DateTime dt = DateTime.MaxValue;
            if (string.IsNullOrEmpty(date) == false)
            {
                DateTime.TryParse(date, out dt);
                dttemp = dt;
            }
            int year = 0;
            int month = 0;
            int day = 0;


            switch (type)
            {
                case 0:
                    break;
                case 1:
                    year = dt.Year;
                    break;
                case 2:
                    year = dt.Year;
                    month = dt.Month;
                    break;
                case 3:
                    year = dt.Year;
                    month = dt.Month;
                    day = dt.Day;
                    break;

                default:
                    break;
            }
            CompensationService.GetInstance().Save(new Compensation
            {
                id = id,
                plantid = plantid,
                isplant = isplant,
                year = year,
                month = month,
                day = day,
                type = type,
                dataValue = dtemp,
                compensationDate = dttemp
            });
            return Content("ok");
        }


        public ActionResult EnergyRate(int id)
        {
            Plant plant = plantService.GetPlantInfoById(id);
            if (plant.energyRate.Equals(0.0))
                plant.energyRate = 1;
            return View(plant);
        }

        [HttpPost]
        public ActionResult SaveEnergyRate(Plant plant)
        {
            double? rate = plant.energyRate;
            double? maxRate = plant.maxEnergyRate;
            plant = plantService.GetPlantInfoById(plant.id);
            plant.energyRate = rate;
            plant.maxEnergyRate = maxRate;
            plantService.UpdatePlantInfo(plant);
            return View("energyrate", plant);
        }
    }
}
