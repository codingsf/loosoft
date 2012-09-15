using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;
using System.IO;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：报表生成器
    /// 创建时间：2011-2-24
    /// </summary>
    public static class ReportBuilder
    {

        private static string[] colors = new string[] { "#EF5808", "#4682B4", "#89A54E", "#FFDB2F", "#68228B", "#8B0000", "#4572A7", "#AA4643", "#2F4F4F", "#BF3EFF", "#458B00" };

        /// <summary>
        /// 创建单维图表数据
        /// </summary>
        /// <param name="xAxisText"></param>
        /// <param name="datas"></param>
        /// <param name="colors"></param>
        /// <returns>json格式的x和y轴的数据</returns>
        public static ChartData createJsonChartXY(string chartName, string[] xAxisText, KeyValuePair<string, float?[]> data, string yname, string unit, string chartType, bool isUp)
        {
            return createJsonChartXY(chartName, xAxisText, data, yname, unit, chartType, "", isUp);
        }

        /// <summary>
        /// 创建单维图表数据
        /// 
        /// </summary>
        /// <param name="xAxisText"></param>
        /// <param name="datas"></param>
        /// <param name="colors"></param>
        /// <returns>json格式的x和y轴的数据</returns>
        public static ChartData createJsonChartXY(string chartName, string[] xAxisText, KeyValuePair<string, float?[]> data, string yname, string unit, string chartType, string comareObj, bool isUp)
        {
            return createMultiJsonChartXY(chartName, xAxisText, new List<KeyValuePair<string, float?[]>> { data }, yname, unit, chartType, comareObj, isUp);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="chartName"></param>
        /// <param name="xAxisText"></param>
        /// <param name="datas"></param>
        /// <returns></returns>
        public static ChartData createMultiJsonChartXY(string chartName, string[] xAxisText, IList<KeyValuePair<string, float?[]>> datas, string yname, string unit, string chartType, string comareObj, bool isUp)
        {
            string[] chartTypes = new string[] { chartType };
            string[] units = new string[] { unit };
            string[] ynames = new string[] { yname };
            string[] comareObjs = new string[] { comareObj };
            return createMultiJsonChartXY(chartName, xAxisText, datas, ynames, chartTypes, units, comareObjs, isUp);
        }

        /// <summary>
        /// 创建多维图表数据
        /// 
        /// </summary>
        /// <param name="xAxisText"></param>
        /// <param name="datas"></param>
        /// <param name="colors"></param>
        /// <returns>json格式的x和y轴的数据</returns>
        public static ChartData createMultiJsonChartXY(string chartName, string[] xAxisText, IList<KeyValuePair<string, float?[]>> datas, string[] ynames, string[] chartTypes, string[] units, bool isUp)
        {
            return createMultiJsonChartXY(chartName, xAxisText, datas, ynames, chartTypes, units, null, isUp);
        }

        public static ChartData createMultiJsonChartXY(string chartName, string[] xAxisText, IList<KeyValuePair<string, float?[]>> datas, string[] ynames, string[] chartTypes, string[] units, string[] comareObjs, bool isUp)
        {
            string[] colors = new string[units.Length];
            return createMultiJsonChartXY(chartName, xAxisText, datas, ynames, chartTypes, units, comareObjs, colors, isUp);
        }

        /// <summary>
        /// 创建多维图表数据
        /// </summary>
        /// <param name="chartName"></param>
        /// <param name="xAxisText"></param>
        /// <param name="datas"></param>
        /// <param name="ynames"></param>
        /// <param name="chartTypes"></param>
        /// <param name="units"></param>
        /// <param name="comareObjs"></param>
        /// <param name="colors"></param>
        /// <param name="isUP">是否进制</param>
        /// <returns></returns>
        public static ChartData createMultiJsonChartXY(string chartName, string[] xAxisText, IList<KeyValuePair<string, float?[]>> datas, string[] ynames, string[] chartTypes, string[] units, string[] comareObjs, string[] colors, bool isUP)
        {
            IDictionary<string, int> unitIndexMap = new Dictionary<string, int>();
            IList<string> unitList = new List<string>();
            IList<string> ynameList = new List<string>();
            for (int i = 0; i < units.Length; i++)
            {
               if (!unitList.Contains(units[i]))
               {
                    unitList.Add(units[i]);
                    ynameList.Add(ynames[i]);
                    unitIndexMap.Add(units[i], unitList.Count - 1);
               }
            }
            string[] aimColors = getColors(datas.Count);

            ChartData chartData = new ChartData();
            chartData.name = chartName;
            chartData.categories = xAxisText;

            chartData.colors = aimColors;
            chartData.units = unitList.ToArray();
            chartData.names = ynameList.ToArray();
            YData yData = null;//单条y轴数据
            YData[] ydatas = new YData[datas.Count];
            string tmpunit, tmpobj = "";
            bool isHasData = false;
            for (int i = 0; i < datas.Count; i++)
            {
                KeyValuePair<string, float?[]> data = datas[i];
                if (data.Value == null)
                {
                    continue;
                }
                yData = new YData();
                //if (data.Key.IndexOf("20") == -1)//除了年度的其他都要按照data.Key+"["+tmpunit+"]-电站"格式输出;
                //{
                tmpunit = units.Length == 1 ? units[0] : units[i];
                if (comareObjs != null)
                    tmpobj = comareObjs.Length == 1 ? "--" + comareObjs[0] : "--" + comareObjs[i];
                //yData.name = data.Key + "[" + tmpunit + "] " + (tmpobj.Equals("--")?"":tmpobj);
                //}
                // else
                // yData.name = data.Key;
                yData.type = chartTypes.Length == 1 ? chartTypes[0] : chartTypes[i];
                yData.data = data.Value;
                int realYAxisIndex = units.Length == 1 ? 0 : unitIndexMap[units[i]];

                //有指定颜色就用指定颜色，否则用从备用色中顺序取得颜色
                if (colors.Length > i && colors[i] != null)
                    yData.color = colors[i];
                else
                    yData.color = aimColors[i];

                yData.yAxis = realYAxisIndex.ToString();
                //取得数据的最大值
                yData.max = getMax(yData.data);
                yData.min = getMin(yData.data);
                if (yData.min > 0) yData.min = 0;
                //进行进制
                if (isUP)
                {
                    float newMax = upUnitData(yData.max, yData.data, i, chartData.units);
                    if (yData.min < 0 && yData.max != newMax)
                    {
                        yData.min = upUnitValue(yData.min);
                    }
                    yData.max = newMax;
                }
                string newUnitstr = units[i].Equals("") ? units[i] : "[" + units[i] + "] ";
                yData.name = data.Key + newUnitstr + (tmpobj.Equals("--") ? "" : tmpobj);
                ydatas[i] = yData;
                isHasData = true;
            }
            chartData.isHasData = isHasData;
            if (isHasData)
            {
                chartData.series = ydatas;
            }
            else
            {
                chartData.errorDesc = LanguageUtil.getDesc("CHART_ERROR_NODATA");
                chartData.series = new YData[] { };
            }
            //产生唯一序号
            chartData.serieNo = DateTime.Now.ToString("ddhhmmss") + new Random().Next(1000);
            TempDataUtil.putChartData(chartData.serieNo, chartData);
            return chartData;
            //return JsonUtil.convertToJson(chartData, typeof(ChartData));

        }

        /// <summary>
        /// 根据单个值进制
        /// </summary>
        /// <param name="max"></param>
        /// <param name="data"></param>
        /// <param name="i"></param>
        /// <returns></returns>
        private static float upUnitValue(float max)
        {
            //进制
            if (max >= 1000000)
            {
                return (float)Math.Round((double)(max / 1000000), 2);
            }
            else if (max >= 1000)
            { 
                return (float)Math.Round((double)(max / 1000), 2);
            }
            //不需要进制
            return max;
        }

        /// <summary>
        /// 根据最大值进行进制
        /// </summary>
        /// <param name="max"></param>
        /// <param name="data"></param>
        /// <param name="i"></param>
        /// <returns></returns>
        private static float upUnitData(float max, float?[] data, int i, string[] units)
        {
            //如果超出单位数组边界直接返回
            if (units.Count() <= i) return max;
            //只有功率和发电量才进制
            if (!units[i].ToLower().Equals("kwh") && !units[i].ToLower().Equals("w") && !units[i].ToLower().Equals("kw")) return max;

            //进制
            if (max >= 1000000)
            {
                for (int k = 0; k < data.Count(); k++)
                {
                    if (data[k] != null)
                        data[k] = (float)Math.Round((double)(data[k] / 1000000), 2);
                }
                if ("kwh".ToLower().Equals(units[i].ToLower()))
                {
                    units[i] = "GWh";
                }else if ("kw".ToLower().Equals(units[i].ToLower()))
                {
                    units[i] = "GW";
                }
                else
                {
                    units[i] = "G" + units[i];
                }
                return (float)Math.Round((double)(max / 1000000), 2);
            }
            else if (max >= 1000)
            {
                for (int k = 0; k < data.Count(); k++)
                {
                    if (data[k] != null)
                        data[k] = (float)Math.Round((double)(data[k] / 1000), 2);
                }
                if ("kwh".ToLower().Equals(units[i].ToLower()))
                {
                    units[i] = "MWh";
                }
                else if ("kw".ToLower().Equals(units[i].ToLower()))
                {
                    units[i] = "MW";
                }
                else
                {
                    units[i] = "M" + units[i];
                }

                return (float)Math.Round((double)(max / 1000), 2);
            }
            //不需要进制
            return max;
        }

        /// <summary>
        /// 取得数字的最大值
        /// </summary>
        /// <param name="datas"></param>
        /// <returns></returns>
        private static float getMax(float?[] datas)
        {
            float? max = datas.Max();
            double newvalue = max == null ? 0 : (max.Value > 0 ? max.Value * 1.2 : max.Value * 0.8);
            return float.Parse(newvalue.ToString());
        }


        /// <summary>
        /// 取得数字的最小值
        /// </summary>
        /// <param name="datas"></param>
        /// <returns></returns>
        private static float getMin(float?[] datas)
        {
            float? min = datas.Min();
            double newvalue = min == null ? 0 : (min.Value > 0 ? min.Value * 0.8 : min.Value * 1.2);
            return float.Parse(newvalue.ToString());
        }

        /// <summary>
        /// 根据预定义取得颜色
        /// </summary>
        /// <param name="num"></param>
        /// <returns></returns>
        private static string[] getColors(int num)
        {
            string[] aimcolors = new string[num];
            for (int i = 0; i < num; i++)
            {
                aimcolors[i] = colors[i % colors.Length];
            }
            return aimcolors;
        }
        /// <summary>
        /// 判断是否多维图表
        /// </summary>
        /// <param name="units"></param>
        /// <returns></returns>
        public static bool isMulti(string[] units)
        {
            string firstUnit;
            if (units.Length> 0)
            {
                firstUnit = units[0];
            }
            else {
                return false;
            }
            for (int i = 1; i < units.Length;i++ )
            {
                if (!firstUnit.Equals(units[i])) return true;
            }
            return false;
        }
    }

    /// <summary>
    /// 封装整个图表数据
    /// </summary>
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    [Serializable]
    public class ChartData
    {
        [DataMember(Order = 0)]
        public string name { get; set; }
        [DataMember(Order = 1)]
        public string[] names { get; set; }//多维图表名称
        [DataMember(Order = 2)]
        public string[] colors { get; set; }//多维图表颜色
        [DataMember(Order = 3)]
        public string[] units { get; set; }//多维图表单位
        [DataMember(Order = 4)]
        public string[] categories { get; set; }//横坐标数据
        [DataMember(Order = 5)]
        public YData[] series { get; set; }
        [DataMember(Order = 6)]
        public bool isHasData { get; set; }
        [DataMember(Order = 7)]
        public string errorDesc { get; set; }
        [DataMember(Order = 8)]
        public string serieNo { get; set; }//唯一序列号，用户标识数据
    }

    /// <summary>
    /// y轴数据
    /// </summary>
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    [Serializable]
    public class YData
    {
        [DataMember(Order = 0)]
        public string name { get; set; }  //纬度名称
        [DataMember(Order = 1)]
        public string type { get; set; }  //图表类型
        [DataMember(Order = 2)]
        public string color { get; set; } //颜色
        [DataMember(Order = 3)]
        public string yAxis { get; set; } //y轴序列
        [DataMember(Order = 4)]
        public float?[] data { get; set; }//数据
        [DataMember(Order = 5)]
        public float max { get; set; }    //y轴最大值
        [DataMember(Order = 6)]
        public float min { get; set; }    //y轴最小值
    }

}
