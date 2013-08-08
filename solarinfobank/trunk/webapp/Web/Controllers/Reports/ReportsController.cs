using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Collections;
using System.Globalization;


namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class ReportsController : BaseController
    {
        //
        // GET: /Reports/
        ReportService reportService = ReportService.GetInstance();
        ReportDataItemService dataItemService = ReportDataItemService.GetInstance();
        ReportConfigService reportConfigService = ReportConfigService.GetInstance();
        CollectorYearDataService collectorYearDataService = CollectorYearDataService.GetInstance();

        public ActionResult ReportIndex(string id, int userId)
        {
            ViewData["id"] = id;
            ViewData["userId"] = userId;
            return View();
        }
        /// <summary>
        ///
        /// </summary>
        /// <returns></returns>
        public ActionResult allReportIndex(int userId)
        {
            ViewData["id"] = null;
            ViewData["userId"] = userId;
            return View("ReportIndex");
        }

        /// <summary>
        /// 取得运行报表列表
        /// </summary>
        /// <param name="id">页码</param>
        /// <returns></returns>
        public ActionResult RunReport(string id, string plantId, string userId)
        {
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
                User user = UserService.GetInstance().Get(int.Parse(plant.userID.ToString()));
                ViewData["user"] = user;
                base.FillPlantYears(int.Parse(plantId));

                Hashtable table = new Hashtable();
                table.Add("page", page);
                table.Add("PlantId", plantId);
                items = reportService.GetRunReportsByPageByPlantId(table);
            }
            else
            {
                User user = UserService.GetInstance().Get(int.Parse(userId));
                ViewData["user"] = user;
                base.FillAllPlantYears(user);
                Hashtable table = new Hashtable();
                table.Add("page", page);
                table.Add("UserId", user.id);
                items = reportService.GetRunReportsListByUserId(table);
            }
            ViewData["Culture"] = Session["Culture"];

            return View(items);
        }

        /// <summary>
        /// 回填事件报表
        /// </summary>
        /// <param name="id">电站Id</param>
        /// <returns></returns>
        public ActionResult EventReport(int id)
        {
            ViewData["plantId"] = id;
            ReportConfig eventConfig = reportConfigService.GetEventReportConfigByIdAndReportId(id);
            if (eventConfig != null && string.IsNullOrEmpty(eventConfig.email) == false)
                eventConfig.email = eventConfig.email.Replace(",", ";");
            ViewData["config"] = eventConfig;
            return View(eventConfig);
        }

        /// <summary>
        /// 查看报表
        /// </summary>
        /// <param name="id"></param>
        /// <param name="cTime"></param>
        /// <param name="tId"></param>
        /// <returns></returns>

        public ActionResult ViewReport(string rId, string cTime, string tId, string pId, string type)
        {
            string lang = Request.QueryString["lang"];
            if (string.IsNullOrEmpty(lang) == false)
                Session["Culture"] = new CultureInfo(lang);
            ViewData["preview"] = "";
            ViewData["rId"] = rId;
            DefineReport report = ReportService.GetInstance().GetRunReportById(rId);
            return HandleViewReport(report, int.Parse(tId), cTime, pId, type);
        }

        /// <summary>
        /// 真正处理报表数据和返回视图的地方，预览和查看公用
        /// </summary>
        /// <param name="report"></param>
        /// <param name="cTime"></param>
        /// <param name="pId"></param>
        /// <returns></returns>
        private ActionResult HandleViewReport(DefineReport report, int tId, string cTime, string pId, string type)
        {
            ViewData["Culture"] = Session["Culture"];
            ViewData["rId"] = report.Id;
            ViewData["tId"] = tId.ToString();
            ViewData["cTime"] = cTime;
            ViewData["pId"] = pId;
            if (!(string.IsNullOrEmpty(pId)))
            {
                if (string.IsNullOrEmpty(cTime)) cTime = CalenderUtil.curDateWithTimeZone(report.plant.timezone, "yyyyMMdd");
            }
            else
            {
                if (string.IsNullOrEmpty(cTime)) cTime = CalenderUtil.curDateWithTimeZone(report.user.timezone, "yyyyMMdd");
            }

            ViewData["time"] = cTime;
            if (tId == DataReportType.TOTAL_REPORT_CODE)
            {
                IList<int> workYears = null;
                if (!(string.IsNullOrEmpty(pId)))
                {
                    workYears = collectorYearDataService.GetWorkYears(report.plant);
                    cTime = CalenderUtil.curDateWithTimeZone(report.plant.timezone, "yyyy");
                }
                else
                {
                    workYears = collectorYearDataService.GetWorkYears(report.user.displayPlants);
                    cTime = CalenderUtil.curDateWithTimeZone(report.user.timezone, "yyyy");
                }
                if (workYears.Count > 0)
                {
                    cTime = workYears[0] + "-" + workYears[workYears.Count - 1];
                    ViewData["time"] = cTime;
                }
                else
                {
                    cTime += "-" + cTime;
                    ViewData["time"] = Resources.SunResource.NO_WORK_YEARS;
                }
            }
            else if (tId == DataReportType.WEEK_REPORT_CODE)
            {
                string[] wTime = reportService.convertToDateArr(tId, cTime);
                int year1 = int.Parse(wTime[0].Substring(0, 4));
                int mm1 = int.Parse(wTime[0].Substring(4, 2));
                int dd1 = int.Parse(wTime[0].Substring(6, 2));
                int year2 = int.Parse(wTime[1].Substring(0, 4));
                int mm2 = int.Parse(wTime[1].Substring(4, 2));
                int dd2 = int.Parse(wTime[1].Substring(6, 2));
                string weekTime = year1 + "/" + mm1 + "/" + dd1 + "-" + year2 + "/" + mm2 + "/" + dd2;
                ViewData["time"] = weekTime;
            }
            else if (tId == DataReportType.MONTH_REPORT_CODE)
            {
                cTime = cTime.Split('-').Length > 2 ? cTime.Substring(0, cTime.LastIndexOf("-")) : cTime;
                ViewData["time"] = cTime;
            }
            else if (tId == DataReportType.YEAR_REPORT_CODE)
            {
                cTime = cTime.Split('-').Length > 2 ? cTime.Substring(0, cTime.IndexOf("-")) : cTime;
                ViewData["time"] = cTime;
            }

            if (report != null)
            {
                IList<Object> datalist = reportService.getDatabyItemCodes(report, cTime);
                if (datalist.Count != 0)
                {
                    ViewData["deviceHash"] = (Hashtable)datalist[2];
                    ViewData["plantItemCodes"] = addIntNumtoList((IList<int>)datalist[0]);
                    ViewData["plantHash"] = (Hashtable)datalist[1];
                    ViewData["deviceItemCodes"] = (IList<int>)datalist[3];
                }
                else
                {
                    ViewData["NoData"] = LanguageUtil.getDesc("NODATA");
                }
            }
            else
            {
                ViewData["NoData"] = LanguageUtil.getDesc("NODATA");
            }

            if (!(string.IsNullOrEmpty(pId)))
            {
                base.FillPlantYears(int.Parse(pId));

                string yyyy = ViewData["cTime"] != null ? ViewData["cTime"] as string : DateTime.Now.Year.ToString();

                yyyy = yyyy.Length >= 4 ? yyyy.Substring(0, 4) : yyyy;


                if (ViewData[ComConst.WorkYears] != null && (ViewData[ComConst.WorkYears] as IList<SelectListItem>).Count > 0)
                {
                    foreach (SelectListItem item in ViewData[ComConst.WorkYears] as IList<SelectListItem>)
                    {
                        item.Selected = false;
                        item.Selected = item.Text.Equals(yyyy);
                    }
                }




                if (tId == DataReportType.TODAY_REPORT_CODE)
                {
                    if (string.IsNullOrEmpty(type))
                        return View("ViewDayReport", report);
                    else
                        return View("EmailViewDayReport", report);
                }
                else
                {
                    if (string.IsNullOrEmpty(type))
                        return View("ViewNotDayReport", report);
                    else
                        return View("EmailViewNotDayReport", report);
                }
            }
            else
            {
                base.FillAllPlantYears(report.user);


                string yyyy = ViewData["cTime"] != null ? ViewData["cTime"] as string : DateTime.Now.Year.ToString();

                yyyy = yyyy.Length >= 4 ? yyyy.Substring(0, 4) : yyyy;


                if (ViewData[ComConst.WorkYears] != null && (ViewData[ComConst.WorkYears] as IList<SelectListItem>).Count > 0)
                {
                    foreach (SelectListItem item in ViewData[ComConst.WorkYears] as IList<SelectListItem>)
                    {
                        item.Selected = false;
                        item.Selected = item.Text.Equals(yyyy);
                    }

                }
                if (string.IsNullOrEmpty(type))
                    return View("ViewUserReport", report);
                else
                    return View("EmailViewUserReport", report);
            }
        }

        /// <summary>
        /// 补齐3的整数量，方便前台显示
        /// </summary>
        /// <param name="hashtable"></param>
        /// <returns></returns>
        private IList<int> addIntNumtoList(IList<int> oArr)
        {
            int count = oArr.Count;
            int inum = count % 3 > 0 ? (count / 3 + 1) : (count / 3);
            for (int i = inum * 3; i > count; i--)
            {
                oArr.Add(0);
            }
            return oArr;
        }

        public ActionResult DeleteReport(string id, string plantId)
        {
            reportService.DeleteReportById(id);
            reportConfigService.DeleteReportConfigByReportId(int.Parse(id));
            if (!string.IsNullOrEmpty(plantId))
            {
                return RedirectToAction("PlantReport", "plant", new { @id = plantId });
            }
            else
            {
                return Redirect("/user/AllPlantsReport");
            }
        }

        [IsLoginAttribute]
        public ActionResult SaveReport(DefineReport report, ReportConfig rc)
        {
            int lastId = 0;
            if (report.PlantId == 0)
            {
                report.UserId = (UserUtil.getCurUser()).id;//如果是所有电站就取当前用户ID
            }
            lastId = reportService.AddRunReport(report);
            rc.reportId = lastId;
            if (string.IsNullOrEmpty(rc.email) == false)
                rc.email = rc.email.Replace(";", ",");
            reportConfigService.SendEventReport(rc);
            if (report.PlantId == 0)
            {
                return Redirect("/user/AllPlantsReport");
            }
            else
            {
                return RedirectToAction("PlantReport", "plant", new { @id = report.PlantId });
            }
        }


        [IsLoginAttribute]
        public ActionResult UpdateReport(DefineReport report, ReportConfig rc)
        {
            if (report.PlantId == 0)
            {
                report.UserId = (UserUtil.getCurUser()).id;
            }
            rc.reportId = report.Id;

            if (string.IsNullOrEmpty(rc.email) == false)
                rc.email = rc.email.Replace(";", ",");


            reportConfigService.UpdateReportConfig(rc);
            reportService.EditReportById(report);

            if (report.PlantId == 0)
            {
                return Redirect("/user/AllPlantsReport");
            }
            else
            {
                return RedirectToAction("PlantReport", "plant", new { @id = report.PlantId });
            }
        }

        [IsLoginAttribute]
        public ActionResult CreateReport(string plantId)
        {
            if (!string.IsNullOrEmpty(plantId) && !plantId.Equals("null"))
            {
                ViewData["plantId"] = plantId;
                FillPlantYears(int.Parse(plantId));
                ViewData["userId"] = null;
            }
            else
            {
                User user = UserUtil.getCurUser();
                base.FillAllPlantYears(user);
                ViewData["userId"] = user.id;
            }

            return View();

        }
        /// <summary>
        /// 显示编辑页面
        /// </summary>
        /// <param name="id">报表Id</param>
        /// <param name="plantId">电站Id</param>
        /// <returns></returns>
        public ActionResult EditReport(string id, string plantId)
        {
            ViewData["id"] = id;
            DefineReport report = reportService.GetRunReportById(id);
            ViewData["pId"] = plantId;
            ViewData["userId"] = report.UserId;
            ViewData["dataItems"] = report.dataitem;
            ViewData["reportTypeId"] = report.ReportType;
            //IList<DataItem> list=
            ReportConfig config = reportConfigService.GetReportConfigByReportId(int.Parse(id));
            if (string.IsNullOrEmpty(config.email) == false)
                config.email = config.email.Replace(",", ";");
            config.defineReport = report;
            if (string.IsNullOrEmpty(plantId) || "null".Equals(plantId))
            {
                base.FillAllPlantYears(report.user);
                ViewData["userId"] = report.user.id;
            }
            else
            {
                FillPlantYears(int.Parse(plantId));
            }
            return View(config);
        }
        /// <summary>
        /// 根据报表类型取得数据项
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult ShowDataItemByType(string id)
        {
            IList<DataItem> list = dataItemService.GetFilterDataItemListByCode(int.Parse(id));
            IList<ReportDataItem> showList = new List<ReportDataItem>();
            foreach (DataItem item in list)
            {
                showList.Add(new ReportDataItem(item.code));
            }
            ViewData["list"] = showList;

            return View();
        }

        public ActionResult ShowUserDataItemByType(int id)
        {
            id = 10 + id;
            IList<DataItem> list = dataItemService.GetFilterDataItemListByCode(id);
            IList<ReportDataItem> showList = new List<ReportDataItem>();
            foreach (DataItem item in list)
            {
                showList.Add(new ReportDataItem(item.code));
            }
            ViewData["list"] = showList;

            return View("ShowDataItemByType");
        }

        public ActionResult SaveEventReport(ReportConfig config, int idstr)
        {
            config.id = idstr;
            config.sendMode = Session[ComConst.User].ToString();//这里保存用户ID
            if (string.IsNullOrEmpty(config.email) == false)
                config.email = config.email.Replace(";", ",");
            reportConfigService.UpdateEventReport(config);
            TempData["eventreport"] = "0";
            ViewData["id"] = config.plantId;

            return RedirectToAction("PlantReport", "plant", new { @id = config.plantId });

        }
        /// <summary>
        /// 报表预览 包括所有电站和单个电站
        /// 其实报表预览就是查看唯一区别是要重新组织成一个报表对象作为输入而已
        /// </summary>
        /// <param name="id">数据项名称</param>
        /// <param name="tId">报表类型</param>
        /// <param name="rName">报表名称</param>
        /// <returns></returns>
        public ActionResult PreviewReport(string userId, string dataItem, int tId, string rName, string cTime, string plantId, string type)
        {
            ViewData["preview"] = "preview";
            DefineReport report = new DefineReport();
            if (string.IsNullOrEmpty(plantId) || plantId.Equals("null"))
            {
                plantId = null;
                report.user = UserService.GetInstance().Get(int.Parse(userId));
                report.UserId = report.user.id;
            }
            else
            {
                report.PlantId = int.Parse(plantId);
                report.plant = PlantService.GetInstance().GetPlantInfoById(report.PlantId);
            }
            report.ReportName = rName;
            report.ReportType = tId;
            report.dataitem = dataItem;
            return HandleViewReport(report, tId, cTime, plantId, type);
        }
    }
}

