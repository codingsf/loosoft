using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    /// <summary>
    /// 功能：设备控制器
    /// 描述：对设备的运行实时数据
    /// 作者：张月
    /// 时间：2011年3月10日
    /// </summary>
    public class DeviceController : BaseController
    {

        FaultService faultService = FaultService.GetInstance();

        [HttpGet]
        public ActionResult RunData(int id)
        {
            Device device = DeviceService.GetInstance().get(id);
            IList<IList<KeyValuePair<MonitorType, string>>> rundatas = device.runData.convertRunstrToList(true);

            ViewData["rundatas"] = rundatas;
            ViewData["device"] = device;
            PlantUnit plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(plantUnit.plantID);
            ViewData["plant"] = plant;
            return View();
        }

        public ActionResult Log()
        {
            int intValue = 0;
            string strValue = string.Empty;
            strValue = Request.QueryString["pid"];
            int.TryParse(strValue, out intValue);
            ICollection<ErrorType> errorTypes = ErrorType.getErrorList();
            ViewData["errorTypes"] = errorTypes;
            return View(FindPlant(intValue));
        }
        [HttpPost]
        public ActionResult LoadLog(int userId, int dId, string pageNo)
        {

            int totalRecord = 0;
            int yyyy = DateTime.Now.Year;
            int intValue = 0;
            int.TryParse(pageNo, out intValue);

            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = intValue };
            Hashtable table = new Hashtable();
            table.Add("page", page);
            Fault fault = new Fault() { confirmed = "0", device = new Device() { id = dId }, sendTime = DateTime.Now };
            table.Add("fault", fault);
            ViewData["page"] = page;
            IList<Fault> faultsList = faultService.GetDeviceLogsPage(table);
            totalRecord += (table["page"] as Pager).RecordCount;
            int startIndex = (intValue-1) * page.PageSize;//当前页码的开始索引
            IList<Fault> faults = new List<Fault>();

            if (totalRecord > startIndex)
            {
                foreach (Fault item in faultsList)
                {
                    if (faults.Count < page.PageSize )
                        faults.Add(item);
                    else
                        break;
                }
            }


            while (yyyy-- > DateTime.Now.Year - 5)
            {
                //改成开始时间
                page.PageIndex = Math.Abs(startIndex + page.PageSize - totalRecord) / page.PageSize;
                fault.sendTime = fault.sendTime.AddYears(-1);
                faultsList = faultService.GetDeviceLogsPage(table);
                int skip = 0;
                if (Math.Abs(totalRecord - startIndex) < page.PageSize)
                    skip = totalRecord - startIndex;

                totalRecord += (table["page"] as Pager).RecordCount;
                if (totalRecord > startIndex)
                {
                    foreach (Fault item in faultsList)
                    {
                        if (faults.Count < page.PageSize && skip++ >= 0)
                            faults.Add(item);
                    }
                }

            }

            page.RecordCount = totalRecord;//返回查询的所有年数的所有记录
            page.PageIndex = intValue; ;
            ViewData["user"] = UserService.GetInstance().Get(userId);
            return View("DeviceLogAjax", faults);
        }


        [HttpPost]
        public ActionResult LoadModel(int id)
        {
            Hashtable jsonData = new Hashtable();
            IList<DeviceModel> models = DeviceModelService.GetInstance().getXhbyDeviceType(id);
            foreach (DeviceModel model in models)
            {
                jsonData.Add(model.code, model.name);
            }
            string json = JsonUtil.convertToJson(jsonData, typeof(Hashtable));
            return Content(json);

        }

        [HttpPost]
        public ActionResult LoadDevice(int plantid, int unitId, int typeId, int modelId)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(plantid);
            IList<PlantUnit> units = new List<PlantUnit>();//电站单元列表
            if (unitId.Equals(-1))//如果为-1代表当前电站的所有单元
                units = plant.plantUnits;
            else
                foreach (PlantUnit unit in plant.plantUnits)//如果选择单元 则为当前单元
                    if (unit.id.Equals(unitId))
                    {
                        units.Add(unit);
                        break;
                    }
            IList<Device> devices = new List<Device>();

            foreach (PlantUnit unit in units)
            {
                if (unit.devices != null)
                    foreach (Device device in unit.devices)//循环单元中的所有设备
                    {
                        if (typeId > 0 || modelId > 0)
                        {
                            if (modelId > 0)//如果选择了设备型号
                            {
                                if (device.deviceModel != null && device.deviceModel.code == modelId)
                                {
                                    devices.Add(device);//添加指定的设备型号
                                }
                            }
                            else
                            {
                                if (device.deviceTypeCode == typeId)//如果选择了设备类型
                                    devices.Add(device);
                            }
                        }
                        else
                        {
                            devices.Add(device);
                        }

                    }
            }

            Hashtable jsonData = new Hashtable();
            foreach (Device model in devices)
            {
                jsonData.Add(model.id, model.deviceAddress);
            }
            string json = JsonUtil.convertToJson(jsonData, typeof(Hashtable));
            return Content(json);
        }

        [HttpPost]
        public ActionResult Confirm(string unitId, string type, string logList)
        {
            if (type.Equals("1"))
                if (logList.Equals("-1"))
                    return Content(LanguageUtil.getDesc("USER_LOG_CONFIRM_RECORD"));
            string result = "fail";
            try
            {
                faultService.CofirmDeviceLog(unitId, type, logList);
                result = "success";
            }
            catch
            {
                result = "fail";
            }
            return Content(result);

        }

        /// <summary>
        /// 加载设备日功率统计数据
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult PowerCount(int id, string startYYYYMMDDHH, string endYYYYMMDDHH)
        {
            int year = int.Parse(startYYYYMMDDHH.Substring(0, 4));
            int month = int.Parse(startYYYYMMDDHH.Substring(4, 2));
            int day1 = int.Parse(startYYYYMMDDHH.Substring(6, 2));
            int day2 = int.Parse(endYYYYMMDDHH.Substring(6, 2));
            DeviceDataCount ddc1 = new DeviceDataCount() { deviceId = id, deviceTable = TableUtil.DEVICE, monitorCode = MonitorType.MIC_INVERTER_TOTALYGPOWER, year = year, day = day1, month = month };
            DeviceDataCount ddc2 = new DeviceDataCount() { deviceId = id, deviceTable = TableUtil.DEVICE, monitorCode = MonitorType.MIC_INVERTER_TOTALYGPOWER, year = year, day = day2, month = month };
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
            return View();
        }

        /// <summary>
        /// 加载设备日光照统计数据
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult SunlightCount(int id, string YYYYMMDDHH)
        {
            int year = int.Parse(YYYYMMDDHH.Substring(0, 4));
            int month = int.Parse(YYYYMMDDHH.Substring(4, 2));
            int day = int.Parse(YYYYMMDDHH.Substring(6, 2));
            DeviceDataCount ddc = new DeviceDataCount() { deviceId = id, deviceTable = TableUtil.DEVICE, monitorCode = MonitorType.MIC_DETECTOR_SUNLINGHT, year = year, day = day, month = month };
            DeviceDataCount dayddc = DeviceDataCountService.GetInstance().Get(ddc);
            DeviceDataCount monthddc = DeviceDataCountService.GetInstance().GetMonthMax(ddc);
            DeviceDataCount yearddc = DeviceDataCountService.GetInstance().GetYearMax(ddc);
            ViewData["dayddc"] = dayddc;
            ViewData["monthddc"] = monthddc;
            ViewData["yearddc"] = yearddc;
            return View();
        }

        /// <summary>
        /// 加载汇流箱设备总电流最大值统计数据
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult CurrentCount(int id, string YYYYMMDDHH)
        {
            int year = int.Parse(YYYYMMDDHH.Substring(0, 4));
            int month = int.Parse(YYYYMMDDHH.Substring(4, 2));
            int day = int.Parse(YYYYMMDDHH.Substring(6, 2));
            DeviceDataCount ddc = new DeviceDataCount() { deviceId = id, deviceTable = TableUtil.DEVICE, monitorCode = MonitorType.MIC_BUSBAR_TOTALCURRENT, year = year, day = day, month = month };
            DeviceDataCount dayddc = DeviceDataCountService.GetInstance().Get(ddc);
            DeviceDataCount monthddc = DeviceDataCountService.GetInstance().GetMonthMax(ddc);
            DeviceDataCount yearddc = DeviceDataCountService.GetInstance().GetYearMax(ddc);
            ViewData["dayddc"] = dayddc;
            ViewData["monthddc"] = monthddc;
            ViewData["yearddc"] = yearddc;
            return View();
        }
    }
}
