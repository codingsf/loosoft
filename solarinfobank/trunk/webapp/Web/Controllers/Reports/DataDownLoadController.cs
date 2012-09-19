using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Collections;
using Common;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Text;
using System.Web.Script.Serialization;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Configuration;
using System.IO;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class DataDownLoadController : BaseController
    {
        private static string type_csv = "csv";//报表类型csv
        private static string type_xls = "xls";//报表类型excel
        private static string type_pdf = "pdf";//报表类型pdf
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
                IList<int> yearList = collectorYearDataService.GetWorkYears(users.displayPlants);
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
                    workYears = collectorYearDataService.GetWorkYears(report.user.displayPlants);
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
                    workYears = collectorYearDataService.GetWorkYears(report.user.displayPlants);
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

        /// <summary>
        /// 下载设备历史数据
        /// add by qhb in 20120917 
        /// </summary>
        /// <param name="deviceId">设备id</param>
        /// <param name="yyyyMMdd"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public ActionResult DownLoadRundata(int deviceId, string yyyyMMdd, string type)
        {
            //设备
            Device device = DeviceService.GetInstance().get(deviceId);
            //或者数据
            IList<string> allmts = new List<string>();//所有测点
            IDictionary<string, IDictionary<string, string>> timemtMap = DeviceDayDataService.GetInstance().handleDayData(allmts, device, yyyyMMdd);
            string filename = device.fullName + yyyyMMdd + Resources.SunResource.DEVICE_HISTORYRUN_DATA;//下载文件名称
            //判断类型
            if (type_csv.Equals(type)) {
                return DownLoadCsvRunData(allmts, timemtMap, filename);
            }
            else if (type_xls.Equals(type))
            {
                return DownLoadExcelRunData(allmts, timemtMap, filename);
            }
            else {
                return DownLoadPdfRunData(allmts, timemtMap, filename);
            }
        }

        /// <summary>
        /// 输出csv文件
        /// </summary>
        /// <param name="allmts"></param>
        /// <param name="timemtMap"></param>
        /// <param name="filename"></param>
        /// <returns></returns>
        public ActionResult DownLoadCsvRunData(IList<string> allmts, IDictionary<string, IDictionary<string, string>> timemtMap, string filename)
        {
            CsvStreamWriter scvWriter = new CsvStreamWriter();

            //输入出到csv文件中的数据列表
            IList<string> dataList = new List<string>();
            //设置抬头行
            dataList.Add("                        " + filename + "                       ");
            //循环设置数据行
            //设置标题行
            allmts.Insert(0, Resources.SunResource.REPORT_TIME);
            dataList.Add(scvWriter.ConvertToSaveLine(allmts));
            //数据行临时list
            IList<string> tempList = new List<string>();
            foreach (string key in timemtMap.Keys) {
                dataList.Add(scvWriter.ConvertToSaveCell(key) + "," + scvWriter.ConvertToSaveLine(timemtMap[key].Values));
            }

            scvWriter.AddStrDataList(dataList);
            scvWriter.Save(Server.MapPath("/") + "tempexportfile/" + filename + ".csv");
            return File(Server.MapPath("/") + "tempexportfile/" + filename + ".csv", "text/csv; charset=UTF-8", urlcode(filename) + ".csv");
        }

        /// <summary>
        /// 导出excel数据
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="serieNo"></param>
        /// <returns></returns>
        public ActionResult DownLoadExcelRunData(IList<string> allmts, IDictionary<string, IDictionary<string, string>> timemtMap, string filename)
        {
            IList<ExcelData> datas = new List<ExcelData>();
            ExcelData data = new ExcelData();
            bool isMulti = false;
            //标题行
            IList<string> xList = new List<string>();
            xList.Add("                        " + filename + "                       ");
            xList.Add(Resources.SunResource.REPORT_TIME);
            foreach (string key in timemtMap.Keys)
            {
                xList.Add(key);
            }
            data.Rows.Add(xList);
            datas.Add(data);

            IList<string> tmps = null;
            foreach (string mtkey in allmts)
            {
                data = new ExcelData();
                tmps = new List<string>();
                tmps.Add("        ");
                tmps.Add(mtkey);
                foreach (string key in timemtMap.Keys)
                {
                    //第一列是时间
                    tmps.Add(timemtMap[key][mtkey]);
                }
                data.Rows.Add(tmps);
                datas.Add(data);
            }

            ExcelStreamWriter xlsWriter = new ExcelStreamWriter(filename, datas, new string[] { }, "", "", isMulti);
            xlsWriter.Save(false);
            return File(xlsWriter.FullName, "text/xls; charset=UTF-8", urlcode(xlsWriter.FileName));
        }

        /// <summary>
        /// 导出pdf运行时数据
        /// </summary>
        /// <param name="allmts"></param>
        /// <param name="timemtMap"></param>
        /// <param name="filename"></param>
        /// <returns></returns>
        public ActionResult DownLoadPdfRunData(IList<string> allmts, IDictionary<string, IDictionary<string, string>> timemtMap, string filename)
        {
            string displayPdfName = filename;
            string fullPdfPath = Server.MapPath("/") + "tempexportfile/" + filename + ".pdf";

            //-------------------------------以下为生成pdf代码
            var doc = new Document();
            //string binPath = Server.MapPath(@"/bin");
            // BaseFont.AddToResourceSearch(binPath + "/iTextAsian.dll");
            //BaseFont.AddToResourceSearch(binPath + "/iTextAsianCmaps.dll");
            //中文支持
            BaseFont baseFont = BaseFont.CreateFont(ConfigurationManager.AppSettings["languageEncodePath"], BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

            //BaseFont baseFont = BaseFont.CreateFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);

            iTextSharp.text.Font font = new iTextSharp.text.Font(baseFont, 9, iTextSharp.text.Font.NORMAL);

            PdfWriter.GetInstance(doc, new FileStream(fullPdfPath, FileMode.Create));

            doc.Open();
            //生成图表图片
            PdfPTable table = new PdfPTable(allmts.Count+1);
            table.AddCell(new PdfPCell(new Phrase(Resources.SunResource.REPORT_TIME, font)));

            foreach (string mtkey in allmts) {
                table.AddCell(new PdfPCell(new Phrase(mtkey, font)));    
            }
            doc.Add(table);

            foreach (string timekey in timemtMap.Keys) {
                table = new PdfPTable(allmts.Count + 1);
                table.AddCell(new PdfPCell(new Phrase(timekey, font)));
                foreach (string mtvalue in timemtMap[timekey].Values) {
                    table.AddCell(new PdfPCell(new Phrase(mtvalue, font)));    
                }
                doc.Add(table);
            }

            doc.Close();
            //-----------------------pdf 代码结束
            ActionResult tmp = File(fullPdfPath, "application/pdf; charset=UTF-8", urlcode(displayPdfName) + ".pdf");
            return tmp;

        }

    }
}
