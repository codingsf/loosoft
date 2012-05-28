using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Collections;
using Common;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class DataDownLoadController : BaseController
    {
        CollectorYearDataService collectorYearDataService = CollectorYearDataService.GetInstance();
        ReportService reportService = ReportService.GetInstance();
        /// <summary>
        /// 根据电站Id填充电站年份
        /// </summary>
        /// <param name="plantId"></param>
        public void FillPlantYears(string plantId)
        {
            if (!(string.IsNullOrEmpty(plantId)) && plantId != "null")
            {
                Plant plant = FindPlant(int.Parse(plantId));
                IList<int> yearList = collectorYearDataService.GetWorkYears(plant);
                IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
                ViewData["plantYear"] = plantYearsList;
            }
            else
            {
                User users =UserUtil.getCurUser();
                IList<int> yearList = collectorYearDataService.GetWorkYears(users.plants);
                IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);
                ViewData["plantYear"] = plantYearsList;
            }
        }

        public ActionResult DownLoadDayReport(string id, string reportId, string cTime)
        {
            DefineReport report = reportService.GetRunReportById(reportId);
            int tId = report.ReportType;
            IList<string> dataList = new List<string>();
            IList<object> obj = reportService.getDatabyItemCodes(report, cTime);
            IList<int> itemCode = addIntNumtoList(obj[0] as List<int>);
            Hashtable plantDataHash = obj[1] as Hashtable;
            Hashtable deviceDataHash = obj[2] as Hashtable;
            CsvStreamWriter csv = new CsvStreamWriter();
            dataList.Add("                        " + report.ReportName + "                       ");
            ArrayList list2 = new ArrayList();
            list2.Add("                                         " + Resources.SunResource.REPORT_VIEW_TIME);
            list2.Add(cTime);
            dataList.Add(csv.ConvertToSaveLine(list2));
            dataList.Add(Resources.SunResource.REPORT_PLANT_COUNT_DATA);
            ArrayList list3 = new ArrayList();
            ArrayList list4 = new ArrayList();
            int i = 1;
            foreach (int code in itemCode)
            {

                int tmpcode = code;
                string keystr = " ", keyvalue = " ";

                if (i == 5)
                {
                    i = 1;
                }
                else
                {
                    i++;
                }
                if (tmpcode != 0)
                {
                    keystr = DataItem.getNameByCode(tmpcode);
                    keyvalue = plantDataHash[tmpcode].ToString();
                    list3.Add(keystr);
                    list3.Add(keyvalue);
                }

            }
            dataList.Add(csv.ConvertToSaveLine(list3));
            dataList.Add(Resources.SunResource.REPORT_DEVICE_COUNT_DATA);


            list4.Add(Resources.SunResource.REPORT_COUNT_ITEM);
            list4.Add(Resources.SunResource.REPORT_COUNT_DEVICE);
            list4.Add("7:00");
            list4.Add("8:00");
            list4.Add("9:00");
            list4.Add("10:00");
            list4.Add("11:00");
            list4.Add("12:00");
            list4.Add("13:00");
            list4.Add("14:00");
            list4.Add("15:00");
            list4.Add("16:00");
            list4.Add("17:00");
            list4.Add("18:00");
            list4.Add("19:00");
            list4.Add(Resources.SunResource.REPORT_COUNT_TODAYSUN);
            dataList.Add(csv.ConvertToSaveLine(list4));

            foreach (DictionaryEntry de in deviceDataHash)
            {
                i = 1;
                string tmpcode = de.Key.ToString();
                string keystr = "", unit = "";
                if (!tmpcode.StartsWith(" "))
                {
                    keystr = DataItem.getNameByCode(int.Parse(tmpcode));
                    unit = MonitorType.getMonitorTypeByCode(int.Parse(tmpcode)).unit;
                }
                IList<string[]> dataArrList = (IList<string[]>)de.Value;
                for (int k = 1; k < dataArrList.Count; k++)
                {
                    ArrayList list5 = new ArrayList();
                    string[] dataArr = dataArrList[k];
                    if (i == 1)
                    {
                        i++;
                        list5.Add(keystr + " " + unit);

                        list5.Add(dataArr[1]);
                        list5.Add(dataArr[2]);
                        list5.Add(dataArr[3]);
                        list5.Add(dataArr[4]);
                        list5.Add(dataArr[5]);
                        list5.Add(dataArr[6]);
                        list5.Add(dataArr[7]);
                        list5.Add(dataArr[8]);
                        list5.Add(dataArr[9]);
                        list5.Add(dataArr[10]);
                        list5.Add(dataArr[11]);
                        list5.Add(dataArr[12]);
                        list5.Add(dataArr[13]);
                        list5.Add(dataArr[14]);
                        list5.Add(dataArr[15]);
                    }
                    else
                    {
                        list5.Add(" ");
                        list5.Add(dataArr[1]);
                        list5.Add(dataArr[2]);
                        list5.Add(dataArr[3]);
                        list5.Add(dataArr[4]);
                        list5.Add(dataArr[5]);
                        list5.Add(dataArr[6]);
                        list5.Add(dataArr[7]);
                        list5.Add(dataArr[8]);
                        list5.Add(dataArr[9]);
                        list5.Add(dataArr[10]);
                        list5.Add(dataArr[11]);
                        list5.Add(dataArr[12]);
                        list5.Add(dataArr[13]);
                        list5.Add(dataArr[14]);
                        list5.Add(dataArr[15]);
                    }
                    dataList.Add(csv.ConvertToSaveLine(list5));
                }

            }
            CsvStreamWriter scvWriter = new CsvStreamWriter();
            scvWriter.AddStrDataList(dataList);
            scvWriter.Save(Server.MapPath("/") + "tempexportfile/" + (report.ReportName + "-" + cTime) + ".csv");
            //转化为csv格式的字符串
            //string res="dsfdsf";
            //byte[] bytes = Encoding.Default.GetBytes(res);
            return File(Server.MapPath("/") + "tempexportfile/" + (report.ReportName + "-" + cTime) + ".csv", "text/csv; charset=UTF-8", urlcode(report.ReportName.Replace(" ", "") + "-" + cTime) + ".csv");
        }

        public ActionResult DownLoadReport(string id, string reportId, string cTime)
        {
            
            DefineReport report = reportService.GetRunReportById(reportId);
            int tId = report.ReportType;
            if (tId == DataReportType.TODAY_REPORT_CODE || tId == DataReportType.WEEK_REPORT_CODE)
            {
                if ((string.IsNullOrEmpty(cTime) || cTime == "undefined"))
                {
                    cTime = DateTime.Now.ToString("yyyy-MM-dd");
                }
            }
            if (tId == DataReportType.MONTH_REPORT_CODE && (string.IsNullOrEmpty(cTime) || cTime == "undefined"))
            {
                cTime = DateTime.Now.ToString("yyyy-MM");
            }
            if (tId == DataReportType.YEAR_REPORT_CODE && (string.IsNullOrEmpty(cTime) || cTime == "undefined"))
            {
                cTime = DateTime.Now.ToString("yyyy");
            }
            ViewData["time"] = cTime;
            if (!(string.IsNullOrEmpty(id)))
            {
                if (tId == DataReportType.TODAY_REPORT_CODE)
                    return DownLoadDayReport(id, reportId, cTime);
                else
                    return DownLoadNotDayReport(id, reportId, cTime);
            }
            else
            {
                return DownLoadAllPlantsReport(id,reportId,cTime);
            }

        }

        [IsLoginAttribute]
        public ActionResult DownLoadAllPlantsReport(string id,string reportId,string cTime)
        {

            DefineReport report = reportService.GetRunReportById(reportId);
            int tId = report.ReportType;
            string weekTime = string.Empty;
            if (tId == DataReportType.TOTAL_REPORT_CODE)
            {
                IList<int> workYears = null;
                if (!(string.IsNullOrEmpty(id)))
                {
                    workYears = collectorYearDataService.GetWorkYears(report.plant);
                }
                else
                {
                    workYears = collectorYearDataService.GetWorkYears(report.user.plants);
                }
                if (workYears.Count > 0)
                {
                    cTime = workYears[0] + "-" + workYears[workYears.Count - 1];
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
                weekTime = year1 + "/" + mm1 + "/" + dd1 + "-" + year2 + "/" + mm2 + "/" + dd2;


            }
            IList<string> dataList = new List<string>();
            IList<object> obj = reportService.getDatabyItemCodes(report, cTime);
            IList<int> itemCode = addIntNumtoList(obj[0] as List<int>);
            Hashtable plantDataHash = obj[1] as Hashtable;
            Hashtable deviceDataHash = obj[2] as Hashtable;
            CsvStreamWriter csv = new CsvStreamWriter();
            dataList.Add("                        " + report.ReportName + "                       ");
           
            ArrayList list2 = new ArrayList();
            list2.Add("                                         " + Resources.SunResource.REPORT_VIEW_TIME);
            if (tId == 2)
            {
                list2.Add(weekTime);
            }
            else
            {
                list2.Add(cTime);
            }
            dataList.Add(csv.ConvertToSaveLine(list2));
            dataList.Add(Resources.SunResource.REPORT_PLANT_COUNT_DATA);
            ArrayList list3 = new ArrayList();
           
            int i = 1;
            foreach (int code in itemCode)
            {

                int tmpcode = code;
                string keystr = " ", keyvalue = " ";

                if (i == 5)
                {
                    i = 1;
                }
                else
                {
                    i++;
                }

                if (tmpcode != 0)
                {
                    keystr = DataItem.getNameByCode(tmpcode);
                    keyvalue = plantDataHash[tmpcode].ToString();
                    list3.Add(keystr);
                    list3.Add(keyvalue);
                }
            }
            dataList.Add(csv.ConvertToSaveLine(list3));
            CsvStreamWriter scvWriter = new CsvStreamWriter();
            scvWriter.AddStrDataList(dataList);
            scvWriter.Save(Server.MapPath("/") + "tempexportfile/" + (report.ReportName + "-" + cTime) + ".csv");
            //转化为csv格式的字符串
            //string res="dsfdsf";
            //byte[] bytes = Encoding.Default.GetBytes(res);

            return File(Server.MapPath("/") + "tempexportfile/" + (report.ReportName + "-" + cTime) + ".csv", "text/csv; charset=UTF-8", urlcode(report.ReportName.Replace(" ", "") + "-" + cTime) + ".csv");
        }

        [IsLoginAttribute]
        public ActionResult DownLoadNotDayReport(string id, string reportId, string cTime)
        {
            DefineReport report = reportService.GetRunReportById(reportId);
            int tId = report.ReportType;
            string weekTime = string.Empty;
            if (tId == DataReportType.TOTAL_REPORT_CODE)
            {
                IList<int> workYears = null;
                if (!(string.IsNullOrEmpty(id)))
                {
                    workYears = collectorYearDataService.GetWorkYears(report.plant);
                }
                else
                {
                    workYears = collectorYearDataService.GetWorkYears(report.user.plants);
                }
                if (workYears.Count > 0)
                {
                    cTime = workYears[0] + "-" + workYears[workYears.Count - 1];
                   
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
                 weekTime = year1 + "/" + mm1 + "/" + dd1 + "-" + year2 + "/" + mm2 + "/" + dd2;
            }
            IList<string> dataList = new List<string>();
            IList<object> obj = reportService.getDatabyItemCodes(report, cTime);
            IList<int> itemCode = addIntNumtoList(obj[0] as List<int>);
            Hashtable plantDataHash = obj[1] as Hashtable;
            Hashtable deviceDataHash = obj[2] as Hashtable;
            CsvStreamWriter csv = new CsvStreamWriter();
            dataList.Add("                        " + report.ReportName + "                       ");
            ArrayList list2 = new ArrayList();
            list2.Add("                                         " + Resources.SunResource.REPORT_VIEW_TIME);
            if (tId == DataReportType.WEEK_REPORT_CODE)
            {
                list2.Add(weekTime);
            }
            else
            {
                list2.Add(cTime);
            }
            dataList.Add(csv.ConvertToSaveLine(list2));
            dataList.Add(Resources.SunResource.REPORT_PLANT_COUNT_DATA);
            ArrayList list3 = new ArrayList();
            ArrayList list4 = new ArrayList();
            int i = 1;
            foreach (int code in itemCode)
            {

                int tmpcode = code;
                string keystr = " ", keyvalue = " ";

                if (i == 5)
                {
                    i = 1;
                }
                else
                {
                    i++;
                }
                if (tmpcode != 0)
                {
                    keystr = DataItem.getNameByCode(tmpcode);
                    keyvalue = plantDataHash[tmpcode].ToString();
                    list3.Add(keystr);
                    list3.Add(keyvalue);
                }

            }
            dataList.Add(csv.ConvertToSaveLine(list3));
            dataList.Add(Resources.SunResource.REPORT_DEVICE_COUNT_DATA);

            foreach (DictionaryEntry de in  deviceDataHash)
            {
                i = 1;
                string tmpcode = de.Key.ToString();
                string keystr = "", unit = "";
                if (!tmpcode.StartsWith(" "))
                {
                    keystr = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).name;
                    unit = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit;
                }
                IList<string[]> dataArrList = (IList<string[]>)de.Value;
                for (int k = 0; k < dataArrList.Count; k++)
                {
                    ArrayList list5 = new ArrayList();
                    string[] dataArr = dataArrList[k];
                    if (i == 1)
                    {
                        i++;
                        foreach (string v in dataArr)
                        {
                            list5.Add(v);
                        }
                    }
                    else if (i == 2)
                    {
                        i++;
                        list5.Add(keystr + " " + unit);
                        for (int n = 1; n < dataArr.Length; n++)
                        {
                            list5.Add(dataArr[n]);
                        }
                    }
                    else
                    {
                        for (int m = 0; m < dataArr.Length; m++)
                        {
                         
                           list5.Add(dataArr[m]==null?" ":dataArr[m]);
                        }
                    }
                   dataList.Add(csv.ConvertToSaveLine(list5));
                }
            }
            CsvStreamWriter scvWriter = new CsvStreamWriter();
            scvWriter.AddStrDataList(dataList);
            scvWriter.Save(Server.MapPath("/") + "tempexportfile/" + (report.ReportName + "-" + cTime) + ".csv");
            //转化为csv格式的字符串
            //string res="dsfdsf";
            //byte[] bytes = Encoding.Default.GetBytes(res);
            return File(Server.MapPath("/") + "tempexportfile/" + (report.ReportName + "-" + cTime) + ".csv", "text/csv; charset=UTF-8", urlcode(report.ReportName.Replace(" ", "") + "-" + cTime) + ".csv");
        }


        private string convertArrtoStr(string[] arr)
        {
            StringBuilder sb = new StringBuilder();
            foreach (string a in arr)
            {
                sb.Append(",").Append(a);
            }
            return sb.ToString();
        }

        private string convertArrtoStr(float?[] arr)
        {
            StringBuilder sb = new StringBuilder();
            foreach (float? a in arr)
            {
                sb.Append(",").Append(a);
            }
            return sb.ToString();
        }
        /// <summary>
        /// 补齐5的整数量，方便前台显示
        /// </summary>
        /// <param name="hashtable"></param>
        /// <returns></returns>
        private IList<int> addIntNumtoList(IList<int> oList)
        {
            int count = oList.Count;
            int inum = count % 5 > 0 ? (count / 5 + 1) : (count / 5);
            for (int i = inum * 5; i > count; i--)
            {
                oList.Add(0);
            }
            return oList;
        }

    }
}
