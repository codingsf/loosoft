using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Service.vo;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text.RegularExpressions;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using System.Threading;
using System.Configuration;
using System.Globalization;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    /// <summary>
    /// 功能：为安卓 app应用提供各种接口
    /// 19日及以后的改 3.2号同步于主干
    /// 作者：钱厚兵
    /// 时间：2011年3月24日 16:31:48
    /// </summary>
    public class AappController : BaseAppController
    {

        /// <summary>
        /// 登录验证
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public ActionResult loginvalid(string username, string password, string lan)
        {
            //将就点demo账号，转为新的，以便兼容就的demo账号
            if (username!=null && UserUtil.olddemousername.Equals(username))
            {
                username = UserUtil.demousername;
            }

            setlan(lan);

            string data;
            User user = UserService.GetInstance().GetUserByName(username);
            if (user == null)
            {
                AppError appError = new AppError(AppError.usernameOrpasswordError, "Username don`t existed");
                data = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            else
            {
                if (!user.depassword.Equals(password))
                {
                    AppError appError = new AppError(AppError.usernameOrpasswordError, "Username or password error");
                    data = JsonUtil.convertToJson(appError, typeof(AppError));
                }
                else
                {
                    MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                    MonitorType powerMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_POWER_CODE);
                    UserPlantVO userPlantVO = new UserPlantVO();
                    userPlantVO.totalEnergy = user.upTotalEnergy;
                    userPlantVO.totalEnergyUnit = user.TotalEnergyUnit;
                    userPlantVO.todayEnergy = user.upTotalDayEnergy;
                    userPlantVO.todayEnergyUnit = user.TotalDayEnergyUnit;
                    userPlantVO.userId = user.id;
                    userPlantVO.username = user.username;
                    userPlantVO.co2Reduction = user.TotalReductiong;
                    userPlantVO.co2ReductionUnit = user.TotalReductiongUnit;
                    userPlantVO.revenue = Math.Round(user.revenue, 2);
                    userPlantVO.revenueUnit = user.currencies;
                    userPlantVO.power = user.upTotalPower;
                    userPlantVO.powerUnit = user.TotalPowerUnit;
                    userPlantVO.families = user.TotalFamilies.ToString();
                    IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(user.plants);
                    userPlantVO.warnNums = FaultService.GetInstance().getNewLogNums(user.plants, workYears);
                    userPlantVO.plants = convertToSPlantVOs(user.plants);

                    data = JsonUtil.convertToJson(userPlantVO, typeof(UserPlantVO));
                }
            }
            return Content(data);
        }

        /// <summary>
        /// 用户所要电站的月天图标数据
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public ActionResult AllPlantMonthDayChart(int userId, string startYYYYMMDD, string endYYYYMMDD, string chartType, string lan)
        {
            setlan(lan);

            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            string reportData = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                //取得用户年度发电量图表数据
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetAppInstance().MMDDChartBypList(user.plants, startYYYYMMDD, endYYYYMMDD, chartType, unit);
                //if (chartData.series.Length > 0)
                //{
                    //if (chartData.series[0].data.Length>3)
                        //chartData.series[0].data[3] = -566;
                    //chartData.series[0].min = -600;
                //}
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.useridnoexist, Resources.SunResource.CHART_USER_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 用户所要电站的月天图标数据,
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <param name="num">正数向前，负数向后</param>
        /// <returns></returns>
        public ActionResult AllPlantMonthDayChartBatch(int userId, int curYear, int curMonth, string chartType, int num, string lan)
        {
            setlan(lan);

            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            string reportData = string.Empty;
            User user = UserService.GetInstance().Get(userId);

            string liststr = "";
            if (user != null && user.plants != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                string startYYYYMMDD = "", endYYYYMMDD = "";


                for (int i = 0; i < num + 1; i++)
                {
                    if (curMonth + i > 12) { curMonth = 0; curYear = curYear + 1; }
                    startYYYYMMDD = curYear + (curMonth + i).ToString("00") + "01";
                    endYYYYMMDD = curYear + (curMonth + i).ToString("00") + CalenderUtil.getMonthDays(curYear, (curMonth + i));
                    //取得用户年度发电量图表数据
                    Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetAppInstance().MMDDChartBypList(user.plants, startYYYYMMDD, endYYYYMMDD, chartType, unit);
                    reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
                    liststr += reportData + "▲";
                }

                num = -1 * num;
                for (int i = -1; i > num - 1; i--)
                {
                    if (curMonth + i < 1) { curMonth = 13; curYear = curYear - 1; }
                    startYYYYMMDD = curYear + (curMonth + i).ToString("00") + "01";
                    endYYYYMMDD = curYear + (curMonth + i).ToString("00") + CalenderUtil.getMonthDays(curYear, (curMonth + i));
                    //取得用户年度发电量图表数据
                    Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetAppInstance().MMDDChartBypList(user.plants, startYYYYMMDD, endYYYYMMDD, chartType, unit);
                    reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
                    liststr = reportData + "▲" + liststr;
                }

                if (!liststr.Equals(""))
                {
                    liststr = liststr.Substring(0, liststr.Length - 1);
                }
                reportData = liststr;
            }
            else
            {
                AppError appError = new AppError(AppError.useridnoexist, Resources.SunResource.CHART_USER_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 用户所有电站的年月发电量图表数据
        /// </summary>
        /// <param name="userId">用户id</param>
        /// <param name="startYM">开始年月</param>
        /// <param name="endYM">截止年月</param>
        /// <param name="chartType">图表类型</param>
        /// <returns></returns>
        public ActionResult AllPlantYearMMChart(int userId, string startYM, string endYM, string chartType, string lan)
        {
            setlan(lan);
            string reportData = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                //取得用户年度发电量图表数据
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetAppInstance().YearMMChartBypList(user.plants, startYM, endYM, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.useridnoexist, Resources.SunResource.CHART_USER_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }


        /// <summary>
        /// 单个电站的年月发电量图表数据
        /// </summary>
        /// <param name="userId">用户id</param>
        /// <param name="startYM">开始年月</param>
        /// <param name="endYM">截止年月</param>
        /// <param name="chartType">图表类型</param>
        /// <returns></returns>
        public ActionResult PlantYearMMChart(int pId, string startYM, string endYM, string chartType, string lan)
        {
            setlan(lan);

            string reportData = string.Empty;
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);

            if (plant != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                //取得用户年度发电量图表数据
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetAppInstance().YearMMChartBypList(new List<Plant>() { plant }, startYM, endYM, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 单个设备的年月发电量图表数据
        /// </summary>
        /// <param name="userId">用户id</param>
        /// <param name="startYM">开始年月</param>
        /// <param name="endYM">截止年月</param>
        /// <param name="chartType">图表类型</param>
        /// <returns></returns>
        public ActionResult DeviceYearMMChart(int dId, string startYM, string endYM, string chartType, string lan)
        {
            setlan(lan);

            string reportData = string.Empty;
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            if (device != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                //取得用户年度发电量图表数据
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetAppInstance().YearMMChartByDevice(device, 1.0F, string.Format(LanguageUtil.getDesc("DEVICEYEAR_CHART_NAME"), device.fullName), startYM, endYM, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.devicenoexist, Resources.SunResource.CHART_DEVICE_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }


        /// <summary>
        /// 单个设备的图表数据
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult DeviceYearChart(int dId, string chartType, string lan)
        {
            setlan(lan);

            string reportData = string.Empty;
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            if (device != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetAppInstance().YearChartByDevice(device, 1.0F, string.Format(LanguageUtil.getDesc("DEVICETOTALCHART_NAME"), device.fullName), chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.devicenoexist, Resources.SunResource.CHART_DEVICE_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 逆变器设备的月天数据
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult DeviceMonthDayChart(int dId, string startYYYYMMDD, string endYYYYMMDD, string chartType, string lan)
        {
            setlan(lan);

            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            string reportData = string.Empty;
            if (device != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TODAYENERGY);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetAppInstance().MonthDDChartByDevice(device, 1.0F, string.Format(LanguageUtil.getDesc("DEVICEMONTHCHART_NAME"), device.fullName), startYYYYMMDD, endYYYYMMDD, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.devicenoexist, Resources.SunResource.CHART_DEVICE_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 取得某个设备跨小时的某测点图表
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <returns></returns>
        public ActionResult MonitorDayChart(int dId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, int monitorCode, string lan)
        {
            setlan(lan);

            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            //获得报表js代码
            MonitorType energyMt = MonitorType.getMonitorTypeByCode(monitorCode);
            string unit = energyMt.unit;
            string chartName = device.fullName + " " + LanguageUtil.getDesc("CHART_DAY_CHART");
            string reportData = string.Empty;

            if (device != null)
            {
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetAppInstance().DayChart(device, chartName, startYYYYMMDDHH, endYYYYMMDDHH, chartType, unit, monitorCode, intervalTime);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.devicenoexist, Resources.SunResource.CHART_DEVICE_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 取得某个设备跨小时的功率图表
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <returns></returns>
        public ActionResult DeviceDayChart(int dId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string lan)
        {
            setlan(lan);

            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            int monitorCode = MonitorType.MIC_INVERTER_TOTALYGPOWER;//功率
            switch (device.deviceTypeCode)
            {
                case DeviceData.HUILIUXIANG_CODE:
                    monitorCode = MonitorType.MIC_BUSBAR_TOTALCURRENT;
                    break;
                case DeviceData.CABINET_CODE:
                    monitorCode = MonitorType.MIC_BUSBAR_TOTALCURRENT;
                    break;
                case DeviceData.ENVRIOMENTMONITOR_CODE:
                    monitorCode = MonitorType.MIC_DETECTOR_SUNLINGHT;
                    break;
                case DeviceData.AMMETER_CODE:
                    monitorCode = MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE;
                    break;
                default:
                    monitorCode = MonitorType.MIC_INVERTER_TOTALYGPOWER;//功率
                    break;
            }

            MonitorType Mt = MonitorType.getMonitorTypeByCode(monitorCode);
            string unit = Mt.unit;
            string chartName = device.fullName + " " + LanguageUtil.getDesc("CHART_DAY_CHART");
            string reportData = string.Empty;

            if (device != null)
            {
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetAppInstance().DayChart(device, chartName, startYYYYMMDDHH, endYYYYMMDDHH, chartType, unit, monitorCode, intervalTime);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.devicenoexist, Resources.SunResource.CHART_DEVICE_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 用户所有电站的年度发电量图表数据
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult AllPlantYearChart(int userId, string chartType, string lan)
        {
            setlan(lan);

            string reportData = string.Empty;
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.plants != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetAppInstance().YearChartBypList(user.plants, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.useridnoexist, Resources.SunResource.CHART_USER_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 单个电站的年度发电量图表数据
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult PlantYearChart(int pId, string chartType, string lan)
        {
            setlan(lan);

            string reportData = string.Empty;
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            if (plant != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetAppInstance().YearChartBypList(new List<Plant>() { plant }, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 电站的月天数据
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult PlantMonthDayChart(int pid, string startYYYYMMDD, string endYYYYMMDD, string chartType, string lan)
        {
            setlan(lan);

            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            string reportData = string.Empty;
            if (plant != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetAppInstance().MMDDChartBypList(new List<Plant> { plant }, startYYYYMMDD, endYYYYMMDD, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 取得某个电站跨小时的功率图表
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <returns></returns>
        public ActionResult PlantDayChart(int pid, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string lan)
        {
            setlan(lan);

            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            //获得报表业务逻辑类
            PlantChartService reportService = PlantChartService.GetAppInstance();
            //获得报表js代码
            int monitorCode = MonitorType.PLANT_MONITORITEM_POWER_CODE;//发电量测点
            MonitorType Mt = MonitorType.getMonitorTypeByCode(monitorCode);
            string unit = Mt.unit;
            string chartName = LanguageUtil.getDesc("CHART_DAY_POWER_CHART");
            string reportData = string.Empty;

            if (plant != null)
            {
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = reportService.PlantDayChart(plant, chartName, startYYYYMMDDHH, endYYYYMMDDHH, chartType, unit, monitorCode, intervalTime);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 取得用户所有电站跨小时的功率图表
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult AllPlantDayChart(int userId, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string lan)
        {
            setlan(lan);

            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            User user = UserService.GetInstance().Get(userId);

            //获得报表业务逻辑类
            PlantChartService reportService = PlantChartService.GetAppInstance();
            //获得报表js代码
            int monitorCode = MonitorType.PLANT_MONITORITEM_POWER_CODE;//发电量测点
            MonitorType Mt = MonitorType.getMonitorTypeByCode(monitorCode);
            string unit = Mt.unit;
            string chartName = LanguageUtil.getDesc("CHART_DAY_POWER_CHART");
            string reportData = string.Empty;

            if (user != null && user.plants != null)
            {
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = reportService.PlantDayChart(user.plants, chartName, startYYYYMMDDHH, endYYYYMMDDHH, chartType, unit, monitorCode, intervalTime);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                AppError appError = new AppError(AppError.useridnoexist, Resources.SunResource.CHART_USER_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 取得用户的所有故障列表
        /// </summary>
        /// <param name="userId">用户id</param>
        /// <param name="pagecount">第几页</param>
        /// <param name="pagesize">每页显示数量</param>
        /// <param name="errortype">告警类型：all是所有，error：错误，warning：警告，fault：故障，info：信息</param>
        /// <param name="errorby">排序字段</param>
        /// <returns></returns>
        public ActionResult ErrorList(int userId, string pagecount, string pagesize, string errortype, string errorby, string lan)
        {
            setlan(lan);
            User user = UserService.GetInstance().Get(userId);
            IList<int> years = CollectorYearDataService.GetInstance().GetWorkYears(user.plants);
            int manyear = years.Count > 0 ? years[0] : DateTime.Now.Year;
            DateTime startTime = Convert.ToDateTime(string.Format("{0}-{1}", manyear, "01-01"));
            DateTime endTime = DateTime.Now;
            int psize = 0;
            int.TryParse(pagesize, out psize);
            FaultService service = FaultService.GetInstance();

            string inforank = "";
            if (errortype.Equals("all")) inforank = ErrorType.ERROR_TYPE_ERROR + "," + ErrorType.ERROR_TYPE_FAULT + "," + ErrorType.ERROR_TYPE_INFORMATRION + "," + ErrorType.ERROR_TYPE_WARN;
            if (errortype.Equals("error")) inforank = ErrorType.ERROR_TYPE_ERROR.ToString();
            if (errortype.Equals("warning")) inforank = ErrorType.ERROR_TYPE_WARN.ToString();
            if (errortype.Equals("fault")) inforank = ErrorType.ERROR_TYPE_FAULT.ToString();
            if (errortype.Equals("info")) inforank = ErrorType.ERROR_TYPE_INFORMATRION.ToString();

            Hashtable table = new Hashtable();
            Pager page = new Pager() { PageIndex = int.Parse(pagecount), PageSize = psize };
            table.Add("page", page);
            table.Add("user", user);
            table.Add("startTime", startTime);
            table.Add("endTime", endTime);
            table.Add("items", inforank);
            table.Add("state", "0");

            service.GetAllLogs(table);
            IList<Fault> faultList = (IList<Fault>)table["source"];

            AFaultVoResult faultResult = new AFaultVoResult();
            IList<AFaultVO> faults = new List<AFaultVO>();
            AFaultVO faultVO = null;
            PlantUnit tmpunit;
            Plant plant;
            foreach (Fault fault in faultList)
            {
                faultVO = new AFaultVO();
                //faultVO.deviceAddress = fault.address;
                faultVO.deviceAddress = fault.device.xinhaoName + "#" + fault.address;//临时方案，设备地址字段放设备设备型号名称+地址，这样不用修改app
                //faultVO.deviceModel =  fault.device.xinhaoName;
                faultVO.deviceModel = fault.device.typeName; ;//临时方案,设备型号字段放设备类型，这样不用修改app
                //faultVO.deviceType = fault.device.typeName;
                tmpunit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(fault.collectorID);
                faultVO.deviceType = tmpunit.collector.code;//tmpu/nit.displayname;//临时方案，设备类型字段放单元名称，这样不用修改app
                faultVO.faultDesc = fault.content;
                faultVO.faultId = fault.id;
                faultVO.isConfirmed = fault.confirm ? "true" : "false";
                faultVO.datetime = fault.sendTime.ToString("yyyy-MM-dd HH:mm:ss");
                faultVO.errorType = getAppErrorType(fault.errorTypeCode);
                plant = PlantService.GetInstance().GetPlantInfoById(tmpunit.plantID);
                faultVO.plantName = StringUtil.cutStr(plant.name, 18, "...");
                faults.Add(faultVO);
            }

            faultResult.totalpagecount = page.PageCount;
            faultResult.faults = faults;
            string data = JsonUtil.convertToJson(faultResult, typeof(AFaultVoResult));
            return Content(data);
        }

        /// <summary>
        /// 取得电站的故障列表
        /// </summary>
        /// <param name="plantId">电站id</param>
        /// <param name="pagecount">第几页</param>
        /// <param name="pagesize">每页显示数量</param>
        /// <param name="errortype">告警类型：all是所有，error：错误，warning：警告，fault：故障，info：信息</param>
        /// <param name="errorby">排序字段</param>
        /// <returns></returns>
        public ActionResult PlantErrorList(int plantId, string pagecount, string pagesize, string errortype, string errorby, string lan)
        {
            setlan(lan);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(plantId);
            IList<int> years = CollectorYearDataService.GetInstance().GetWorkYears(plant);
            int manyear = years.Count > 0 ? years[0] : DateTime.Now.Year;
            DateTime startTime = Convert.ToDateTime(string.Format("{0}-{1}", manyear, "01-01"));
            DateTime endTime = DateTime.Now;
            int psize = 0;
            int.TryParse(pagesize, out psize);
            FaultService service = FaultService.GetInstance();

            User user = UserService.GetInstance().Get((int)plant.userID);

            string inforank = "";
            if (errortype.Equals("all")) inforank = ErrorType.ERROR_TYPE_ERROR + "," + ErrorType.ERROR_TYPE_FAULT + "," + ErrorType.ERROR_TYPE_INFORMATRION + "," + ErrorType.ERROR_TYPE_WARN;
            if (errortype.Equals("error")) inforank = ErrorType.ERROR_TYPE_ERROR.ToString();
            if (errortype.Equals("warning")) inforank = ErrorType.ERROR_TYPE_WARN.ToString();
            if (errortype.Equals("fault")) inforank = ErrorType.ERROR_TYPE_FAULT.ToString();
            if (errortype.Equals("info")) inforank = ErrorType.ERROR_TYPE_INFORMATRION.ToString();
            Hashtable table = new Hashtable();
            Pager page = new Pager() { PageIndex = int.Parse(pagecount), PageSize = psize };
            table.Add("page", page);
            table.Add("plants", new List<Plant>() { plant });
            table.Add("startTime", startTime);
            table.Add("endTime", endTime);
            table.Add("items", inforank);
            table.Add("state", "0");

            service.GetAllLogs(table);
            IList<Fault> faultList = (IList<Fault>)table["source"];

            AFaultVoResult faultResult = new AFaultVoResult();


            IList<AFaultVO> faults = new List<AFaultVO>();
            AFaultVO faultVO = null;
            PlantUnit tmpunit;
            foreach (Fault fault in faultList)
            {
                faultVO = new AFaultVO();
                //faultVO.deviceAddress = fault.address;
                faultVO.deviceAddress = fault.device.xinhaoName + "#" + fault.address;//临时方案，设备地址字段放设备设备型号名称+地址，这样不用修改app
                //faultVO.deviceModel =  fault.device.xinhaoName;
                faultVO.deviceModel = fault.device.typeName; ;//临时方案,设备型号字段放设备类型，这样不用修改app
                //faultVO.deviceType = fault.device.typeName;
                tmpunit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(fault.collectorID);
                faultVO.deviceType = tmpunit.displayname;//临时方案，设备类型字段放单元名称，这样不用修改app
                faultVO.faultDesc = fault.content;
                faultVO.faultId = fault.id;
                faultVO.isConfirmed = fault.confirm ? "true" : "false";
                faultVO.datetime = fault.sendTime.ToString("yyyy-MM-dd HH:mm:ss");
                faultVO.errorType = getAppErrorType(fault.errorTypeCode);
                faultVO.plantName = StringUtil.cutStr(plant.name, 18, "...");
                faults.Add(faultVO);
            }

            faultResult.totalpagecount = page.PageCount;
            faultResult.faults = faults;
            string data = JsonUtil.convertToJson(faultResult, typeof(AFaultVoResult));
            return Content(data);
        }

        /// <summary>
        /// 取得电站详细信息
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public ActionResult Plantinfo(int pid, string lan)
        {
            setlan(lan);

            string data;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            if (plant == null)
            {
                AppError appError = new AppError(AppError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                data = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            else
            {
                User user = UserService.GetInstance().Get((int)plant.userID);

                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                MonitorType powerMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_POWER_CODE);
                PlantInfoVO plantvo = new PlantInfoVO();

                plantvo.totalEnergy = plant.upTotalEnergy;
                plantvo.todayEnergy = plant.upTotalDayEnergy;
                plantvo.pId = plant.id;
                plantvo.name = plant.name;
                plantvo.co2Reduction = plant.Reductiong;
                plantvo.revenue = user.revenue * plantvo.totalEnergy;
                plantvo.designPower = Math.Round(plant.design_power,2);
                plantvo.powerUnit = "KWp";
                plantvo.revenueUnit = plant.currencies;
                plantvo.totalEnergyUnit = plant.TotalEnergyUnit;
                plantvo.todayEnergyUnit = plant.TotalDayEnergyUnit;
                plantvo.co2ReductionUnit = plant.ReductiongUnit;
                plantvo.pic = base.getCurWebContext() + "/ufile/small/" + plant.onePic;
                
                plantvo.country = plant.country;
                plantvo.city = plant.city;
                plantvo.direction = plant.direction;
                plantvo.installdate = plant.installdate.ToString("yyyy-MM-dd");
                plantvo.angle = plant.angle;
                plantvo.latitude = plant.latitudeString;
                plantvo.location = plant.location;
                plantvo.longitude = plant.longitudeString;
                plantvo.street = plant.street;
                plantvo.sunlight = plant.Sunstrength.ToString();
                plantvo.temperature = plant.Temperature.ToString();
                plantvo.weather = "Sundy";
                plantvo.moduleType = plant.module_type;
                plantvo.email = plant.email;

                plantvo.manufacturer = plant.manufacturer;
                plantvo.operatorPerson = plant.operater;
                plantvo.phone = plant.phone;
                plantvo.revenueRate = plant.revenueRate.ToString();

                plantvo.timeZone = Cn.Loosoft.Zhisou.SunPower.Common.TimeZone.GetText(plant.timezone);
                plantvo.zipCode = plant.postcode;
                data = JsonUtil.convertToJson(plantvo, typeof(PlantInfoVO));
            }
            return Content(data);
        }

        /// <summary>
        /// 取得设备详细信息
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public ActionResult Deviceinfo(int did, string lan)
        {
            setlan(lan);

            string data;
            Device device = DeviceService.GetInstance().get(did);
            int timezone = 0;
            try
            {
                PlantUnit plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                Plant plant = PlantService.GetInstance().GetPlantInfoById(plantUnit.plantID);
                timezone = plant.timezone;
            }
            catch (Exception ee)
            {
                LogUtil.error(ee.Message);
            }

            if (device == null)
            {
                AppError appError = new AppError(AppError.devicenoexist, Resources.SunResource.CHART_DEVICE_DONT_EXISTED);
                data = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            else
            {
                ADeviceInfoVO vo = new ADeviceInfoVO();
                vo.deviceId = device.id;
                vo.deviceModel = device.xinhaoName;
                vo.deviceName = device.fullName;
                vo.deviceType = device.typeName;
                vo.deviceTypeCode = device.deviceTypeCode.ToString();
                vo.address = device.deviceAddress;
                if (device.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE)
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_SUNLINGHT);
                    string str = mt.name + " :" + device.Sunlight + " " + mt.unit;
                    mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE);
                    float tempr = device.runData == null ? 0 : device.runData.getMonitorValue(MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE);
                    str += "," + mt.name + " :" + tempr + " " + mt.unit;
                    mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_WINDSPEED);
                    string windspeed = device.getMonitorValueWithStatus(MonitorType.MIC_DETECTOR_WINDSPEED);
                    str += "," + mt.name + " :" + windspeed + " " + mt.unit;
                    vo.displayField = str;
                }
                else if (device.deviceTypeCode == DeviceData.HUILIUXIANG_CODE || device.deviceTypeCode == DeviceData.CABINET_CODE)
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_BUSBAR_TOTALCURRENT);
                    float totalCurrent = device.runData == null ? 0 : device.runData.getMonitorValue(mt.code);
                    string str = mt.name + " :" + totalCurrent + " " + mt.unit;
                    mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_BUSBAR_JNTEMPRATURE);
                    float tempr = device.runData == null ? 0 : device.runData.getMonitorValue(mt.code);
                    str += "," + mt.name + " :" + tempr + " " + mt.unit;
                    vo.displayField = str;
                }
                else if (device.deviceTypeCode == DeviceData.AMMETER_CODE)
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE);
                    float totalCurrent = device.runData == null ? 0 : device.runData.getMonitorValue(mt.code);
                    string str = mt.name + " :" + totalCurrent + " " + mt.unit;
                    //mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_BUSBAR_JNTEMPRATURE);
                    //float tempr = device.runData == null ? 0 : float.Parse(device.runData.getMonitorValue(mt.code));
                    //str += "," + mt.name + " :" + tempr + " " + mt.unit;
                    vo.displayField = str;
                }
                else
                {
                    MonitorType TotalEmt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TOTALENERGY);
                    MonitorType TodayEmt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TODAYENERGY);
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TOTALYGPOWER);
                    string str = TodayEmt.name + " : " + device.TodayEnergy(timezone) + TodayEmt.unit;
                    str += "," + TotalEmt.name + " : " + device.TotalEnergy + TotalEmt.unit;
                    str += "," + mt.name + " : " + device.TotalPower + mt.unit;
                    vo.displayField = str;
                }
                vo.workStatus = device.status;
                vo.lastUpdateTime = CalenderUtil.formatDate(device.runData.updateTime, "yyyy-MM-dd HH:mm:ss");
                vo.hasChart = (device.deviceTypeCode == DeviceData.INVERTER_CODE || device.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE || device.deviceTypeCode == DeviceData.HUILIUXIANG_CODE || device.deviceTypeCode == DeviceData.AMMETER_CODE || device.deviceTypeCode == DeviceData.CABINET_CODE) ? "true" : "false";
                vo.datas = convertToSPlantVOs(device.runData.convertRunstrToList(true, device.deviceTypeCode));
                data = JsonUtil.convertToJson(vo, typeof(ADeviceInfoVO));
            }
            return Content(data);
        }

        /// <summary>
        /// 取得电站简要数据和单元列表
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public ActionResult PlantUnits(int pid, string lan)
        {
            setlan(lan);

            string data;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            if (plant == null)
            {
                AppError appError = new AppError(AppError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                data = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            else
            {
                User user = UserService.GetInstance().Get((int)plant.userID);

                Plant2UnitVO userPlantVO = new Plant2UnitVO();
                userPlantVO.totalEnergy = plant.upTotalEnergy;
                userPlantVO.todayEnergy = plant.upTotalDayEnergy;
                userPlantVO.plantId = plant.id;
                userPlantVO.name = plant.name;
                userPlantVO.co2Reduction = this.getCO2Rate() * plant.TotalEnergy;
                userPlantVO.revenue = user.revenueRate * plant.TotalEnergy;
                userPlantVO.power = plant.TodayTotalPower;
                userPlantVO.powerUnit = "kW";
                userPlantVO.revenueUnit = plant.currencies;
                userPlantVO.totalEnergyUnit = plant.TotalEnergyUnit;
                userPlantVO.todayEnergyUnit = plant.TotalDayEnergyUnit;
                userPlantVO.co2ReductionUnit = plant.ReductiongUnit;
                IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(new List<Plant>() { plant });
                userPlantVO.errorcount = FaultService.GetInstance().getNewLogNums(new List<Plant>() { plant }, workYears);
                userPlantVO.pic = base.getCurWebContext() + "/ufile/small/" + plant.onePic;
                userPlantVO.city = plant.city;
                userPlantVO.country = plant.country;
                userPlantVO.units = convertToSUnitVOs(plant.plantUnits);
                data = JsonUtil.convertToJson(userPlantVO, typeof(Plant2UnitVO));
            }
            return Content(data);
        }

        /// <summary>
        /// 取得单元简要数据和设备列表
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public ActionResult UnitDevices(int uid, string lan)
        {
            setlan(lan);

            string data;
            PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(uid);
            if (unit == null)
            {
                AppError appError = new AppError(AppError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                data = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            else
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(unit.plantID);

                AUnitDeviceVO userPlantVO = new AUnitDeviceVO();
                userPlantVO.unitId = unit.id;
                userPlantVO.name = unit.displayname;
                userPlantVO.units = convertToSDeviceVOs(unit.displayDevices, plant);
                data = JsonUtil.convertToJson(userPlantVO, typeof(AUnitDeviceVO));
            }
            return Content(data);
        }



        /// <summary>
        /// 将电站列表转换成
        /// </summary>
        /// <param name="plants"></param>
        /// <returns></returns>
        private IList<SimplePlantVO> convertToSPlantVOs(IList<Plant> plants)
        {
            IList<SimplePlantVO> splants = new List<SimplePlantVO>();
            SimplePlantVO vo;
            foreach (Plant plant in plants)
            {
                vo = new SimplePlantVO(plant.id, plant.name, plant.firstPic, plant.DisplayTotalDayEnergy + " " + plant.TotalDayEnergyUnit, plant.TodayTotalPower + " kW", plant.DisplayTotalEnergy + " " + plant.TotalEnergyUnit);
                vo.fullpic = base.getCurWebContext() + "/ufile/small/" + plant.onePic; ;
                splants.Add(vo);
            }
            return splants;
        }

        /// <summary>
        /// 将设备测点数据列表转换成测点vo列表
        /// </summary>
        /// <param name="plants"></param>
        /// <returns></returns>
        private IList<MonitorDataVO> convertToSPlantVOs(IList<IList<KeyValuePair<MonitorType, string>>> monitorDatas)
        {
            IList<MonitorDataVO> splants = new List<MonitorDataVO>();
            IList<KeyValuePair<MonitorType, string>> kvList = null;
            for (int i = 0; i < monitorDatas.Count; i++)
            {
                kvList = monitorDatas[i];
                foreach (KeyValuePair<MonitorType, string> kv in kvList)
                {
                    string isHasChart = MonitorType.historyMonitorList.Contains(kv.Key.code) ? "true" : "false";

                    if (kv.Key.code == MonitorType.MIC_INVERTER_OUTTYPE) continue;//输出类型暂不显示
                    MonitorDataVO vo = new MonitorDataVO() { monitorName = kv.Key.name, monitorCode = kv.Key.code, hasChart = isHasChart, isEmpty = "false" };
                    vo.monitorValue = kv.Value + " " + kv.Key.unit;

                    splants.Add(vo);
                }
                //一组后增加一个空行
                if (i < monitorDatas.Count - 1)
                {
                    splants.Add(new MonitorDataVO() { isEmpty = "true" });
                }
            }
            return splants;
        }

        /// <summary>
        /// 将单元列表转换成
        /// </summary>
        /// <param name="plants"></param>
        /// <returns></returns>
        private IList<SimpleUnitVO> convertToSUnitVOs(IList<PlantUnit> units)
        {
            IList<SimpleUnitVO> splants = new List<SimpleUnitVO>();
            Plant plant = null;
            foreach (PlantUnit unit in units)
            {
                plant = PlantService.GetInstance().GetPlantInfoById(unit.plantID);
                splants.Add(new SimpleUnitVO(unit.id, unit.displayname, unit.isWork(plant.timezone) ? "true" : "false", unit.displayDevices.Count));
            }
            return splants;
        }

        /// <summary>
        /// 将单元列表转换成
        /// </summary>
        /// <param name="plants"></param>
        /// <returns></returns>
        private IList<ATypeDeviceVO> convertToSDeviceVOs(IList<Device> devices, Plant plant)
        {
            string apath = Request.Url.AbsolutePath;
            string auri = Request.Url.AbsoluteUri;

            string devicePicBaseWebappUrl = auri.Substring(0, auri.IndexOf(apath)) + "/devicepic";

            IList<ATypeDeviceVO> splants = new List<ATypeDeviceVO>();
            IDictionary<int, IList<ASimpleDeviceVO>> typeDic = new Dictionary<int, IList<ASimpleDeviceVO>>();
            typeDic.Add(DeviceData.INVERTER_CODE, new List<ASimpleDeviceVO>());
            typeDic.Add(DeviceData.ENVRIOMENTMONITOR_CODE, new List<ASimpleDeviceVO>());
            typeDic.Add(DeviceData.HUILIUXIANG_CODE, new List<ASimpleDeviceVO>());
            typeDic.Add(DeviceData.CABINET_CODE, new List<ASimpleDeviceVO>());
            typeDic.Add(DeviceData.AMMETER_CODE, new List<ASimpleDeviceVO>());

            ASimpleDeviceVO sdvo = null;
            foreach (Device device in devices)
            {
                sdvo = new ASimpleDeviceVO();
                sdvo.deviceId = device.id;
                sdvo.deviceModel = device.xinhaoName;
                sdvo.deviceName = device.fullName;
                sdvo.deviceType = device.typeName;
                if (device.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE)
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_SUNLINGHT);
                    sdvo.displayField = mt.name + ": " + device.Sunlight + mt.unit;
                }
                else if (device.deviceTypeCode == DeviceData.HUILIUXIANG_CODE || device.deviceTypeCode == DeviceData.CABINET_CODE)
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_BUSBAR_TOTALCURRENT);
                    float totalCurrent = device.runData == null ? 0 : device.runData.getMonitorValue(MonitorType.MIC_BUSBAR_TOTALCURRENT);
                    sdvo.displayField = mt.name + ": " + totalCurrent + mt.unit;
                }
                else if (device.deviceTypeCode == DeviceData.AMMETER_CODE)
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE);
                    float totalCurrent = device.runData == null ? 0 : device.runData.getMonitorValue(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE);
                    sdvo.displayField = mt.name + ": " + totalCurrent + mt.unit;
                }
                else
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TOTALYGPOWER);
                    sdvo.displayField = mt.name + ": " + device.TotalPower + mt.unit;
                }

                sdvo.workStatus = (device.Over1Day(plant.timezone) ? 0 : 1).ToString();//超过一天无数据为不工作，工作返回1 不工作返回0
                sdvo.address = device.deviceAddress;
                sdvo.pic = devicePicBaseWebappUrl + "/devicepic_31.gif";
                int stoptime = device.stopTime(0);
                sdvo.displayStatus = (stoptime > 24 ? 3 : (stoptime > 1 ? 2 : 1)).ToString();
                sdvo.lastUpdatedTime = device.lastUpdateTime;
                IList<ASimpleDeviceVO> deviceVoList = typeDic[device.deviceTypeCode];
                deviceVoList.Add(sdvo);
                typeDic[device.deviceTypeCode] = deviceVoList;
            }
            ATypeDeviceVO tdvo = null;
            foreach (int key in typeDic.Keys)
            {
                tdvo = new ATypeDeviceVO();
                tdvo.type = DeviceData.getDeviceTypeByCode(key).name;
                tdvo.devices = typeDic[key];
                if (tdvo.devices.Count < 1) continue;
                splants.Add(tdvo);
            }
            return splants;
        }

    }
}


