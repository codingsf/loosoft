﻿using System;
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
    /// 功能：为第三方应用提供各种开放接口
    /// 
    /// 作者：钱厚兵
    /// 时间：2011年12月11日 16:31:48
    /// </summary>
    public class OpenApiController : BaseAppController
    {

        /// <summary>
        /// 获取电站信息
        /// </summary>
        /// <param name="pid">电站id</param>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="call_id">请求序号</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="format">返回结果格式，暂时值支持json</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns></returns>
        public ActionResult plantinfo(int pid, string app_key, string call_id, string sig, string v, string format, string lan)
        {
            setlan(lan);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pid);
            PlantVO vo = new PlantVO();
            if (plant != null)
            {
                vo.CQ2reduce = plant.Reductiong.ToString();
                vo.CQ2reduceUnit = plant.ReductiongUnit;
                vo.curPower = plant.TodayTotalPower.ToString();
                vo.curPowerUnit = "kW";
                vo.dayEnergy = plant.DisplayTotalDayEnergy;
                vo.dayEnergyUnit = plant.TotalDayEnergyUnit;
                IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(new List<Plant>() { plant });
                vo.logCount = FaultService.GetInstance().getNewLogNums(new List<Plant>() { plant }, workYears);
                vo.plantId = pid;
                vo.plantName = plant.name;
                vo.solarIntensity = plant.Sunstrength.ToString();
                vo.solarIntensityUnit = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_LINGT_CODE).unit;
                //add by qhb in 20120106 for 增加逆变器数量
                IList<Device> inverterDevices = plant.typeDevices(DeviceData.INVERTER_CODE);
                vo.inverterCount = inverterDevices.Count.ToString();
                vo.inverterTypeStr = getMainType(inverterDevices, 3);
                string ts = "";
                double t = plant.Temperature;
                User user = UserService.GetInstance().Get((int)plant.userID);
                if (t == 0)
                {
                    CityCodeService codeService = CityCodeService.GetInstance();
                    t = codeService.GetTemperature(plant.city);
                    if (!double.IsNaN(t))
                    {
                        ts = t.ToString("0.0");
                    }
                }
                else {
                    ts = t.ToString("0.0");
                }
                if (user != null && !user.TemperatureType.ToLower().Equals("c"))
                {
                    t = (32 + (t * 1.8));
                    ts = t.ToString("0.0");
                }
                vo.temprature = ts;
                vo.tempratureUnit = user.TemperatureType.ToUpper();
                vo.totalEnergy = plant.DisplayTotalEnergy;
                vo.totalEnergyUnit = plant.TotalEnergyUnit;
                vo.imageArray = "http://" + Request.Url.Authority + "/ufile/" + (string.IsNullOrEmpty(plant.onePic) ? "Nopic/nopico02.gif" : plant.onePic);
                vo.DesignPower = plant.design_power + " kWp";
                vo.Country = plant.country;
                vo.City = plant.city;
                vo.organize = user.organize;
                vo.installDate = plant.installdate.ToString("yyyy-MM-dd");
            }
            string data = JsonUtil.convertToJson(vo, typeof(PlantVO));
            return Content(data);
        }

        /// <summary>
        /// 取得主要前三个设备类型
        /// </summary>
        /// <param name="inverterDevices"></param>
        /// <returns></returns>
        private string getMainType(IList<Device> inverterDevices,int befornum)
        {
            if (inverterDevices == null) return "";
            IDictionary<string, int> typenumMap = new Dictionary<string, int>();
            string xinhaoname="";
            foreach (Device device in inverterDevices) { 
                xinhaoname = device.xinhaoName;
                if(xinhaoname==null|| xinhaoname.Equals(""))continue;
                if (typenumMap.Keys.Contains(xinhaoname))
                {
                    typenumMap[xinhaoname] = typenumMap[xinhaoname] + 1;
                }
                else {
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
            string typestr="";
            for (int i = 0; i < numList.Count; i++) {
                if (i > befornum-1) break;
                typestr = "," + numtypeMap[numList[i]];
            }

            return typestr.Length > 0 ? typestr.Substring(1) : typestr;
        }
        /// <summary>
        /// 电站月天数据
        /// </summary>
        /// <param name="pId">电站id</param>
        /// <param name="startTime">开始时间，格式：yyyyMMdd 20111112</param>
        /// <param name="endTime">截止时间,格式：yyyyMMdd 20111212</param>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="call_id">请求序号</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="format">返回结果格式，暂时值支持json</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns>图表封装的数据</returns>
        public ActionResult PlantMonthDayChart(int pId, string startDate, string endDate, string app_key, string call_id, string sig, string v, string format, string lan)
        {
            setlan(lan);

            string chartType = ChartType.column;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            string reportData = string.Empty;
            if (plant != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetInstance().MMDDChartBypList(new List<Plant> { plant }, startDate, endDate, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                ApiError appError = new ApiError(ApiError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(ApiError));
            }
            return Content(reportData);
        }


        /// <summary>
        /// 取得电站的日图表数据
        /// </summary>
        /// <param name="pId">电站id</param>
        /// <param name="startTime">开始时间，格式：yyyyMMddhh 2011111105</param>
        /// <param name="endTime">截止时间,格式：yyyyMMddhh 2011111223</param>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="call_id">请求序号</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="format">返回结果格式，暂时值支持json</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns>图表封装的数据</returns>
        public ActionResult plantDayChartData(int pId, string startDate, string endDate, string app_key, string call_id, string sig, string v, string format, string lan)
        {
            setlan(lan);

            string chartType = ChartType.column;

            string reportCode = string.Empty;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            string intervalMins = "5,5";
            string[] intervals = intervalMins.Split(',');
            if (plant != null && plant.plantUnits.Count > 0)
            {
                IList<DeviceStuct> devices = new List<DeviceStuct>();
                string deviceId = plant.id.ToString();
                string[] chartTypes = chartType.Split(',');
                devices.Add(new DeviceStuct() { deviceId = deviceId, rate = 1.0F, comareObj = plant.name, chartType = chartTypes[0], monitorType = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_POWER_CODE), cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = int.Parse(intervals[0]) });

                //判断该测点是否有数据,有数据则增加关照对比
                Hashtable dataHash = CollectorDayDataService.GetInstance().GetUnitDaydataList(plant.plantUnits, startDate, endDate, int.Parse(intervals[0]), MonitorType.PLANT_MONITORITEM_POWER_CODE);
                if (dataHash.Count > 0)
                {
                    float rate = 1F;
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_LINGT_CODE);
                    devices.Add(new DeviceStuct() { deviceId = plant.id.ToString(), rate = rate, comareObj = plant.name, name = mt.name, unit = "", chartType = chartTypes[0], monitorType = mt, cVal = ComputeType.Avg, deviceType = ChartDeviceType.PLANT, intervalMins = int.Parse(intervals[1]) });
                }
                else
                {
                    return Content("error:" + Resources.SunResource.NODATA);
                }

                string chartName = LanguageUtil.getDesc("PLANT_CHART_DAY_POWER_SUNLIGHT_COMPARE_CHART");
                //取得用户年度发电量图表数据
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(chartName, devices, startDate, endDate, int.Parse(intervals[0]));
                reportCode = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            return Content(reportCode);
        }

        /// <summary>
        /// 取得所有电站信息
        /// </summary>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="call_id">请求序号</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="format">返回结果格式，暂时值支持json</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns>图表封装的数据</returns>
        public ActionResult PlantInfoList(string app_key, string call_id, string sig, string v, string format, string lan, string userName,string userPwd)
        {
            setlan(lan);
            IList<Plant> plantList;
            if (userName == null)
            {
                plantList = PlantService.GetInstance().GetPlantInfoList();
            }
            else
            {
                User user = UserService.GetInstance().GetUserByName(userName);
                if (user == null)
                {
                    return Content("error:此用户名不存在");
                }
                if(user.depassword.Equals(userPwd)==false)
                    return Content("error:您输入的密码不正确");

                plantList = user.plants;
            }

            List<PlantInfoVo> pinfoVos = new List<PlantInfoVo>();
            foreach (Plant plant in plantList)
            {
                pinfoVos.Add(new PlantInfoVo() { plantId = plant.id.ToString(), plantName = plant.name, country = plant.country, city = plant.city, latitude = plant.latitude, Longitude = plant.longitude, design_power = plant.design_power.ToString()});
            }
            string data = JsonUtil.convertToJson(pinfoVos, typeof(List<PlantInfoVo>));
            return Content(data);
        }


        /// <summary>
        /// 取得所有统计数据
        /// </summary>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="call_id">请求序号</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="format">返回结果格式，暂时值支持json</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns></returns>
        public ActionResult TotalInfo(string app_key, string call_id, string sig, string v, string format, string username, string lan)
        {
            setlan(lan);
            TotalInfo tinfo = new TotalInfo();
            if (string.IsNullOrEmpty(username))
            {
                double allTotalEnergy = DeviceRunDataService.GetInstance().GetAllTotalEnergy();
                double allDayEnergy = CollectorRunDataService.GetInstance().GetAllDayEnergy();
                double allDayPower = CollectorRunDataService.GetInstance().getAllPower();
                tinfo.totalDayEnergy = Util.upDigtal(allDayEnergy);
                tinfo.totalDayEnergyUnit = Util.upEnergyUnit(allDayEnergy);
                tinfo.plantsCount = PlantService.GetInstance().GetPlantInfoList().Count();
                tinfo.totalCO2Reduce = Util.upDigtal(ItemConfig.reductionRate * allTotalEnergy);
                tinfo.totalCO2ReduceUnit = Util.upCo2Unit(ItemConfig.reductionRate * allTotalEnergy);
                tinfo.totalEnergy = Util.upDigtal(allTotalEnergy);
                tinfo.totalEnergyUnit = Util.upEnergyUnit(allTotalEnergy);
                tinfo.totalTodayPower = Util.upDigtal(allDayPower);
                tinfo.totalTodayPowerUnit = Util.upPowerUnit(allDayPower);
                double top = PlantService.GetInstance().getTotalPower();
                tinfo.totalPower = Util.upDigtal(top);
                tinfo.totalPowerUnit = Util.upPowerUnit(top);
                tinfo.treeNum = (allTotalEnergy / 40).ToString("0");
            }
            else 
            {
                User user = UserService.GetInstance().GetUserByName(username);
                if (user != null) {
                    double allTotalEnergy = user.TotalEnergy;
                    double allDayEnergy = user.TotalDayEnergy;
                    double allDayPower = user.TotalPower;
                    tinfo.totalDayEnergy = Util.upDigtal(allDayEnergy);
                    tinfo.totalDayEnergyUnit = Util.upEnergyUnit(allDayEnergy);
                    tinfo.plantsCount = user.plants.Count;
                    tinfo.totalCO2Reduce = Util.upDigtal(ItemConfig.reductionRate * allTotalEnergy);
                    tinfo.totalCO2ReduceUnit = Util.upCo2Unit(ItemConfig.reductionRate * allTotalEnergy);
                    tinfo.totalEnergy = Util.upDigtal(allTotalEnergy);
                    tinfo.totalEnergyUnit = Util.upEnergyUnit(allTotalEnergy);
                    tinfo.totalTodayPower = Util.upDigtal(allDayPower);
                    tinfo.totalTodayPowerUnit = Util.upPowerUnit(allDayPower);
                    double top = 0;
                    foreach(Plant p in user.plants){
                        top += p.design_power;
                    }
                    tinfo.totalPower = Util.upDigtal(top);
                    tinfo.totalPowerUnit = Util.upPowerUnit(top);
                    tinfo.treeNum = (allTotalEnergy / 40).ToString("0");
                }
            }
            string data = JsonUtil.convertToJson(tinfo, typeof(TotalInfo));
            return Content(data);
        }

        /// <summary>
        /// 按照电站名称取得对应时区
        /// add by qhb in 20120831 
        /// </summary>
        /// <param name="plantName">电站名称</param>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="call_id">请求序号</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="format">返回结果格式，暂时值支持json</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns></returns>
        public ActionResult PlantTimezone(string plantName, string app_key, string call_id, string sig, string v, string format, string lan)
        {
            setlan(lan);

            Plant plant = PlantService.GetInstance().GetplantByName(plantName);
            string reportData = string.Empty;
            if (plant != null)
            {
                PlantTimezoneVo plantTimezoneVo = new PlantTimezoneVo();
                plantTimezoneVo.plantId = plant.id.ToString();
                plantTimezoneVo.plantName = plant.name;
                plantTimezoneVo.timezoneCode = plant.timezone.ToString();
                plantTimezoneVo.timezoneName = Cn.Loosoft.Zhisou.SunPower.Common.TimeZone.GetText(plant.timezone);
                reportData = JsonUtil.convertToJson(plantTimezoneVo, typeof(PlantTimezoneVo));

            }
            else
            {
                ApiError appError = new ApiError(ApiError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(ApiError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 按照sn取得对应时区
        /// add by qhb in 20120831 
        /// </summary>
        /// <param name="sn">sn</param>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="call_id">请求序号</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="format">返回结果格式，暂时值支持json</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns></returns>
        public ActionResult SnTimezone(string sn, string app_key, string call_id, string sig, string v, string format, string lan)
        {
            setlan(lan);

            int collectorId = CollectorInfoService.GetInstance().getCollectorIdbyCode(sn);
            PlantUnit plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(collectorId);
            string reportData = string.Empty;
            if (plantUnit != null)
            {
                Plant plant = PlantService.GetInstance().GetPlantInfoById(plantUnit.plantID);
                if (plant == null)
                {
                    ApiError appError = new ApiError(ApiError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                    reportData = JsonUtil.convertToJson(appError, typeof(ApiError));
                }
                else
                {
                    PlantTimezoneVo plantTimezoneVo = new PlantTimezoneVo();
                    plantTimezoneVo.plantId = plant.id.ToString();
                    plantTimezoneVo.plantName = plant.name;
                    plantTimezoneVo.timezoneCode = plant.timezone.ToString();
                    plantTimezoneVo.timezoneName = Cn.Loosoft.Zhisou.SunPower.Common.TimeZone.GetText(plant.timezone);
                    reportData = JsonUtil.convertToJson(plantTimezoneVo, typeof(PlantTimezoneVo));
                }
            }
            else
            {
                ApiError appError = new ApiError(ApiError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(ApiError));
            }
            return Content(reportData);
        }

        /// <summary>
        /// 取得用户的所有故障列表
        /// </summary>
        /// <param name="pagecount">第几页</param>
        /// <param name="pagesize">每页显示数量</param>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="call_id">请求序号</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="format">返回结果格式，暂时值支持json</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns></returns>
        public ActionResult PlantTimezoneList(int pagecount, int pagesize, string app_key, string call_id, string sig, string v, string format, string lan)
        {
            setlan(lan);
            string reportData = string.Empty;
            if (pagecount == 0) pagecount = 1;
            if (pagesize == 0) pagesize = 10;
            Pager page = new Pager() { PageIndex = pagecount, PageSize = pagesize };
            IList<Plant> plants = PlantService.GetInstance().GetPlantByPage(page);
            if (plants.Count > 0)
            {
                PlantTimezonePageVo plantTimezonePageVo = new PlantTimezonePageVo();
                IList<PlantTimezoneVo> timezonevos = new List<PlantTimezoneVo>();
                PlantTimezoneVo plantTimezoneVo = null;
                foreach (Plant plant in plants) { 
                    plantTimezoneVo = new PlantTimezoneVo();
                    plantTimezoneVo.plantId = plant.id.ToString();
                    plantTimezoneVo.plantName = plant.name;
                    plantTimezoneVo.timezoneCode = plant.timezone.ToString();
                    plantTimezoneVo.timezoneName = Cn.Loosoft.Zhisou.SunPower.Common.TimeZone.GetText(plant.timezone);
                    timezonevos.Add(plantTimezoneVo);
                }
                plantTimezonePageVo.timezones = timezonevos;
                plantTimezonePageVo.totalpagecount = page.PageCount;
                reportData = JsonUtil.convertToJson(plantTimezonePageVo, typeof(PlantTimezonePageVo));
            }
            else
            {
                ApiError appError = new ApiError(ApiError.plantnoexist, Resources.SunResource.CHART_PLANT_DONT_EXISTED);
                reportData = JsonUtil.convertToJson(appError, typeof(ApiError));
            }
            return Content(reportData);
        }

    }
}
