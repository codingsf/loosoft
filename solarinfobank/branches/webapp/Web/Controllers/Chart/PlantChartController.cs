using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Collections;
using System.Web.Script.Serialization;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{

    public class PlantChartController : BaseController
    {
        //
        // GET: /ReportTest/

        public ActionResult Index(int id)
        {
            return View();
        }


        /// <summary>
        /// 获取单个电站的总电量统计报表
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public ActionResult PlantYearChart(int id, string chartType)
        {
            string reportCode = string.Empty;
            if (id > 0)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
                IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(plant);
                if (workYears.Count < 1)
                {
                    reportCode = "error:" + LanguageUtil.getDesc("PLANT_YEAR_CHART_ERROR_STRING_NOFORMAT");
                    return Content(reportCode);
                }
                if (workYears.Count <= 2) chartType = ChartType.column;
                string unit = "kWh";
                ChartData chartData = PlantChartService.GetInstance().YearChartByPlant(plant, chartType, unit);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));

            }
            FillPlantYears(id);
            return Content(reportCode);
        }

        /// <summary>
        /// 电站总体投资收益
        /// </summary>
        /// <param name="id"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult PlantYearKwpChart(int id, string chartType)
        {
            string reportCode = string.Empty;
            if (id > 0)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
                IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(plant);
                if (workYears.Count < 1)
                {
                    reportCode = "error:" + LanguageUtil.getDesc("PLANT_YEAR_CHART_ERROR_STRING_NOFORMAT");
                    return Content(reportCode);
                }
                if (workYears.Count <= 2) chartType = ChartType.column;
                string unit = "kWh/kWp";
                float rate = 1 / plant.chartPower;
                ChartData chartData = PlantChartService.GetInstance().YearChartBypList(new List<Plant>() { plant }, rate, LanguageUtil.getDesc("CHART_TITLE_TOTALKWPENERGYCHART"), LanguageUtil.getDesc("CHART_TITLE_INVEST_INCOME"), chartType, unit);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            FillPlantYears(id);
            return Content(reportCode);
        }

        /// <summary>
        /// 获取当前用户所有电站的电量统计报表
        /// ajax方式
        /// </summary>
        /// <returns></returns>
        public ActionResult UserYearChart(int userId, string chartType)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                if (user.plants.Count <= 2) chartType = ChartType.column;
                string unit = "kWh";// DeviceData.getMonitorItemByCode(monitorCode).Units[0];
                ChartData chartData = PlantChartService.GetInstance().YearChartBypList(user.plants, chartType, unit);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 获取当前用户所有电站的当前月数据图表
        /// ajax方式
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult UserMonthDDChart(int userId, string startYYYYMMDD, string endYYYYMMDD, string chartType)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                if (user.plants.Count <= 2) chartType = ChartType.column;
                string unit = "kWh";
                //取得用户年度发电量图表数据
                ChartData chartData = PlantChartService.GetInstance().MMDDChartBypList(user.plants, startYYYYMMDD, endYYYYMMDD, chartType, unit);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }

        [HttpPost]
        public ActionResult ChartDetailHtml(string data, string date)
        {//注释  测试pdf 导出

            JavaScriptSerializer jserializer = new JavaScriptSerializer();
            ChartData chartData = null;
            try
            {
                chartData = jserializer.Deserialize<ChartData>(data);
            }
            catch
            {
                chartData = null;
            }
            ViewData["date"] = date;




            //-------------------------------以下为pdf代码

            //var doc = new Document();

            //BaseFont baseFont = BaseFont.CreateFont("c:\\windows\\fonts\\STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

            //iTextSharp.text.Font font = new iTextSharp.text.Font(baseFont, 9);

            //string path = Server.MapPath("/PDFs");

            //PdfWriter.GetInstance(doc, new FileStream(path + "/Doc1.pdf", FileMode.Create));

            //doc.Open();
            //PdfPTable table = new PdfPTable(chartData.series.Count() + 1);
            //table.AddCell(new PdfPCell(new Phrase(Resources.SunResource.CUSTOMREPORT_CHART_TIME, font)));
            //string unit = string.Empty;
            //bool isprocessUnit = true;
            //int firsIndex = chartData.series[0].name.IndexOf('[');
            //int lastIndex = chartData.series[0].name.LastIndexOf(']');
            //if (chartData.units.Count().Equals(1) || chartData.units.GroupBy(m => m.ToString()).Count().Equals(1))//只有一个项目或者所有单位相同
            //{
            //    unit = chartData.units[0];
            //    isprocessUnit = false;
            //}
            //int yy = DateTime.Now.Year;
            //int mm = DateTime.Now.Month;
            //int dd = DateTime.Now.Day;
            //int hh = DateTime.Now.Hour;
            //int MM = DateTime.Now.Minute;
            //int ss = DateTime.Now.Second;

            //date = ViewData["date"] == null ? string.Empty : ViewData["date"].ToString();
            //date = date.Equals("undefined") ? string.Empty : date;

            //if (Regex.IsMatch(date, "^\\d{10}$"))//日请求数据
            //{
            //    yy = int.Parse(date.Substring(0, 4));
            //    mm = int.Parse(date.Substring(4, 2));
            //    dd = int.Parse(date.Substring(6, 2));
            //}
            //else
            //    if (Regex.IsMatch(date, "^\\d{8}$"))//月请求数据
            //    {
            //        yy = int.Parse(date.Substring(0, 4));
            //        mm = int.Parse(date.Substring(4, 2));
            //    }
            //    else
            //        if (Regex.IsMatch(date, "^\\d{4}$"))//年请求数据
            //        {
            //            yy = int.Parse(date);
            //        }

            //IList<int> years = new List<int>();
            //for (int x = 0; x < chartData.series.Count(); x++)
            //{

            //    string name = chartData.series[x].name;
            //    name = name.Contains('-') ? name.Substring(0, name.LastIndexOf('-')) : name;
            //    if (name.Contains('['))
            //        name = isprocessUnit == false ? name.Substring(0, name.IndexOf('[')) : name;
            //    name = name.Replace("-", " ");
            //    if (Regex.IsMatch(name, "^\\d{4}$"))//多年比较 
            //        years.Add(int.Parse(name));

            //    table.AddCell(new PdfPCell(new Phrase(name, font)));

            //}

            //int y = 0;
            //for (; y < chartData.categories.Count(); y++)
            //{
            //    string dStr = chartData.categories[y];
            //    if (Regex.IsMatch(dStr, "^\\d{2}:\\d{2}/\\d{2}$"))//日请求数据
            //    {
            //        dd = int.Parse(dStr.Substring(6, 2));
            //        hh = int.Parse(dStr.Substring(0, 2));
            //        MM = int.Parse(dStr.Substring(3, 2));
            //    }
            //    else
            //        if (Regex.IsMatch(dStr, "^\\d{2}$"))//月请求数据
            //        {
            //            dd = int.Parse(dStr.Substring(0, 2));
            //        }
            //        else
            //        {
            //            if (Regex.IsMatch(dStr, "^\\d{4}$"))//总请求数据 
            //            {
            //                yy = int.Parse(dStr);
            //            }
            //            else if (Regex.IsMatch(dStr.ToLower(), "^[a-z]*$") || date.Length == 4 || date == string.Empty)
            //            {
            //                mm = y + 1;
            //            }

            //        }
            //    switch (mm)
            //    {
            //        case 2:
            //            dd = dd > 28 ? 28 : dd;
            //            break;
            //        case 4:
            //        case 6:
            //        case 9:
            //        case 11:
            //            dd = dd > 30 ? 30 : dd;
            //            break;
            //    }
            //    DateTime dNow = new DateTime(yy, mm, dd, hh, MM, ss);
            //    table.AddCell(new PdfPCell(new Phrase(dStr, font)));

            //    int index = 0;
            //    while (index++ < chartData.series.Count())
            //    {
            //        if (years.Count > 1)//说明多年比较
            //            dNow = new DateTime(years[index - 1], mm, dd, hh, MM, ss);
            //        table.AddCell(new PdfPCell(new Phrase(chartData.series[index - 1].data[y] == null ? dNow < DateTime.Now ? "None" : string.Empty : ((double)chartData.series[index - 1].data[y]).ToString("0.00"), font)));
            //    }
            //}
            //doc.Add(table);
            //doc.Close();


            //-----------------------pdf 代码结束


            return PartialView("chartdetailhtml", chartData);

        }

        /// <summary>
        /// 获取某电站上年年统计报表
        /// ajax方式
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult UserYearMMChart(int userId, string startYM, string endYM, string chartType)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                string unit = "kWh";
                //取得用户年度发电量图表数据
                ChartData chartData = PlantChartService.GetInstance().YearMMChartBypList(user.plants, startYM, endYM, chartType, unit);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
                ViewData[ComConst.ReportCode] = reportCode;
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 
        /// 取得某个用户所有电站跨小时的功率图表
        /// </summary>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType">图表格式串</param>
        /// <param name="mt">测点串</param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult UserDayChart(int userId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string mts, int intervalMins)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                string deviceId = "";
                foreach (Plant plant in user.plants)
                {
                    deviceId += "," + plant.id;
                }
                string[] chartTypes = chartType.Split(',');
                string[] mtArr = mts.Split(',');
                for (int i = 0; i < mtArr.Length; i++)
                {
                    devices.Add(new DeviceStuct() { deviceId = deviceId, rate = 1.0F, chartType = chartTypes[i], monitorType = MonitorType.getMonitorTypeByCode(int.Parse(mtArr[i])), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = intervalMins });
                }

                string chartName = LanguageUtil.getDesc("PLANT_CHART_DAY_CHART");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 性能比较
        /// 性能=当前功率/设计功率
        /// </summary>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult PerformanceChart(int userId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, int intervalMins)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                float rate = 1.0F;
                Plant plant;
                for (int i = 0; i < user.plants.Count; i++)
                {
                    plant = user.plants[i];
                    rate = 1 / plant.chartPower;
                    if (user.plants.Count <= 2)
                        chartType = ChartType.column;
                    else
                    {
                        chartType = ChartType.line;
                    }
                    devices.Add(new DeviceStuct() { deviceId = plant.id.ToString(), rate = rate, name = plant.name, unit = "kW/kWp", chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_POWER_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = intervalMins });
                }

                string chartName = LanguageUtil.getDesc("PLANT_CHART_PERFORMANCE_COMPARE_CHART");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));

            }
            return Content(reportCode);
        }

        /// <summary>
        /// 各个电站之间日kwp发电量对比
        /// </summary>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult UserPEnergyChart(int userId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, int intervalMins)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                float rate = 1.0F;

                foreach (Plant plant in user.plants)
                {
                    if (user.plants.Count <= 2)
                        chartType = ChartType.column;
                    else
                    {
                        chartType = ChartType.line;
                    }
                    rate = 1 / plant.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = plant.id.ToString(), rate = rate, name = plant.name, unit = "kWh/kWp", chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = intervalMins });
                }

                string chartName = LanguageUtil.getDesc("PLANT_CHART_PERFORMANCE_INVESTMENT_COMPARE_INPLANTS_CHART");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 电站间月投资收益比较
        /// </summary>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UserMonthDDKwpChart(int userId, string startYYYYMMDD, string endYYYYMMDD, string chartType)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (Plant plant in user.plants)
                {
                    if (user.plants.Count <= 2)
                        chartType = ChartType.column;
                    else
                    {
                        chartType = ChartType.line;
                    }
                    string unit = "kWh/kWp";
                    float rate = 1 / plant.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = plant.id.ToString(), rate = rate, name = plant.name, unit = unit, chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT });
                }

                string chartName = LanguageUtil.getDesc("CHART_TITLE_PLANTSMONTHKWPENERGYCOMPARECHART");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareMMDDMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDD, endYYYYMMDD);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 用户多个电站年月kwp比较
        /// </summary>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UserYearMonthKwpChart(int userId, int year, string chartType)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (Plant plant in user.plants)
                {
                    if (user.plants.Count <= 2)
                        chartType = ChartType.column;
                    else
                    {
                        chartType = ChartType.line;
                    }
                    string unit = "kWh/kWp";
                    float rate = 1 / plant.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = plant.id.ToString(), rate = rate, name = plant.name, unit = unit, chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT });
                }

                string startYearMM = year + "01";
                string endYearMM = year + "12";
                string chartName = LanguageUtil.getDesc("CHART_TITLE_PLANTSYEARKWPENERGYCOMPARECHART");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareYearMMMultiDeviceMultiMonitor(chartName, devices, startYearMM, endYearMM);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UserTotalKwpChart(int userId, string startYYYYMMDD, string endYYYYMMDD, string chartType)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                IList<int> tmpyears = collectorYearDataService.GetWorkYears(user.plants);
                IList<string> workYears = new List<string>();
                // int len = 5;
                //if (tmpyears.Count < len)
                //{
                // int MaxYear = tmpyears.Count == 0 ? DateTime.Now.Year : tmpyears[tmpyears.Count - 1];
                //for (int i = 0; i < 5; i++)
                //{
                // tmpyears.Add((MaxYear - (len - i - 1)));
                //}
                // }
                foreach (int year in tmpyears)
                {
                    workYears.Add(year.ToString());
                }

                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (Plant plant in user.plants)
                {
                    //chartType = ChartType.column;
                    string unit = "kWh/kWp";
                    float rate = 1 / plant.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = plant.id.ToString(), rate = rate, name = plant.name, unit = unit, chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT });
                }

                string chartName = LanguageUtil.getDesc("CHART_TITLE_PLANTSTOTALKWPENERGYCOMPARECHART");

                ChartData chartData = CompareChartService.GetInstance().compareYearsMultiDeviceMultiMonitor(chartName, devices, workYears);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 电站日kwp发电量对比
        /// </summary>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult PEnergyChart(int id, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string intervalMins)
        {
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            if (plant != null)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                float rate = 1 / plant.chartPower;
                string[] chartTypes = chartType.Split(',');
                string[] intervalMinArr = intervalMins.Split(',');
                devices.Add(new DeviceStuct() { deviceId = plant.id.ToString(), rate = rate, name = Resources.SunResource.CHART_TITLE_INVEST_INCOME, comareObj = plant.name, unit = "kWh/kWp", chartType = chartTypes[0], monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = int.Parse(intervalMinArr[0]) });
                //如果有光照强度添加关照对比
                Device device = plant.getFirstDetector();
                if (device != null)
                {
                    rate = 1F;
                    Hashtable dataHash = DeviceDayDataService.GetInstance().GetDaydataList(null, device, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervalMinArr[1]), MonitorType.MIC_DETECTOR_SUNLINGHT);
                      if (dataHash.Keys.Count > 0)//有日照数据
                      {
                          MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_SUNLINGHT);
                          devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, comareObj = plant.name, name = mt.name, unit = "", chartType = chartTypes[1], monitorType = mt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = int.Parse(intervalMinArr[1]) });
                      }
                }

                string chartName = LanguageUtil.getDesc("PLANT_CHART_PERFORMANCE_INVESTMENT_COMPARE_CHART");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervalMinArr[0]));
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            FillPlantYears(id);
            return Content(reportCode);
        }

        /// <summary>
        /// 取得某个电站的年度发电量图表
        /// ajax方式
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public ActionResult PlantYearMMChart(int id, int year, string chartType)
        {
            string reportCode = string.Empty;
            if (id > 0)
            {
                string unit = "kWh";// DeviceData.getMonitorItemByCode(monitorCode).Units[0];
                Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
                ChartData chartData = PlantChartService.GetInstance().YearMMChartByPlant(plant, year, chartType, unit);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            FillPlantYears(id);
            return Content(reportCode);
        }

        /// <summary>
        /// 年月投资收益
        /// </summary>
        /// <param name="id"></param>
        /// <param name="year"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult PlantYearMMKwpChart(int id, int year, string chartType)
        {
            string reportCode = string.Empty;
            if (id > 0)
            {
                string unit = "kWh/kWp";// DeviceData.getMonitorItemByCode(monitorCode).Units[0];
                Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
                float rate = 1 / plant.chartPower;
                string startYearMM = year + "01";
                string endYearMM = year + "12";
                string chartName = LanguageUtil.getDesc("CHART_TITLE_YEARLYKWPENERGYCHART");

                ChartData chartData = PlantChartService.GetInstance().YearMMChartBypList(new List<Plant>() { plant }, rate, chartName, LanguageUtil.getDesc("CHART_TITLE_INVEST_INCOME"), startYearMM, endYearMM, chartType, unit);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            FillPlantYears(id);
            return Content(reportCode);
        }

        /// <summary>
        /// 取得某个电站的所有工作年份发电量比较图表
        /// </summary>
        /// <param name="id"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UserYearCompare(int userId, string chartType)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user.plants.Count > 0)
            {
                IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(user.plants);
                if (workYears.Count == 0)
                {
                    reportCode = "error:" + LanguageUtil.getDesc("PLANT_CHART_REPORTCODE_NO_WORK_YEAR");
                    return Content(reportCode);
                }
                if (workYears.Count <= 2) chartType = ChartType.column;
                MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = mt.getMonitorFirstUnitByCode();

                ChartData chartData = CompareChartService.GetInstance().PlantYearCompare(user.plants, workYears, Resources.SunResource.DEVICEMONITORITEM_11, mt, unit, chartType, 1.0F);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                reportCode = "error:" + LanguageUtil.getDesc("NODATA");
                return Content(reportCode);
            }
            return Content(reportCode);
        }


        /// <summary>
        /// 用户所有电站月天发电量比较
        /// </summary>
        /// <param name="mm"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UserMonthDDCompare(int userId, int mm, string chartType)
        {
            string reportCode = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            IList<string> yyyymms = new List<string>();
            if (user.plants.Count > 0)
            {
                IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(user.plants);
                if (workYears.Count == 0)
                {
                    reportCode = "error:" + LanguageUtil.getDesc("PLANT_CHART_REPORTCODE_NO_WORK_YEAR");
                    return Content(reportCode);
                }
                if (workYears.Count <= 2) chartType = ChartType.column;
                foreach (int year in workYears)
                {
                    yyyymms.Add(year + mm.ToString("00"));
                }
                MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = mt.getMonitorFirstUnitByCode();

                ChartData chartData = CompareChartService.GetInstance().PlantMMCompare(user.plants, yyyymms, Resources.SunResource.DEVICEMONITORITEM_11, mt, unit, chartType, 1.0F);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }


        /// <summary>
        /// 取得某个电站的所有工作年份发电量比较图表
        /// </summary>
        /// <param name="id"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult PlantYearCompare(int id, string chartType)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            float rate = 1.0F;
            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
            string unit = mt.getMonitorFirstUnitByCode();
            FillPlantYears(id);
            return PlantYearCompareChart(plant, chartType, mt.name, mt, unit, rate);
        }


        /// <summary>
        /// 取得某个电站的所有工作年份发电量比较图表
        /// </summary>
        /// <param name="id"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult PlantMonthCompare(int id, int mm, string chartType)
        {
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            IList<string> yyyymms = new List<string>();
            if (plant != null)
            {
                IList<Plant> plants = new List<Plant>() { plant };
                IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(plants);
                if (workYears.Count == 0)
                {
                    reportCode = "error:" + LanguageUtil.getDesc("PLANT_CHART_REPORTCODE_NO_DATA");
                    return Content(reportCode);
                }
                if (workYears.Count <= 2) chartType = ChartType.column;
                foreach (int year in workYears)
                {
                    yyyymms.Add(year + mm.ToString("00"));
                }
                MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = mt.getMonitorFirstUnitByCode();

                ChartData chartData = CompareChartService.GetInstance().PlantMMCompare(plants, yyyymms, Resources.SunResource.DEVICEMONITORITEM_11, mt, unit, chartType, 1.0F);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            FillPlantYears(id);
            return Content(reportCode);
        }

        /// <summary>
        /// 生成电站多年 月kWp发电量对比
        /// </summary>
        /// <param name="id"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult PlantYearPCompareChart(int id, string chartType)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            float rate = 1 / plant.chartPower;
            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
            string unit = "kWh/kWp";
            FillPlantYears(id);
            return PlantYearCompareChart(plant, chartType, Resources.SunResource.CHART_TITLE_INVEST_INCOME, mt, unit, rate);
        }

        /// <summary>
        /// 生成电站多年 月kWp发电量对比
        /// </summary>
        /// <param name="id"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        private ActionResult PlantYearCompareChart(Plant plant, string chartType, string name, MonitorType mt, string unit, float rate)
        {
            string reportCode = string.Empty;
            if (plant != null)
            {
                IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(plant);
                if (workYears.Count <= 2) chartType = ChartType.column;
                if (workYears.Count == 0)
                {
                    reportCode = "error:" + LanguageUtil.getDesc("PLANT_CHART_NOWORK_YEAR");
                    return Content(reportCode);
                }
                ChartData chartData = CompareChartService.GetInstance().PlantYearCompare(new List<Plant>() { plant }, workYears, name, mt, unit, chartType, rate);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站Id和年份获得当年的发电量报表
        /// 创建时间：2011-02-25
        /// </summary>
        /// <param name="id"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public ActionResult PlantMonthDDChart(int id, string startYYYYMMDD, string endYYYYMMDD, string chartType)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            string reportCode = string.Empty;
            if (plant != null)
            {
                string unit = "kWh";// DeviceData.getMonitorItemByCode(monitorCode).Units[0];
                ChartData chartData = PlantChartService.GetInstance().MMDDChartBypList(new List<Plant> { plant }, startYYYYMMDD, endYYYYMMDD, chartType, unit);
                //chartData.series[0].data[3] = 23;
                //chartData.series[0].data[4] = 236567;
                //chartData.series[0].max = 236567;
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            FillPlantYears(id);
            return Content(reportCode);
        }


        /// <summary>
        /// 电站月天投资收益
        /// </summary>
        /// <param name="id"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult PlantMonthDDKwpChart(int id, string startYYYYMMDD, string endYYYYMMDD, string chartType)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            string reportCode = string.Empty;
            if (plant != null)
            {
                string unit = "kWh/kWp";
                float rate = 1 / plant.chartPower;
                ChartData chartData = PlantChartService.GetInstance().MonthDDChartBypList(new List<Plant>() { plant }, rate, LanguageUtil.getDesc("CHART_TITLE_MONTHKWPENERGYCHART"), LanguageUtil.getDesc("CHART_TITLE_INVEST_INCOME"), startYYYYMMDD, endYYYYMMDD, chartType, unit);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            FillPlantYears(id);
            return Content(reportCode);
        }

        /// <summary>
        /// 取得某个电站日数据
        /// </summary>
        /// <param name="?"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult PlantDayChart(int pid, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, int intervalMins)
        {
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            if (plant != null && plant.plantUnits.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                string deviceId = plant.id.ToString();
                string[] chartTypes = chartType.Split(',');
                devices.Add(new DeviceStuct() { deviceId = deviceId, rate = 1.0F, comareObj = plant.name, chartType = ChartType.area, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_POWER_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = intervalMins });
                //判断该测点是否有数据,有数据则增加关照对比
                Hashtable dataHash = CollectorDayDataService.GetInstance().GetUnitDaydataList(plant.plantUnits, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, MonitorType.PLANT_MONITORITEM_POWER_CODE);
                if (dataHash.Count > 0)
                {
                    Device device = plant.getFirstDetector();
                    if (device != null)
                    {
                        dataHash = DeviceDayDataService.GetInstance().GetDaydataList(null, device, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, MonitorType.MIC_DETECTOR_SUNLINGHT);
                          if (dataHash.Keys.Count > 0)//有日照数据
                          {
                              float rate = 1F;
                              MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_SUNLINGHT);
                              devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, comareObj = plant.name, name = mt.name, unit = "", chartType = ChartType.line, monitorType = mt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = intervalMins });
                          }
                    }
                }
                else
                {
                    return Content("error:" + Resources.SunResource.NODATA);
                }
                string chartName = LanguageUtil.getDesc("PLANT_CHART_DAY_CHART");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins);
                //ChartData chartData_large = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, 60);

                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            FillPlantYears(pid);
            return Content(reportCode);
        }


        /// <summary>
        /// 取得某个电站日数据
        /// </summary>
        /// <param name="?"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult PlantDayPowerSunCompare(int pid, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string intervalMins)
        {
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);

            string[] intervals = intervalMins.Split(',');
            if (plant != null && plant.plantUnits.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                string deviceId = plant.id.ToString();
                string[] chartTypes = chartType.Split(',');
                devices.Add(new DeviceStuct() { deviceId = deviceId, rate = 1.0F, comareObj = plant.name, chartType = chartTypes[0], monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_POWER_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = int.Parse(intervals[0]) });

                //判断该测点是否有数据,有数据则增加关照对比
                Hashtable dataHash = CollectorDayDataService.GetInstance().GetUnitDaydataList(plant.plantUnits, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]), MonitorType.PLANT_MONITORITEM_POWER_CODE);
                if (dataHash.Count > 0)
                {
                      Device device = plant.getFirstDetector();
                      if (device != null)
                      {
                            dataHash = DeviceDayDataService.GetInstance().GetDaydataList(null, device, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]), MonitorType.MIC_DETECTOR_SUNLINGHT);
                            if (dataHash.Keys.Count > 0)//有日照数据
                            {
                                float rate = 1F;
                                MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_SUNLINGHT);
                                devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, comareObj = plant.name, name = mt.name, unit = "", chartType = chartTypes[0], monitorType = mt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = int.Parse(intervals[1]) });
                            }
                      }
                }
                else
                {
                    return Content("error:" + Resources.SunResource.NODATA);
                }

                string chartName = LanguageUtil.getDesc("PLANT_CHART_DAY_POWER_SUNLIGHT_COMPARE_CHART");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]));
                //ChartData chartData2 = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, 60);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            FillPlantYears(pid);
            return Content(reportCode);
        }

        public ActionResult PlantDayEnergySunCompare(int pid, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string intervalMins)
        {
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            if (plant != null && plant.plantUnits.Count > 0)
            {
                string[] intervals = intervalMins.Split(',');
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                string deviceId = plant.id.ToString();
                string[] chartTypes = chartType.Split(',');
                devices.Add(new DeviceStuct() { deviceId = deviceId, rate = 1.0F, comareObj = plant.name, chartType = chartTypes[0], monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = int.Parse(intervals[0]) });
                //判断该测点是否有数据,有数据则增加关照对比
                Hashtable dataHash = CollectorDayDataService.GetInstance().GetUnitDaydataList(plant.plantUnits, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]), MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                if (dataHash.Count > 0)
                {
                      Device device = plant.getFirstDetector();
                      if (device != null)
                      {
                          dataHash = DeviceDayDataService.GetInstance().GetDaydataList(null, device, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]), MonitorType.MIC_DETECTOR_SUNLINGHT);
                          if (dataHash.Keys.Count > 0)//有日照数据
                          {
                              float rate = 1F;
                              MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_SUNLINGHT);
                              devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, comareObj = plant.name, name = mt.name, unit = "", chartType = chartTypes[0], monitorType = mt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = int.Parse(intervals[1]) });
                          }
                      }
                }
                else
                {
                    return Content("error:" + Resources.SunResource.NODATA);
                }

                string chartName = LanguageUtil.getDesc("PLANT_CHART_DAY_ENERGY_SOLAR_INTENSITY");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]));
                //TempDataUtil.putChartData(chartData.serieNo, chartData);
                //再取一个整点的间隔数据
                //ChartData chartData2 = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, 60);

                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            FillPlantYears(pid);
            return Content(reportCode);
        }

        /// <summary>
        /// 电站下多个单元的日kwp发电量对比
        /// </summary>
        /// <param name="pId">电站id</param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult CompareDaykWpChartByPlant(int pId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, int intervalMins)
        {
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            IList<PlantUnit> unitList = plant.plantUnits;

            if (unitList != null && unitList.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (PlantUnit unit in unitList)
                {
                    float rate = 1 / unit.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = unit.collectorID.ToString(), rate = rate, name = unit.displayname, unit = "kWh/kWp", chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.COLLECTOR, intervalMins = intervalMins });
                }

                string chartName = LanguageUtil.getDesc("UNITDAYLY_INVEST_INCOME_COMPARE_CHART_NAME");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, ComputeType.Avg);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                reportCode = "error:" + Resources.SunResource.CHART_TIP_NODEVICES;
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 电站下多个单元月kwp发电量对比
        /// </summary>
        /// <param name="pId">电站id</param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult CompareMonthkWpChartByPlant(int pId, string startYYYYMMDD, string endYYYYMMDD, string chartType)
        {
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            IList<PlantUnit> unitList = plant.plantUnits;

            if (unitList != null && unitList.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (PlantUnit unit in unitList)
                {
                    float rate = 1 / unit.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = unit.id.ToString(), rate = rate, name = unit.displayname, unit = "kWh/kWp", chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.UNIT });
                }

                string chartName = LanguageUtil.getDesc("UNITMONTHLY_INVEST_INCOME_COMPARE_CHART_NAME");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareMMDDMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDD, endYYYYMMDD, ComputeType.Avg);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                reportCode = "error:" + Resources.SunResource.CHART_TIP_NODEVICES;
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 电站下多个单元年kwp发电量对比
        /// </summary>
        /// <param name="pId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult CompareYearkWpChartByPlant(int pId, string startYYYYMM, string endYYYYMM, string chartType)
        {
            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            IList<PlantUnit> unitList = plant.plantUnits;

            if (unitList != null && unitList.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (PlantUnit unit in unitList)
                {
                    float rate = 1 / unit.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = unit.id.ToString(), rate = rate, name = unit.displayname, unit = "kWh/kWp", chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.UNIT });
                }

                string chartName = LanguageUtil.getDesc("UNITYEARLY_INVEST_INCOME_COMPARE_CHART_NAME");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareYearMMMultiDeviceMultiMonitor(chartName, devices, startYYYYMM, endYYYYMM, ComputeType.Avg);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                reportCode = "error:" + Resources.SunResource.CHART_TIP_NODEVICES;
            }
            return Content(reportCode);
        }


        /// <summary>
        /// 加载功率发电量图表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult DayCompare(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            FillPlantYears(id);
            return View(plant);
        }

        /// <summary>
        /// 加载某个电站发电量年度比较图表页面
        /// 废弃
        /// </summary>
        /// <returns></returns>
        public ActionResult EnergyYearCompare(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(plant);
            //获得该电站的运营时间
            ViewData[ComConst.WorkYears] = workYears;
            FillPlantYears(id);
            return View(plant);
        }

        /// <summary>
        /// 加载某个电站发电量月度比较图表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult EnergyMonthCompare(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            FillPlantYears(id);
            return View(plant);
        }

        /// <summary>
        /// 加载电站日每KWP发电量柱状图页面
        /// </summary>
        /// <returns></returns>
        public ActionResult PlantDayPEnergyPage(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            FillPlantYears(id);
            return View(plant);
        }
        /// <summary>
        /// 电站多年每月每KWP发电量柱状对比图页面
        /// 废弃
        /// </summary>
        /// <returns></returns>
        public ActionResult PEnergyYearComparePage(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            base.FillPlantYears(id);
            return View(plant);
        }

        /// <summary>
        /// 电站多年每月每KWP发电量柱状对比图页面
        /// 加载某个电站发电量年度比较图表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult YearComparePage(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            FillPlantYears(id);
            return View(plant);
        }

        /// <summary>
        /// 加载单元间比较页面
        /// </summary>
        /// <returns></returns>
        public ActionResult UnitComparePage(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);

            FillPlantYears(id);
            return View(plant);
        }


        public ActionResult PRChart(int pid)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);

            string startYM = (DateTime.Now.Year - 1) + "" + DateTime.Now.Month.ToString("00");
            string endYM = DateTime.Now.Year + "" + DateTime.Now.Month.ToString("00");

            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);

            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);

            ViewData["plantYear"] = plantYearsList;

            return View(plant);
        }

        [HttpPost]
        public ActionResult PRYearChart(int pId)
        {
            String reportCode = "";
            if (pId > 0)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
                ChartData chartData = PlantChartService.GetInstance().YearPRChartBypList(new List<Plant>() { plant }, LanguageUtil.getDesc("TOTAL_PR_PERFORMANCE_CHART_NAME"), ChartType.column);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("Error:");
            }

            return Content(reportCode);
        }

        /// <summary>
        /// 电站月天rp性能图
        /// </summary>
        /// <param name="pId"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult PRMonthDDChart(int pId, string startYYYYMMDD, string endYYYYMMDD)
        {
            String reportCode = "";
            if (pId > 0)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
                ChartData chartData = PlantChartService.GetInstance().MonthDDRPChartBypList(new List<Plant>() { plant }, LanguageUtil.getDesc("MONTHLY_PR_PERFORMANCE_CHART_NAME"), startYYYYMMDD, endYYYYMMDD, ChartType.column);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("Error:");
            }

            return Content(reportCode);
        }

        [HttpPost]
        public ActionResult PRYearMMChart(int pId, int year)
        {
            String reportCode = "";
            if (pId > 0)
            {
                string startYearMM = year + "01";
                string endYearMM = year + "12";
                Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
                ChartData chartData = PlantChartService.GetInstance().yearMonthRPChartBypList(new List<Plant>() { plant }, LanguageUtil.getDesc("YEARLY_PR_PERFORMANCE_CHART_NAME"), startYearMM, endYearMM, ChartType.column);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("Error:");
            }

            return Content(reportCode);
        }

     
    }
}
