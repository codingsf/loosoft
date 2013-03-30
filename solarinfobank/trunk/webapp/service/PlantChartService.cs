using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：电站报表业务类
    /// 创建时间：2011年02月25日
    /// </summary>
    public class PlantChartService : BaseChartService
    {
        private static PlantChartService _instance = new PlantChartService();
        private static PlantChartService _appinstance = new PlantChartService(true);

        private bool fromApp = false;
        private PlantChartService()
        {
        }

        private PlantChartService(bool fromApp)
        {
            this.fromApp = fromApp;
        }

        public static PlantChartService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new PlantChartService();
            }
            return _instance;
        }

        public static PlantChartService GetAppInstance()
        {
            if (_appinstance == null)
            {
                _appinstance = new PlantChartService(true);
            }
            return _appinstance;
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过单个电站列表获得电站总量报表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ChartData YearChartByPlant(Plant plant, string chartType, string unit)
        {
            return YearChartBypList(new List<Plant>() { plant }, chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站列表获得电站总量图表数据
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="plantList">电站列表</param>
        /// <returns></returns>
        public ChartData YearChartBypList(IList<Plant> plantList, string chartType, string unit)
        {
            return this.YearChartBypList(plantList, 1.0F, LanguageUtil.getDesc("CHART_TITLE_TOTALENERGYCHART"), null,chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站列表获得电站总量图表数据
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="plantList">电站列表</param>
        /// <param name="rate">数据换算系数</param>
        /// <returns></returns>
        public ChartData YearChartBypList(IList<Plant> plantList, float rate, string chartname, string newserieKey, string chartType, string unit)
        {
            if (plantList == null)
            {
                return new ChartData();
            }

            //所有子站累加
            Hashtable yearEnergy = CollectorYearDataService.GetInstance().GetYearDatasByUnits(this.getUnitsByPlantList(plantList));
            string[] ic = sortCollection(yearEnergy.Keys);
            string[] newic = null;
            int len = 5;
            int skip = len - ic.Length;
            int left = (int)skip / 2;
            int right = 5 - ic.Length - left;
            if (ic.Length < len)
            {
                newic = new string[len];
                len = 0;
                int startYear = ic.Length == 0 ? DateTime.Now.Year : int.Parse(ic[0]);
                int endYear = ic.Length == 0 ? DateTime.Now.Year : int.Parse(ic[ic.Length - 1]);
                while (left >0)
                    newic[len++] = (startYear - (left--)).ToString();
                foreach (string s in ic)
                    newic[len++] = s;
                for (int i = 1; i <= right; i++)
                    newic[len++] = (endYear + (i)).ToString();
            }
            else
            {
                newic = ic;
            }

            //add by qhb in 20120928 for 补偿发电量
            base.addPlantYearEnergy(yearEnergy, plantList);

            string[] xAxis = formatXaxis(newic, ChartTimeType.Year);
            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (yearEnergy.Count > 0)
            {
                if (newserieKey == null)
                {
                    data = GenerateChartData(mt.name, newic, yearEnergy, rate);
                }
                else {
                    data = GenerateChartData(newserieKey, newic, yearEnergy, rate);
                }
            }

            string comobj = "";//plantList.Count > 1 ? "" : plantList[0].name;
            return ReportBuilder.createJsonChartXY(chartname, xAxis, data, "", unit, chartType, comobj, fromApp);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过单个电站列表获得电站总量报表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ChartData YearCO2ChartByPlant(Plant plant, string unit, string chartType)
        {
            return YearCO2ChartBypList(new List<Plant>() { plant }, unit, chartType);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站列表获得电站总量图表数据
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="plantList">电站列表</param>
        /// <returns></returns>
        public ChartData YearCO2ChartBypList(IList<Plant> plantList, string unit, string chartType)
        {
            float rate = getCO2Rate();
            return this.YearChartBypList(plantList, rate, "CO2 Reduction Chart", null, chartType, unit);
        }



        public ChartData YearIncomeChartBypList(IList<Plant> plantList, string unit, string chartType)
        {
            float rate = getCO2Rate();
            return this.YearChartBypList(plantList, rate, "Revenue Chart", null,chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过单个电站列表获得单年度图表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ChartData YearMMChartByPlant(Plant plant, int year, string chartType, string unit)
        {
            return YearMMChartBypList(new List<Plant>() { plant }, year, chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过单个电站列表获得跨年月图表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ChartData YearMMChartByPlant(Plant plant, string startYearMM, string endYearMM, string chartType, string unit)
        {
            return YearMMChartBypList(new List<Plant>() { plant }, startYearMM, endYearMM, chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站列表获得单年图表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="plantList">电站列表</param>
        /// <returns></returns>
        public ChartData YearMMChartBypList(IList<Plant> plantList, int year, string chartType, string unit)
        {
            string startYearMM = year + "01";
            string endYearMM = year + "12";
            return this.YearMMChartBypList(plantList, startYearMM, endYearMM, chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站列表获得跨年月图表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="plantList">电站列表</param>
        /// <returns></returns>
        public ChartData YearMMChartBypList(IList<Plant> plantList, string startYearMM, string endYearMM, string chartType, string unit)
        {
            string chartName = LanguageUtil.getDesc("CHART_TITLE_YEARLYENERGYCHART");
            //if (startYearMM.Substring(0, 4).Equals(endYearMM.Substring(0, 4)) && startYearMM.Substring(4, 2).Equals("01") && endYearMM.Substring(4, 2).Equals("12")) {
            //chartName = startYearMM.Substring(0, 4) + chartName;
            //}
            return this.YearMMChartBypList(plantList, 1.0F, LanguageUtil.getDesc("CHART_TITLE_YEARLYENERGYCHART"), null,startYearMM, endYearMM, chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站列表获得跨月度图表数据
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="plantList">电站列表</param>
        /// <param name="rate">数据换算系数</param>
        /// <returns></returns>
        public ChartData YearMMChartBypList(IList<Plant> plantList, float rate, string chartname, string newserieKey, string startYearMM, string endYearMM, string chartType, string unit)
        {
            if (plantList == null)
            {
                return new ChartData();
            }
            ///所有子站累加
            IList<PlantUnit> units = this.getUnitsByPlantList(plantList);

            int startYear = int.Parse(startYearMM.Substring(0, 4));
            int endYear = int.Parse(endYearMM.Substring(0, 4));

            Hashtable yearMonthEnergy = CollectorYearMonthDataService.GetInstance().GetUnitBetweenYearData(units, startYear, endYear);

            string[] ic = base.getXseriesFromYYYYMM(startYearMM, endYearMM).ToArray();

            string[] xAxis = formatXaxis(ic, ChartTimeType.YearMonth);
            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            //add by qhb in 20120928 for 补偿发电量
            base.addPlantMonthEnergy(yearMonthEnergy, plantList, startYearMM, endYearMM.ToString());
            if (yearMonthEnergy.Count > 0)
            {
                if (newserieKey == null)
                {
                    data = GenerateChartData(mt.name, ic, yearMonthEnergy, rate);
                }
                else {
                    data = GenerateChartData(newserieKey, ic, yearMonthEnergy, rate);
                }
            }
            string comobj = "";//plantList.Count > 1 ? "" : plantList[0].name;
            return ReportBuilder.createJsonChartXY(chartname, xAxis, data, "", unit, chartType, comobj, fromApp);
        }




        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过单个电站获但月度年度图表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ChartData MMDDChartByPlant(Plant plant, int year, int month, string chartType, string unit)
        {
            return MMDDChartBypList(new List<Plant>() { plant }, year, month, chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站列表获得单月天发电图表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="plantList">电站列表</param>
        /// <returns></returns>
        public ChartData MMDDChartBypList(IList<Plant> plantList, int year, int month, string chartType, string unit)
        {
            string monthstr = TableUtil.convertIntToMnthStr(month);
            string startYearMMDD = year + monthstr + "01";
            string endYearMMDD = year + monthstr + CalenderUtil.getMonthDays(year, month);
            return this.MMDDChartBypList(plantList, startYearMMDD, endYearMMDD, chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过单个电站列表获得跨月天的天图表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ChartData MMDDChartByPlant(Plant plant, string startYYYYMMDD, string endYYYYMMDD, string chartType, string unit)
        {
            return MMDDChartBypList(new List<Plant>() { plant }, startYYYYMMDD, endYYYYMMDD, chartType, unit);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站列表获得跨年月图表
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="plantList">电站列表</param>
        /// <returns></returns>
        public ChartData MMDDChartBypList(IList<Plant> plantList, string startYearMMDD, string endYearMMDD, string chartType, string unit)
        {

            return this.MonthDDChartBypList(plantList, 1.0F, LanguageUtil.getDesc("CHART_TITLE_MONTH_ENERGY"),null, startYearMMDD, endYearMMDD, chartType, unit);
        }

        /// <summary>
        /// 从起止年月天中取得起止年
        /// </summary>
        /// <param name="startYearMMDD"></param>
        /// <param name="endYearMMDD"></param>
        /// <returns></returns>
        private string[] getYearMonths(string startYearMMDD, string endYearMMDD)
        {
            string startYear = startYearMMDD.Substring(0, 6);
            string endYear = endYearMMDD.Substring(0, 6);
            if (startYear.Equals(endYear))
                return new string[] { startYear.Substring(0, 4) + "/" + startYear.Substring(4, 2) };
            else
            {
                return new string[] { startYear.Substring(0, 4) + "/" + startYear.Substring(4, 2), endYear.Substring(0, 4) + "/" + endYear.Substring(4, 2) };
            }
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站列表获得跨天度图表数据
        /// 创建时间：2011年02月25日
        /// 修改：胡圣忠
        /// </summary>
        /// <param name="plantList"></param>
        /// <param name="rate"></param>
        /// <param name="chartname"></param>
        /// <param name="startYearMM"></param>
        /// <param name="endYearMM"></param>
        /// <returns></returns>
        public ChartData MonthDDChartBypList(IList<Plant> plantList, float rate, string chartname, string newseriekey, string startYearMMDD, string endYearMMDD, string chartType, string unit)
        {
            if (plantList == null)
            {
                return new ChartData();
            }

            ///所有子站累加
            IList<PlantUnit> units = this.getUnitsByPlantList(plantList);

            Hashtable monthDDEnergy = CollectorMonthDayDataService.GetInstance().GetUnitBetweenMonthData(units, startYearMMDD, endYearMMDD);

            string[] ic = base.getXseriesFromYYYYMMDD(startYearMMDD, endYearMMDD).ToArray();

            string[] xAxis;
            string[] years = getYearMonths(startYearMMDD, endYearMMDD);
            if (years.Length > 1)
            {
                //chartname = "from " + years[0] + " to " + years[1] + " " + chartname;
                xAxis = formatXaxis(ic, ChartTimeType.YearMonthDay);
            }
            else
            {
                //chartname = years[0] + " " + chartname;
                xAxis = formatXaxis(ic, ChartTimeType.MonthDay);
            }

            //add by qhb in 20120928 for 添加补偿发电量
            base.addPlantDayEnergy(monthDDEnergy, plantList, startYearMMDD, startYearMMDD);

            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (monthDDEnergy.Count > 0)
            {
                if (newseriekey == null)
                    data = GenerateChartData(mt.name, ic, monthDDEnergy, rate);
                else
                    data = GenerateChartData(newseriekey, ic, monthDDEnergy, rate);
            }

            string comobj = "";//plantList.Count > 1 ? "" : plantList[0].name;
            return ReportBuilder.createJsonChartXY(chartname, xAxis, data, "", unit, chartType, comobj, fromApp);
        }

        /// <summary>
        /// 取得多个电站的pr性能图表数据
        /// </summary>
        /// <param name="plantList"></param>
        /// <param name="chartname"></param>
        /// <param name="newseriekey"></param>
        /// <param name="startYearMMDD"></param>
        /// <param name="endYearMMDD"></param>
        /// <param name="chartType"></param>
        /// <param name="unit"></param>
        /// <returns></returns>
        public ChartData MonthDDRPChartBypList(IList<Plant> plantList, string chartName, string startYearMMDD, string endYearMMDD, string chartType)
        {
            if (plantList == null)
            {
                return new ChartData();
            }

            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
            IList<string> chartTypes = new List<string>(); //图表类型
            IList<string> units = new List<string>();      //单位
            IList<string> ynames = new List<string>();     //y轴名称
            //IList<string> compareObjs = null;//图例比较对象，因为是同一个电站，不追加
            chartTypes.Add(chartType);
            chartTypes.Add(chartType);
            ynames.Add(mt.name);
            ynames.Add(mt.name);

            ///所有单元累加
            IList<PlantUnit> unitList = this.getUnitsByPlantList(plantList);
            //产生坐标
            string[] ic = base.getXseriesFromYYYYMMDD(startYearMMDD, endYearMMDD).ToArray();
            string[] xAxis;
            string[] years = getYearMonths(startYearMMDD, endYearMMDD);
            if (years.Length > 1)
            {
                xAxis = formatXaxis(ic, ChartTimeType.YearMonthDay);
            }
            else
            {
                xAxis = formatXaxis(ic, ChartTimeType.MonthDay);
            }
            float rate = 1.0F;
            string newseriekey;
            //取得多个采集器的实际发电量
            Hashtable monthDDEnergy = CollectorMonthDayDataService.GetInstance().GetUnitBetweenMonthData(unitList, startYearMMDD, endYearMMDD);

            units.Add(mt.unit);

            //add by qhb in 20120928 for 补偿发电量
            base.addPlantDayEnergy(monthDDEnergy, plantList, startYearMMDD, endYearMMDD);

            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (monthDDEnergy.Count > 0)
            {
                newseriekey = LanguageUtil.getDesc("ACTUALENERGY");

                data = GenerateChartData(newseriekey, ic, monthDDEnergy, rate);
                units.Add(mt.unit);
                //string comobj = "";//plantList.Count > 1 ? "" : plantList[0].name;
                datas.Add(data);
                //取得日照增量强度，并依次计算理论发电量
                //取得有增量日照迁强度的环境监测仪设备
                IList<Device> devices = getDevicesByPlantsWithSunshine(plantList);
                //计算理论发电量换算率
                IList<float> rates = this.getDeviceRatesByPlantsWithSunshine(plantList);

                monthDDEnergy = DeviceMonthDayDataService.GetInstance().unionYearMMDDList(devices, startYearMMDD, endYearMMDD, rates);
                newseriekey = LanguageUtil.getDesc("THEORYENERGY");

                data = GenerateChartData(newseriekey, ic, monthDDEnergy, rate);
                datas.Add(data);

                float?[] newDataArr = computeByType(xAxis.ToArray(), datas, ComputeType.Ratio);
                KeyValuePair<string, float?[]> newdata = new KeyValuePair<string, float?[]>("PR", newDataArr);
                datas.Add(newdata);
                chartTypes.Add(ChartType.line);
                units.Add("%");
                ynames.Add("PR");
            }
            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes.ToArray(), units.ToArray(), fromApp);
        }

        /// <summary>
        /// 电站年月pr性能
        /// </summary>
        /// <param name="plantList"></param>
        /// <param name="chartName"></param>
        /// <param name="startYearMM"></param>
        /// <param name="endYearMM"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ChartData yearMonthRPChartBypList(IList<Plant> plantList, string chartName, string startYearMM, string endYearMM, string chartType)
        {
            if (plantList == null)
            {
                return new ChartData();
            }
            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
            IList<string> chartTypes = new List<string>(); //图表类型
            IList<string> units = new List<string>();      //单位
            IList<string> ynames = new List<string>();     //y轴名称
            //IList<string> compareObjs = null;//图例比较对象，因为是同一个电站，不追加
            chartTypes.Add(chartType);
            chartTypes.Add(chartType);
            ynames.Add(mt.name);
            ynames.Add(mt.name);
            ///所有单元累加
            IList<PlantUnit> unitList = this.getUnitsByPlantList(plantList);
            //产生坐标

            int startYear = int.Parse(startYearMM.Substring(0, 4));
            int endYear = int.Parse(endYearMM.Substring(0, 4));

            string[] ic = base.getXseriesFromYYYYMM(startYearMM, endYearMM).ToArray();

            string[] xAxis = formatXaxis(ic, ChartTimeType.YearMonth);

            float rate = 1.0F;
            string newseriekey;
            //取得多个采集器的实际发电量
            Hashtable yearMonthEnergy = CollectorYearMonthDataService.GetInstance().GetUnitBetweenYearData(unitList, startYear, endYear);

            //add by qhb in 20120928 for 补偿发电量
            base.addPlantMonthEnergy(yearMonthEnergy, plantList, startYear.ToString(), endYear.ToString());

            units.Add(mt.unit);
            units.Add(mt.unit);
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (yearMonthEnergy.Count > 0)
            {
                newseriekey = LanguageUtil.getDesc("ACTUALENERGY");
                data = GenerateChartData(newseriekey, ic, yearMonthEnergy, rate);

                //string comobj = "";//plantList.Count > 1 ? "" : plantList[0].name;
                datas.Add(data);
                //取得日照增量强度，并依次计算理论发电量
                //取得有增量日照迁强度的环境监测仪设备
                IList<Device> devices = getDevicesByPlantsWithSunshine(plantList);
                //计算理论发电量换算率
                IList<float> rates = this.getDeviceRatesByPlantsWithSunshine(plantList);

                yearMonthEnergy = DeviceYearMonthDataService.GetInstance().GetDeviceBetweenYearData(devices, startYear, endYear, rates);
                newseriekey = LanguageUtil.getDesc("THEORYENERGY");

                data = GenerateChartData(newseriekey, ic, yearMonthEnergy, rate);
                datas.Add(data);

                float?[] newDataArr = computeByType(xAxis.ToArray(), datas, ComputeType.Ratio);
                KeyValuePair<string, float?[]> newdata = new KeyValuePair<string, float?[]>("PR", newDataArr);
                datas.Add(newdata);
                chartTypes.Add(ChartType.line);
                units.Add("%");
                ynames.Add("PR");
            }
            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes.ToArray(), units.ToArray(), fromApp);
        }

        /// <summary>
        /// 取得总体年度pr性能
        /// </summary>
        /// <param name="plantList"></param>
        /// <param name="chartName"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ChartData YearPRChartBypList(IList<Plant> plantList, string chartName, string chartType)
        {
            if (plantList == null)
            {
                return new ChartData();
            }

            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
            IList<string> chartTypes = new List<string>(); //图表类型
            IList<string> units = new List<string>();      //单位
            IList<string> ynames = new List<string>();     //y轴名称
            //IList<string> compareObjs = null;//图例比较对象，因为是同一个电站，不追加
            chartTypes.Add(chartType);
            chartTypes.Add(chartType);
            ynames.Add(mt.name);
            ynames.Add(mt.name);

            //所有单元累加
            IList<PlantUnit> unitList = this.getUnitsByPlantList(plantList);
            //产生坐标
            Hashtable yearEnergy = CollectorYearDataService.GetInstance().GetYearDatasByUnits(unitList);
            string[] ic = sortCollection(yearEnergy.Keys);
            string[] newic = null;
            int len = 5;
            int skip = len - ic.Length;
            int left = (int)skip / 2;
            int right = 5 - ic.Length - left;
            if (ic.Length < len)
            {
                newic = new string[len];
                len = 0;
                int startYear = ic.Length == 0 ? DateTime.Now.Year : int.Parse(ic[0]);
                int endYear = ic.Length == 0 ? DateTime.Now.Year : int.Parse(ic[ic.Length - 1]);
                while (left > 0)
                    newic[len++] = (startYear - (left--)).ToString();
                foreach (string s in ic)
                    newic[len++] = s;
                for (int i = 1; i <= right; i++)
                    newic[len++] = (endYear + (i)).ToString();
            }
            else
            {
                newic = ic;
            }
            string[] xAxis = formatXaxis(newic, ChartTimeType.Year);

            float rate = 1.0F;
            string newseriekey;
            //取得多个采集器的实际发电量

            //add by qhb in 20120928 for 补偿发电量
            base.addPlantYearEnergy(yearEnergy, plantList);

            units.Add(mt.unit);
            units.Add(mt.unit);
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (yearEnergy.Count > 0)
            {
                newseriekey = LanguageUtil.getDesc("ACTUALENERGY");

                data = GenerateChartData(newseriekey, newic, yearEnergy, rate);

                datas.Add(data);
                //取得日照增量强度，并依次计算理论发电量
                //取得有增量日照迁强度的环境监测仪设备
                IList<Device> devices = getDevicesByPlantsWithSunshine(plantList);
                //计算理论发电量换算率
                IList<float> rates = this.getDeviceRatesByPlantsWithSunshine(plantList);

                yearEnergy = DeviceYearDataService.GetInstance().GetTotalDatasByDevices(devices);
                newseriekey = LanguageUtil.getDesc("THEORYENERGY");

                data = GenerateChartData(newseriekey, newic, yearEnergy, rate);
                datas.Add(data);


                float?[] newDataArr = computeByType(xAxis.ToArray(), datas, ComputeType.Ratio);
                KeyValuePair<string, float?[]> newdata = new KeyValuePair<string, float?[]>("PR", newDataArr);
                datas.Add(newdata);
                chartTypes.Add(ChartType.line);
                units.Add("%");
                ynames.Add("PR");
            }
            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes.ToArray(), units.ToArray(), fromApp);
        }


        /// <summary>
        /// 取得单个电站跨小时的图表
        /// </summary>
        /// <param name="plant"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ChartData PlantDayChart(Plant plant, string chartname, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string unit, int monitorCode, int intervalMins)
        {
            return this.PlantDayChart(new List<Plant>() { plant }, chartname, startYYYYMMDDHH, endYYYYMMDDHH, chartType, unit, monitorCode, intervalMins);
        }

        /// <summary>
        /// 取得多个电站跨小时的功率图表
        /// </summary>
        /// <param name="plants"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ChartData PlantDayChart(IList<Plant> plants, string chartname, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string unit, int monitorCode, int intervalMins)
        {
            //将整天的数据截断头尾
            string head = startYYYYMMDDHH.Substring(6, 4);
            string foot = endYYYYMMDDHH.Substring(6, 4);
            MonitorType mt = MonitorType.getMonitorTypeByCode(monitorCode);
            string[] ic = base.getXseriesFromYYYYMMDDHH(startYYYYMMDDHH, endYYYYMMDDHH, intervalMins).ToArray();//cutXAxisData(sortCollection(powerHash.Keys), head, foot);

            string[] xAxis = formatXaxis(ic, this.fromApp ? ChartTimeType.Hour : ChartTimeType.Day);
            //string name = (plants.Count > 1 ? LanguageUtil.getDesc("CHART_TITLE_ALL_PLANTS") : plants[0].name) + " " + LanguageUtil.getDesc("CHART_TITLE_DAY_CHART");
            string name = mt.name;
            KeyValuePair<string, float?[]> alldata = new KeyValuePair<string, float?[]>();
            foreach (Plant plant in plants)
            {
                IList<PlantUnit> units = plant.allFactUnits;

                ///结果需要按时间先后排序
                Hashtable powerHash = CollectorDayDataService.GetInstance().GetUnitDaydataList(units, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, monitorCode);

                if (powerHash.Count > 0)
                {
                    KeyValuePair<string, float?[]> data = GenerateChartData(name, ic, powerHash, 1.0F);
                    if (alldata.Key == null)
                        alldata = data;
                    else
                    {
                        alldata = new KeyValuePair<string, float?[]>(alldata.Key, mergeHash(alldata.Value, data.Value));
                    }
                }
            }

            //MonitorType mt = MonitorType.getMonitorTypeByCode(monitorCode);
            return ReportBuilder.createJsonChartXY(chartname, xAxis, alldata, mt.name, unit, chartType, fromApp);
        }

        /// <summary>
        /// 将同数量的两组数据，组织成坐标
        /// add by hbqian in 2013-03-23 for 生成电站功率和日照散列图
        /// </summary>
        /// <param name="chatName"></param>
        /// <param name="xData"></param>
        /// <param name="yData"></param>
        /// <returns></returns>
        public ChartData genNewScatter(string chartName,string startYearMMDDHH, string endYearMMDDHH,int interval, Hashtable xData ,Hashtable yData,string unit,string chartType) {
            string[] ic = base.getXseriesFromYYYYMMDDHH(startYearMMDDHH, endYearMMDDHH, interval).ToArray();
            KeyValuePair<string, float?[]> xMergedata = base.GenerateChartData("日照", ic, xData, 1.0f);
            KeyValuePair<string, float?[]> yMergedata = base.GenerateChartData("功率", ic, yData, 1.0f);
            for (int i = 0; i < xMergedata.Value.Length; i++)
            {
                ic[i] = xMergedata.Value[i] == null ? "" : xMergedata.Value[i].ToString();
            }
            IList<KeyValuePair<string, float?[]>> yDataList = new List<KeyValuePair<string, float?[]>>(){yMergedata};
            string[] ynames = new string[]{"日照","功率"};
            string[] units = new string[] {"W/㎡", "kW" };
            string[] chartTypes = new string[]{"scatter","scatter"};
            return ReportBuilder.createMultiJsonChartXY(chartName, ic, yDataList, ynames,chartTypes,units,false);
        }

        /// <summary>
        /// 统计某年某个测点各时段内值和
        /// </summary>
        /// <param name="plants"></param>
        /// <param name="chartname"></param>
        /// <param name="YYYYMM"></param>
        /// <param name="chartType"></param>
        /// <param name="unit"></param>
        /// <param name="monitorCode"></param>
        /// <param name="intervalMins"></param>
        /// <param name="weidu"></param>
        /// <returns></returns>
        public ChartData PlantYearSectionCountChart(IList<Plant> plants, string chartname, int YYYY, string chartType, string unit, int monitorCode, int intervalMins, int weidu)
        {
            
            //ChartData resChartData = null;
            //for (int i = 1; i <= months; i++)
            //{
            //    ChartData chartData = PlantMonthSectionCountChart(plants, chartname, YYYY + i.ToString("00"), chartType, unit, monitorCode, intervalMins, weidu);
            //    if (resChartData == null)
            //    {
            //        resChartData = chartData;
            //    }
            //    else
            //    {
            //        mergeHash(resChartData.series[0].data, chartData.series[0].data);
            //        mergeHash(resChartData.series[1].data, chartData.series[1].data);
            //    }
            //}
            //return resChartData;
            ChartData resChartData = null;
            //电费维度轴
            YData feeyData = new YData();
            YData[] newSeries = new YData[2];
            string[] newCategories = new string[4 + 1] { "峰", "平", "谷", "尖", "合计" };
            ///要进行多个电站累计，因为电站配置的
            float?[] newValues = new float?[5] { 0, 0, 0, 0, 0 };
            float?[] newFeeValues = new float?[5]{0,0,0,0,0};
            foreach (Plant plant in plants)
            {
                if (plant.allFactUnits == null || plant.allFactUnits.Count < 1) continue;
                Hashtable dataHash = CollectorYearDataService.GetInstance().GetYearDatasByUnits(plant.allFactUnits);
                if (dataHash == null || dataHash.Count < 1) continue;

                //取出本月数据
                object v = dataHash[YYYY.ToString()];
                float energy = v == null ? 0 : (float)v;

                //按照既定比率分拆
                ElecPrice[] sections = plant.ElecPriceList.ToArray();

                float rate = 0;
                ElecPrice x = null;
                //float max = 0;
                for (int i = 0; i < 4; i++)
                {
                    if (sections == null || i >= sections.Length)
                    {
                        if (i == 0)
                        {//峰
                            rate = 0.4f;
                            x = new ElecPrice() { fromHm = "08:00", toHm = "12:00", price = "0.6" };
                        }
                        else if (i == 1)
                        {//平
                            rate = 0.45f;
                            x = new ElecPrice() { fromHm = "12:00", toHm = "18:00", price = "0.5" };
                        }
                        else if (i == 2)
                        {//谷
                            rate = 0.1f;
                            x = new ElecPrice() { fromHm = "18:00", toHm = "23:00", price = "0.2" };
                        }
                        else
                        {//尖
                            rate = 0.05f;
                            x = new ElecPrice() { fromHm = "01:00", toHm = "08:00", price = "0.4" };
                        }
                    }
                    else
                    {
                        x = sections[i];
                        if (string.IsNullOrEmpty(x.fromHm))
                        {
                            if (i == 0)
                            {//峰
                                rate = 0.4f;
                                x = new ElecPrice() { fromHm = "08:00", toHm = "12:00", price = "0.6" };
                            }
                            else if (i == 1)
                            {//平
                                rate = 0.45f;
                                x = new ElecPrice() { fromHm = "12:00", toHm = "18:00", price = "0.5" };
                            }
                            else if (i == 2)
                            {//谷
                                rate = 0.1f;
                                x = new ElecPrice() { fromHm = "18:00", toHm = "23:00", price = "0.2" };
                            }
                            else
                            {//尖
                                rate = 0.05f;
                                x = new ElecPrice() { fromHm = "01:00", toHm = "08:00", price = "0.4" };
                            }
                        }
                    }
                    newValues[i] = (newValues[i] == 0 ? 0 : newValues[i]) + energy * rate;
                    if (newValues[i] < 0) newValues[i] = 0;
                }

                //合计总发电量
                float? value = 0;
                for (int k = 0; k < 4; k++)
                {
                    value += newValues[k];
                }

                newValues[4] = value;


                //总=（峰电费+平电费+谷电费+尖电费）+（峰发电量 + 平发电量 + 谷发电量 + 尖发电量）*基础电价
                float? total = 0;
                for (int k = 0; k < 4; k++)
                {
                    newFeeValues[k] = newValues[k] * float.Parse(x.price);
                    total += newFeeValues[k];
                }
                //总电费
                newFeeValues[4] = total + value * plant.basePrice;//1是基础电价

                if (resChartData == null)
                {
                    YData yData = null;
                    resChartData = new ChartData();
                    resChartData.name = "年度峰平谷尖发电量和收入";
                    resChartData.isHasData = true;
                    yData = new YData();
                    yData.data = new float?[] { 0, 0, 0, 0, 0 };
                    yData.name = "发电量[kWh]";
                    yData.yAxis = "0";
                    yData.type = chartType;
                    yData.color = "#EF5808";

                    feeyData = new YData();
                    //将新的结果重新放到结果对象中            
                    resChartData.categories = newCategories;
                    yData.data = newValues;
                    feeyData.data = newFeeValues;
                    feeyData.name = "收入[元]";
                    feeyData.yAxis = "1";
                    feeyData.type = chartType;
                    feeyData.color = "#4682B4";
                    //feeyData.max = max;
                    newSeries[0] = yData;
                    newSeries[1] = feeyData;
                    resChartData.series = newSeries;
                    resChartData.names = new String[] { "发电量", "收入" };
                    resChartData.units = new String[] { "kWh", "元" };
                    resChartData.colors = new String[] { "#EF5808", "#4682B4" };
                    resChartData.serieNo = DateTime.Now.ToString("ddhhmmss") + new Random().Next(1000);
                    TempDataUtil.putChartData(resChartData.serieNo, resChartData);
                }
                else
                {
                    mergeHash(resChartData.series[0].data, newValues);
                    mergeHash(resChartData.series[1].data, newFeeValues);
                }
            }
            if (resChartData == null) return new ChartData() { isHasData = false };
            //计算最大值
            float max = 0;
            for (int k = 0; k < 5; k++)
            {
                if (resChartData.series[0].data[k] > max) max = resChartData.series[0].data[k].Value;
            }
            resChartData.series[0].max = max * 1.2f;

            max = 0;
            for (int k = 0; k < 5; k++)
            {
                if (resChartData.series[1].data[k] > max) max = resChartData.series[1].data[k].Value;
            }
            resChartData.series[1].max = max * 1.2f;
            return resChartData;
        }

        /// <summary>
        /// 统计某月某个测点各时段内值和
        /// </summary>
        /// <param name="plants"></param>
        /// <param name="chartname"></param>
        /// <param name="YYYYMM"></param>
        /// <param name="chartType"></param>
        /// <param name="unit"></param>
        /// <param name="monitorCode"></param>
        /// <param name="intervalMins"></param>
        /// <param name="weidu"></param>
        /// <returns></returns>
        public ChartData PlantMonthSectionCountChart(IList<Plant> plants, string chartname, string YYYYMM, string chartType, string unit, int monitorCode, int intervalMins, int weidu)
        {
            int year = int.Parse(YYYYMM.Substring(0,4));
            int month = int.Parse(YYYYMM.Substring(4,2));
            int days = CalenderUtil.getMonthDays(year, month);
            //ChartData resChartData = null;
            //for (int i = 1; i <= days; i++) {
            //    ChartData chartData = PlantDaySectionCountChart(plants, chartname, YYYYMM + i.ToString("00"), chartType, unit, monitorCode, intervalMins, weidu);
            //    if (resChartData == null)
            //    {
            //        resChartData = chartData;
            //    }
            //    else
            //    {
            //        mergeHash(resChartData.series[0].data, chartData.series[0].data);
            //        mergeHash(resChartData.series[1].data, chartData.series[1].data);
            //    }
            //}
            //return resChartData;

            ChartData resChartData = null;
            //电费维度轴
            YData feeyData = new YData();
            YData[] newSeries = new YData[2];
            string[] newCategories = new string[4 + 1] { "峰", "平", "谷", "尖", "合计" };
            ///要进行多个电站累计，因为电站配置的
            float?[] newValues = new float?[5] { 0, 0, 0, 0, 0 };
            float?[] newFeeValues = new float?[5] { 0, 0, 0, 0, 0 };
            foreach (Plant plant in plants)
            {
                if (plant.allFactUnits == null || plant.allFactUnits.Count < 1) continue;
                Hashtable dataHash = CollectorYearMonthDataService.GetInstance().GetUnitBetweenYearData(plant.allFactUnits, year, year);
                if (dataHash== null || dataHash.Count < 1) continue;
                //取出本月数据
                object v = dataHash[YYYYMM.ToString()];
                float energy = v == null ? 0 : (float)v;
                //按照既定比率分拆
                ElecPrice[] sections = plant.ElecPriceList.ToArray();

                float rate = 0;
                ElecPrice x = null;
                for (int i = 0; i < 4; i++)
                {
                    if (sections == null || i >= sections.Length)
                    {
                        if (i == 0)
                        {//峰
                            rate = 0.4f;
                            x = new ElecPrice() { fromHm = "08:00", toHm = "12:00", price = "0.6" };
                        }
                        else if (i == 1)
                        {//平
                            rate = 0.45f;
                            x = new ElecPrice() { fromHm = "12:00", toHm = "18:00", price = "0.5" };
                        }
                        else if (i == 2)
                        {//谷
                            rate = 0.1f;
                            x = new ElecPrice() { fromHm = "18:00", toHm = "23:00", price = "0.2" };
                        }
                        else
                        {//尖
                            rate = 0.05f;
                            x = new ElecPrice() { fromHm = "01:00", toHm = "08:00", price = "0.4" };
                        }
                    }
                    else
                    {
                        x = sections[i];
                        if (string.IsNullOrEmpty(x.fromHm))
                        {
                            if (i == 0)
                            {//峰
                                rate = 0.4f;
                                x = new ElecPrice() { fromHm = "08:00", toHm = "12:00", price = "0.6" };
                            }
                            else if (i == 1)
                            {//平
                                rate = 0.45f;
                                x = new ElecPrice() { fromHm = "12:00", toHm = "18:00", price = "0.5" };
                            }
                            else if (i == 2)
                            {//谷
                                rate = 0.1f;
                                x = new ElecPrice() { fromHm = "18:00", toHm = "23:00", price = "0.2" };
                            }
                            else
                            {//尖
                                rate = 0.05f;
                                x = new ElecPrice() { fromHm = "01:00", toHm = "08:00", price = "0.4" };
                            }
                        }
                    }
                    newValues[i] = (newValues[i] == 0 ? 0 : newValues[i]) + energy * rate;
                    
                    if (newValues[i] < 0) newValues[i] = 0;
                }

                //合计总发电量
                float? value = 0;
                for (int k = 0; k < 4; k++)
                {
                    value += newValues[k];
                }

                newValues[4] = value;


                //总=（峰电费+平电费+谷电费+尖电费）+（峰发电量 + 平发电量 + 谷发电量 + 尖发电量）*基础电价
                float? total = 0;
                for (int k = 0; k < 4; k++)
                {
                    newFeeValues[k] = newValues[k] * float.Parse(x.price);
                    total += newFeeValues[k];
                }
                //总电费
                newFeeValues[4] = total + value * plant.basePrice;//1是基础电价

                if (resChartData == null)
                {
                    YData yData = null;
                    resChartData = new ChartData();
                    resChartData.name = "月度峰平谷尖发电量和收入";
                    resChartData.isHasData = true;
                    yData = new YData();
                    yData.data = new float?[] { 0, 0, 0, 0, 0 };
                    yData.name = "发电量[kWh]";
                    yData.yAxis = "0";
                    yData.type = chartType;
                    yData.color = "#EF5808";

                    feeyData = new YData();
                    //将新的结果重新放到结果对象中            
                    resChartData.categories = newCategories;
                    yData.data = newValues;
                    feeyData.data = newFeeValues;
                    feeyData.name = "收入[元]";
                    feeyData.yAxis = "1";
                    feeyData.type = chartType;
                    feeyData.color = "#4682B4";
                    newSeries[0] = yData;
                    newSeries[1] = feeyData;
                    resChartData.series = newSeries;
                    resChartData.names = new String[] { "发电量", "收入" };
                    resChartData.units = new String[] { "kWh", "元" };
                    resChartData.colors = new String[] { "#EF5808", "#4682B4" };
                    resChartData.serieNo = DateTime.Now.ToString("ddhhmmss") + new Random().Next(1000);
                    TempDataUtil.putChartData(resChartData.serieNo, resChartData);
                }
                else
                {
                    mergeHash(resChartData.series[0].data, newValues);
                    mergeHash(resChartData.series[1].data, newFeeValues);
                }
            }
            if (resChartData == null) return new ChartData() { isHasData = false };
            //计算最大值
            float max = 0;
            for (int k = 0; k < 5; k++)
            {
                if (resChartData.series[0].data[k] > max) max = resChartData.series[0].data[k].Value;
            }
            resChartData.series[0].max = max*1.2f;

            max = 0;
            for (int k = 0; k < 5; k++)
            {
                if (resChartData.series[1].data[k] > max) max = resChartData.series[1].data[k].Value;
            }
            resChartData.series[1].max = max * 1.2f;
            return resChartData;
        }

        /// <summary>
        /// 统计某天某个测点各时段内值和
        /// </summary>
        /// <param name="plants"></param>
        /// <param name="chartname"></param>
        /// <param name="YYYYMMDD"></param>
        /// <param name="chartType"></param>
        /// <param name="unit"></param>
        /// <param name="monitorCode"></param>
        /// <param name="intervalMins"></param>
        /// <param name="sections">时间段集合，需要按照</param>
        /// <returns></returns>
        public ChartData PlantDaySectionCountChart(IList<Plant> plants, string chartname, string YYYYMMDD, string chartType, string unit, int monitorCode, int intervalMins, int weidu)
        {
            ChartData resChartData = null;
            //电费维度轴
            YData feeyData = new YData();
            YData[] newSeries = new YData[2];
            string[] newCategories = new string[4 + 1]{"峰","平","谷","尖","合计"}; 
            ///要进行多个电站累计，因为电站配置的
            float?[] newValues = new float?[5] { 0, 0, 0, 0, 0 };
            float?[] newFeeValues = new float?[5] { 0, 0, 0, 0, 0 };
            foreach (Plant plant in plants)
            {
                ChartData chartData = PlantDayChart(plant, chartname, YYYYMMDD + "00", YYYYMMDD + "23", chartType, unit, monitorCode, intervalMins);
                //按照时段进行分拆
                int day = int.Parse(YYYYMMDD.Substring(4, 2));
                ElecPrice[] sections = plant.ElecPriceList.ToArray();

                string key = null;
                ElecPrice x = null;
                for (int i = 0; i < 4; i++)
                {
                    if (sections == null || i >= sections.Length)
                    {
                        if (i == 0)//峰
                            x = new ElecPrice() { fromHm = "08:00", toHm = "12:00", price = "0.6" };
                        else if (i == 1)//平
                            x = new ElecPrice() { fromHm = "12:00", toHm = "18:00", price = "0.5" };
                        else if (i == 2)//谷
                            x = new ElecPrice() { fromHm = "18:00", toHm = "23:00", price = "0.2" };
                        else//尖
                            x = new ElecPrice() { fromHm = "01:00", toHm = "08:00", price = "0.4" };
                    }
                    else
                    {
                        x = sections[i];
                        if (string.IsNullOrEmpty(x.fromHm))
                        {
                            if (i == 0)//峰
                                x = new ElecPrice() { fromHm = "08:00", toHm = "12:00", price = "0.6" };
                            else if (i == 1)//平
                                x = new ElecPrice() { fromHm = "12:00", toHm = "18:00", price = "0.5" };
                            else if (i == 2)//谷
                                x = new ElecPrice() { fromHm = "18:00", toHm = "23:00", price = "0.2" };
                            else//尖
                                x = new ElecPrice() { fromHm = "01:00", toHm = "08:00", price = "0.4" };
                        }
                    }

                    key = getKeyPointWithMid(intervalMins, x.fromHm.Replace(":",""),":");

                    //从数据中取出对应坐标的值
                    int index = getIndexinArr(chartData.categories, key);
                    //通过下标从数据数据中找到数据
                    float? startValue = chartData.isHasData?getValueinArr(chartData.series[0].data, index, false):0;
                    key = getKeyPointWithMid(intervalMins, x.toHm.Replace(":", ""), ":");
                    //从数据中取出对应坐标的值
                    index = getIndexinArr(chartData.categories, key);
                    float? endValue = chartData.isHasData?getValueinArr(chartData.series[0].data, index, true):0;
                    newValues[i] = (newValues[i] == 0 ? 0 : newValues[i]) + (endValue == null ? 0 : endValue) - (startValue == null ? 0 : startValue);
                    if (newValues[i] < 0) newValues[i] = 0;
                }

                //合计总发电量
                float? value = 0;
                for (int k = 0; k < 4; k++)
                {
                    value += newValues[k];
                }

                newValues[4] = value;


                //总=（峰电费+平电费+谷电费+尖电费）+（峰发电量 + 平发电量 + 谷发电量 + 尖发电量）*基础电价
                float? total = 0;
                for (int k = 0; k < 4; k++)
                {
                    newFeeValues[k] = newValues[k] * float.Parse(x.price);
                    total += newFeeValues[k];
                }
                //总电费
                newFeeValues[4] = total + value * plant.basePrice;//1是基础电价

                if(resChartData==null){
                    YData yData = null;
                    resChartData = chartData;
                    resChartData.name = "日峰平谷尖发电量和收入";
                    if (!chartData.isHasData)
                    {
                        yData = new YData();
                        yData.data = new float?[] {0,0,0,0,0};
                        yData.name = "发电量[kWh]";
                        yData.yAxis = "0";
                        yData.type = chartType;
                    }
                    else {
                        yData = chartData.series[0];
                    }
                    feeyData = new YData();
                    //将新的结果重新放到结果对象中            
                    resChartData.categories = newCategories;
                    yData.data = newValues;
                    feeyData.data = newFeeValues;
                    feeyData.name = "收入[元]";
                    feeyData.yAxis = "1";
                    feeyData.type = chartType;
                    newSeries[0] = yData;
                    newSeries[1] = feeyData;
                    resChartData.series = newSeries;
                    resChartData.names = new String[] { "发电量", "收入" };
                    resChartData.units = new String[] { "kWh","元"};
                    resChartData.colors = new String[] { "#EF5808", "#4682B4" };
                    resChartData.serieNo = DateTime.Now.ToString("ddhhmmss") + new Random().Next(1000);
                    TempDataUtil.putChartData(resChartData.serieNo, resChartData);
                }else{
                    
                    mergeHash(resChartData.series[0].data, newValues);
                    mergeHash(resChartData.series[1].data, newFeeValues);
                }
                if (chartData.isHasData && !resChartData.isHasData)
                {
                    resChartData.isHasData = true;
                }
            }
            if (resChartData == null) return new ChartData() { isHasData=false};
            //计算最大值
            float max = 0;
            for (int k = 0; k < 5; k++)
            {
                if (resChartData.series[0].data[k] > max) max = resChartData.series[0].data[k].Value;
            }
            resChartData.series[0].max = max * 1.2f;

            max = 0;
            for (int k = 0; k < 5; k++)
            {
                if (resChartData.series[1].data[k] > max) max = resChartData.series[1].data[k].Value;
            }
            resChartData.series[1].max = max * 1.2f;
            return resChartData;
        }

        /// <summary>
        /// 从数组中找到指定数据对应的下标
        /// </summary>
        /// <param name="arr"></param>
        /// <param name="key"></param>
        /// <returns></returns>
        private int getIndexinArr(string[] arr, string key) {
            for (int i = 0; i < arr.Length; i++) {
                if (arr[i].Equals(key)) return i;
            }
            return 0;
        }

        /// <summary>
        /// 从数据中找出给定下班之前或之后的第一个非null数据
        /// </summary>
        /// <param name="datas"></param>
        /// <param name="index"></param>
        /// <param name="before"></param>
        /// <returns></returns>
        private float? getValueinArr(float?[] datas, int index,bool before)
        {
            if (before)
            {
                for (int i = index; i >=0; i--)
                {
                    if (datas[i]!=null) return datas[i];
                }
            }
            else
            {
                for (int i = 0; i <= index; i++)
                {
                    if (datas[i]!=null) return datas[i];
                }
            }
            return 0;
        }
    }
}