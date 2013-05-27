using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class BigScreenController : Controller
    {
        /// <summary>
        /// 第一个页面 电站profile页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Profile()
        {
            return View();
        }


        /// <summary>
        /// 功率曲线页面
        /// </summary>
        /// <returns></returns>
        public ActionResult PowerChart()
        {
            return View();
        }

        /// <summary>
        /// 月发电量曲线页面
        /// </summary>
        /// <returns></returns>
        public ActionResult MonthEnergyChart()
        {
            return View();
        }

        /// <summary>
        /// 电站年发电量页面
        /// </summary>
        /// <returns></returns>
        public ActionResult YearEnergyChart()
        {
            return View();
        }

        public ActionResult RenderPage()
        {
            return View();
        }

        public ActionResult Execute(string id)
        {
            User user = UserUtil.getCurUser();
            ViewData["logo"] = user.BigScreenLogoFomartPath;
            string value = string.Empty;
            if (string.IsNullOrEmpty(id) == false)
            {
                int pid = 0;
                int.TryParse(id, out pid);
                Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
                value = plant.id.ToString();
            }
            else
                foreach (Plant plant in user.relatedPlants)
                    value += plant.id + ",";

            value = value.EndsWith(",") ? value.Substring(0, value.Length - 1) : value;
            ViewData["plantIds"] = value;
            ViewData["plantArray"] = value.Split(',');
            value = System.Configuration.ConfigurationManager.AppSettings["bigscreen_cache"];
            if (string.IsNullOrEmpty(value)) value = "5";
            ViewData["cacheminutes"] = value;
            value = System.Configuration.ConfigurationManager.AppSettings["bigscreen_page_interval"];
            if (string.IsNullOrEmpty(value)) value = "5000";
            ViewData["pageinterval"] = value;
            return View();
        }

        /// <summary>
        /// 加载数据 总的用这一个函数实现
        /// 根据dataType区分
        /// 数据返回json格式
        /// </summary>
        /// <param name="dataType"></param>
        /// <returns></returns>
        public ActionResult loadData(int dataType)
        {
            string plantId = Request["plantid"];
            int iplantId = 0;
            int.TryParse(plantId, out iplantId);
            switch (dataType)
            {
                case 0:
                    return PlantData(iplantId);
                case 1:
                    return PlantDayChart(iplantId, 5);
                case 2:
                    return MonthDDChart(iplantId);
                case 3:
                    return YearMMChart(iplantId);

            }
            return null;
        }

        public ActionResult PlantData(int plantId)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(plantId);
            Cn.Loosoft.Zhisou.SunPower.Common.vo.PlantVO plantVO = new Cn.Loosoft.Zhisou.SunPower.Common.vo.PlantVO();

            User user = UserService.GetInstance().Get((int)plant.userID);
            plantVO.plantName = plant.name;
            plantVO.CQ2reduce = plant.Reductiong.ToString();
            plantVO.CQ2reduceUnit = plant.ReductiongUnit;
            plantVO.curPower = plant.DisplayTodayTotalPower;
            plantVO.curPowerUnit = plant.TodayTotalPowerUnit;
            plantVO.dayEnergy = plant.DisplayTotalDayEnergy;
            plantVO.dayEnergyUnit = plant.TotalDayEnergyUnit;
            plantVO.solarIntensity = plant.Sunstrength == null ? "" : plant.Sunstrength.ToString();
            plantVO.solarIntensityUnit = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_LINGT_CODE).unit;
            //add by qhb in 20120106 for 增加逆变器数量
            IList<Device> inverterDevices = plant.typeDevices(DeviceData.INVERTER_CODE);
            plantVO.inverterCount = inverterDevices.Count.ToString();
            plantVO.inverterTypeStr = getMainType(inverterDevices, 3);
            plantVO.installDate = plant.installdate.ToString("yyyy-MM-dd");
            plantVO.DesignPower = plant.design_power + " kWp";
            plantVO.Country = plant.country;
            plantVO.City = plant.city;
            plantVO.organize = user.organize;
            plantVO.totalEnergy = plant.DisplayTotalEnergy;
            plantVO.totalEnergyUnit = plant.TotalEnergyUnit;
            plantVO.imageArray = "http://" + Request.Url.Authority + (string.IsNullOrEmpty(plant.onePic) ? "/bigscreen/images/plant_img.jpg":"/ufile/"+plant.onePic);
            plantVO.temprature = getPlantTemp(plant).ToString();
            plantVO.tempratureUnit = user.TemperatureType.ToUpper();
            return Json(plantVO, JsonRequestBehavior.AllowGet);
        }

        private object getPlantTemp(Plant plant)
        {

            if (plant.getFirstDetector() != null)
            {
                return plant.getFirstDetector().getMonitorValue(MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE).ToString();
            }
            else {
                object temperature = plant.Temperature;
                if (double.IsNaN((double)temperature))
                {
                    CityCodeService codeService = CityCodeService.GetInstance();
                    temperature = codeService.GetTemperature(plant.city);
                }
                //修正了温度不存在显示0的问题
                if (!double.IsNaN(((double)temperature)) && temperature != null)
                {
                    User user = UserUtil.getCurUser();
                    if (user != null && !user.TemperatureType.ToLower().Equals("c"))
                    {
                        temperature = Math.Round(32 + ((double)temperature * 1.8), 1);
                    }
                    else
                    {
                        temperature = Math.Round((double)temperature, 1);
                    }
                }
                else
                    temperature = "";
                return temperature;
            }

        }
        public ActionResult PlantDayChart(int pid, int intervalMins)
        {
            string startYYYYMMDDHH = DateTime.Now.AddDays(-1).ToString("yyyyMMdd00");
            string endYYYYMMDDHH = DateTime.Now.ToString("yyyyMMdd23");
            string chartType = "area";
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            if (plant != null && plant.allFactUnits.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                string deviceId = plant.id.ToString();
                string[] chartTypes = chartType.Split(',');
                devices.Add(new DeviceStuct() { deviceId = deviceId, rate = 1.0F, comareObj = plant.name, chartType = ChartType.area, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_POWER_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = intervalMins });
                //判断该测点是否有数据,有数据则增加关照对比
                //Hashtable dataHash = CollectorDayDataService.GetInstance().GetUnitDaydataList(plant.allFactUnits, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, MonitorType.PLANT_MONITORITEM_POWER_CODE);
                string chartName = LanguageUtil.getDesc("PLANT_CHART_DAY_CHART_POWER");
                //if (dataHash.Count > 0)
                //{
                    Device device = plant.getFirstDetector();
                    if (device != null)
                    {
                        //dataHash = DeviceDayDataService.GetInstance().GetDaydataList(null, device, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, MonitorType.MIC_DETECTOR_SUNLINGHT);
                        //if (dataHash.Keys.Count > 0)//有日照数据
                        //{
                            chartName = LanguageUtil.getDesc("PLANT_CHART_DAY_CHART");
                            float rate = 1F;
                            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_SUNLINGHT);
                            devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, comareObj = plant.name, name = mt.name, unit = "", chartType = ChartType.line, monitorType = mt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = intervalMins });
                        //}
                    }
                //}
                //else
                //{
                    //return Content("error:" + Resources.SunResource.NODATA);
                //}
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, ComputeType.None, false);
                // ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins);
                //ChartData chartData_large = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, 60);

                foreach (YData yd in chartData.series)
                {
                    if(yd.max==0)
                        yd.max = 10;
                }
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportCode);
        }

        public ActionResult MonthDDChart(int plantId)
        {
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(plantId);
            if (plant != null)
            {
                string unit = "kWh";
                string startYYYYMMDD = DateTime.Now.ToString("yyyyMM01");
                string endYYYYMMDD = new DateTime(DateTime.Now.Year, DateTime.Now.Month + 1, 1).AddDays(-1).ToString("yyyyMMdd");
                //ChartData chartData = PlantChartService.GetInstance().MMDDChartBypList(new List<Plant> { plant }, startYYYYMMDD, endYYYYMMDD, "column", unit);
                ChartData chartData = PlantChartService.GetInstance().MonthDDChartBypList(new List<Plant> { plant }, 1.0F, LanguageUtil.getDesc("CHART_TITLE_MONTH_ENERGY"), null, startYYYYMMDD, endYYYYMMDD, ChartType.column, unit,false);
                foreach (YData yd in chartData.series)
                {
                    if (yd.max == 0)
                        yd.max = 10;
                }
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportCode);
        }

        public ActionResult YearMMChart(int plantId)
        {
            string reportCode = string.Empty;
            if (plantId > 0)
            {
                string unit = "kWh";
                Plant plant = PlantService.GetInstance().GetPlantInfoById(plantId);
                //ChartData chartData = PlantChartService.GetInstance().YearMMChartByPlant(plant, DateTime.Now.Year, ChartType.column, unit);
                string chartName = LanguageUtil.getDesc("CHART_TITLE_YEARLYENERGYCHART");
                //if (startYearMM.Substring(0, 4).Equals(endYearMM.Substring(0, 4)) && startYearMM.Substring(4, 2).Equals("01") && endYearMM.Substring(4, 2).Equals("12")) {
                //chartName = startYearMM.Substring(0, 4) + chartName;
                //}
                string startYearMM = DateTime.Now.Year + "01";
                string endYearMM = DateTime.Now.Year + "12";
                ChartData chartData = PlantChartService.GetInstance().YearMMChartBypList(new List<Plant> { plant }, 1.0F, chartName, null, startYearMM, endYearMM, ChartType.column, unit, true);
                foreach (YData yd in chartData.series)
                {
                    if (yd.max == 0)
                        yd.max = 10;
                }
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportCode);
        }


        /// <summary>
        /// 取得主要前三个设备类型
        /// </summary>
        /// <param name="inverterDevices"></param>
        /// <returns></returns>
        private string getMainType(IList<Device> inverterDevices, int befornum)
        {
            if (inverterDevices == null) return "";
            IDictionary<string, int> typenumMap = new Dictionary<string, int>();
            string xinhaoname = "";
            foreach (Device device in inverterDevices)
            {
                xinhaoname = device.xinhaoName;
                if (xinhaoname == null || xinhaoname.Equals("")) continue;
                if (typenumMap.Keys.Contains(xinhaoname))
                {
                    typenumMap[xinhaoname] = typenumMap[xinhaoname] + 1;
                }
                else
                {
                    typenumMap[xinhaoname] = 1;
                }
            }
            //给放到新map中
            IDictionary<int, string> numtypeMap = new Dictionary<int, string>();
            List<int> numList = new List<int>();
            int num;
            foreach (string xinhao in typenumMap.Keys)
            {
                num = typenumMap[xinhao];
                numtypeMap[num] = xinhao;
                numList.Add(num);
            }
            //给数量map的key排序
            numList.Sort(delegate(int left, int right) { return right - left; });
            //找出前三个最多的设备类型
            string typestr = "";
            for (int i = 0; i < numList.Count; i++)
            {
                if (i > befornum - 1) break;
                typestr = "," + numtypeMap[numList[i]];
            }

            return typestr.Length > 0 ? typestr.Substring(1) : typestr;
        }


    }
}
