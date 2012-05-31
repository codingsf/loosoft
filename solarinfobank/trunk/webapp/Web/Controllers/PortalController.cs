using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.IO;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Drawing;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Service.vo;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class PortalController : BaseController
    {
        CollectorYearDataService collectorYearDataService = CollectorYearDataService.GetInstance();

        public ActionResult Manage()
        {
            User user = UserUtil.getCurUser();
            Protal protal = ProtalService.GetInstance().GetByUser(user.id);
            if (protal == null) protal = new Protal();
            return View(protal);
        }

        [HttpPost]
        public ActionResult Save(HttpPostedFileBase markpic, HttpPostedFileBase logo)
        {
            string id = Request.Form["id"];
            if (string.IsNullOrEmpty(id)) id = "0";
            User user = UserUtil.getCurUser();
            Protal protal = ProtalService.GetInstance().GetByUser(user.id);
            if (protal == null) protal = new Protal();
            protal.id = int.Parse(id);
            protal.uid = user.id;
            protal.name = Request.Form["name"];
            protal.rate = Request.Form["rate"];
            protal.items = Request.Form["items"];
            protal.footer = Request.Form["footer"];
            try
            {
                if (!Directory.Exists(Server.MapPath("/protalimg/")))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("/protalimg/"));
                }

                if (markpic != null && markpic.ContentLength > 0)
                {
                    string filename = string.Format("{0}_{1}", user.id, "markpic.") + markpic.FileName.Substring(markpic.FileName.LastIndexOf('.') + 1);
                    string filePath = Path.Combine(HttpContext.Server.MapPath("../protalimg/"), filename);
                    protal.markPic = filename;
                    markpic.SaveAs(filePath);
                }

                if (logo != null && logo.ContentLength > 0)
                {
                    string filename = string.Format("{0}_{1}", user.id, "logo.") + logo.FileName.Substring(logo.FileName.LastIndexOf('.') + 1);
                    string filePath = Path.Combine(HttpContext.Server.MapPath("../protalimg/"), filename);

                    Bitmap myImage = new Bitmap(logo.InputStream);
                    //if (myImage.Width > 140)
                    //{
                    //    TempData["error"] = "图片宽度不能大于140";
                    //}
                    //else if (myImage.Height > 40)
                    //    TempData["error"] = "图片高度不能大于40";
                    //else
                    //{
                    myImage.Save(filePath);
                    protal.logo = filename;
                    //}
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            ProtalService.GetInstance().Save(protal);
            return Redirect("/portal/manage");
        }

        /// <summary>
        /// 取得门户各页面的汇总数据
        /// plant和user只能传一个值，另外一个为null
        /// </summary>
        /// <param name="itemStr">数据项目</param>
        /// <param name="plant">电站</param>
        /// <param name="portal">门户</param>
        private void GetIcos(string itemStr, Plant plant, Protal portal)
        {
            User portalUser = UserUtil.getCurUser();
            //门户用户的管理者
            User parentUser = UserService.GetInstance().Get(portalUser.ParentUserId);
            string[] items = itemStr.Split(',');
            IList<Hashtable> tableIcos = new List<Hashtable>();
            Hashtable ico = null;
            foreach (string item in items)
                if (string.IsNullOrEmpty(item) == false)
                {
                    if ((item.Equals(ProtalItems.temperature) || item.Equals(ProtalItems.sunshine)) && !(plant != null && !plant.isVirtualPlant))
                        continue;
                    if (item.Equals(ProtalItems.plantCount) && (plant != null && !plant.isVirtualPlant))
                        continue;
                    ico = new Hashtable();
                    ico.Add("id", item);
                    switch (item)
                    {
                        case ProtalItems.todayEnergy://今日发电
                            ico.Add(string.Format("data"), plant == null ? portalUser.DisplayTotalDayEnergy : plant.DisplayTotalDayEnergy);
                            ico.Add(string.Format("unit"), plant == null ? portalUser.TotalDayEnergyUnit : plant.TotalDayEnergyUnit);
                            ico.Add("displayName", ProtalItems.todayEnergyDisplayName);
                            break;
                        case ProtalItems.totalEnergy://总发电
                            ico.Add(string.Format("data"), plant == null ? portalUser.DisplayTotalEnergy : plant.DisplayTotalEnergy);
                            ico.Add(string.Format("unit"), plant == null ? portalUser.TotalEnergyUnit : plant.TotalEnergyUnit);
                            ico.Add("displayName", ProtalItems.totalEnergyDisplayName);
                            break;
                        case ProtalItems.power://功率
                            ico.Add(string.Format("data"), plant == null ? portalUser.DisplayTotalPower : plant.DisplayTodayTotalPower);
                            ico.Add(string.Format("unit"), plant == null ? portalUser.TotalPowerUnit : plant.TodayTotalPowerUnit);
                            ico.Add("displayName", ProtalItems.powerDisplayName);
                            break;
                        case ProtalItems.totalCo2://总CO2
                            ico.Add(string.Format("data"), plant == null ? portalUser.TotalReductiong.ToString("0.00") : plant.Reductiong.ToString("0.00"));
                            ico.Add(string.Format("unit"), plant == null ? portalUser.TotalReductiongUnit : plant.ReductiongUnit);
                            ico.Add("displayName", ProtalItems.totalCo2DisplayName);
                            break;
                        case ProtalItems.trees://等效树木
                            ico.Add(string.Format("data"), plant == null ? (portalUser.TotalEnergy / 40).ToString("0") : (plant.TotalEnergy / 40).ToString("0"));
                            ico.Add(string.Format("unit"), "棵");
                            ico.Add("displayName", ProtalItems.treesDisplayName);
                            break;
                        case ProtalItems.Income://收益
                            //先将门户的设置的收益转化率付给门户用户，即所有门户用户的采用同一个换算率
                            portalUser.revenueRate = double.Parse(portal.rate);
                            portalUser.currencies = "￥";
                            if (plant != null)
                            {
                                plant.revenueRate = double.Parse(portal.rate);
                                plant.currencies = parentUser.currencies;
                            }
                            ico.Add(string.Format("data"), plant == null ? portalUser.DisplayRevenue : plant.DisplayRevenue);
                            ico.Add(string.Format("unit"), parentUser.currencies);
                            ico.Add("displayName", ProtalItems.incomeDisplayName);
                            break;
                        case ProtalItems.sunshine://日照
                            ico.Add(string.Format("data"), plant == null ? "" : plant.Sunstrength.ToString());
                            ico.Add(string.Format("unit"), plant == null ? "" : MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_LINGT_CODE).unit);
                            ico.Add("displayName", ProtalItems.sunshineDisplayName);
                            break;
                        case ProtalItems.temperature://温度
                            double temper = plant.Temperature;
                            if (plant.Temperature == 0.0)
                            {
                                CityCodeService codeService = CityCodeService.GetInstance();
                                temper = codeService.GetTemperature(plant.city);
                            }
                            if (!double.IsNaN(temper))
                            {
                                if (parentUser != null && !parentUser.TemperatureType.ToLower().Equals("c"))
                                {
                                    temper = 32 + ((double)temper * 1.8);
                                }
                                ico.Add(string.Format("data", item), temper.ToString("0.0"));
                            }
                            else
                                ico.Add(string.Format("data", item), "");


                            ico.Add(string.Format("unit"), "°" + parentUser.TemperatureType);
                            ico.Add("displayName", ProtalItems.temperatureDispalyName);
                            break;
                        case ProtalItems.plantCount://电站数量
                            ico.Add("data", plant == null ? portalUser.assignedPlants.Count : plant.childs.Count);
                            ico.Add(string.Format("unit"), "个");
                            ico.Add("displayName", ProtalItems.plantCountDisplayName);
                            break;

                        case ProtalItems.installPower://安装功率
                            ico.Add("data", plant == null ? portalUser.assignedPlants.Sum(m => m.TotalDegignPower).ToString("0") : plant.TotalDegignPower.ToString("0"));
                            ico.Add(string.Format("unit"), "kWh");
                            ico.Add("displayName", ProtalItems.installPowerDisplayName);
                            break;


                        default:
                            break;

                    }
                    tableIcos.Add(ico);
                }

            ViewData["icos"] = tableIcos;
        }


        /// <summary>
        /// 门户首页
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            User user = UserUtil.getCurUser();
            ViewData["currency"] = string.IsNullOrEmpty(user.currencies) ? "￥" : user.currencies;
            ViewData["plants"] = user.assignedPlants;
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);

            GetIcos(protal.items, null, protal);
            ViewData["footer"] = protal.footer;
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);

            //double[] point = { 1960, 980, 490, 245, 120, 60, 30, 15, 7.5, 3.7, 1.90 };
            //IList<Plant> plants = user.assignedPlants;
            //IList<double> values = new List<double>();
            //if (plants.Count > 1)
            //{
            //    for (int i = 1; i < plants.Count; i++)
            //    {
            //        values.Add(GetDistance(plants[0].latitude, plants[0].longitude, plants[i].latitude, plants[i].longitude));
            //    }
            //}
            //double max = values.Count > 0 ? values.Max() : 0;
            //ViewData["point"] = 2;
            //for (int i = point.Length - 1; i >= 0; i--)
            //{
            //    if (point[i] > max / 8)
            //    {
            //        ViewData["point"] = i;
            //        break;
            //    }
            //}

            //取得峰谷平尖发电量和电费数据
            //先取得天发电量
            //CalenderUtil.formatDate(DateTime.Now,"yyyyMMdd")
            ChartData chartData = PlantChartService.GetAppInstance().PlantDaySectionCountChart(user.allAssignedFactPlants, "天发电量和电费", CalenderUtil.formatDate(DateTime.Now, "yyyyMMdd"), ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
            double?[] daydatas = null;
            if (chartData == null || !chartData.isHasData)
            {
                daydatas = new double?[10] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            }
            else
            {
                //生成数据表
                daydatas = new double?[chartData.series[0].data.Length + chartData.series[1].data.Length];
                for (int m = 0; m < chartData.series[0].data.Length; m++)
                {
                    daydatas[m] = Util.upDigtal(chartData.series[0].data[m].Value, 3);
                }
                //chartData.series[0].data.CopyTo(daydatas, 0);
                for (int m = 0; m < chartData.series[1].data.Length; m++)
                {
                    daydatas[m + 5] = Util.upDigtal(chartData.series[1].data[m].Value, 4);
                }
                //chartData.series[1].data.CopyTo(daydatas, chartData.series[1].data.Length);
            }
            ViewData["daydatas"] = daydatas;

            //月数据
            chartData = PlantChartService.GetAppInstance().PlantMonthSectionCountChart(user.allAssignedFactPlants, "月发电量和电费", CalenderUtil.formatDate(DateTime.Now, "yyyyMM"), ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
            double?[] monthdatas = null;
            if (chartData == null || !chartData.isHasData)
            {
                monthdatas = new double?[10] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            }
            else
            {
                monthdatas = new double?[chartData.series[0].data.Length + chartData.series[1].data.Length];
                for (int m = 0; m < chartData.series[0].data.Length; m++)
                {
                    monthdatas[m] = Util.upDigtal(chartData.series[0].data[m].Value, 3);
                }
                //chartData.series[0].data.CopyTo(monthdatas, 0);
                for (int m = 0; m < chartData.series[1].data.Length; m++)
                {
                    monthdatas[m + 5] = Util.upDigtal(chartData.series[1].data[m].Value, 4);
                }
                //chartData.series[1].data.CopyTo(monthdatas, chartData.series[1].data.Length);
            }
            ViewData["monthdatas"] = monthdatas;

            //年数据
            chartData = PlantChartService.GetAppInstance().PlantYearSectionCountChart(user.allAssignedFactPlants, "年发电量和电费", DateTime.Now.Year, ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
            double?[] yeardatas = null;
            if (chartData == null || !chartData.isHasData)
            {
                yeardatas = new double?[10] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            }
            else
            {
                yeardatas = new double?[chartData.series[0].data.Length + chartData.series[1].data.Length];
                for (int m = 0; m < chartData.series[0].data.Length; m++)
                {
                    yeardatas[m] = Util.upDigtal(chartData.series[0].data[m].Value, 3);
                }
                //chartData.series[0].data.CopyTo(yeardatas, 0);
                for (int m = 0; m < chartData.series[1].data.Length; m++)
                {
                    yeardatas[m + 5] = Util.upDigtal(chartData.series[1].data[m].Value, 4);
                }
                //chartData.series[1].data.CopyTo(yeardatas, chartData.series[1].data.Length);
            }
            ViewData["yeardatas"] = yeardatas;
            ViewData["uid"] = user.id;
            return View(protal);
        }

        /// <summary>
        /// 门户中显示某个组合电站的信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Virtual(int id)
        {
            User user = UserUtil.getCurUser();
            Plant vplant = PlantService.GetInstance().GetPlantInfoById(id);
            ViewData["currency"] = string.IsNullOrEmpty(user.currencies) ? "￥" : user.currencies;
            ViewData["childPlants"] = vplant.childs;
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            GetIcos(protal.items, vplant, protal);
            ViewData["footer"] = protal.footer;
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);

            //天数据
            ChartData chartData = PlantChartService.GetAppInstance().PlantDaySectionCountChart(vplant.allFactPlants, "天发电量和电费", CalenderUtil.formatDate(DateTime.Now, "yyyMMdd"), ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
            double?[] daydatas = null;
            if (chartData == null || !chartData.isHasData)
            {
                daydatas = new double?[10] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            }
            else
            {
                //生成数据表
                daydatas = new double?[chartData.series[0].data.Length + chartData.series[1].data.Length];
                for (int m = 0; m < chartData.series[0].data.Length; m++)
                {
                    daydatas[m] = chartData.series[0].data[m] / 1000;
                }
                //chartData.series[0].data.CopyTo(daydatas, 0);
                for (int m = 0; m < chartData.series[1].data.Length; m++)
                {
                    daydatas[m + 5] = Util.upDigtal(chartData.series[1].data[m].Value, 4);
                }
                //chartData.series[1].data.CopyTo(daydatas, chartData.series[1].data.Length);
            }
            ViewData["daydatas"] = daydatas;

            //月数据
            chartData = PlantChartService.GetAppInstance().PlantMonthSectionCountChart(vplant.allFactPlants, "月发电量和电费", CalenderUtil.formatDate(DateTime.Now, "yyyyMM"), ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
            double?[] monthdatas = null;
            if (chartData == null || !chartData.isHasData)
            {
                monthdatas = new double?[10] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            }
            else
            {
                monthdatas = new double?[chartData.series[0].data.Length + chartData.series[1].data.Length];
                for (int m = 0; m < chartData.series[0].data.Length; m++)
                {
                    monthdatas[m] = chartData.series[0].data[m] / 1000;
                }
                //chartData.series[0].data.CopyTo(monthdatas, 0);
                for (int m = 0; m < chartData.series[1].data.Length; m++)
                {
                    monthdatas[m + 5] = Util.upDigtal(chartData.series[1].data[m].Value, 4);
                }
                //chartData.series[1].data.CopyTo(monthdatas, chartData.series[1].data.Length);
            }
            ViewData["monthdatas"] = monthdatas;

            //年数据
            chartData = PlantChartService.GetAppInstance().PlantYearSectionCountChart(vplant.allFactPlants, "年发电量和电费", DateTime.Now.Year, ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
            double?[] yeardatas = null;
            if (chartData == null || !chartData.isHasData)
            {
                yeardatas = new double?[10] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            }
            else
            {
                yeardatas = new double?[chartData.series[0].data.Length + chartData.series[1].data.Length];
                for (int m = 0; m < chartData.series[0].data.Length; m++)
                {
                    yeardatas[m] = chartData.series[0].data[m] / 1000;
                }
                //chartData.series[0].data.CopyTo(yeardatas, 0);
                for (int m = 0; m < chartData.series[1].data.Length; m++)
                {
                    yeardatas[m + 5] = Util.upDigtal(chartData.series[1].data[m].Value, 4);
                }
                //chartData.series[1].data.CopyTo(yeardatas, chartData.series[1].data.Length);
            }
            ViewData["yeardatas"] = yeardatas;
            ViewData["url"] = "/portal";
            if (vplant.parentId > 0)
                ViewData["url"] = "/portal/virtual/" + vplant.parentId;


            //电站分布图开始
            string path = Server.MapPath("~") + "/config/";
            List<StructPoint> points = new List<StructPoint>();
            XmlHelper.DeserializerXML(string.Format("{1}structPointConfig{0}.xml", id, path), ref points);
            Plant plant = null;
            foreach (StructPoint point in points)
            {
                plant = PlantService.GetInstance().GetPlantInfoById(int.Parse(point.id));
                point.displayName = plant.name;
                point.targetUrl = string.Format("/portal/{0}/{1}", plant.isVirtualPlant ? "virtual" : "plant", plant.id);
            }
            ViewData["points"] = points;
            return View(vplant);
        }

        /// <summary>
        /// 查看门户单个电站
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Plant(string id)
        {


            User user = UserUtil.getCurUser();
            User parentUser = UserService.GetInstance().Get(user.ParentUserId);
            int pid = 0;
            int.TryParse(id, out pid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            ViewData["temp"] = plant.Temperature;
            if (plant.Temperature == 0.0)
            {
                CityCodeService codeService = CityCodeService.GetInstance();
                ViewData["temp"] = codeService.GetTemperature(plant.city);
            }
            if (!double.IsNaN(((double)ViewData["temp"])))
            {
                if (parentUser != null && !parentUser.TemperatureType.ToLower().Equals("c"))
                {
                    ViewData["temp"] = 32 + ((double)ViewData["temp"] * 1.8);
                }
            }
            else
                ViewData["temp"] = "";
            if (plant.parentId > 0)
                ViewData["url"] = "/portal/virtual/" + plant.parentId;
            else
                ViewData["url"] = "/portal/index";
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            GetIcos(protal.items, plant, protal);
            ViewData["footer"] = protal.footer;
            ViewData["portalName"] = protal.name;
            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);

            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);

            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);
            ViewData["plantYear"] = plantYearsList;
            //天数据
            ChartData chartData = PlantChartService.GetAppInstance().PlantDaySectionCountChart(plant.allFactPlants, "天发电量和电费", CalenderUtil.formatDate(DateTime.Now, "yyyyMMdd"), ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
            float?[] daydatas = null;
            if (chartData == null || !chartData.isHasData)
            {
                daydatas = new float?[10] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            }
            else
            {
                //生成数据表
                daydatas = new float?[chartData.series[0].data.Length + chartData.series[1].data.Length]; ;
                chartData.series[0].data.CopyTo(daydatas, 0);
                chartData.series[1].data.CopyTo(daydatas, chartData.series[1].data.Length);
            }
            ViewData["daydatas"] = daydatas;

            //月数据
            chartData = PlantChartService.GetAppInstance().PlantMonthSectionCountChart(plant.allFactPlants, "月发电量和电费", CalenderUtil.formatDate(DateTime.Now, "yyyyMM"), ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
            float?[] monthdatas = null;
            if (chartData == null || !chartData.isHasData)
            {
                monthdatas = new float?[10] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            }
            else
            {
                monthdatas = new float?[chartData.series[0].data.Length + chartData.series[1].data.Length]; ;
                chartData.series[0].data.CopyTo(monthdatas, 0);
                chartData.series[1].data.CopyTo(monthdatas, chartData.series[1].data.Length);
            }
            ViewData["monthdatas"] = monthdatas;

            //年数据
            chartData = PlantChartService.GetAppInstance().PlantYearSectionCountChart(plant.allFactPlants, "年发电量和电费", DateTime.Now.Year, ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
            float?[] yeardatas = null;
            if (chartData == null || !chartData.isHasData)
            {
                yeardatas = new float?[10] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            }
            else
            {
                yeardatas = new float?[chartData.series[0].data.Length + chartData.series[1].data.Length]; ;
                chartData.series[0].data.CopyTo(yeardatas, 0);
                chartData.series[1].data.CopyTo(yeardatas, chartData.series[1].data.Length);
            }
            ViewData["yeardatas"] = yeardatas;


            if (ProtalUtil.isAutoLogin)
            {

                List<StructPoint> points = new List<StructPoint>();
                string path = Server.MapPath("~") + "/config/";
                XmlHelper.DeserializerXML(string.Format("{1}structPointConfig{0}.xml", id, path), ref points);
                foreach (StructPoint point in points)
                {
                    foreach (PlantUnit unit in plant.plantUnits)
                        if (unit.id.Equals(int.Parse(point.id)))
                        {
                            point.displayName = unit.displayname;
                            point.targetUrl = string.Format("/portal/unit?uid={0}&pid={1}", unit.id, pid);
                            break;
                        }
                }
                ViewData["points"] = points;
            }


            return View(plant);





        }

        /// <summary>
        /// 排序电站设备
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        private IList<Device> SortPlantDevice(int pid)
        {

            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
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
        /// <summary>
        /// 电站设备状态
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult DeviceStatus(string id)
        {
            User user = UserUtil.getCurUser();
            ViewData["id"] = id;
            int pid = 0;
            int.TryParse(id, out  pid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            ViewData["data"] = SortPlantDevice(pid);
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            ViewData["footer"] = protal.footer;
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);

            return View(plant);
        }

        public ActionResult data()
        {
            return View();
        }
        /// <summary>
        /// 门户告警信息列表
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult fault(string id)
        {

            int pid = 0;
            int.TryParse(id, out pid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
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

                            table.Add("beforeYesterdayEnergy", PlantService.GetInstance().getDayPr(plant, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-2).Day, beforeYesterdayEnergy).ToString("0%"));
                            table.Add("yesterdayEnergy", PlantService.GetInstance().getDayPr(plant, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.AddDays(-1).Day, beforeYesterdayEnergy).ToString("0%"));
                            table.Add("todayEnergy", PlantService.GetInstance().getDayPr(plant, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, todayEnergy).ToString("0%"));
                            table.Add("thisMonthEnergy", PlantService.GetInstance().getMonthPr(plant, DateTime.Now.Year, DateTime.Now.Month, thisMonthEnergy).ToString("0%"));
                            table.Add("thisYearEnergy", PlantService.GetInstance().getYearPr(plant, DateTime.Now.Year, thisYearEnergy).ToString("0%"));
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
            User user = UserUtil.getCurUser();
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            ViewData["portalName"] = protal.name;
            ViewData["footer"] = protal.footer;
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);
            return View(plant);
        }

        /// <summary>
        /// 获取电站报表
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Report(string id, string plantId, string userId)
        {

            User tuser = UserUtil.getCurUser();

            Protal protal = ProtalService.GetInstance().GetByUser(tuser.ParentUserId);
            ViewData["logoName"] = protal.name;

            ViewData["footer"] = protal.footer;

            ViewData["footer"] = protal.footer;
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);

            int no = 0; ;
            if (string.IsNullOrEmpty(id))
            {
                no = 1;
            }
            else
            {
                int.TryParse(id, out no);
            }
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = no };

            IList<DefineReport> items = null;
            ViewData["page"] = page;
            ViewData["id"] = plantId;
            if (!string.IsNullOrEmpty(plantId))
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(int.Parse(plantId));
                ViewData["logoName"] = plant.name;

                User user = UserService.GetInstance().Get(int.Parse(plant.userID.ToString()));
                ViewData["user"] = user;
                base.FillPlantYears(int.Parse(plantId));

                Hashtable table = new Hashtable();
                table.Add("page", page);
                table.Add("PlantId", plantId);
                items = ReportService.GetInstance().GetRunReportsByPageByPlantId(table);
            }
            else
            {
                User user = UserService.GetInstance().Get(int.Parse(userId));
                ViewData["user"] = user;
                base.FillAllPlantYears(user);
                Hashtable table = new Hashtable();
                table.Add("page", page);
                table.Add("UserId", user.id);
                items = ReportService.GetInstance().GetRunReportsListByUserId(table);
            }
            ViewData["Culture"] = Session["Culture"];
            //Plant temp = PlantService.GetInstance().GetPlantInfoById(int.Parse(plantId));
            ViewData["plantName"] = "";//temp.name;
            return View(items);
        }
        /// <summary>
        /// 电站pr性能图和 实际plantController是一致的，暂时先拷贝过来，后面再优化
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public ActionResult PRChart(int pid)
        {

            User user = UserUtil.getCurUser();
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);

            string startYM = (DateTime.Now.Year - 1) + "" + DateTime.Now.Month.ToString("00");
            string endYM = DateTime.Now.Year + "" + DateTime.Now.Month.ToString("00");

            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);

            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData["footer"] = protal.footer;
            ViewData["plantYear"] = plantYearsList;
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);
            return View(plant);
        }
        /// <summary>
        /// 电站历史数据，参照overview
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult historyData(int id)
        {
            User user = UserUtil.getCurUser();
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);

            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            ViewData[ComConst.PlantName] = plant.name;

            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);

            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);


            ViewData["footer"] = protal.footer;
            ViewData["plantYear"] = plantYearsList;
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);
            return View(plant);
        }

        /// <summary>
        /// 从电站列表中取出第一个电站的峰谷平尖电价和基础电价
        /// </summary>
        /// <param name="plants"></param>
        /// <returns></returns>
        private double?[] getPlantPrice(IList<Plant> plants)
        {
            double?[] price = new double?[5] { 0.6d, 0.5d, 0.2d, 0.4d, 1d };
            if (plants.Count > 0)
            {
                if (plants[0].ElecPriceList.Count > 0)
                {
                    ElecPrice ep = null;
                    for (int i = 0; i < plants[0].ElecPriceList.Count; i++)
                    {
                        ep = plants[0].ElecPriceList[i];
                        if (!string.IsNullOrEmpty(ep.price))
                        {
                            price[i] = StringUtil.stringtoFloat(ep.price);
                        }
                    }
                }
                price[4] = plants[0].basePrice;
            }
            return price;
        }
        /// <summary>
        /// 取得电站的峰谷平尖详细数据
        /// </summary>
        /// <param name="plants">电站列表</param>
        /// <param name="isSum">是否进行汇总</param>
        private IList<FGPJVO> getDetailDatas(IList<Plant> plants, bool isSum)
        {
            IList<FGPJVO> fjpjvos = new List<FGPJVO>();
            TIMEFGPJVO dayTIMEFGPJVO = null;
            TIMEFGPJVO monthTIMEFGPJVO = null;
            TIMEFGPJVO yearTIMEFGPJVO = null;
            FGPJVO fgpjVO = null;
            double?[] priceArr = this.getPlantPrice(plants);
            foreach (Plant plant in plants)
            {
                fgpjVO = new FGPJVO();
                fgpjVO.timevos = new List<TIMEFGPJVO>();
                dayTIMEFGPJVO = new TIMEFGPJVO();
                //天数据
                ChartData chartData = PlantChartService.GetAppInstance().PlantDaySectionCountChart(plant.allFactPlants, "天发电量和电费", CalenderUtil.formatDate(DateTime.Now, "yyyyMMdd"), ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
                double?[] daydatas = null;
                if (chartData == null || !chartData.isHasData)
                {
                    daydatas = new double?[15] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
                    priceArr.CopyTo(daydatas, 5);
                }
                else
                {
                    //生成数据表
                    daydatas = new double?[chartData.series[0].data.Length + chartData.series[1].data.Length + priceArr.Length];
                    for (int m = 0; m < chartData.series[0].data.Length; m++)
                    {
                        daydatas[m] = Util.upDigtal(chartData.series[0].data[m].Value, 3);
                    }
                    //chartData.series[0].data.CopyTo(daydatas, 0);
                    priceArr.CopyTo(daydatas, 5);
                    for (int m = 0; m < chartData.series[1].data.Length; m++)
                    {
                        daydatas[m + 10] = Util.upDigtal(chartData.series[1].data[m].Value, 4);
                    }
                    //chartData.series[1].data.CopyTo(daydatas, 10);
                }
                dayTIMEFGPJVO.energy = Util.upDigtal(plant.TotalDayEnergy);
                dayTIMEFGPJVO.time = "当日";
                dayTIMEFGPJVO.fgpjdata = daydatas;
                fgpjVO.timevos.Add(dayTIMEFGPJVO);


                monthTIMEFGPJVO = new TIMEFGPJVO();
                //月数据
                chartData = PlantChartService.GetAppInstance().PlantMonthSectionCountChart(plant.allFactPlants, "月发电量和电费", CalenderUtil.formatDate(DateTime.Now, "yyyyMM"), ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
                double?[] monthdatas = null;
                if (chartData == null || !chartData.isHasData)
                {
                    monthdatas = new double?[15] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
                    priceArr.CopyTo(monthdatas, 5);
                }
                else
                {
                    monthdatas = new double?[chartData.series[0].data.Length + chartData.series[1].data.Length + priceArr.Length];
                    for (int m = 0; m < chartData.series[0].data.Length; m++)
                    {
                        monthdatas[m] = chartData.series[0].data[m] / 1000;
                    }
                    //chartData.series[0].data.CopyTo(monthdatas, 0);
                    priceArr.CopyTo(monthdatas, 5);
                    for (int m = 0; m < chartData.series[1].data.Length; m++)
                    {
                        monthdatas[m + 10] = Util.upDigtal(chartData.series[1].data[m].Value, 4);
                    }
                    //chartData.series[1].data.CopyTo(monthdatas, 10);
                }
                string startYM = CalenderUtil.formatDate(DateTime.Now, "yyyy-MM-") + "01";
                string endYm = CalenderUtil.formatDate(DateTime.Now, "yyyy-MM-") + CalenderUtil.getCurMonthDays().ToString("00");
                monthTIMEFGPJVO.energy = Util.upDigtal(PlantService.GetInstance().GetEnergy(plant, startYM, endYm), 3);
                monthTIMEFGPJVO.time = "当月";
                monthTIMEFGPJVO.fgpjdata = monthdatas;
                fgpjVO.timevos.Add(monthTIMEFGPJVO);

                yearTIMEFGPJVO = new TIMEFGPJVO();
                //年数据
                chartData = PlantChartService.GetAppInstance().PlantYearSectionCountChart(plant.allFactPlants, "年发电量和电费", DateTime.Now.Year, ChartType.column, "kWh", MonitorType.PLANT_MONITORITEM_ENERGY_CODE, 5, 1);
                double?[] yeardatas = null;
                if (chartData == null || !chartData.isHasData)
                {
                    yeardatas = new double?[15] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
                    priceArr.CopyTo(yeardatas, 5);
                }
                else
                {
                    yeardatas = new double?[chartData.series[0].data.Length + chartData.series[1].data.Length + priceArr.Length]; ;
                    for (int m = 0; m < chartData.series[0].data.Length; m++)
                    {
                        yeardatas[m] = chartData.series[0].data[m] / 1000;
                    }
                    //chartData.series[0].data.CopyTo(yeardatas, 0);
                    priceArr.CopyTo(yeardatas, 5);
                    for (int m = 0; m < chartData.series[1].data.Length; m++)
                    {
                        yeardatas[m + 10] = Util.upDigtal(chartData.series[1].data[m].Value, 4);
                    }
                    //chartData.series[1].data.CopyTo(yeardatas, 10);
                }
                startYM = CalenderUtil.formatDate(DateTime.Now, "yyyy-") + "01";
                endYm = CalenderUtil.formatDate(DateTime.Now, "yyyy-") + "12";
                yearTIMEFGPJVO.energy = Util.upDigtal(PlantService.GetInstance().GetEnergy(plant, startYM, endYm), 3);

                yearTIMEFGPJVO.time = "当年";
                yearTIMEFGPJVO.fgpjdata = yeardatas;

                fgpjVO.timevos.Add(yearTIMEFGPJVO);
                fgpjVO.plantName = plant.name;
                fgpjVO.power = plant.TodayTotalPower;
                fjpjvos.Add(fgpjVO);
            }
            //汇总

            if (isSum)
            {
                FGPJVO sumfgpjVO = new FGPJVO();
                sumfgpjVO.timevos = new List<TIMEFGPJVO>();
                TIMEFGPJVO sumdayTIMEFGPJVO = new TIMEFGPJVO();
                sumdayTIMEFGPJVO.fgpjdata = new double?[15] { 0, 0, 0, 0, 0, double.NaN, double.NaN, double.NaN, double.NaN, double.NaN, 0, 0, 0, 0, 0 };
                sumdayTIMEFGPJVO.time = "当日";
                TIMEFGPJVO summonthTIMEFGPJVO = new TIMEFGPJVO();
                summonthTIMEFGPJVO.fgpjdata = new double?[15] { 0, 0, 0, 0, 0, double.NaN, double.NaN, double.NaN, double.NaN, double.NaN, 0, 0, 0, 0, 0 };
                summonthTIMEFGPJVO.time = "当月";
                TIMEFGPJVO sumyearTIMEFGPJVO = new TIMEFGPJVO();
                sumyearTIMEFGPJVO.fgpjdata = new double?[15] { 0, 0, 0, 0, 0, double.NaN, double.NaN, double.NaN, double.NaN, double.NaN, 0, 0, 0, 0, 0 };
                sumyearTIMEFGPJVO.time = "当年";

                float power = 0;
                foreach (FGPJVO f in fjpjvos)
                {
                    power += f.power;
                    sumdayTIMEFGPJVO.energy += f.timevos[0].energy;
                    summonthTIMEFGPJVO.energy += f.timevos[1].energy;
                    sumyearTIMEFGPJVO.energy += f.timevos[2].energy;
                    TIMEFGPJVO v = null;
                    for (int i = 0; i < f.timevos.Count; i++)
                    {
                        v = f.timevos[i];
                        if (i == 0)
                        {
                            for (int k = 0; k < 5; k++)
                            {
                                sumdayTIMEFGPJVO.fgpjdata[k] += v.fgpjdata[k];
                            }
                            for (int k = 10; k < 15; k++)
                            {
                                sumdayTIMEFGPJVO.fgpjdata[k] += v.fgpjdata[k];
                            }
                        }
                        else if (i == 1)
                        {
                            for (int k = 0; k < 5; k++)
                            {
                                summonthTIMEFGPJVO.fgpjdata[k] += v.fgpjdata[k];
                            }
                            for (int k = 10; k < 15; k++)
                            {
                                summonthTIMEFGPJVO.fgpjdata[k] += v.fgpjdata[k];
                            }
                        }
                        else
                        {
                            for (int k = 0; k < 5; k++)
                            {
                                sumyearTIMEFGPJVO.fgpjdata[k] += v.fgpjdata[k];
                            }
                            for (int k = 10; k < 15; k++)
                            {
                                sumyearTIMEFGPJVO.fgpjdata[k] += v.fgpjdata[k];
                            }
                        }
                    }
                }
                sumfgpjVO.timevos.Add(sumdayTIMEFGPJVO);
                sumfgpjVO.timevos.Add(summonthTIMEFGPJVO);
                sumfgpjVO.timevos.Add(sumyearTIMEFGPJVO);
                sumfgpjVO.power = power;
                sumfgpjVO.plantName = "汇总";
                fjpjvos.Insert(0, sumfgpjVO);
            }

            return fjpjvos;
        }

        /// <summary>
        /// 峰谷平发电量统计
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult fgpjData(int id)
        {
            User user = UserUtil.getCurUser();
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            if (id != 0)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
                ViewData[ComConst.PlantName] = plant.name;
                IList<int> yearList = collectorYearDataService.GetWorkYears(plant);
                IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
                ViewData["portalName"] = protal.name;
                ViewData["footer"] = protal.footer;
                ViewData["plantYear"] = plantYearsList;
                ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);
                //取得数据
                IList<FGPJVO> fjpjvo = getDetailDatas(plant.isVirtualPlant ? plant.childs : new List<Plant> { plant }, plant.isVirtualPlant ? true : false);
                ViewData["fjpjvo"] = fjpjvo;
                return View(plant);
            }
            else
            {
                ViewData[ComConst.PlantName] = protal.name;
                IList<int> yearList = collectorYearDataService.GetWorkYears(user.allAssignedFactPlants);
                IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
                ViewData["portalName"] = protal.name;
                ViewData["footer"] = protal.footer;
                ViewData["plantYear"] = plantYearsList;
                ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);

                //取得数据
                IList<FGPJVO> fjpjvo = getDetailDatas(user.assignedPlants, true);
                ViewData["fjpjvo"] = fjpjvo;

                return View("userFgpjData", user);
            }
        }
        public ActionResult Devicerelation(string pid)
        {
            string groupName = string.Empty;
            int id = 0;
            int.TryParse(pid, out id);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            IList<DeviceRelation> groupRelations = DeviceRelationService.GetInstance().getNamesPlantId(id);
            ViewData["group"] = groupRelations;
            if (string.IsNullOrEmpty(Request["name"]))
                groupName = groupRelations.Count > 0 ? groupRelations[0].name : string.Empty;
            else
                groupName = Request["name"];
            User user = UserUtil.getCurUser();
            Protal portal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            ViewData["portalName"] = portal.name;
            ViewData["pid"] = pid;
            ViewData["logo"] = string.Format("/protalimg/{0}", portal.logo);
            ViewData["footer"] = portal.footer;
            RelationConfig config = RelationConfigService.GetInstance().GetConfig(user.ParentUserId, id, RelationConfig.DeviceType, groupName);
            if (config == null) config = new RelationConfig { width = "100", height = "100", config3 = "30", config4 = "20" };
            TempData["iSubtreeSeparation"] = config.config3;
            TempData["iSiblingSeparation"] = config.config4;
            return View(plant);
        }

        public ActionResult ViewReport(string rId, string cTime, string tId, string pId)
        {
            User tuser = UserUtil.getCurUser();

            Protal protal = ProtalService.GetInstance().GetByUser(tuser.ParentUserId);
            ViewData["logoName"] = protal.name;
            ViewData["footer"] = protal.footer;
            ViewData["footer"] = protal.footer;
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);
            ViewData["rid"] = rId;
            ViewData["ctime"] = cTime;
            ViewData["tid"] = tId;
            ViewData["pid"] = pId;
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
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);

            string startYM = (DateTime.Now.Year - 1) + "" + DateTime.Now.Month.ToString("00");
            string endYM = DateTime.Now.Year + "" + DateTime.Now.Month.ToString("00");

            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);

            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData["footer"] = protal.footer;
            ViewData["plantYear"] = plantYearsList;
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);
            return View(plant);
        }


        public ActionResult Logs(string pid)
        {
            ICollection<ErrorType> errorTypes = ErrorType.getErrorList();
            ViewData["errorTypes"] = errorTypes;
            User cuser = UserUtil.getCurUser();
            ViewData["uid"] = cuser.id;
            Protal portal = ProtalService.GetInstance().GetByUser(cuser.ParentUserId);
            ViewData["name"] = portal.name;
            ViewData["portalName"] = portal.name;
            ViewData["footer"] = portal.footer;
            ViewData["logo"] = string.Format("/protalimg/{0}", portal.logo);
            if (string.IsNullOrEmpty(pid) == false)
            {
                int id;
                int.TryParse(pid, out id);
                Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
                ViewData["name"] = plant.name;
            }
            return View();
        }

        public ActionResult SearchLogs(string userId, string startDate, string endDate, string state, int plant, int pindex, string errorType, string ctype)
        {

            #region 将查询时间设为23点59分59秒
            DateTime startTime = Convert.ToDateTime(startDate);
            DateTime endTime = Convert.ToDateTime(endDate).AddDays(1);
            #endregion

            int uid = 0;
            int.TryParse(userId, out uid);
            Hashtable table = new Hashtable();
            table.Add("user", UserService.GetInstance().Get(uid));
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
                FaultService.GetInstance().GetAllLogs(table);
                if (table.ContainsKey("source") && table["source"] != null)
                    logs = table["source"] as IList<Fault>;
            }
            catch
            {
                logs = new List<Fault>();
            }
            return View(logs);

        }



        public string createFolderTree(IList<DirectoryInfo> topDirectoryInfo, int uplevel, string pid, IList<string> displayName, IList<string> rootFolder)
        {
            string jsstr = "";
            if (uplevel == -1)
            {
                jsstr += string.Format(" d.add({0}, {1}, '{2}', 'javascript:void(0);', '', '', '/images/tree/folder.gif');", 0, uplevel, "视频监控图片");
                uplevel++;
            }
            //有下级那么就递归调用下级生成脚本。进行累计
            if (topDirectoryInfo != null && topDirectoryInfo.Count > 0)
            {
                DirectoryInfo tmpDir = null;
                int curLevel = 0;
                for (int i = 0; i < topDirectoryInfo.Count; i++)
                {
                    tmpDir = topDirectoryInfo[i];
                    if (tmpDir.GetDirectories().Length == 0 && tmpDir.GetFiles().Length == 0 && displayName == null)//没有下级目录并且当前目录没有文件不显示
                        continue;
                    curLevel = ((uplevel + 1) * 10 + i);
                    string path = string.Empty;
                    DirectoryInfo parentDic = tmpDir.Parent;
                    while (parentDic != null)
                    {
                        string tmp = path;
                        path = string.Format("{0}/{1}", parentDic.Name, path);
                        parentDic = parentDic.Parent;
                    }
                    bool createLink = true;
                    path = string.Format("{0}{1}", path, tmpDir.Name);
                    if (displayName != null && displayName.Count > 0)
                        createLink = false;
                    else
                        foreach (string str in rootFolder)
                            if (tmpDir.Parent.FullName.Equals(str))
                            {
                                createLink = false;
                                break;
                            }
                    path = Convert.ToBase64String(ASCIIEncoding.UTF8.GetBytes(path));
                    jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '/images/tree/folder.gif');", curLevel, uplevel, (displayName != null && displayName.Count > 0) ? displayName[i] : tmpDir.Name, !createLink ? "javascript:void(0);" : string.Format("/portal/video/?path={0}&id={1}", path, pid));
                    if (tmpDir.GetDirectories() != null && tmpDir.GetDirectories().Length > 0)
                        jsstr += createFolderTree(tmpDir.GetDirectories(), curLevel, pid, null, rootFolder);
                }
            }
            return jsstr;
        }

        public ActionResult Video(string path, string id)
        {
            User user = UserUtil.getCurUser();
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            int pid = 0;
            int.TryParse(id, out pid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            IList<VideoMonitor> monitors = VideoMonitorService.GetInstance().GetList(new VideoMonitor() { plantId = pid });
            ViewData["data"] = monitors;
            IList<DirectoryInfo> dirInfos = new List<DirectoryInfo>();
            IList<string> displayName = new List<string>();
            IList<string> rootFolder = new List<string>();
            foreach (VideoMonitor monitor in monitors)
            {
                if (string.IsNullOrEmpty(monitor.folder))
                    continue;
                if (Directory.Exists(monitor.folder))
                {
                    dirInfos.Add(new DirectoryInfo(monitor.folder));
                    displayName.Add(monitor.name);
                    rootFolder.Add(monitor.folder);
                }
            }
            string str = string.Empty;
            str = createFolderTree(dirInfos, -1, id, displayName, rootFolder);
            ViewData["str"] = str;
            IList<FileInfo> finfoArray = new List<FileInfo>();
            if (string.IsNullOrEmpty(path) == false)//读文件夹图片
            {
                path = Encoding.UTF8.GetString(Convert.FromBase64String(path));
                DirectoryInfo dinfo = new DirectoryInfo(path);
                finfoArray = dinfo.GetFiles("*.jpg", SearchOption.AllDirectories);
            }
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);
            ViewData["images"] = finfoArray;
            return View(plant);
        }

        public ActionResult Overview(string id)
        {
            User user = UserUtil.getCurUser();
            User parentUser = UserService.GetInstance().Get(user.ParentUserId);
            int pid = 0;
            int.TryParse(id, out pid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            ViewData["temp"] = plant.Temperature;
            if (plant.Temperature == 0.0)
            {
                CityCodeService codeService = CityCodeService.GetInstance();
                ViewData["temp"] = codeService.GetTemperature(plant.city);
            }
            if (!double.IsNaN(((double)ViewData["temp"])))
            {
                if (parentUser != null && !parentUser.TemperatureType.ToLower().Equals("c"))
                {
                    ViewData["temp"] = 32 + ((double)ViewData["temp"] * 1.8);
                }
            }
            else
                ViewData["temp"] = "";
            ViewData["url"] = Request.UrlReferrer;
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            GetIcos(protal.items, plant, protal);
            ViewData["footer"] = protal.footer;
            ViewData["portalName"] = protal.name;
            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);
            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData["logo"] = string.Format("/protalimg/{0}", protal.logo);
            ViewData["plantYear"] = plantYearsList;
            ViewData[ComConst.PlantName] = plant.name;

            return View(plant);

        }

        public ActionResult PlantUnit(string id)
        {
            User user = UserUtil.getCurUser();
            int pid = 0;
            int.TryParse(id, out pid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            List<StructPoint> points = new List<StructPoint>();
            string path = Server.MapPath("~") + "/config/";
            XmlHelper.DeserializerXML(string.Format("{1}structPointConfig{0}.xml", id, path), ref points);
            foreach (StructPoint point in points)
            {
                foreach (PlantUnit unit in plant.plantUnits)
                    if (unit.id.Equals(int.Parse(point.id)))
                    {
                        point.displayName = unit.displayname;
                        point.targetUrl = string.Format("/portal/unit?uid={0}&pid={1}", unit.id, pid);
                        break;
                    }
            }
            ViewData["points"] = points;

            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            ViewData["logo"] = protal.logo;
            return View(plant);
        }

        public ActionResult PlantInfo(string id)
        {
            User user = UserUtil.getCurUser();
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            ViewData["logo"] = protal.logo;
            ViewData["footer"] = protal.footer;
            int pid = 0;
            int.TryParse(id, out pid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            return View(plant);
        }

        public ActionResult Unit(string uid, string pid)
        {
            User user = UserUtil.getCurUser();
            Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
            ViewData["logo"] = protal.logo;
            int iid = 0;
            int.TryParse(uid, out iid);
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(iid);
            int.TryParse(pid, out iid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(iid);
            ViewData["plantUnit"] = unit;
            ViewData["hashlx"] = false;

            foreach (Device dce in unit.devices)
            {
                if (dce.deviceTypeCode == DeviceData.HUILIUXIANG_CODE)
                {
                    ViewData["hashlx"] = true;
                    break;
                }
            }
            FillPlantYears(plant.id.ToString());
            return View(plant);

        }

        public void FillPlantYears(string plantId)
        {
            Plant plant = FindPlant(int.Parse(plantId));
            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);
            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData["plantYear"] = plantYearsList;
        }

        public ActionResult HLXchart(string pid, string uid)
        {
            int iid = 0;
            int.TryParse(uid, out iid);
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(iid);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(unit.plantID);
            ViewData["plantUnit"] = unit;
            FillPlantYears(plant.id.ToString());
            return View(plant);
        }

        public ActionResult Footer()
        {
            return View();
        }

    }
}
