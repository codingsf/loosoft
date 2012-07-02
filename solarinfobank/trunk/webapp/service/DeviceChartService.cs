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
    /// 功能：设备报表业务类
    /// 创建时间：2011年02月25日
    /// </summary>
    public class DeviceChartService : BaseChartService
    {
        private static DeviceChartService _instance = new DeviceChartService();
        private static DeviceChartService _appInstance = new DeviceChartService(true);

        private bool fromApp = false;
        private DeviceChartService()
        {

        }

        private DeviceChartService(bool fromApp)
        {
            this.fromApp = fromApp;
        }

        public static DeviceChartService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new DeviceChartService();
            }
            return _instance;
        }


        public static DeviceChartService GetAppInstance()
        {
            if (_appInstance == null)
            {
                _appInstance = new DeviceChartService(true);
            }
            return _appInstance;
        }
        /// <summary>
        /// 设备年度统计图表
        /// </summary>
        /// <param name="device"></param>
        /// <param name="rate"></param>
        /// <param name="chartname"></param>
        /// <param name="chartType"></param>
        /// <param name="unit"></param>
        /// <returns></returns>
        public ChartData YearChartByDevice(Device device, float rate, string chartname, string chartType, string unit)
        {
            if (device == null)
            {
                return new ChartData();
            }

            string chartName = LanguageUtil.getDesc("CHART_TITLE_TOTAL_ENERGY");

            ///所有子站累加
            Hashtable yearEnergy = DeviceYearDataService.GetInstance().GetTotalDatasByDevice(device);

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

            string yname = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).name;
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (yearEnergy.Count > 0)
            {
                data = GenerateChartData(yname, newic, yearEnergy, rate);
            }

            return ReportBuilder.createJsonChartXY(chartName, xAxis, data, "", unit, chartType, fromApp);
        }

        /// <summary>
        /// 取得设备年度收益率图表
        /// </summary>
        /// <param name="device"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ChartData TotalCO2ChartByDevice(Device device, string chartType, string unit)
        {
            float rate = getCO2Rate();
            return this.YearChartByDevice(device, rate, "CO2 Reduction Chart", chartType, unit);
        }

        /// <summary>
        /// 设备的年月统计图表
        /// </summary>
        /// <param name="device"></param>
        /// <param name="rate"></param>
        /// <param name="chartname"></param>
        /// <param name="startYearMM"></param>
        /// <param name="endYearMM"></param>
        /// <param name="chartType"></param>
        /// <param name="unit"></param>
        /// <returns></returns>
        public ChartData YearMMChartByDevice(Device device, float rate, string chartname, string startYearMM, string endYearMM, string chartType, string unit)
        {
            if (device == null)
            {
                return new ChartData();
            }
            string name = LanguageUtil.getDesc("CHART_TITLE_YEAR_ENERGY");

            int startYear = int.Parse(startYearMM.Substring(0, 4));
            int endYear = int.Parse(endYearMM.Substring(0, 4));
            Hashtable yearMonthEnergy = DeviceYearMonthDataService.GetInstance().GetDeviceBetweenYearData(device, startYear, endYear);

            string[] ic = base.getXseriesFromYYYYMM(startYearMM, endYearMM).ToArray();

            string[] xAxis = formatXaxis(ic, ChartTimeType.YearMonth);

            string yname = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).name;

            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (yearMonthEnergy.Count > 0)
            {
                data = GenerateChartData(yname, ic, yearMonthEnergy, rate);
            }
            return ReportBuilder.createJsonChartXY(name, xAxis, data, "", unit, chartType, fromApp);
        }

        /// <summary>
        /// 设备的月天统计图表
        /// </summary>
        /// <param name="device"></param>
        /// <param name="rate"></param>
        /// <param name="chartname"></param>
        /// <param name="startYearMMDD"></param>
        /// <param name="endYearMMDD"></param>
        /// <param name="chartType"></param>
        /// <param name="unit"></param>
        /// <returns></returns>
        public ChartData MonthDDChartByDevice(Device device, float rate, string chartname, string startYearMMDD, string endYearMMDD, string chartType, string unit)
        {
            if (device == null)
            {
                return new ChartData() ;
            }
            string name =  LanguageUtil.getDesc("CHART_TITLE_MONTH_ENERGY");

            string startYearMM = startYearMMDD.Substring(0, 6);
            string endYearMM = endYearMMDD.Substring(0, 6);
            Hashtable monthDDEnergy = DeviceMonthDayDataService.GetInstance().DeviceYearMMDDList(device, startYearMM, endYearMM);

            string[] ic = base.getXseriesFromYYYYMMDD(startYearMMDD, endYearMMDD).ToArray();

            string[] xAxis = formatXaxis(ic, ChartTimeType.MonthDay);
            string xname = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).name;

            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (monthDDEnergy.Count > 0)
            {
                data = GenerateChartData(xname, ic, monthDDEnergy, rate);
            }
            return ReportBuilder.createJsonChartXY(name, xAxis, data, "", unit, chartType, fromApp);
        }

        /// <summary>
        /// 设备单个测点的日图表
        /// </summary>
        /// <param name="device"></param>
        /// <param name="chartName"></param>
        /// <param name="startYYYYMMDDHH"></param>
        /// <param name="endYYYYMMDDHH"></param>
        /// <param name="chartType"></param>
        /// <param name="unit"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public ChartData DayChart(Device device, string chartName, string startYYYYMMDDHH, string endYYYYMMDDHH, string chartType, string unit, int monitorCode, int intervalMins)
        {
            //将整天的数据截断头尾
            string[] ic = base.getXseriesFromYYYYMMDDHH(startYYYYMMDDHH, endYYYYMMDDHH, intervalMins).ToArray();

            ///结果需要按时间先后排序
            Hashtable powerHash = DeviceDayDataService.GetInstance().GetDaydataList(ic, device, startYYYYMMDDHH, endYYYYMMDDHH, intervalMins, monitorCode);

            string[] xAxis = formatXaxis(ic, this.fromApp ? ChartTimeType.Hour : ChartTimeType.Day);
            MonitorType monitorType = MonitorType.getMonitorTypeByCode(monitorCode);

            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (powerHash.Count > 0)
            {
                //先屏蔽了，因为两天跨度的中间部分平滑有问题，但不是对原来是否有影响测试后才知道
                //this.FirstHandleChartData(ic, powerHash);
                data = GenerateChartData(monitorType.name, ic, powerHash, 1.0F);
            }

            return ReportBuilder.createJsonChartXY(chartName, xAxis, data, "", unit, chartType, fromApp);
        }

        /// <summary>
        /// 取得总体年度pr性能
        /// </summary>
        /// <param name="invertDevice"></param>
        /// <param name="detectorDevice"></param>
        /// <param name="chartName"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ChartData YearPRChartBypList(Device invertDevice,Device detectorDevice, string chartName, string chartType)
        {
            if (invertDevice == null)
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

            //产生坐标
            Hashtable yearEnergy = DeviceYearDataService.GetInstance().GetTotalDatasByDevice(invertDevice);
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

            units.Add(mt.unit);
            units.Add(mt.unit);
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (yearEnergy.Count > 0)
            {
                newseriekey = LanguageUtil.getDesc("ACTUALENERGY");
                data = GenerateChartData(newseriekey, newic, yearEnergy, rate);
            }

            datas.Add(data);
            //取得日照增量强度，并依次计算理论发电量
            //取得有增量日照迁强度的环境监测仪设备
            //计算理论发电量换算率
            rate = this.getEnergyRate(invertDevice.designPower);

            yearEnergy = DeviceYearDataService.GetInstance().GetTotalDatasByDevice(detectorDevice);
            newseriekey = LanguageUtil.getDesc("THEORYENERGY");
            data = GenerateChartData(newseriekey, ic, yearEnergy, rate);
            datas.Add(data);


            float?[] newDataArr = computeByType(xAxis.ToArray(), datas, ComputeType.Ratio);
            KeyValuePair<string, float?[]> newdata = new KeyValuePair<string, float?[]>("PR", newDataArr);
            datas.Add(newdata);
            chartTypes.Add(ChartType.line);
            units.Add("%");
            ynames.Add("PR");

            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes.ToArray(), units.ToArray(), fromApp);
        }

        /// <summary>
        /// 设备年月pr性能
        /// </summary>
        /// <param name="invertDevice"></param>
        /// <param name="detectorDevice"></param>
        /// <param name="chartName"></param>
        /// <param name="startYearMM"></param>
        /// <param name="endYearMM"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ChartData yearMonthRPChartBypList(Device invertDevice,Device detectorDevice, string chartName, string startYearMM, string endYearMM, string chartType)
        {
            if (invertDevice == null)
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
            //产生坐标
            int startYear = int.Parse(startYearMM.Substring(0, 4));
            int endYear = int.Parse(endYearMM.Substring(0, 4));

            string[] ic = base.getXseriesFromYYYYMM(startYearMM, endYearMM).ToArray();

            string[] xAxis = formatXaxis(ic, ChartTimeType.YearMonth);

            float rate = 1.0F;
            string newseriekey;
            //取得多个采集器的实际发电量
            Hashtable yearMonthEnergy = DeviceYearMonthDataService.GetInstance().GetDeviceBetweenYearData(invertDevice, startYear, endYear);


            units.Add(mt.unit);
            units.Add(mt.unit);
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (yearMonthEnergy.Count > 0)
            {
                newseriekey = LanguageUtil.getDesc("ACTUALENERGY");
                data = GenerateChartData(newseriekey, ic, yearMonthEnergy, rate);
            }
            //string comobj = "";//plantList.Count > 1 ? "" : plantList[0].name;
            datas.Add(data);
            //取得日照增量强度，并依次计算理论发电量
            //取得有增量日照迁强度的环境监测仪设备
            rate = this.getEnergyRate(invertDevice.designPower);

            yearMonthEnergy = DeviceYearMonthDataService.GetInstance().GetDeviceBetweenYearData(detectorDevice, startYear, endYear);
            newseriekey = LanguageUtil.getDesc("THEORYENERGY"); 
            data = GenerateChartData(newseriekey, ic, yearMonthEnergy, rate);
            datas.Add(data);

            float?[] newDataArr = computeByType(xAxis.ToArray(), datas, ComputeType.Ratio);
            KeyValuePair<string, float?[]> newdata = new KeyValuePair<string, float?[]>("PR", newDataArr);
            datas.Add(newdata);
            chartTypes.Add(ChartType.line);
            units.Add("%");
            ynames.Add("PR");

            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes.ToArray(), units.ToArray(), fromApp);
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
        public ChartData MonthDDRPChartBypList(Device invertDevice,Device detectorDevice, string chartName, string startYearMMDD, string endYearMMDD, string chartType)
        {
            if (invertDevice == null)
            {
                return new ChartData();
            }

            MonitorType mt = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE);
            IList<string> chartTypes = new List<string>(); //图表类型
            IList<string> units = new List<string>();      //单位
            IList<string> ynames = new List<string>();     //y轴名称
            //IList<string> compareObjs = null;            //图例比较对象，因为是同一个电站，不追加
            chartTypes.Add(chartType);
            chartTypes.Add(chartType);
            ynames.Add(mt.name);
            ynames.Add(mt.name);

            //产生坐标
            string[] ic = base.getXseriesFromYYYYMMDD(startYearMMDD, endYearMMDD).ToArray();

            string[] xAxis = formatXaxis(ic, ChartTimeType.MonthDay);
            float rate = 1.0F;
            string newseriekey;
            //取得多个采集器的实际发电量
            Hashtable monthDDEnergy = DeviceMonthDayDataService.GetInstance().DeviceYearMMDDList(invertDevice, startYearMMDD, endYearMMDD);

            units.Add(mt.unit);
            units.Add(mt.unit);

            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            if (monthDDEnergy.Count > 0)
            {
                newseriekey = LanguageUtil.getDesc("ACTUALENERGY");
                data = GenerateChartData(newseriekey, ic, monthDDEnergy, rate);
            }
            //string comobj = "";//plantList.Count > 1 ? "" : plantList[0].name;
            datas.Add(data);
            //取得日照增量强度，并依次计算理论发电量
            rate = this.getEnergyRate(invertDevice.designPower);

            monthDDEnergy = DeviceMonthDayDataService.GetInstance().DeviceYearMMDDList(detectorDevice, startYearMMDD, endYearMMDD);
            newseriekey = LanguageUtil.getDesc("THEORYENERGY");
            data = GenerateChartData(newseriekey, ic, monthDDEnergy, rate);
            datas.Add(data);

            float?[] newDataArr = computeByType(xAxis.ToArray(), datas, ComputeType.Ratio);
            KeyValuePair<string, float?[]> newdata = new KeyValuePair<string, float?[]>("PR", newDataArr);
            datas.Add(newdata);
            chartTypes.Add(ChartType.line);
            units.Add("%");
            ynames.Add("PR");

            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes.ToArray(), units.ToArray(), fromApp);
        }
    }



}
