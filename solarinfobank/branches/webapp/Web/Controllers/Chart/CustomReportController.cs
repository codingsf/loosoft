using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using System.Text;
using System.Globalization;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{

    /// <summary>
    /// 系统设置
    /// </summary>
    public class CustomReportController : Controller
    {
        CollectorYearDataService collectorYearDataService = CollectorYearDataService.GetInstance();

        //
        // GET: /ItemConfig/
        //
        [HandleError]
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 生成自定义图表
        /// </summary>
        /// <returns>自定义报表页面</returns>
        public ActionResult ChartView(int id, string startTime, string endTime)
        {
            string report = "";

            DateTime dt = DateTime.Now;
            switch (id)
            {
                default:///自定义
                    CustomChart crt = new CustomChart();
                    crt.id = id;
                    crt = CustomChartService.GetInstance().Get(crt);
                    crt.startTime = startTime;
                    crt.endTime = endTime;
                    report = GetCustomReport(crt);
                    break;
            }
            return Content(report);
        }

        /// <summary>
        /// 取得自定义图表的数据
        /// </summary>
        /// <param name="crt"></param>
        /// <returns></returns>
        private string GetCustomReport(CustomChart crt)
        {
            User user = UserUtil.getCurUser();
            DateTime dt = CalenderUtil.curDateWithTimeZone(user.timezone);

            string ret = "sorry:" + Resources.SunResource.NODATA;
            if (crt != null)
            {
                Analysis(ref crt);
                ///多设备多测点单时间报表
                List<DeviceStuct> list = new List<DeviceStuct>();
                list = GetDeviceStucts(crt);
                string reportName = crt.reportName;
                switch (crt.timeInterval.Trim().ToUpper())
                {
                    case "YEAR":

                        //if (crt.timeSlot.Trim().ToUpper().Equals("YEAR"))
                        //{  
                        ChartData chartData = CompareChartService.GetInstance().compareYearsMultiDeviceMultiMonitor(crt.reportName, list, getWorkYears(list));
                        ret = JsonUtil.convertToJson(chartData, typeof(ChartData));
                        //}
                        break;
                    case "MONTH":
                        //if (crt.timeSlot.Trim().ToUpper().Equals("YEAR"))
                        //{
                        //dtstart = dt.AddYears(-crt.tcounter.Value);
                        //}
                        //else if (crt.timeSlot.Trim().ToUpper().Equals("MONTH"))
                        // {
                        //dtstart = dt.AddMonths(-crt.tcounter.Value);
                        //}

                        chartData = CompareChartService.GetInstance().compareYearMMMultiDeviceMultiMonitor(crt.reportName, GetDeviceStucts(crt), crt.startTime, crt.endTime);
                        ret = JsonUtil.convertToJson(chartData, typeof(ChartData));
                        break;
                    case "DAY":
                        //if (crt.timeSlot.Trim().ToUpper().Equals("DAY"))
                        //{
                        //dtstart = dt.AddDays(-crt.tcounter.Value);
                        // }
                        //else if (crt.timeSlot.Trim().ToUpper().Equals("MONTH"))
                        //{
                        //dtstart = dt.AddMonths(-crt.tcounter.Value);
                        // }
                        chartData = CompareChartService.GetInstance().compareMMDDMultiDeviceMultiMonitor(crt.reportName, GetDeviceStucts(crt), crt.startTime, crt.endTime);
                        ret = JsonUtil.convertToJson(chartData, typeof(ChartData));
                        break;
                    case "HOUR":
                        //if (crt.timeSlot.Trim().ToUpper().Equals("DAY"))
                        //{
                        //    dtstart = dt.AddDays(-crt.tcounter.Value);
                        //}
                        //else if (crt.timeSlot.Trim().ToUpper().Equals("HOUR"))
                        //{
                        //    dtstart = dt.AddHours(-crt.tcounter.Value);
                        //}
                        int intervalMins = 5;
                        chartData = CompareChartService.GetInstance().compareDayHHMultiDeviceMultiMonitor(crt.reportName, GetDeviceStucts(crt), crt.startTime, crt.endTime, intervalMins);
                        ret = JsonUtil.convertToJson(chartData, typeof(ChartData));
                        break;
                    default:
                        break;
                }
            }
            return ret;
        }
        /// <summary>
        /// 取得工作年份，待完善
        /// 
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        private IList<string> getWorkYears(List<DeviceStuct> list)
        {
            IList<int> workYears = new List<int>();
            IList<string> newWorkYears = new List<string>();
            foreach (DeviceStuct ds in list)
            {
                if (ds.deviceType == ChartDeviceType.PLANT)
                {
                    Plant plant = PlantService.GetInstance().GetPlantInfoById(int.Parse(ds.deviceId));
                    workYears = CollectorYearDataService.GetInstance().GetWorkYears(plant);
                }
            }
            if (workYears.Count > 0)
            {
                foreach (int year in workYears)
                {
                    newWorkYears.Add(year.ToString());
                }
            }
            else
            {
                newWorkYears.Add(DateTime.Now.Year.ToString());
            }
            return newWorkYears;
        }
        /// <summary>
        /// 根据自定义图表，构造设备比较结构
        /// </summary>
        /// <param name="crt"></param>
        /// <returns></returns>
        private List<DeviceStuct> GetDeviceStucts(CustomChart crt)
        {

            List<DeviceStuct> list = new List<DeviceStuct>();

            string[] ss = crt.product.Split(';');

            foreach (string ssssss in ss)
            {
                if (string.IsNullOrEmpty(ssssss))
                    continue;
                string[] ssa = ssssss.Split(',');
                DeviceStuct dev = new DeviceStuct();
                dev.chartType = crt.subType;
                dev.intervalMins = 5;
                dev.rate = 1F;

                foreach (string s in ssa)
                {
                    string[] ss0 = s.Split('&');
                    if (ss0.Length == 2)
                    {
                        switch (ss0[1])
                        {
                            case "subType":
                                dev.chartType = ss0[0];
                                break;
                            case "cVal":
                                dev.cVal = int.Parse(ss0[0]);
                                break;
                            case "Unit":
                                dev.unit = ss0[0];
                                break;
                            case "valueType":
                                dev.monitorType = MonitorType.getMonitorTypeByCode(int.Parse(ss0[0]));
                                break;
                            case "0":///DeviceData.PLANT_CODE.ToString()
                                dev.deviceType = ChartDeviceType.PLANT;
                                dev.deviceId = ss0[0];
                                Plant plant = PlantService.GetInstance().GetPlantInfoById(int.Parse(dev.deviceId));
                                dev.comareObj = plant.name;
                                break;
                            default:
                                dev.deviceType = ChartDeviceType.DEVICE;
                                dev.deviceId = ss0[0];
                                Device device = DeviceService.GetInstance().get(int.Parse(dev.deviceId));
                                dev.comareObj = device.fullName;
                                break;
                        }

                    }
                }
                if (!(dev.monitorType.code != MonitorType.PLANT_MONITORITEM_ENERGY_CODE && !crt.timeInterval.Equals("Hour")))
                {
                    list.Add(dev);
                }
            }
            return list;
        }


        public string GetAjaxHead()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" <script type=\"text/jscript\">");
            sb.Append("  $(document).ready(function() {");
            return sb.ToString();
        }

        public string GetAjaxTail()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" });");
            sb.Append(" </script>");
            return sb.ToString();
        }

        public string GetGroupAjax(ChartGroup rg)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("    $('" + "#aGroupDel" + rg.id + "').click(function() {");
            sb.Append("            if (confirm(\"删除改组将会同时删除改组下的自定义报表; 确定删除'" + rg.groupName + "'？\") == \"0\") {");
            sb.Append("              return;");
            sb.Append("             } else {");
            sb.Append("             $.ajax({");
            sb.Append("              type: \"POST\",");
            sb.Append("              url: \"/CustomReport/DeleteGroup\",");
            //sb.Append("              data: { id: $('" + "#hGroup" + rg.id + "').val() },");
            sb.Append("              data: { id: \"" + rg.id + "\" },");
            sb.Append("            success: function(result) {");
            sb.Append("                 $('" + "#divGroup" + "').empty();");
            sb.Append("                 $('" + "#divGroup" + "').append(result);");
            sb.Append("              }");
            sb.Append("          });");
            sb.Append("       }");
            sb.Append("       });");
            //sb.Append("       $('" + "#aGroupEdit" + rg.id + "').click(function() {");
            //sb.Append("            $.ajax({");
            //sb.Append("                 type: \"GET\",");
            //sb.Append("                url: \"/CustomReport/CreateGroup\",");
            ////sb.Append("                data: { id: $('" + "#hGroup" + rg.id + "').val() },");
            //sb.Append("                data: { id: \"" + rg.id + "\" },");
            //sb.Append("               success: function(result) {");
            //// sb.Append("                   $('#divGroup').empty();");
            ////sb.Append("                    $('#divGroup').append(result);");
            //sb.Append("                }");
            //sb.Append("            });");
            //sb.Append("        });");
            return sb.ToString();

        }

        public string GetReporAjax(CustomChart cr)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("   $('#aReporDel" + cr.id + "').click(function() {");
            sb.Append("       if (confirm(\"确定删除自定义报表'" + cr.reportName + "'？\") == \"0\") {");
            sb.Append("           return;");
            sb.Append("         } else {");
            sb.Append("         $.ajax({");
            sb.Append("            type: \"POST\",");
            sb.Append("             url: \"/CustomReport/DeleteReport\",");
            //sb.Append("             data: { id: $('#hRepor" + cr.id + "').val() },");
            sb.Append("             data: { id: \"" + cr.id + "\"},");
            sb.Append("             success: function(result) {");
            sb.Append("             $('#divGroup').empty();");
            sb.Append("             $('#divGroup').append(result);");
            sb.Append("               }");
            sb.Append("            });");
            sb.Append("        }");
            sb.Append("    });");
            //sb.Append("   $('#aReporEdit" + cr.id + "').click(function() {");
            //sb.Append("      $.ajax({");
            //sb.Append("      type: \"POST\",");
            //sb.Append("        url: \"/CustomReport/EditReport\",");
            ////sb.Append("         data: { id: $('#hRepor" + cr.id + "').val() },");
            //sb.Append("         data: { id:\"" + cr.id + "\"},");
            //sb.Append("       success: function(result) {");
            ////sb.Append("           $('#divGroup').empty();");
            ////sb.Append("           $('#divGroup').append(result);");
            //sb.Append("       }");
            //sb.Append("         });");
            //sb.Append("    });");
            return sb.ToString();

        }


        public string GetTableHead()
        {
            return "<table width=\"100%\" border=\"0\" cellspacing=\"0\">";

        }

        public string GetTableTail()
        {
            return " </table>";
        }

        public string GetGroupTr(ChartGroup rg)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("     <tr>");
            sb.Append("      <td width=\"100%\">");
            sb.Append("        <table width=\"100%\" border=\"0\" cellspacing=\"0\" class=\"cxtal\">");
            sb.Append("           <tr>");
            sb.Append("            <td width=\"54%\" height=\"40\" align=\"left\" class=\"pl40\">");
            sb.Append("              <strong>" + rg.groupName + "</strong>");
            sb.Append("              <input id=\"hGroup" + rg.id + "\" type=\"hidden\" value=\"" + rg.id + "\" />");
            sb.Append("             </td>");
            sb.Append("             <td width=\"23%\" align=\"center\">");
            sb.Append("              <a href=\"/CustomReport/CreateGroup/" + rg.id + "\" id=\"aGroupEdit" + rg.id + "\">");
            sb.Append("               <img src=\"/images/sub/hammer_screwdriver.gif\" width=\"16\" height=\"16\" class=\"imga\" /></a>");
            sb.Append("             </td>");
            sb.Append("             <td width=\"23%\" align=\"center\">");
            sb.Append("              <a href=\"#\" id=\"aGroupDel" + rg.id + "\">");
            sb.Append("                <img src=\"/images/sub/cross.png\" width=\"16\" height=\"16\" class=\"imga\" /></a>");
            sb.Append("              </td>");
            sb.Append("               </tr>");
            sb.Append("            </table>");
            sb.Append("         </td>");
            sb.Append("      </tr>");
            return sb.ToString();
        }

        public string GetReportTr(CustomChart cr)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append(" <tr visible=\"false\">");
            sb.Append("   <td>");
            sb.Append("     <table width=\"100%\" border=\"0\" cellspacing=\"0\">");
            sb.Append("       <tr>");
            sb.Append("        <td width=\"54%\" height=\"28\" class=\"bp01 pl40\">");
            sb.Append("        " + cr.reportName + "");
            sb.Append("          <input id=\"hRepor" + cr.id + "\" type=\"hidden\" value=\"" + cr.id + "\" />");
            sb.Append("         </td>");
            sb.Append("          <td width=\"23%\" align=\"center\" class=\"bp01\">");
            sb.Append("           <a href=\"/CustomReport/Defined/" + cr.id + "\" id=\"aReporEdit" + cr.id + "\"  >");
            sb.Append("            <img src=\"/images/sub/edit.gif\" width=\"14\" height=\"14\" class=\"imga\" /></a>");
            sb.Append("          </td>");
            sb.Append("         <td align=\"center\" class=\"bp01\">");
            sb.Append("            <a href=\"#\" id=\"aReporDel" + cr.id + "\">");
            sb.Append("             <img src=\"/images/sub/del.gif\" width=\"14\" height=\"14\" class=\"imga\" /></a>");
            sb.Append("          </td>");
            sb.Append("          </tr>");
            sb.Append("          </table>");
            sb.Append("         </td>");
            sb.Append("       </tr>");

            return sb.ToString();
        }

        /// <summary>
        /// 废弃
        /// </summary>
        /// <param name="userid"></param>
        public void SetReportGroups(int userid)
        {

            IList<ChartGroup> reportGroup = ChartGroupService.GetInstance().GetReportGroupList(userid);
            Session[ComConst.ChartGroup] = reportGroup;

            IList<CustomChart> outlist = CustomChartService.GetInstance().GetListOutGroup(userid);
            Session[ComConst.ChartOutGroup] = outlist;
        }


        /// <summary>
        /// 进入分组
        /// </summary>
        /// <returns>分组界面</returns>
        [HttpGet]
        public ActionResult CreateGroup(string id)
        {

            ChartGroup group = new ChartGroup();
            User user = UserUtil.getCurUser();

            IList<CustomChart> ilistcc = CustomChartService.GetInstance().GetListByGroup(user.id, 0);
            Session[ComConst.ChartGroupDefault] = ilistcc;

            if (user != null && group != null)
            {
                group.userId = user.id;
                SetReportGroups(user.id);
            }
            if (!string.IsNullOrEmpty(id))
            {
                group.id = int.Parse(id);
                group = ChartGroupService.GetInstance().Get(group);
            }
            return View("ReportGroup", group);

        }

        /// <summary>
        /// 解析
        /// </summary>
        /// <param name="cr"></param>
        public void TextTo(ref CustomChart customReport)
        {
            if (!string.IsNullOrEmpty(customReport.product))
            {
                string[] strText = customReport.product.Split(';');
                foreach (string str in strText)
                {
                    string[] sss = str.Split(',');

                }
            }
        }
        /// <summary>
        /// 定义电站图表
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns       
        [HttpGet]
        [IsLoginAttribute]
        public ActionResult DefinedPlantChart(int id, string cid)
        {
            int temp = 0;
            int.TryParse(cid, out temp);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            SetDeviceList(plant);
            SetMI(null);
            CustomChart cus = null;
            if (string.IsNullOrEmpty(cid))
            {
                cus = new CustomChart();
                cus.groupId = 0;
                cus.plantId = plant.id;
            }
            else
            {
                cus = CustomChartService.GetInstance().Get(new CustomChart() { id = temp });
                Analysis(ref cus);
            }
            ViewData["charts"] = CustomChartService.GetInstance().GetListByPlant(cus.plantId);
            return View("CustomChart", cus);
        }

        [HttpGet]
        [IsLoginAttribute]
        public ActionResult DefinedPlantChartList(int id, string cid)
        {
            int temp = 0;
            int.TryParse(cid, out temp);
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            SetDeviceList(plant);
            SetMI(null);
            CustomChart cus = null;
            if (string.IsNullOrEmpty(cid))
            {
                cus = new CustomChart();
                cus.groupId = 0;
                cus.plantId = plant.id;
            }
            else
            {
                cus = CustomChartService.GetInstance().Get(new CustomChart() { id = temp });
                Analysis(ref cus);
            }
            ViewData["charts"] = CustomChartService.GetInstance().GetListByPlant(cus.plantId);
            return View("CustomChartList", cus);
        }



        /// <summary>
        /// 定义用户图表
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns       
        [HttpGet]
        [IsLoginAttribute]
        public ActionResult DefinedUserChart()
        {
            User user = UserUtil.getCurUser();
            SetDeviceList(user.plants);
            SetMI(null);
            CustomChart cus = new CustomChart();
            cus.groupId = 0;
            cus.userId = user.id;
            ViewData["charts"] = CustomChartService.GetInstance().GetListByGroup(user.id, 0);
            return View("CustomChart", cus);
        }

        /// <summary>
        /// 进入自定义报表
        /// </summary>
        /// <returns>自定义报表页面</returns>
        [HttpGet]
        public ActionResult modifyDefined(string id)
        {

            CustomChart cus = null;

            if (!string.IsNullOrEmpty(id))
            {
                cus = new CustomChart();
                cus.id = int.Parse(id);
                cus = CustomChartService.GetInstance().Get(cus);
            }
            Plant plant = PlantService.GetInstance().GetPlantInfoById(cus.plantId);
            SetDeviceList(plant);

            Analysis(ref cus);

            ViewData["charts"] = CustomChartService.GetInstance().GetListByPlant(cus.plantId);
            return View("CustomChart", cus);
        }

        /// <summary>
        /// 15&Plant,Power&valueType,KW&Unit,Max&cVal;
        /// 解析定义图表规则
        /// </summary>
        /// <param name="cc"></param>
        private void Analysis(ref  CustomChart cc)
        {
            if (cc != null && !string.IsNullOrEmpty(cc.product))
            {
                if (cc.customType.Trim().Equals("1"))
                {
                    string ss = cc.product.Replace(";", string.Empty);
                    string[] ssa = ss.Split(',');

                    foreach (string s in ssa)
                    {
                        string[] ss0 = s.Split('&');

                        if (ss0.Length == 2)
                        {
                            switch (ss0[1])
                            {
                                case "cVal":
                                    cc.cVal = ss0[0];
                                    break;
                                case "Unit":
                                    cc.units = ss0[0];
                                    break;
                                case "valueType":
                                    cc.valueType = ss0[0];
                                    break;
                                case "subType":
                                    cc.subType = ss0[0];
                                    break;
                                default:
                                    cc.productList = s;
                                    cc.ProIdType = s;
                                    break;
                            }

                        }
                    }
                    SetMI(cc.ProIdType);
                }

                else if (cc.customType.Trim().Equals("3"))
                {
                    if (!string.IsNullOrEmpty(cc.times))
                    {
                        List<string> slist = new List<string>();
                        string[] splis = cc.times.Split(';');
                        foreach (string ss in splis)
                        {
                            if (!string.IsNullOrEmpty(ss))
                            {
                                slist.Add(ss);
                            }
                        }
                        ViewData["TimesList"] = slist;
                    }
                }
                else
                {
                    if (!string.IsNullOrEmpty(cc.product))
                    {
                        List<SelectListItem> slist = new List<SelectListItem>();
                        string[] splis = cc.product.Split(';');
                        string[] sproductName = cc.productName.Split(';');

                        for (int i = 0; i < splis.Length; i++)
                        {
                            SelectListItem sel = new SelectListItem();
                            if (!string.IsNullOrEmpty(splis[i]))
                            {
                                sel.Value = splis[i];
                                sel.Text = sproductName[i];
                                slist.Add(sel);
                            }
                        }
                        ViewData["ProductList"] = slist;
                    }
                }

            }
            SetMI(cc.ProIdType);
        }

        /// <summary>
        /// 设置测点
        /// </summary>
        /// <param name="ProIdType"></param>
        private void SetMI(string ProIdType)
        {

            List<SelectListItem> listmi = new List<SelectListItem>();
            int deviceTypeCode = DeviceData.PLANT_CODE;
            if (!string.IsNullOrEmpty(ProIdType))
            {
                string[] strvalue = ProIdType.Split('&');
                deviceTypeCode = int.Parse(strvalue[1].Trim());
            }
            string[] items = new string[] { };
            MonitorConfig config = MonitorConfigService.GetInstance().Get(deviceTypeCode);
            if (config != null)
                items = config.items.Split(',');
            Hashtable has = new Hashtable();
            IList<MonitorType> mts = MonitorType.getMonitorTypesByTypeCode(deviceTypeCode);
            if (mts != null)
            {
                foreach (MonitorType item in mts)
                {
                    foreach (string s in items)
                    {
                        if (s.Equals(item.code.ToString()))
                        {
                            listmi.Add(new SelectListItem() { Text = item.name, Value = item.code.ToString() });
                            break;
                        }

                    }
                }
            }

            ViewData["MonitorItems"] = listmi;

        }

        /// <summary>
        /// 设置某个电站的设备
        /// </summary>
        /// <param name="plant"></param>
        public void SetDeviceList(Plant plant)
        {
            this.SetDeviceList(new List<Plant>() { plant });
        }
        /// <summary>
        /// 设置电站所有的设备列表
        /// </summary>
        /// <param name="user"></param>
        public void SetDeviceList(IList<Plant> plants)
        {
            List<SelectListItem> DeviceList = new List<SelectListItem>();
            foreach (Plant plant in plants)
            {
                DeviceList.Add(new SelectListItem { Text = plant.name, Value = plant.id + "&" + DeviceData.PLANT_CODE });
                foreach (PlantUnit unit in plant.plantUnits)
                {
                    DeviceList.Add(new SelectListItem { Text = "--" + unit.displayname, Value = "" });
                    if (unit.displayDevices != null && unit.displayDevices.Count > 0)
                    {
                        foreach (Device device in unit.displayDevices)
                        {
                            try
                            {
                                DeviceList.Add(new SelectListItem { Text = "----" + device.fullName, Value = device.id + "&" + device.deviceTypeCode });
                            }
                            catch
                            { }
                        }
                    }
                }
            }
            ViewData[ComConst.DeviceList] = DeviceList;
        }


        /// <summary>
        /// 删除分组
        /// </summary>
        /// <param name="customReport"></param>
        /// <returns></returns>
        public ActionResult DeleteGroup(string id, string returnUrl)
        {
            User user = UserUtil.getCurUser();
            ChartGroup mode = new ChartGroup();
            mode.id = int.Parse(id);
            ChartGroupService.GetInstance().Remove(mode);
            CustomChartService.GetInstance().Delete(mode.id);

            //  string ret = GetHtml(user.id);
            return new RedirectResult(returnUrl);

        }



        /// <summary>
        /// 删除报表
        /// </summary>
        /// <param name="customReport"></param>
        /// <returns></returns>
        [HttpPost]
        [IsLoginAttribute]
        public ActionResult DeleteReport(int id)
        {
            CustomChart mode = new CustomChart();
            mode.id = id;
            int flag = CustomChartService.GetInstance().Remove(mode);
            User user = UserUtil.getCurUser();

            string ret = GetHtml(user.id);
            return RedirectToAction("ReportGroup", ret);
        }


        /// <summary>
        /// 删除系统配置
        /// </summary>
        /// <param name="id">配置Id</param>
        /// <returns>系统配置列表</returns>
        [HttpGet]
        [IsLoginAttribute]
        public ActionResult Delete(int id, string returnUrl)
        {
            CustomChart mode = new CustomChart();
            UpdateModel(mode, Request.Form.AllKeys);

            int flag = CustomChartService.GetInstance().Remove(mode);

            return new RedirectResult(returnUrl);
        }

        /// <summary>
        /// 保存分组
        /// </summary>    
        [HttpPost]
        public ActionResult SaveGroup(ChartGroup customReport)
        {
            int flag = 0;
            string ret = Resources.SunResource.CUSTOM_SAVE_SUCCESSFULLY;
            User user = UserUtil.getCurUser();
            if (null != user && UserUtil.demousername.Equals(user.username))
            {
                ret = "Sorry,exampleuser prohibit to save";
                return Content(ret);
            }
            else if (string.IsNullOrEmpty(customReport.groupName))
            {
                ret = Resources.SunResource.CUSTOMREPORT_PLEASE_ENTER_GROUP;
                return Content(ret);
            }
            try
            {
                if (ChartGroupService.GetInstance().Get(customReport) != null)
                {
                    flag = ChartGroupService.GetInstance().Update(customReport);
                }
                else
                {
                    flag = ChartGroupService.GetInstance().Insert(customReport);
                }
            }
            catch (Exception ee)
            { }
            return Content(ret);
        }



        /// <summary>
        /// 保存报表
        /// </summary>
        [HttpPost]
        [IsLoginAttribute]
        public ActionResult Save(CustomChart customReport, string cid)
        {
            int temp = 0;
            int.TryParse(cid, out temp);
            customReport.id = temp;
            customReport.groupId = 0;
            string ret = Resources.SunResource.CUSTOM_SAVE_SUCCESSFULLY;

            if (customReport != null)
            {
                if (!customReport.customType.Equals("2") && string.IsNullOrEmpty(customReport.product))
                {
                    customReport.product = customReport.ProIdType;
                }
            }
            User user = UserUtil.getCurUser();
            if (null != user && UserUtil.demousername.Equals(user.username))
            {
                ret = "Sorry,exampleuser prohibit to save";
                return Content(ret);
            }
            else if (string.IsNullOrEmpty(customReport.reportName))
            {
                ret = Resources.SunResource.CUSTOMREPORT_SAVE_FAILED_NAME;
                return Content(ret);
            }
            else if (customReport.customType.Trim().Equals("2") && string.IsNullOrEmpty(customReport.product))
            {
                ret = Resources.SunResource.CUSTOMREPORT_SAVE_FAILED_EQUIPMENT;
                return Content(ret);
            }
            else if (customReport.customType.Trim().Equals("3") && string.IsNullOrEmpty(customReport.times))
            {
                ret = Resources.SunResource.CUSTOMREPORT_SAVE_FAILED_TIME;
                return Content(ret);
            }

            int flag = 0;

            try
            {
                if (customReport.id <= 0)
                {
                    flag = CustomChartService.GetInstance().Insert(customReport);
                }
                else if (CustomChartService.GetInstance().Get(customReport) != null)
                {
                    flag = CustomChartService.GetInstance().Update(customReport);
                }
                else
                {
                    flag = CustomChartService.GetInstance().Insert(customReport);
                }
            }
            catch (Exception ee)
            {
                ret = "Save failed！" + ee.Message;
                return Content(ret);
            }
            return Content(ret);
        }

        /// <summary>
        /// 产生分组列表
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        public string GetHtml(int userid)
        {
            StringBuilder strAjax = new StringBuilder();
            StringBuilder strTable = new StringBuilder();

            IList<ChartGroup> list = ChartGroupService.GetInstance().GetReportGroupList(userid);
            if (list != null && list.Count > 0)
            {
                strAjax.Append(GetAjaxHead());
                strTable.Append(GetTableHead());

                foreach (ChartGroup rgp in list)
                {
                    strAjax.Append(GetGroupAjax(rgp));
                    strTable.Append(GetGroupTr(rgp));
                    foreach (CustomChart cr in rgp.CustomReports)
                    {
                        strAjax.Append(GetReporAjax(cr));
                        strTable.Append(GetReportTr(cr));
                    }

                }
                strAjax.Append(GetAjaxTail());
                strTable.Append(GetTableTail());
            }
            return strAjax.ToString() + strTable.ToString();
        }


        /// <summary>
        /// 动态产生单位等下拉框列表
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DropDownList(string lang)
        {
            Session["Culture"] = new CultureInfo(lang);
            string customType = Request.Form["customType"];
            string valuetype = Request.Form["selectvalue"];
            string type = Request.Form["selecttype"];
            string timeInterval = Request.Form["timeInterval"];//报表时间类型
            StringBuilder sb = new StringBuilder();
            //单位
            if (type.Trim().Equals("ValueType"))
            {
                if (!string.IsNullOrEmpty(valuetype) && !valuetype.Trim().ToLower().Equals("null"))
                {
                    try
                    {
                        int imi = int.Parse(valuetype.Trim());

                        MonitorType mm = MonitorType.getMonitorTypeByCode(imi);
                        if (mm != null && !string.IsNullOrEmpty(mm.unit))
                        {
                            string[] sunit = mm.units();
                            foreach (string ss in sunit)
                            {
                                sb.Append("<option value=\"" + ss + "\">" + ss + "</option>");
                            }
                        }
                    }
                    catch
                    { }
                }
            }
            else if (type.Trim().Equals("TimeSlot"))//时间大类
            {
                sb.Append("  <select id=\"timeInterval\" name=\"timeInterval\" class = \"subselect02\">");

                if (valuetype.ToLower().Trim().Equals(ComConst.Time_YEAR.ToLower().Trim()))
                {
                    sb.Append(" <option title=\"YEAR\" value=\"YEAR\">YEAR</option>");

                    sb.Append(" <option title=\"MONTH\" value=\"MONTH\">MONTH</option>");
                }
                else if (valuetype.ToLower().Trim().Equals(ComConst.Time_MONTH.ToLower().Trim()))
                {
                    sb.Append(" <option title=\"MONTH\" value=\"MONTH\">MONTH</option>");

                    sb.Append("  <option title=\"DAY\" value=\"DAY\">DAY</option>");
                }
                else if (valuetype.ToLower().Trim().Equals(ComConst.Time_DAY.ToLower().Trim()))
                {
                    sb.Append("  <option title=\"DAY\" value=\"DAY\">DAY</option>");

                    sb.Append("  <option title=\"HOUR\" value=\"HOUR\">HOUR</option>");
                }
                sb.Append("  </select>");

            }
            else if (type.Trim().Equals("IdType"))
            {
                string[] strvalue = valuetype.Split('&');
                if (strvalue != null && strvalue.Length == 2)
                {
                    int deviceTypeCode = int.Parse(strvalue[1].Trim());
                    IList<MonitorType> mts = MonitorType.getFilterMonitorTypesByTypeCode(deviceTypeCode);

                    IList<MonitorType> temp = new List<MonitorType>();

                    string[] items = new string[] { };
                    MonitorConfig config = MonitorConfigService.GetInstance().Get(deviceTypeCode);
                    if (config != null)
                        items = config.items.Split(',');

                    foreach (MonitorType monitor in mts)
                    {
                        foreach (string s in items)
                        {
                            if (s.Equals(monitor.code.ToString()))
                            {
                                temp.Add(monitor);
                                break;
                            }
                        }
                    }





                    if (temp != null)
                    {
                        if (deviceTypeCode == DeviceData.INVERTER_CODE && !timeInterval.Equals("Hour"))
                        {
                            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
                            sb.Append(" <option value=\"" + mt.code + "\">" + mt.name + "</option>");
                        }
                        else
                        {
                            foreach (MonitorType item in temp)
                            {
                                //if (item.code == MonitorType.MIC_DETECTOR_ADR || item.code == MonitorType.MIC_DETECTOR_SOI || item.code == MonitorType.MIC_DETECTOR_WINDDIRECTION || item.code == MonitorType.MIC_BUSBAR_MAXLINE || item.code == MonitorType.MIC_BUSBAR_COMMUNICATION || item.code == MonitorType.MIC_BUSBAR_DIGITALINPUT || item.code == MonitorType.MIC_BUSBAR_JDQOUT || item.code == MonitorType.MIC_BUSBAR_MAXLINE || item.code == MonitorType.MIC_INVERTER_STATUSTIME || item.code == MonitorType.MIC_INVERTER_DEVICESTATUS || item.code == MonitorType.MIC_INVERTER_OUTTYPE || item.code == MonitorType.MIC_INVERTER_POWER || item.code == MonitorType.MIC_INVERTER_RUNTIME || item.code == MonitorType.MIC_INVERTER_STATUSDATA1 || item.code == MonitorType.MIC_INVERTER_STATUSDATA2 || item.code == MonitorType.MIC_INVERTER_STATUSDATA3 || item.code == MonitorType.MIC_INVERTER_TODAYENERGY)
                                //    continue;
                                sb.Append(" <option value=\"" + item.code + "\">" + item.name + "</option>");
                            }
                        }
                    }
                }
            }

            return Content(sb.ToString());
        }

        /// <summary>
        /// 预览
        /// </summary>
        /// <param name="customReport"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Preview(CustomChart customReport)
        {
            string ret = "";
            CustomChart crt = new CustomChart();
            if (customReport != null)
            {
                crt = customReport;
            }
            ret = GetCustomReport(crt);

            return Content(ret);
        }

        /// <summary>
        /// 加载自定义图表页面
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult CustomChartPage(int id)
        {
            if (id == 0)
                id = int.Parse(Session["customID"].ToString());

            ViewData["cid"] = id;
            CustomChart cc = CustomChartService.GetInstance().Get(new CustomChart() { id = id });
            ViewData["gid"] = cc.groupId;
            ViewData["customChart"] = cc;
            FillYearsList();
            return View();
        }

        /// <summary>
        /// 获取电站年份
        /// </summary>
        private void FillYearsList()
        {
            User user = UserUtil.getCurUser();
            IList<int> yearList = collectorYearDataService.GetWorkYears(user.plants);
            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
            ViewData["plantYear"] = plantYearsList;
        }
        /// <summary>
        /// 加载自定义图表页面
        /// </summary>
        /// <returns></returns>
        [IsLoginAttribute]
        public ActionResult CustomChartPage2()
        {
            int id = int.Parse(Session["customID"].ToString());

            ViewData["cid"] = id;
            CustomChart cc = CustomChartService.GetInstance().Get(new CustomChart() { id = id });
            ViewData["gid"] = cc.groupId;
            ViewData["customChart"] = cc;
            FillYearsList();
            return View("CustomChartPage");
        }

        [HttpPost]
        [IsLoginAttribute]
        public ActionResult DeleteChart(int id)
        {
            CustomChart mode = new CustomChart();
            mode.id = id;
            CustomChartService.GetInstance().Remove(mode);
            return Content("success");
        }
    }
}
