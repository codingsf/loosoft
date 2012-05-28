using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Excel = Microsoft.Office.Interop.Excel;
using System.Reflection;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class ExcelUtil
    {
        public static void createChart()
        {

            Excel.Application xlApp = null;
            Excel.Workbook xlBook;
            Excel.Workbooks xlBooks;
            Excel.Sheets xlsheets;
            Excel.Worksheet xlSheet;
            try
            {
                xlApp = new Excel.Application();
                xlBooks = xlApp.Workbooks;
                xlBook = xlBooks.Add(Missing.Value);
                xlsheets = xlBook.Worksheets;
                xlSheet = (Excel.Worksheet)xlsheets.get_Item(1);
                // xlApp.DisplayAlerts = false;
                // create cell header
                object[] objHeaders = { "Count", "num1", "num2", "num3", "num4" };
                // set header text
                //xlRange = xlSheet.get_Range("A1", "E1");
                //xlRange.set_Value(Missing.Value, objHeaders);
                //xlRange.Font.Bold = true;
                //xlRange.Font.Name = "Verdana";
                //xlRange.Font.Size = 10;
                //xlRange.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                for (int i = 0; i < 1; i++)
                {
                    xlSheet.Cells[1, 1 + i] = "";
                    xlSheet.Cells[2, 1 + i] = i + 1 + "k";
                    xlSheet.Cells[3, 1 + i] = i + 2 + "k";
                    xlSheet.Cells[4, 1 + i] = i + 3 + "k";
                    xlSheet.Cells[5, 1 + i] = i + 4 + "k";
                }

                for (int i = 1; i < 3; i++)
                {
                    xlSheet.Cells[1, 1 + i] = "dd" + i;
                    xlSheet.Cells[2, 1 + i] = i + 1;
                    xlSheet.Cells[3, 1 + i] = i + 2;
                    xlSheet.Cells[4, 1 + i] = i + 3;
                    xlSheet.Cells[5, 1 + i] = i + 4;
                }
                List<ChartStuct> css = new List<ChartStuct>();
                ChartStuct cs = new ChartStuct();
                cs.dataRange = xlSheet.get_Range(xlApp.Cells[1, 1], xlApp.Cells[5, 2]);
               // cs.dataRange = xlSheet.get_Range("A2:E2", "A3:E11");
                cs.seriesTitles = new string[]{"s1","s2","s3","s4","s5"};
                cs.yname="功率";
                cs.chartType = Excel.XlChartType.xlLine;
                css.Add(cs);
                cs = new ChartStuct();
                cs.dataRange = xlSheet.get_Range(xlApp.Cells[2, 3], xlApp.Cells[5, 3]);
                // cs.dataRange = xlSheet.get_Range("A2:E2", "A3:E11");
                cs.seriesTitles = new string[] { "s1", "s2", "s3", "s4", "s5" };
                cs.yname = "功率2";
                cs.chartType = Excel.XlChartType.xlLine;
                css.Add(cs);
               // xlSheet.get_Range(xlApp.Cells[1, 1], xlApp.Cells[2, 5]).NumberFormat = "@";
                //xlSheet.get_Range(xlApp.Cells[1, 1], xlApp.Cells[2, 5]).HorizontalAlignment = Excel.XlVAlign.xlVAlignCenter;
                               
                createInnerChart(xlSheet, css, "设备功率图", "dd");

                xlBook.SaveAs("d:\\Analysis.xls", Missing.Value,
                    Missing.Value, Missing.Value, Missing.Value, Missing.Value,
                    Excel.XlSaveAsAccessMode.xlNoChange, Missing.Value, Missing.Value,
                    Missing.Value, Missing.Value, Missing.Value);
                xlBook.Close(false, Missing.Value, Missing.Value);

            }
            catch (Exception ec)
            {
                Console.WriteLine(ec.Message);
            }
            finally
            {
                xlSheet = null;
                xlBook = null;
                xlApp = null;
            }
        }
        //Excel.XlChartType.xl3DColumn
        /// <summary>
        /// 给工作添加一个图标工作表
        /// </summary>
        /// <param name="xlBook">工作簿</param>
        /// <param name="dataSheet">数据工作表</param>
        /// <param name="xData">x轴数据区域：格式A1:A14</param>
        /// <param name="ydata">y轴数据区域：格式B1:E14</param>
        /// <param name="chartName">图标名称</param>
        /// <param name="xname">y轴名称</param>
        /// <param name="yname">y轴名称</param>
        /// <param name="chartType">图表类型</param>
        public static void createSingleChart(Excel.Workbook xlBook,Excel.Worksheet dataSheet,string xData,string ydata,string chartName,string xname,string yname,Excel.XlChartType chartType) { 
            Excel.Chart xlChart = (Excel.Chart)xlBook.Charts.Add(Missing.Value, Missing.Value, Missing.Value, Missing.Value);
            Excel.Range chartRage = dataSheet.get_Range(xData, ydata);
            xlChart.ChartWizard(chartRage, chartType, Missing.Value, Excel.XlRowCol.xlRows, 1, 1, true, chartName, xname, yname, Missing.Value);
        }

        /// <summary>
        /// 给工作表添加一个图表
        /// </summary>
        /// <param name="firstRange">数据工作表</param>
        /// <param name="xData">x轴数据区域：格式A1:A14</param>
        /// <param name="ydata">y轴数据区域：格式B1:E14</param>
        /// <param name="chartName">图标名称</param>
        /// <param name="xname">y轴名称</param>
        /// <param name="yname">y轴名称</param>
        /// <param name="chartType">图表类型</param>
        public static void createInnerChart(Excel.Worksheet dataSheet, List<ChartStuct> charts, string chartName,string categoryName)
        {

            Excel.ChartObjects ChartObjects = (Excel.ChartObjects)dataSheet.ChartObjects(Missing.Value);

            int cols = 0;
            foreach(ChartStuct chartStuct in charts){
                cols += chartStuct.dataRange.Columns.Count;
            }

            Excel.ChartObject chartObject = ChartObjects.Add(cols * 60, 30 , 800, 350);

            if (charts.Count < 1) return;//无数不处理

            //绘制第一维图表
            Excel.Range firstRange = charts[0].dataRange;
            Excel.XlChartType chartType = charts[0].chartType;
            string yname = charts[0].yname;
            chartObject.Chart.ChartWizard(firstRange, chartType, Missing.Value, Excel.XlRowCol.xlColumns, 1, 1, true, chartName, categoryName, yname, Missing.Value);

            Excel.SeriesCollection seriesCollection = (Excel.SeriesCollection)chartObject.Chart.SeriesCollection(Type.Missing);
            int sc = seriesCollection.Count;
            //绘制第二维图表
            //修改第一维图表的各个序列的图例,这里有个bug，会用最后的标题覆盖前面的
           // for (int i = 0; i < charts[0].seriesTitles.Length; i++)
            //{
                //string stitle = charts[0].seriesTitles[i];

                //Excel.Series tmpSeires = (Excel.Series)seriesCollection.Item(1);
                //tmpSeires.Name = stitle;
            //}

            //绘制第二个图表,多维这里设置 当有图表类型为XlChartType.xl3DColumn或其他3d效果时，抛 xlSeries.AxisGroup = Excel.XlAxisGroup.xlSecondary;异常
            for (int i = 1; i < charts.Count; i++)
            {
                ChartStuct cs = charts[i];
                string stitle = cs.seriesTitles[0];
                Excel.Series xlSeries = (Excel.Series)seriesCollection.NewSeries();
                xlSeries.Name = stitle;
                xlSeries.HasLeaderLines = true;
                //xlSeries.Has3DEffect = true;
                //xlSeries.HasDataLabels = true;
                try
                {
                    xlSeries.AxisGroup = Excel.XlAxisGroup.xlSecondary;
                }
                catch (Exception eee){
                    Console.WriteLine(eee.Message);
                }
                xlSeries.ChartType = cs.chartType;
                xlSeries.Values = cs.dataRange;
                Excel.Axis valueAxis = (Excel.Axis)chartObject.Chart.Axes(Excel.XlAxisType.xlValue, Excel.XlAxisGroup.xlSecondary);
                valueAxis.HasTitle = true;
                valueAxis.AxisTitle.Text = cs.yname;
            }
        }

        public static void main(string[] args) {

            ExcelUtil.createChart();
        }


    }
    /// <summary>
    /// 图表数据结构体
    /// </summary>
    public class ChartStuct
    {
        public ChartStuct() { }
        public Excel.Range dataRange { get; set; }//数据区域
        public string yname { get; set; }//y轴名称
        public string[] seriesTitles;//每个序列的图例名称
        public Excel.XlChartType chartType;//图表类型
    }
}
