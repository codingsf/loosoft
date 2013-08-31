using System;
using System.Collections.Generic;
using Excel = Microsoft.Office.Interop.Excel;
using System.Reflection;
using System.IO;
using Cn.Loosoft.Zhisou.SunPower.Common;
namespace Common
{
    public class ExcelData
    {
        public string Title;
        public IList<IList<string>> Rows;
        public string[] series;//序列数组
        public string chartType;
        public bool isHead;
        public ExcelData()
        {
            Rows = new List<IList<string>>();
        }
    }

    public class ExcelStreamWriter
    {
        public bool align = false;
        private string excelPath = System.Configuration.ConfigurationSettings.AppSettings["sys_path"] + "\\tempexportfile";
        private bool isMulti;
        private string chartName;
        private string xName;
        public string FileName
        {
            get
            {
                return this.fileName + ".xls";
            }
        }

        public string FullName
        {
            get
            {
                return string.Format("{0}\\{1}", excelPath, FileName);
            }
        }

        private IList<ExcelData> excelDatas = null;

        private string fileName = null;

        public ExcelStreamWriter()
        {
            fileName = DateTime.Now.ToString("yyyyMMddhhmmsss");
        }

        public ExcelStreamWriter(string _fileName, IList<ExcelData> _excelData, string[] units, string chartName, string xName, bool isMulti)
        {
            this.fileName = _fileName;
            this.excelDatas = _excelData;
            this.isMulti = isMulti;
            this.chartName = chartName;
            this.xName = xName;
        }

        public ExcelStreamWriter(IList<ExcelData> _excelDatas)
        {
            fileName = DateTime.Now.ToString("yyyyMMddhhmmsss");
            this.excelDatas = _excelDatas;
        }

        /// <summary>
        /// 保持excel
        /// </summary>
        /// <param name="isChart">是否生成图表</param>
        /// <returns></returns>
        public bool Save(Boolean isChart)
        {
            Excel.Application xlApp = new Excel.Application();
            Excel.Workbooks xlBooks = xlApp.Workbooks;
            Excel.Workbook xlBook = xlBooks.Add(Missing.Value);
            Excel.Sheets xlsheets = xlBook.Worksheets;
            Excel.Worksheet xlSheet = (Excel.Worksheet)xlsheets.get_Item(1);
            int rowIndex = 0;
            try
            {
                List<ChartStuct> csList = new List<ChartStuct>();
                if (excelDatas != null)
                {
                    ChartStuct cs = new ChartStuct();
                    int innerRows = 0;
                    foreach (ExcelData data in excelDatas)
                    {
                        if (isChart)
                        {
                            //是多维图表
                            if (isMulti)
                            {
                                cs = new ChartStuct();
                                //解决如果是柱状图和线图比较，不能只是辅助y轴的问题，将图表类型改为线图
                                if (data.chartType.Equals(ChartType.column)) data.chartType = ChartType.line;
                            }
                            cs.yname = data.Title;
                            cs.chartType = convertType(data.chartType);
                            cs.seriesTitles = data.series;
                        }

                        if (data.Rows != null && data.Rows.Count > 0)
                        {
                            int rowLength = 0;
                            int iRows = 0;
                            foreach (IList<string> column in data.Rows)
                            {
                                innerRows++;
                                iRows++;
                                rowIndex++;
                                for (int i = 0; i < column.Count; i++)
                                {
                                    if (align)
                                        xlSheet.Cells[rowIndex, i + 1] = column[i];// string.Format("'{0}", column[i]);
                                    else
                                        xlSheet.Cells[i + 1, rowIndex] = column[i];// string.Format("'{0}", column[i]);
                                }
                                rowLength = column.Count;
                            }
                            if (isChart)
                            {
                                //是多维图表
                                if (isMulti)
                                {
                                    cs.dataRange = xlSheet.get_Range(xlApp.Cells[1, rowIndex - iRows + 1], xlApp.Cells[rowLength, rowIndex]);
                                }
                                else
                                {
                                    cs.dataRange = xlSheet.get_Range(xlApp.Cells[1, rowIndex - innerRows + 1], xlApp.Cells[rowLength, rowIndex]);
                                }
                            }
                        }

                        if (cs.dataRange != null)
                        {
                            cs.dataRange.NumberFormat = "@";
                            cs.dataRange.HorizontalAlignment = Excel.XlVAlign.xlVAlignCenter;
                            cs.dataRange.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                            //xlSheet.get_Range(xlApp.Cells[rowIndex, 1], xlApp.Cells[rowIndex, column.Count + 1]).NumberFormat = "@";
                            //xlSheet.get_Range(xlApp.Cells[rowIndex, 1], xlApp.Cells[rowIndex, column.Count + 1]).HorizontalAlignment = Excel.XlVAlign.xlVAlignCenter;
                            csList.Add(cs);
                        }
                    }
                }

                //生成图表
                if (isChart)
                {
                    try
                    {
                        ExcelUtil.createInnerChart(xlSheet, csList, this.chartName, this.xName);
                    }
                    catch (Exception ee)
                    {
                        Console.WriteLine(" ExcelUtil.createInnerChart" + ee.Message);
                    }
                }

                xlSheet = null;
                string fullPath = string.Format("{0}\\{1}.xls", this.excelPath, this.fileName);
                if (File.Exists(fullPath))
                    File.Delete(fullPath);
                xlBook.SaveAs(fullPath, Missing.Value,
                    Missing.Value, Missing.Value, Missing.Value, Missing.Value,
                    Excel.XlSaveAsAccessMode.xlNoChange, Missing.Value, Missing.Value,
                    Missing.Value, Missing.Value, Missing.Value);
                xlBook.Close(false, Missing.Value, Missing.Value);
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine("Save" + e.Message);
                return false;
            }
            finally
            {
                xlApp.Quit();
                xlSheet = null;
                xlBook = null;
                xlApp = null;
                GC.Collect();
            }
        }

        private Excel.XlChartType convertType(string chartType)
        {
            if (chartType.EndsWith(ChartType.area))
            {
                return Excel.XlChartType.xlArea;
            }
            else if (chartType.EndsWith(ChartType.column))
            {
                return Excel.XlChartType.xl3DColumn;
            }
            else
            {
                return Excel.XlChartType.xlLine;
            }
        }

        public bool Save(string _fileName)
        {
            this.fileName = _fileName;
            return Save(false);
        }
    }
}