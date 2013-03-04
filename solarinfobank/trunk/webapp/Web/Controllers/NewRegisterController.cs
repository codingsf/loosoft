using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System;
using System.Globalization;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class NewRegisterController : BaseController
    {
        public ActionResult Register()
        {
            IList<CommonInfo> currencies = CommonInfoService.GetInstance().GetList(new CommonInfo() { pid = CommonInfo.Currency });
            IList<SelectListItem> items = new List<SelectListItem>();
            foreach (CommonInfo currency in currencies)
                items.Add(new SelectListItem() { Text = string.Format("{0}:{1}", currency.code, currency.name), Value = currency.code });

            ViewData["currencies"] = items;

            //为登录用户
            if (UserUtil.getCurUser() == null)
            {
                //创建语言服务
                LanguageService languageservice = LanguageService.GetInstance();
                //获取所有语言信息
                IList<Language> languages = languageservice.GetList();
                string langName = "en-us";
                if (Request.UserLanguages != null && Request.UserLanguages.Length != 0)
                {
                    langName = Request.UserLanguages[0];
                }
                languages = languages.OrderByDescending(lang => lang.codename.ToLower().Equals(langName)).ToList<Language>();
                ViewData["languages"] = languages;
                base.GetLanguage();
                return View();

            }
            else
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
                return View(userservice.Get(UserUtil.getCurUser().id));

            }
        }

        [HttpPost]
        public ActionResult Save(User user)
        {
            if (user.id > 0)
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
                return RedirectToAction("addplant", "newregister");

            }
            else
            {
                int localZont = 0;
                int.TryParse(Request.Form["localZone"], out localZont);
                //创建语言服务
                LanguageService languageservice = LanguageService.GetInstance();
                //获取所有语言信息
                IList<Language> languages = languageservice.GetList();
                ViewData["languages"] = languages;
                User regUser = UserService.GetInstance().GetUserByName(user.username);
                if (regUser == null)
                {
                    int uid = 0;
                    user.password = EncryptUtil.EncryptDES(user.password, EncryptUtil.defaultKey);
                    uid = UserService.GetInstance().save(user);
                    //注册用户默认管理员权限
                    UserRoleService.GetInstance().Insert(new UserRole() { userId = uid, roleId = Role.ROLE_SYSMANAGER });

                    TempData[ComConst.User] = user;
                    UserUtil.ResetLogin(user);
                    //记录登录记录
                    string ip = WebUtil.getClientIp(Request);
                    LoginRecordService.GetInstance().Save(user.id, user.username, ip, localZont);

                    return RedirectToAction("addplant", "newregister");

                }
                else
                {

                    ModelState.AddModelError("UserName", Resources.SunResource.REG_USERNAME_ERROR_INFO);
                    return View("register");
                }
            }
        }

        /// <summary>
        /// 注册时添加一个电站页面
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult AddPlant()
        {
            User curUser = UserUtil.getCurUser();
            IList<Plant> plants = null;
            if (curUser != null)
                plants = curUser.allOwnFactPlants;
            else
                plants = new List<Plant>();
            return View(plants);
        }
        /// <summary>
        /// 添加电站的多个控制页面
        /// </summary>
        /// <param name="plantid"></param>
        /// <returns></returns>
        public ActionResult AddPlantControl(string plantid)
        {
            if (string.IsNullOrEmpty(plantid) == false)
            {
                int pid = 0;
                int.TryParse(plantid, out pid);
                Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);//根据电站id获取电站
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
            return View();
        }
        /// <summary>
        /// 单个设备添加页面
        /// </summary>
        /// <returns></returns>
        public ActionResult AddUnit()
        {
            User user = UserUtil.getCurUser();
            user = UserService.GetInstance().GetUserByName(user.username);
            return View(user.ownPlants);
        }
        /// <summary>
        /// 删除单个电站设备
        /// </summary>
        /// <param name="plantId"></param>
        /// <param name="unitId"></param>
        /// <returns></returns>
        public ActionResult RemoveUnit(string plantId, string unitId)
        {
            try
            {
                //根据电站id和电站单元Id查询该电站是否有该单元
                PlantUnit plantUnit = PlantUnitService.GetInstance().GetPlantUnitByPlantIdPlantUnitId(int.Parse(plantId), Convert.ToInt32(unitId));
                if (plantUnit == null)
                    return Content(false.ToString());
                else
                {
                    PlantUnitService.GetInstance().DeletePlantUnit(int.Parse(plantId), int.Parse(unitId));//根据电站Id和电站单元Id删除电站单元
                    Collector collector = CollectorInfoService.GetInstance().GetClollectorByCodePass(plantUnit.collector.code, plantUnit.collector.password);
                    PlantUnit plantunit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(collector.id);//查找在单元表里是否绑定了该采集器
                    if (plantunit != null)
                        collector.isUsed = true;//如果采集器已经和单元绑定了就为已用状态
                    else
                        collector.isUsed = false;
                    CollectorInfoService.GetInstance().Save(collector);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return Content(true.ToString());
        }
        /// <summary>
        /// 添加多个设备控制页面
        /// </summary>
        /// <param name="plantid"></param>
        /// <returns></returns>
        public ActionResult PlantUnitControl(string plantid)
        {
            int id = 0;
            int.TryParse(plantid, out id);
            Plant plant = FindPlant(id);
            ViewData["plantid"] = id;
            IList<PlantUnit> plantUnits = PlantUnitService.GetInstance().GetAllPlantUnitsByPlantId(id);
            User user = UserService.GetInstance().Get(int.Parse(plant.userID.ToString()));
            if (plantUnits.Count == 0 && user.username != UserUtil.demousername)
                return View(plant);
            ViewData["plantUnits"] = plantUnits;
            return View(plant);
        }
        /// <summary>
        /// 保存设备
        /// </summary>
        /// <param name="unitid"></param>
        /// <param name="plantid"></param>
        /// <param name="code"></param>
        /// <param name="password"></param>
        /// <param name="displayname"></param>
        /// <returns></returns>
        public ActionResult UnitSave(string unitid, int plantid, string code, string password, string displayname)
        {
            int uid = 0;
            int.TryParse(unitid, out uid);
            if (uid > 0)
            {
                PlantUnitService.GetInstance().EditPlantUnit(new PlantUnit { id = uid, displayname = displayname });//修改电站单元
                return Content(true.ToString());
            }
            PlantUnit unit = new PlantUnit();
            unit.plantID = plantid;
            unit.collector = new Collector() { code = code, password = password };
            unit.displayname = displayname;
            Collector collector = CollectorInfoService.GetInstance().GetClollectorByCodePass(code, password);
            if (collector != null && (collector.userId == 0 || collector.userId == UserUtil.getCurUser().id))
            {
                PlantUnit plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(collector.id);//根据collectorID去查询，该采集器是否已经绑定了电站
                if (plantUnit == null)
                {
                    unit.collector.id = collector.id;
                    unit.collectorID = collector.id;
                    unit.collector = collector;
                    PlantUnitService.GetInstance().AddPlantUnit(unit);//添加电站单元
                    collector.isUsed = true;//如果采集器已经和单元绑定了就为已用状态
                    CollectorInfoService.GetInstance().Save(collector);
                    return Content(true.ToString());
                }
                else
                {
                    collector.isUsed = true;//如果采集器已经和单元绑定了就为已用状态
                    CollectorInfoService.GetInstance().Save(collector);
                    return Content(Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_BINDED);
                }

            }
            else
            {
                return Content(Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_ERROR + "！");
            }
        }

        /// <summary>
        /// 保存注册是添的电站信息，新增和修改都可能
        /// </summary>
        /// <param name="plant"></param>
        /// <returns></returns>
        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Post)]
        [IsLoginAttribute]
        public ActionResult SavePlant(Plant plant)
        {
            //设置电站的经纬度
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

            //设置电站的创建者
            plant.userID = UserUtil.getCurUser().id;
            CountryCity area = CountryCityService.GetInstance().GetCity(plant.country);
            plant.area = area == null ? string.Empty : area.weather_code;
            int plantid = plant.id;
            if (plant.id > 0)
            {
                PlantService.GetInstance().UpdatePlantInfo(plant);
            }
            else
            {
                plantid = PlantService.GetInstance().AddPlantInfo(plant);
                //添加电站时，向电站用户关系表中加记录,shared=false表示是自己创建的
                PlantUserService.GetInstance().AddPlantUser(new PlantUser { plantID = plantid, userID = plant.userID, shared = false, roleId = Role.ROLE_SYSMANAGER});
            }
            UserUtil.ResetLogin(UserUtil.getCurUser());
            return Redirect("/newregister/addplantcontrol?plantid=" + plantid);
        }
    }}