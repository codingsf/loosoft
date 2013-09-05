using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
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
using Cn.Loosoft.Zhisou.SunPower.Common.vo;
using Cn.Loosoft.Zhisou.SunPower.Service.vo;
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
                vo.solarIntensity = plant.Sunstrength==null?"":plant.Sunstrength.ToString();
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
                else
                {
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

        /// <summary>
        /// 电站月天数据
        /// </summary>
        /// <param name="pId">电站id</param>
        /// <param name="startTime">开始时间，格式：yyyyMMdd 20111112</param>
        /// <param name="endTime">截止时间,格式：yyyyMMdd 20111212</param>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns>图表封装的数据</returns>
        public ActionResult PlantMonthDayChart(int pId, string startDate, string endDate, string app_key, string sig, string v, string lan)
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
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <returns>图表封装的数据</returns>
        public ActionResult plantDayChartData(int pId, string startDate, string endDate, string app_key, string sig, string v, string lan)
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
        ///  单个电站的年度发电量图表数据
        /// </summary>
        /// <param name="pId"></param>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <param name="lan"></param>
        /// <returns></returns>
        public ActionResult PlantYearChart(int pId, string app_key, string sig, string v, string lan)
        {
            setlan(lan);
            string chartType = ChartType.column;
            string reportData = string.Empty;
            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            if (plant != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetInstance().YearChartBypList(new List<Plant>() { plant }, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
                return Content(reportData);
            }
            else
            {
                return Content("error:" + Resources.SunResource.CHART_PLANT_DONT_EXISTED);
            }
        }

        /// <summary>
        /// 登录验证
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <param name="lan"></param>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <returns></returns>
        public ActionResult loginvalid(string username, string password, string lan, string app_key, string sig, string v)
        {
            //FileLogUtil.info("username:"+username);

            //将就点demo账号，转为新的，以便兼容就的demo账号
            if (username != null && UserUtil.olddemousername.Equals(username.ToLower()))
            {
                username = UserUtil.demousername;
            }

            setlan(lan);

            string data;
            User user = UserService.GetInstance().GetUserByName(username);
            if (user == null)
            {
                username = UserUtil.demousername;
                user = UserService.GetInstance().GetUserByName(username);
                //AppError appError = new AppError(AppError.usernameOrpasswordError, "Username don`t existed");
                //data = JsonUtil.convertToJson(appError, typeof(AppError));
            }
            if (user != null)
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
                    Cn.Loosoft.Zhisou.SunPower.Service.vo.UserPlantVO userPlantVO = new Cn.Loosoft.Zhisou.SunPower.Service.vo.UserPlantVO();
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
                    IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(user.relatedPlants);
                    userPlantVO.warnNums = FaultService.GetInstance().getNewLogNums(user.relatedPlants, workYears);
                    userPlantVO.plants = convertToSPlantVOs(user.relatedPlants);

                    data = JsonUtil.convertToJson(userPlantVO, typeof(Cn.Loosoft.Zhisou.SunPower.Service.vo.UserPlantVO));
                }
            }
            else
            {
                return Content("error: username or password is error.");
            }
            return Content(data);
        }
        
        /// <summary>
        /// 将电站列表转换成
        /// </summary>
        /// <param name="plants"></param>
        /// <returns></returns>
        private IList<Cn.Loosoft.Zhisou.SunPower.Service.vo.SimplePlantVO> convertToSPlantVOs(IList<Plant> plants)
        {
            IList<Cn.Loosoft.Zhisou.SunPower.Service.vo.SimplePlantVO> splants = new List<Cn.Loosoft.Zhisou.SunPower.Service.vo.SimplePlantVO>();
            Cn.Loosoft.Zhisou.SunPower.Service.vo.SimplePlantVO vo;
            foreach (Plant plant in plants)
            {
                vo = new Cn.Loosoft.Zhisou.SunPower.Service.vo.SimplePlantVO(plant.id, plant.name, plant.firstPic, plant.DisplayTotalDayEnergy + plant.TotalDayEnergyUnit, plant.TodayTotalPower + " kW", plant.DisplayTotalEnergy + plant.TotalEnergyUnit);
                vo.fullpic = base.getCurWebContext() + "/ufile/small/" + plant.onePic; ;
                splants.Add(vo);
            }
            return splants;
        }

        /// <summary>
        /// 取得所有电站信息
        /// </summary>
        /// <param name="app_key">第三方应用唯一key</param>
        /// <param name="call_id">请求序号</param>
        /// <param name="sig">签名</param>
        /// <param name="v">api版本</param>
        /// <param name="lan">语言环境，暂时只支持中英文</param>
        /// <param name="userName">用户名</param>
        /// <param name="userPwd">密码</param>
        /// <returns>图表封装的数据</returns>
        public ActionResult PlantInfoList(string app_key, string sig, string v, string lan, string userName,string userPwd)
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
                    return Content("error:username is error.");
                }
                if(user.depassword.Equals(userPwd)==false)
                    return Content("error:password is error.");

                plantList = user.displayPlants;
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
        /// 取得用户所有电站统计数据
        /// </summary>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <param name="username"></param>
        /// <param name="lan"></param>
        /// <returns></returns>
        public ActionResult TotalInfo(string app_key, string sig, string v, string username, string lan)
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
                tinfo.totalPower = Math.Round(top, 2);
                tinfo.totalPowerUnit = Util.upPowerUnit(tinfo.totalPower);
                tinfo.treeNum = (allTotalEnergy / 40).ToString("0");
            }
            else
            {
                User user = UserService.GetInstance().GetUserByName(username);
                if (user != null)
                {
                    double allTotalEnergy = user.TotalEnergy;
                    double allDayEnergy = user.TotalDayEnergy;
                    double allDayPower = user.TotalPower;
                    tinfo.totalDayEnergy = Util.upDigtal(allDayEnergy);
                    tinfo.totalDayEnergyUnit = Util.upEnergyUnit(allDayEnergy);
                    tinfo.plantsCount = user.relatedPlants.Count;
                    tinfo.totalCO2Reduce = Util.upDigtal(ItemConfig.reductionRate * allTotalEnergy);
                    tinfo.totalCO2ReduceUnit = Util.upCo2Unit(ItemConfig.reductionRate * allTotalEnergy);
                    tinfo.totalEnergy = Util.upDigtal(allTotalEnergy);
                    tinfo.totalEnergyUnit = Util.upEnergyUnit(allTotalEnergy);
                    tinfo.totalTodayPower = Util.upDigtal(allDayPower);
                    tinfo.totalTodayPowerUnit = Util.upPowerUnit(allDayPower);
                    double top = 0;
                    foreach (Plant p in user.relatedPlants)
                    {
                        top += p.design_power;
                    }
                    tinfo.totalPower = Math.Round(top, 2);
                    tinfo.totalPowerUnit = Util.upPowerUnit(tinfo.totalPower);
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
                foreach (Plant plant in plants)
                {
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

        /// <summary>
        /// 用户所有电站的月天图标数据
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="startYYYYMMDD"></param>
        /// <param name="endYYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <param name="lan"></param>
        /// <returns></returns>
        public ActionResult UserPlantMonthDayChart(int userId, string startyyyyMMdd, string yyyyMMdd, string chartType, string app_key, string sig, string v, string lan)
        {
            setlan(lan);

            if (string.IsNullOrEmpty(chartType)) chartType = ChartType.column;
            string reportData = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.relatedPlants != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                //取得用户年度发电量图表数据
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetInstance().MMDDChartBypList(user.relatedPlants, startyyyyMMdd, yyyyMMdd, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportData);
        }


        /// <summary>
        /// 用户所有电站的年月发电量图表数据
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="startyyyyMM"></param>
        /// <param name="endyyyyMM"></param>
        /// <param name="chartType"></param>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <param name="lan"></param>
        /// <returns></returns>
        public ActionResult UserPlantYearMMChart(int userId, string startyyyyMM, string endyyyyMM, string app_key, string sig, string v, string lan)
        {
            setlan(lan);
            string chartType = ChartType.column;
            string reportData = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.relatedPlants != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                //取得用户年度发电量图表数据
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetInstance().YearMMChartBypList(user.relatedPlants, startyyyyMM, endyyyyMM, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportData);
        }


        /// <summary>
        /// 用户所有电站的年度发电量图表数据
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ActionResult UserPlantYearChart(int userId, string lan,string app_key, string sig, string v)
        {
            setlan(lan);
            string chartType = ChartType.column;
            string reportData = string.Empty;
            User user = UserService.GetInstance().Get(userId);
            if (user != null && user.relatedPlants != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = PlantChartService.GetInstance().YearChartBypList(user.relatedPlants, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportData);
        }

        /// <summary>
        /// 取得电站简要数据和单元列表
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="lan"></param>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <returns></returns>
        public ActionResult PlantUnits(int pid, string lan, string app_key, string sig, string v)
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
        /// 取得单元简要数据和设备列表
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public ActionResult UnitDevices(int uid, string lan, string app_key, string sig, string v)
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
                UnitDeviceVO userPlantVO = new UnitDeviceVO();
                userPlantVO.unitId = unit.id;
                userPlantVO.name = unit.displayname;
                userPlantVO.units = convertToSDeviceVOs(unit.displayDevices, plant);
                data = JsonUtil.convertToJson(userPlantVO, typeof(UnitDeviceVO));
            }
            return Content(data);
        }

        /// <summary>
        /// 将单元列表转换成
        /// </summary>
        /// <param name="plants"></param>
        /// <returns></returns>
        private IList<TypeDeviceVO> convertToSDeviceVOs(IList<Device> devices, Plant plant)
        {
            string apath = Request.Url.AbsolutePath;
            string auri = Request.Url.AbsoluteUri;

            string devicePicBaseWebappUrl = auri.Substring(0, auri.IndexOf(apath)) + "/devicepic";

            IList<TypeDeviceVO> splants = new List<TypeDeviceVO>();
            IDictionary<string, IList<SimpleDeviceVO>> typeDic = new Dictionary<string, IList<SimpleDeviceVO>>();
            SimpleDeviceVO sdvo = null;
            foreach (Device device in devices)
            {
                sdvo = new SimpleDeviceVO();
                sdvo.deviceId = device.id;
                sdvo.deviceModel = (device.name != null && device.name.IndexOf("#") > -1) ? device.name.Substring(0, device.name.IndexOf("#")) : device.xinhaoName;

                sdvo.deviceType = device.typeName;

                if (device.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE)
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_SUNLINGHT);
                    sdvo.displayField = mt.name + ":" + device.Sunlight + " " + mt.unit;
                }
                else if (device.deviceTypeCode == DeviceData.HUILIUXIANG_CODE || device.deviceTypeCode == DeviceData.CABINET_CODE)
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_BUSBAR_TOTALCURRENT);
                    float totalCurrent = device.runData == null ? 0 : device.runData.getMonitorValue(MonitorType.MIC_BUSBAR_TOTALCURRENT);
                    sdvo.displayField = mt.name + ":" + totalCurrent + " " + mt.unit;
                }
                else if (device.deviceTypeCode == DeviceData.AMMETER_CODE)
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE);
                    double totalCurrent = device.getMonitorValue(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE);
                    sdvo.displayField = mt.name + ": " + totalCurrent + mt.unit;
                }
                else
                {
                    MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TOTALYGPOWER);
                    sdvo.displayField = mt.name + ":" + device.TotalPower + " " + mt.unit;
                }

                sdvo.workStatus = (device.Over1Day(plant.timezone) ? 0 : 1).ToString();//超过一天无数据为不工作，工作返回1 不工作返回0
                sdvo.address = device.deviceAddress;
                sdvo.pic = devicePicBaseWebappUrl + "/devicepic_31.gif";
                int stoptime = device.stopTime(0);
                sdvo.displayStatus = (stoptime > 24 ? 3 : (stoptime > 1 ? 2 : 1)).ToString();
                sdvo.lastUpdatedTime = device.lastUpdateTime;
                IList<SimpleDeviceVO> deviceVoList = null;
                if (!typeDic.ContainsKey(device.typeName))
                {
                    deviceVoList = new List<SimpleDeviceVO>();
                }
                else
                {
                    deviceVoList = typeDic[device.typeName];
                }
                deviceVoList.Add(sdvo);
                typeDic[device.typeName] = deviceVoList;
            }
            TypeDeviceVO tdvo = null;
            foreach (string key in typeDic.Keys)
            {
                tdvo = new TypeDeviceVO();
                tdvo.type = key;
                tdvo.devices = typeDic[key];
                splants.Add(tdvo);
            }
            return splants;
        }

        /// <summary>
        /// 取得某个设备跨小时的功率图表
        /// </summary>
        /// <param name="dId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="lan"></param>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <returns></returns>
        public ActionResult DeviceDayChart(int dId, string startYYYYMMDDHH, string endYYYYMMDDHH, string lan, string app_key, string sig, string v)
        {
            setlan(lan);

            string chartType = ChartType.column;
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
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetInstance().DayChart(device, chartName, startYYYYMMDDHH, endYYYYMMDDHH, chartType, unit, monitorCode, intervalTime);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
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
        public ActionResult DeviceMonthDayChart(int dId, string startYYYYMMDD, string endYYYYMMDD, string lan, string app_key, string sig, string v)
        {
            setlan(lan);

            string chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            string reportData = string.Empty;
            if (device != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TODAYENERGY);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetInstance().MonthDDChartByDevice(device, 1.0F, string.Format(LanguageUtil.getDesc("DEVICEMONTHCHART_NAME"), device.fullName), startYYYYMMDD, endYYYYMMDD, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportData);
        }

        /// <summary>
        /// 单个设备的年月发电量图表数据
        /// </summary>
        /// <param name="dId"></param>
        /// <param name="startYM"></param>
        /// <param name="endYM"></param>
        /// <param name="lan"></param>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <returns></returns>
        public ActionResult DeviceYearMonthChart(int dId, string startYM, string endYM, string lan, string app_key, string sig, string v)
        {
            setlan(lan);

            string reportData = string.Empty;
            string chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            if (device != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                //取得用户年度发电量图表数据
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetInstance().YearMMChartByDevice(device, 1.0F, string.Format(LanguageUtil.getDesc("DEVICEYEAR_CHART_NAME"), device.fullName), startYM, endYM, chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportData);
        }

        /// <summary>
        /// 单个设备的图表数据
        /// </summary>
        /// <param name="dId"></param>
        /// <param name="lan"></param>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <returns></returns>
        public ActionResult DeviceYearChart(int dId, string lan, string app_key, string sig, string v)
        {
            setlan(lan);

            string reportData = string.Empty;
            string chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            if (device != null)
            {
                MonitorType energyMt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                string unit = energyMt.unit;
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetInstance().YearChartByDevice(device, 1.0F, string.Format(LanguageUtil.getDesc("DEVICETOTALCHART_NAME"), device.fullName), chartType, unit);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportData);
        }


        /// <summary>
        /// 取得某个设备跨小时的某测点图表
        /// </summary>
        /// <param name="dId"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="monitorCode"></param>
        /// <param name="lan"></param>
        /// <param name="app_key"></param>
        /// <param name="sig"></param>
        /// <param name="v"></param>
        /// <returns></returns>
        public ActionResult MonitorDayChart(int dId, string startYYYYMMDDHH, string endYYYYMMDDHH, int monitorCode, string lan, string app_key, string sig, string v)
        {
            setlan(lan);

            string chartType = ChartType.column;
            Device device = DeviceService.GetInstance().get(dId);
            //获得报表js代码
            MonitorType energyMt = MonitorType.getMonitorTypeByCode(monitorCode);
            string unit = energyMt.unit;
            string chartName = device.fullName + " " + LanguageUtil.getDesc("CHART_DAY_CHART");
            string reportData = string.Empty;

            if (device != null)
            {
                Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData = DeviceChartService.GetInstance().DayChart(device, chartName, startYYYYMMDDHH, endYYYYMMDDHH, chartType, unit, monitorCode, intervalTime);
                reportData = JsonUtil.convertToJson(chartData, typeof(Cn.Loosoft.Zhisou.SunPower.Common.ChartData));
            }
            else
            {
                return Content("error:" + Resources.SunResource.NODATA);
            }
            return Content(reportData);
        }

        /// <summary>
        /// 取得电站的所有故障列表
        /// </summary>
        /// <param name="userId">电站id</param>
        /// <param name="pagecount">第几页</param>
        /// <param name="pagesize">每页显示数量</param>
        /// <param name="errortype">告警类型：all是所有，error：错误，warning：警告，fault：故障，inf：信息</param>
        /// <param name="errorby">排序字段</param>
        /// <returns></returns>
        public ActionResult PlantFaultList(int pId, string pagecount, string pagesize, string errortype, string errorby, string lan, string app_key, string sig, string v)
        {
            setlan(lan);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(pId);
            IList<int> years = CollectorYearDataService.GetInstance().GetWorkYears(plant);
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
            table.Add("plants", new List<Plant>(){plant});
            table.Add("startTime", startTime);
            table.Add("endTime", endTime);
            table.Add("items", inforank);
            table.Add("state", "0");

            service.GetAllLogs(table);
            IList<Fault> faultList = (IList<Fault>)table["source"];

            FaultVoResult faultResult = new FaultVoResult();
            faultResult.totalpagecount = page.PageCount;

            IList<FaultVO> faults = new List<FaultVO>();
            FaultVO faultVO = null;

            PlantUnit tmpunit;
            foreach (Fault fault in faultList)
            {
                faultVO = new FaultVO();
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
                faults.Add(faultVO);
            }

            faultResult.faults = faults;
            string data = JsonUtil.convertToJson(faultResult, typeof(FaultVoResult));
            return Content(data);
        }

        /// <summary>
        /// 取得用户的所有故障列表
        /// </summary>
        /// <param name="userId">用户id</param>
        /// <param name="pagecount">第几页</param>
        /// <param name="pagesize">每页显示数量</param>
        /// <param name="errortype">告警类型：all是所有，error：错误，warning：警告，fault：故障，inf：信息</param>
        /// <param name="errorby">排序字段</param>
        /// <returns></returns>
        public ActionResult UserFaultList(int userId, string pagecount, string pagesize, string errortype, string errorby, string lan, string app_key, string sig, string v)
        {
            setlan(lan);
            User user = UserService.GetInstance().Get(userId);
            IList<int> years = CollectorYearDataService.GetInstance().GetWorkYears(user.relatedPlants);
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

            FaultVoResult faultResult = new FaultVoResult();
            faultResult.totalpagecount = page.PageCount;

            IList<FaultVO> faults = new List<FaultVO>();
            FaultVO faultVO = null;

            PlantUnit tmpunit;
            foreach (Fault fault in faultList)
            {
                faultVO = new FaultVO();
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
                faults.Add(faultVO);
            }

            faultResult.faults = faults;
            string data = JsonUtil.convertToJson(faultResult, typeof(FaultVoResult));
            return Content(data);
        }

    }


}
