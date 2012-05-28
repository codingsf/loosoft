using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Text;
using Common;
using System.Configuration;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
using System.Collections;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    /// <summary>
    /// 数据导出
    /// </summary>
    public class DataExportController : BaseController
    {

        static string exportFilePath = ConfigurationSettings.AppSettings["export.file.path"];
        //
        // GET: /DataExport/

        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// 导出图表数据
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="serieNo"></param>
        /// <param name="type">导出类型</param>
        /// <returns></returns>
        public ActionResult ExportChart(string filename, string serieNo, string type)
        {
            if (type.ToLower().EndsWith("xls"))
            {
                return this.ExportExcelChart(filename, serieNo);
            }
            else if (type.ToLower().EndsWith("csv"))
            {
                return this.ExportCsvChart(filename, serieNo);
            }
            else
            {
                return Content("");
            }
        }

        private bool DrawChartImage(ChartData chartData, string chartPath)
        {
            if (chartData == null || chartData.isHasData == false)
                return false;
            int axisXInterval = 1;
            bool multiY = false;

            #region 图表横轴interval

            if (chartData.categories.Length > 0)
            {
                string category = chartData.categories[0];
                if (Regex.IsMatch(category, "^\\d{4}$"))//年统计图表
                    axisXInterval = 1;
                else
                    if (chartData.categories.Length.Equals(12) || chartData.categories.Length.Equals(15))
                        axisXInterval = 1;
                    else
                        if (chartData.categories.Length >= 28 && chartData.categories.Length <= 31 || chartData.categories.Length.Equals(34))
                            axisXInterval = 1;
                        else
                            axisXInterval = 24;
            }

            #endregion

            string chartName = chartData.name;
            multiY = chartData.units.Length > 1 && chartName.Contains("&");
            string unit = string.Empty;
            unit = chartData.units[0];
            JavaScriptSerializer jserializer = new JavaScriptSerializer();
            int seriesCount = 0;
            Chart Chart = new Chart();
            Chart.Width = 1000;
            Chart.Height = 500;
            Title title = new Title(chartName, Docking.Top, new System.Drawing.Font("Trebuchet MS", 12, System.Drawing.FontStyle.Regular), System.Drawing.Color.FromArgb(26, 59, 105));
            Chart.Titles.Add(title);
            Chart.ChartAreas.Add("ChartAreas 1");
            Chart.ChartAreas[0].AxisX.Interval = axisXInterval;
            Chart.ChartAreas[0].AxisY.IntervalAutoMode = IntervalAutoMode.VariableCount;
            Chart.ChartAreas[0].AxisY2.IntervalAutoMode = IntervalAutoMode.VariableCount;
            //Chart.ChartAreas[0].AxisX.MajorTickMark.Interval = 2;//次要辅助线间隔
            Chart.ChartAreas[0].AxisX.IntervalOffset = 0;
            //Chart.ChartAreas[0].AxisX.MinorGrid.LineWidth = 0;
            Chart.ChartAreas[0].AxisX.MajorGrid.LineWidth = 0;
            Chart.ChartAreas[0].AxisY.MajorGrid.LineWidth = 1;
            Chart.ChartAreas[0].AxisY.MajorGrid.LineColor = System.Drawing.Color.FromArgb(209, 208, 206);
            Chart.ChartAreas[0].AxisY2.MajorGrid.LineColor = System.Drawing.Color.FromArgb(209, 208, 206);
            Chart.ChartAreas[0].AxisY.Title = string.Format("[{0}]", unit);
            Chart.ChartAreas[0].AxisX.LabelStyle.Angle = -90;//横坐标字符倾斜角度

            #region 图例配置

            Legend legend = new Legend();
            legend.Alignment = StringAlignment.Center;
            legend.Docking = Docking.Bottom;
            legend.Name = string.Format("Legends {0}", 0);
            Chart.Legends.Add(legend);

            #endregion

            Chart.SuppressExceptions = true;
            while (seriesCount++ < chartData.series.Length)
            {

                #region 设置图表类型

                SeriesChartType seriesChartType = SeriesChartType.Column;

                string chartType = chartData.series[seriesCount - 1].type;
                if (chartType.ToLower().Equals("area"))
                    seriesChartType = SeriesChartType.Area;
                if (chartType.ToLower().Equals("line"))
                    seriesChartType = SeriesChartType.Line;
                if (chartType.ToLower().Equals("column"))
                    seriesChartType = SeriesChartType.Column;

                #endregion

                #region 设置图表颜色

                string color = chartData.series[seriesCount - 1].color;
                string r = color.Substring(1, 2);
                string g = color.Substring(3, 2);
                string b = color.Substring(5, 2);

                #endregion


                IList<KeyValuePair<string, float?>> outputData = new List<KeyValuePair<string, float?>>();
                for (int i = 0; i < chartData.categories.Length; i++)
                    outputData.Add(new KeyValuePair<string, float?>(chartData.categories[i], chartData.series[seriesCount - 1].data[i]));
                Chart.Series.Add(string.Format("Series {0}", seriesCount - 1));
                Chart.Series[seriesCount - 1].Points.DataBind(outputData, "key", "value", "");
                Chart.Series[seriesCount - 1].Color = System.Drawing.Color.FromArgb(Convert.ToInt32(r, 16), Convert.ToInt32(g, 16), Convert.ToInt32(b, 16));
                Chart.Series[seriesCount - 1].XValueType = ChartValueType.String;
                Chart.Series[seriesCount - 1].ChartType = seriesChartType;
                #region 图例

                //图例文字
                Chart.Series[seriesCount - 1].LegendText = chartData.series[seriesCount - 1].name;


                #endregion

                if (multiY)
                {
                    Chart.Series[seriesCount - 1].YAxisType = seriesCount % 2 == 1 ? AxisType.Primary : AxisType.Secondary;
                }

            }
            Chart.BorderSkin.SkinStyle = BorderSkinStyle.None;
            Chart.SaveImage(chartPath);
            return true;
        }

        [HttpPost]
        public ActionResult ExportPdfChart(string fileName, string date, string data)
        {
            JavaScriptSerializer jserializer = new JavaScriptSerializer();
            ChartData chartData = null;
            chartData = jserializer.Deserialize<ChartData>(data);
            if (chartData != null)
            {
                string displayPdfName = string.Empty;
                string folderPath = Server.MapPath("/tempexportfile");
                string fullPdfPath = folderPath + "/" + fileName + ".pdf";
                string fullImgPath = string.Format("{0}/{1}.jpg", folderPath, Guid.NewGuid());

                //-------------------------------以下为生成pdf代码
                displayPdfName = fileName + chartData.name.Replace("/", "").Replace(" ", "");

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
                if (DrawChartImage(chartData, fullImgPath))
                {
                    iTextSharp.text.Image JPG = iTextSharp.text.Image.GetInstance(fullImgPath);
                    JPG.ScalePercent(50f);
                    doc.Add(JPG);
                }

                PdfPTable table = new PdfPTable(chartData.series.Count() + 1);
                table.AddCell(new PdfPCell(new Phrase(Resources.SunResource.CUSTOMREPORT_CHART_TIME, font)));
                string unit = string.Empty;
                bool isprocessUnit = true;
                int firsIndex = chartData.series[0].name.IndexOf('[');
                int lastIndex = chartData.series[0].name.LastIndexOf(']');
                if (chartData.units.Count().Equals(1) || chartData.units.GroupBy(m => m.ToString()).Count().Equals(1))//只有一个项目或者所有单位相同
                {
                    unit = chartData.units[0];
                    isprocessUnit = false;
                }
                int yy = DateTime.Now.Year;
                int mm = DateTime.Now.Month;
                int dd = DateTime.Now.Day;
                int hh = DateTime.Now.Hour;
                int MM = DateTime.Now.Minute;
                int ss = DateTime.Now.Second;

                date = date == null ? string.Empty : date.ToString();
                date = date.Equals("undefined") ? string.Empty : date;

                if (Regex.IsMatch(date, "^\\d{10}$"))//日请求数据
                {
                    yy = int.Parse(date.Substring(0, 4));
                    mm = int.Parse(date.Substring(4, 2));
                    dd = int.Parse(date.Substring(6, 2));
                }
                else
                    if (Regex.IsMatch(date, "^\\d{8}$"))//月请求数据
                    {
                        yy = int.Parse(date.Substring(0, 4));
                        mm = int.Parse(date.Substring(4, 2));
                    }
                    else
                        if (Regex.IsMatch(date, "^\\d{4}$"))//年请求数据
                        {
                            yy = int.Parse(date);
                        }

                IList<int> years = new List<int>();
                for (int x = 0; x < chartData.series.Count(); x++)
                {

                    string name = chartData.series[x].name;
                    name = name.Contains('-') ? name.Substring(0, name.LastIndexOf('-')) : name;
                    if (name.Contains('['))
                        name = isprocessUnit == false ? name.Substring(0, name.IndexOf('[')) : name;
                    name = name.Replace("-", " ");
                    if (Regex.IsMatch(name, "^\\d{4}$"))//多年比较 
                        years.Add(int.Parse(name));

                    table.AddCell(new PdfPCell(new Phrase(name, font)));

                }

                int y = 0;
                for (; y < chartData.categories.Count(); y++)
                {
                    string dStr = chartData.categories[y];
                    if (Regex.IsMatch(dStr, "^\\d{2}:\\d{2}/\\d{2}$"))//日请求数据
                    {
                        dd = int.Parse(dStr.Substring(6, 2));
                        hh = int.Parse(dStr.Substring(0, 2));
                        MM = int.Parse(dStr.Substring(3, 2));
                    }
                    else
                        if (Regex.IsMatch(dStr, "^\\d{2}$"))//月请求数据
                        {
                            dd = int.Parse(dStr.Substring(0, 2));
                        }
                        else
                        {
                            if (Regex.IsMatch(dStr, "^\\d{4}$"))//总请求数据 
                            {
                                yy = int.Parse(dStr);
                            }
                            else if (Regex.IsMatch(dStr.ToLower(), "^[a-z]*$") || date.Length == 4 || date == string.Empty)
                            {
                                mm = y + 1;
                            }

                        }
                    switch (mm)
                    {
                        case 2:
                            dd = dd > 28 ? 28 : dd;
                            break;
                        case 4:
                        case 6:
                        case 9:
                        case 11:
                            dd = dd > 30 ? 30 : dd;
                            break;
                    }
                    DateTime dNow = new DateTime(yy, mm, dd, hh, MM, ss);
                    table.AddCell(new PdfPCell(new Phrase(dStr, font)));

                    int index = 0;
                    while (index++ < chartData.series.Count())
                    {
                        if (years.Count > 1)//说明多年比较
                            dNow = new DateTime(years[index - 1], mm, dd, hh, MM, ss);
                        table.AddCell(new PdfPCell(new Phrase(chartData.series[index - 1].data[y] == null ? dNow < DateTime.Now ? "None" : string.Empty : ((double)chartData.series[index - 1].data[y]).ToString("0.00"), font)));
                    }
                }
                doc.Add(table);
                doc.Close();
                if (System.IO.File.Exists(fullImgPath))
                    System.IO.File.Delete(fullImgPath);
                //-----------------------pdf 代码结束
                ActionResult tmp = File(fullPdfPath, "application/pdf; charset=UTF-8", urlcode(displayPdfName) + ".pdf");
                return tmp;
            }
            return Content("");


        }
        /// <summary>
        /// 导出csv格式的图表数据
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="serieNo"></param>
        /// <returns></returns>
        public ActionResult ExportCsvChart(string filename, string serieNo)
        {
            CsvStreamWriter scvWriter = new CsvStreamWriter();
            ChartData chartData = TempDataUtil.getChartData(serieNo);
            string reportname = string.Empty;
            if (chartData != null)
            {
                reportname = (filename.Equals("chart") ? "" : filename) + chartData.name.Replace("/", "").Replace(" ", "");
                IList<string> dataList = new List<string>();
                dataList.Add(convertArrtoStr(chartData.categories));
                foreach (YData ydata in chartData.series)
                {
                    dataList.Add(ydata.name);
                    dataList.Add(convertArrtoStr(ydata.data));
                }
                scvWriter.AddStrDataList(dataList);
            }
            string fullFile = Server.MapPath("/") + "tempexportfile\\" + serieNo + ".csv";
            scvWriter.Save(fullFile);
            //转化为csv格式的字符串
            ActionResult tmp = File(fullFile, "text/csv; charset=UTF-8", urlcode(reportname) + ".csv");
            return tmp;
        }

        private string convertArrtoStr(string[] arr)
        {
            StringBuilder sb = new StringBuilder();
            string hourTime;
            for (int i = 0; i < arr.Length; i++)
            {
                if (arr.Length == 288)
                {
                    if (i <= 60 || i > 240) continue;
                }
                hourTime = arr[i];
                sb.Append(",").Append(hourTime);
            }
            return sb.ToString();
        }

        private string convertArrtoStr(float?[] arr)
        {
            StringBuilder sb = new StringBuilder();
            float? data;
            for (int i = 0; i < arr.Length; i++)
            {
                if (arr.Length == 288)
                {
                    if (i <= 60 || i > 240) continue;
                }
                data = arr[i];
                sb.Append(",").Append(data);
            }
            return sb.ToString();
        }

        /// <summary>
        /// 导出excel数据
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="serieNo"></param>
        /// <returns></returns>
        public ActionResult ExportExcelChart(string filename, string serieNo)
        {
            ChartData chartData = null;// TempDataUtil.getChartData(serieNo+"_large");
            if (chartData == null)
            {
                chartData = TempDataUtil.getChartData(serieNo);
            }

            IList<ExcelData> datas = new List<ExcelData>();
            ExcelData data = new ExcelData();
            string reportname = string.Empty;
            bool isMulti = false;
            if (chartData != null)
            {
                isMulti = ReportBuilder.isMulti(chartData.units);

                reportname = (filename.Equals("chart") ? "" : filename) + chartData.name.Replace("/", "").Replace(" ", "");

                IList<string> xList = new List<string>();
                xList.Add("  ");
                int n = 1;// chartData.categories.Length > 100 ? 12 : 1;
                for (int k = 0; k < chartData.categories.Length; k = k + n)
                {
                    string x = chartData.categories[k];
                    xList.Add(x);
                }
                data.Rows.Add(xList);
                IList<string> tmps = null;
                string[] series = new string[chartData.series.Count()];
                for (int i = 0; i < chartData.series.Count(); i++)
                {
                    if (i > 0 && isMulti)
                    {
                        data = new ExcelData();
                    }
                    tmps = new List<string>();
                    string yname = chartData.series[i].name;
                    tmps.Add(yname);

                    for (int k = 0; k < chartData.series[i].data.Length; k = k + n)
                    {
                        float? f = chartData.series[i].data[k];
                        tmps.Add(f == null ? string.Empty : double.Parse(f.ToString()).ToString("0.00"));
                    }
                    data.Rows.Add(tmps);
                    if (isMulti)
                    {
                        int slen = yname.IndexOf("[");
                        int endLen = yname.IndexOf("]");
                        if (slen > -1)
                        {
                            data.Title = yname.Substring(slen + 1, endLen - slen - 1);
                        }
                        else
                        {
                            data.Title = yname;
                        }
                        data.series = new String[] { chartData.series[i].name };
                        data.chartType = chartData.series[i].type;
                        datas.Add(data);
                    }
                    else
                    {
                        series[i] = chartData.series[i].name;
                    }
                }

                if (!isMulti && chartData.series.Count() > 0)
                {
                    int slen = chartData.series[0].name.IndexOf("[");
                    int endLen = chartData.series[0].name.IndexOf("]");
                    if (slen > -1)
                    {
                        data.Title = chartData.series[0].name.Substring(slen + 1, endLen - slen - 1);
                    }
                    else
                    {
                        data.Title = chartData.series[0].name;
                    }
                    data.series = series;
                    data.chartType = chartData.series[0].type;
                    datas.Add(data);
                }
            }

            ExcelStreamWriter xlsWriter = new ExcelStreamWriter(reportname, datas, chartData.units, reportname, "", isMulti);
            xlsWriter.Save(true);
            return File(xlsWriter.FullName, "text/xls; charset=UTF-8", urlcode(xlsWriter.FileName));
        }

    }
}
