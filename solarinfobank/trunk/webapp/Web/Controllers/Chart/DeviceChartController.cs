using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Collections;
using System.Text;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    /// <summary>
    /// 设备图表
    /// </summary>  
    public class DeviceChartController : BaseController
    {
        //
        // GET: /ReportTest/
        CollectorYearDataService collectorYearDataService = CollectorYearDataService.GetInstance();

        public ActionResult Index(int id)
        {
            return View();
        }
        public void FillPlantYears(string plantId)
        {
            Plant plant = FindPlant(int.Parse(plantId));
            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);
            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData["plantYear"] = plantYearsList;
        }

        /// <summary>
        /// 单个设备的年月发电量图表数据
        /// </summary>
        /// <param name="userId">用户id</param>
        /// <param name="startYM">开始年月</param>
        /// <param name="endYM">截止年月</param>
        /// <param name="chartType">图表类型</param>
        /// <returns></returns>
        public ActionResult DeviceYearMMChart(int dId, string startYM, string endYM, string chartType)
        {
            string reportData = string.Empty;
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            if (device != null)
            {
                string unit = "kWh";
                //取得用户年度发电量图表数据
                ChartData chartData = DeviceChartService.GetInstance().YearMMChartByDevice(device, 1.0F, string.Format(LanguageUtil.getDesc("DEVICEYEAR_CHART_NAME"), device.fullName), startYM, endYM, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportData);
        }


        /// <summary>
        /// 单个设备的图表数据
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult DeviceYearChart(int dId, string chartType)
        {
            string reportData = string.Empty;
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            if (device != null)
            {
                string unit = "kWh";
                ChartData chartData = DeviceChartService.GetInstance().YearChartByDevice(device, 1.0F, string.Format(LanguageUtil.getDesc("DEVICETOTALCHART_NAME"), device.fullName), chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 设备的月天数据
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult DeviceMonthDayChart(int dId, string startYYYYMMDD, string endYYYYMMDD, string chartType)
        {
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            string reportData = string.Empty;
            if (device != null)
            {
                string unit = "kWh";
                ChartData chartData = DeviceChartService.GetInstance().MonthDDChartByDevice(device, 1.0F, string.Format(LanguageUtil.getDesc("DEVICEMONTHCHART_NAME"), device.fullName), startYYYYMMDD, endYYYYMMDD, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(ChartData));

            }
            return Content(reportData);
        }

        /// <summary>
        /// 取得设备某个测点的日变化曲线
        /// </summary>
        /// <param name="dId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public ActionResult MonitorDayChart(int dId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, int monitorCode, int intervalMins)
        {
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            //获得报表js代码
            MonitorType mt = MonitorType.getMonitorTypeByCode(monitorCode);
            string unit = mt.getMonitorFirstUnitByCode();
            string chartName = string.Format(LanguageUtil.getDesc("MONITOR_DAY_CHAR_NAME"), mt.name);
            string reportCode = string.Empty;

            if (device != null)
            {
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetInstance().DayChart(device, chartName, startYYYYMMDDHH, endYYYYMMDDHH, chartType, unit, monitorCode, intervalMins);
                reportCode = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 比较设备的不同测点的日数据，测点根据设备类型指定
        /// 逆变器为：功率、发电量、光照强度
        /// 汇流箱为：
        /// 环境检测仪为：
        /// </summary>
        /// <param name="dId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult CompareDayChart(int dId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string intervalMins)
        {
            string monitorCodes = "";
            Device device = DeviceService.GetInstance().get(dId);
            if (device.deviceTypeCode == DeviceData.INVERTER_CODE)
            {
                return CompareDayChartWithSun(dId, startYYYYMMDDHH, endYYYYMMDDHH, chartType, intervalMins);
            }
            else if (device.deviceTypeCode == DeviceData.HUILIUXIANG_CODE)
            {
                monitorCodes = MonitorType.MIC_BUSBAR_TOTALCURRENT.ToString();
            }
            else if (device.deviceTypeCode == DeviceData.CABINET_CODE)
            {
                monitorCodes = MonitorType.MIC_BUSBAR_TOTALCURRENT.ToString();
            }
            else if (device.deviceTypeCode == DeviceData.AMMETER_CODE)
            {
                monitorCodes = MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE.ToString();
            }
            else
            {
                monitorCodes = MonitorType.MIC_DETECTOR_SUNLINGHT.ToString();
            }

            return this.CompareDayByMonitor(dId, startYYYYMMDDHH, endYYYYMMDDHH, chartType, monitorCodes, int.Parse(intervalMins));
        }

        /// <summary>
        /// 电站日功率和关照对比
        /// </summary>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        private ActionResult CompareDayChartWithSun(int dId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string intervalMins)
        {
            string reportCode = string.Empty;
            Device device = DeviceService.GetInstance().get(dId);

            if (device != null)
            {
                string[] intervals = intervalMins.Split(',');
                string[] chartTypes = chartType.Split(',');
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                float rate = 1.0F;
                MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TOTALYGPOWER);
                devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, comareObj = device.fullName, name = "", unit = "", chartType = chartTypes[0], monitorType = mt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = int.Parse(intervals[0]) });
                //判断该测点是否有数据,有数据则增加关照对比
                Hashtable dataHash = DeviceDayDataService.GetInstance().GetDaydataList(device, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]), mt.code);
                if (dataHash.Count > 0)
                {
                    rate = 1F;
                    MonitorType smt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_LINGT_CODE);
                    devices.Add(new DeviceStuct() { deviceId = device.collectorID.ToString(), rate = rate, comareObj = device.fullName, name = smt.name, unit = "", chartType = chartTypes[1], monitorType = smt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.COLLECTOR, intervalMins = int.Parse(intervals[1]) });
                }
                else
                {
                    return Content("error:" + Resources.SunResource.NODATA);
                }

                string chartName = LanguageUtil.getDesc("DAY_COMPARE_CHART_NAME");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]));
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
        public ActionResult CompareDaykWpChart(int dId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string intervalMins)
        {
            string reportCode = string.Empty;
            Device device = DeviceService.GetInstance().get(dId);
            if (device != null)
            {
                string[] intervals = intervalMins.Split(',');
                string[] chartTypes = chartType.Split(',');
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                float rate = 1 / device.chartPower;
                MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TODAYENERGY);
                devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, comareObj = device.fullName, name = "kWp" + mt.name, unit = "kWh/kWp", chartType = chartTypes[0], monitorType = mt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = int.Parse(intervals[0]) });
                //判断改测点是否有数据
                Hashtable dataHash = DeviceDayDataService.GetInstance().GetDaydataList(device, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]), mt.code);
                if (dataHash.Count > 0)
                {
                    rate = 1F;
                    MonitorType smt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_LINGT_CODE);
                    devices.Add(new DeviceStuct() { deviceId = device.collectorID.ToString(), rate = rate, comareObj = device.fullName, name = smt.name, unit = "", chartType = chartTypes[1], monitorType = smt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.COLLECTOR, intervalMins = int.Parse(intervals[1]) });
                }
                else
                {
                    return Content("error:" + Resources.SunResource.NODATA);
                }

                string chartName = LanguageUtil.getDesc("INVEST_INCOME_COMPARE_CHART");
                //取得用户年度发电量图表数据
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, int.Parse(intervals[0]));
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }


        /// <summary>
        /// 比较一个设备的多个测点的日数据
        /// </summary>
        /// <param name="dId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="monitorCodes">多个测点之间用逗号分隔</param>
        /// <returns></returns>
        public ActionResult CompareDayByMonitor(int dId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string monitorCodes, int intervalMins)
        {
            string reportCode = string.Empty;
            Device device = DeviceService.GetInstance().get(dId);

            IList<MonitorType> monitorTypes = new List<MonitorType>();
            string[] monitorArr = monitorCodes.Split(',');
            IList<DeviceStuct> devices = new List<DeviceStuct>();
            string[] chartTypes = chartType.Split(',');
            string chartName = string.Empty;
            for (int i = 0; i < monitorArr.Length; i++)
            {
                MonitorType monitorType = MonitorType.getMonitorTypeByCode(int.Parse(monitorArr[i]));
                devices.Add(new DeviceStuct() { deviceId = dId.ToString(), rate = 1.0F, comareObj = device.fullName, chartType = chartTypes[i], monitorType = monitorType, cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = intervalMins });
                chartName += monitorType.name + "&";
            }
            chartName = chartName.Length > 1 ? chartName.Substring(0, chartName.Length - 1) : chartName;

            if (device != null)
            {
                // string chartName = LanguageUtil.getDesc("CHART_DAY_CHART");
                ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            return Content(reportCode);
        }


        /// <summary>
        /// 单元下多个汇流箱日总电流对比
        /// </summary>
        /// <param name="uId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult CompareDayCurrentChartByUnit(int uId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, int intervalMins)
        {
            string reportCode = string.Empty;
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(uId);
            IList<Device> deviceList = unit.displayDevices;
            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_BUSBAR_TOTALCURRENT);
            if (deviceList != null && deviceList.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (Device device in deviceList)
                {
                    if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;
                    float rate = 1.0F;
                    devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, name = device.fullName, unit = mt.unit, chartType = chartType, monitorType = mt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = intervalMins });
                }

                string chartName = LanguageUtil.getDesc("DEVICE_DAY_TOTALCURRENT_COMPARE");
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
        /// 单元下多个逆变器日kwp发电量对比
        /// </summary>
        /// <param name="uId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult CompareDaykWpChartByUnit(int uId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, int intervalMins)
        {
            string reportCode = string.Empty;
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(uId);
            IList<Device> deviceList = unit.displayDevices;

            if (deviceList != null && deviceList.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (Device device in deviceList)
                {
                    if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;
                    float rate = 1 / device.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, name = device.fullName, unit = "kWh/kWp", chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TODAYENERGY), cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE, intervalMins = intervalMins });
                }

                string chartName = LanguageUtil.getDesc("MONTHLY_INVEST_INCOME_COMPARE_CHART_NAME");
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
        /// 单元下多个逆变器月kwp发电量对比
        /// </summary>
        /// <param name="uId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult CompareMonthkWpChartByUnit(int uId, string startYYYYMMDD, string endYYYYMMDD, string chartType)
        {
            string reportCode = string.Empty;
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(uId);
            IList<Device> deviceList = unit.displayDevices;

            if (deviceList != null && deviceList.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (Device device in deviceList)
                {
                    if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;
                    float rate = 1 / device.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, name = device.fullName, unit = "kWh/kWp", chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TODAYENERGY), cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE });
                }

                string chartName = LanguageUtil.getDesc("MONTHLY_INVEST_INCOME_COMPARE_CHART_NAME");
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
        /// 单元下多个逆变器年kwp发电量对比
        /// </summary>
        /// <param name="uId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="intervalMins"></param>
        /// <returns></returns>
        public ActionResult CompareYearkWpChartByUnit(int uId, string startYYYYMM, string endYYYYMM, string chartType)
        {
            string reportCode = string.Empty;
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(uId);
            IList<Device> deviceList = unit.displayDevices;

            if (deviceList != null && deviceList.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                foreach (Device device in deviceList)
                {
                    if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;
                    float rate = 1 / device.chartPower;
                    devices.Add(new DeviceStuct() { deviceId = device.id.ToString(), rate = rate, name = device.fullName, unit = "kWh/kWp", chartType = chartType, monitorType = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TODAYENERGY), cVal = ComputeType.Avg, deviceType = ChartDeviceType.DEVICE });
                }

                string chartName = LanguageUtil.getDesc("YEARLY_INVEST_INCOME_COMPARE_CHART_NAME");
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
        /// 加载图表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Chart(int pId, int dId)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            Device device = DeviceService.GetInstance().get(dId);
            ViewData["device"] = device;
            ViewData["Plant"] = plant;
            FillPlantYears(pId.ToString());
            if (device.deviceTypeCode == DeviceData.INVERTER_CODE)
            {
                return View(@"InverterChart", plant);
            }
            else if (device.deviceTypeCode == DeviceData.HUILIUXIANG_CODE)
            {
                return View(@"HlxChart", plant);
            }
            else if (device.deviceTypeCode == DeviceData.CABINET_CODE)
            {
                return View(@"CabinetChart", plant);
            }
            else if (device.deviceTypeCode == DeviceData.AMMETER_CODE)
            {
                return View(@"AmmeterChart", plant);
            }
            else
            {
                return View(@"DetectorChart", plant);
            }
        }

        /// <summary>
        /// 加载PR图表页面
        /// </summary>
        /// <returns></returns>
        public ActionResult PRChart(int pId, int dId)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            Device device = DeviceService.GetInstance().get(dId);
            ViewData["device"] = device;
            ViewData["Plant"] = plant;
            FillPlantYears(pId.ToString());
            return View(@"InverterPRChart", plant);

        }

        /// <summary>
        /// 加载逆变器比较页面
        /// </summary>
        /// <returns></returns>
        public ActionResult InverterComparePage(int id)
        {
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(id);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(unit.plantID);
            ViewData["hashlx"] = false;

            foreach (Device dce in unit.devices)
            {
                if (dce.deviceTypeCode == DeviceData.HUILIUXIANG_CODE)
                {
                    ViewData["hashlx"] = true;
                    break;
                }
            }
            ViewData["plantUnit"] = unit;
            FillPlantYears(plant.id.ToString());
            return View(plant);
        }
        /// <summary>
        /// 加载汇流箱比较页面
        /// </summary>
        /// <returns></returns>
        public ActionResult HlxComparePage(int id)
        {
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(id);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(unit.plantID);
            ViewData["plantUnit"] = unit;
            FillPlantYears(plant.id.ToString());
            return View(plant);
        }

        [HttpPost]
        public ActionResult PRYearChart(int dId, int pId)
        {
            String reportCode = "";
            if (dId > 0)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
                Device invertDevice = DeviceService.GetInstance().get(dId);
                //取得环境监测仪
                Device detetorDevice = plant.getDetectorWithRenderSunshine();

                ChartData chartData = DeviceChartService.GetInstance().YearPRChartBypList(invertDevice, detetorDevice, LanguageUtil.getDesc("TOTAL_PR_PERFORMANCE_CHART_NAME"), ChartType.column);
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
        public ActionResult PRMonthDDChart(int dId, int pId, string startYYYYMMDD, string endYYYYMMDD)
        {
            String reportCode = "";
            if (dId > 0)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
                Device invertDevice = DeviceService.GetInstance().get(dId);
                //取得环境监测仪
                Device detetorDevice = plant.getDetectorWithRenderSunshine();
                ChartData chartData = DeviceChartService.GetInstance().MonthDDRPChartBypList(invertDevice, detetorDevice, LanguageUtil.getDesc("MONTHLY_PR_PERFORMANCE_CHART_NAME"), startYYYYMMDD, endYYYYMMDD, ChartType.column);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("Error:");
            }

            return Content(reportCode);
        }

        [HttpPost]
        public ActionResult PRYearMMChart(int dId, int pId, int year)
        {
            String reportCode = "";
            if (dId > 0)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
                Device invertDevice = DeviceService.GetInstance().get(dId);
                //取得环境监测仪
                Device detetorDevice = plant.getDetectorWithRenderSunshine();
                string startYearMM = year + "01";
                string endYearMM = year + "12";
                ChartData chartData = DeviceChartService.GetInstance().yearMonthRPChartBypList(invertDevice, detetorDevice, LanguageUtil.getDesc("YEARLY_PR_PERFORMANCE_CHART_NAME"), startYearMM, endYearMM, ChartType.column);
                reportCode = JsonUtil.convertToJson(chartData, typeof(ChartData));
            }
            else
            {
                return Content("Error:");
            }

            return Content(reportCode);
        }



        /// <summary>
        /// 加载逆变器比较页面
        /// </summary>
        /// <returns></returns>
        public ActionResult UdeviceChart(int id)
        {
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(id);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(unit.plantID);
            ViewData["plantUnit"] = unit;
            FillPlantYears(plant.id.ToString());
            return View(plant);
        }

        public ActionResult unitDevice(int uid)
        {
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(uid);
            StringBuilder html = new StringBuilder();
            html.Append("<select id='dces' name='dces' onchange='deviceChartInit()' style='width:150px'>");
            html.AppendFormat("<option value='{0}'>{1}</option>", -1, unit.displayname);
            foreach (var item in unit.displayDevices)
                if (item.isFault())
                    html.AppendFormat("<option value='{0}'  style='padding-left:15px; color:red;'>{1}</option>", item.id, item.fullName);
                else
                    html.AppendFormat("<option value='{0}'  style='padding-left:15px;'>{1}</option>", item.id, item.fullName);
            html.Append("</select>");
            return Content(html.ToString());
        }

    }
}
