using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    //设备结构类
    public class DeviceStuct
    {
        public DeviceStuct() { }
        /// <summary>
        /// 需要累计的设备用逗号分隔
        /// </summary>
        public string deviceId { get; set; }//设备id
        public int deviceType { get; set; }//设备类型 参见ChartDeviceType.class
        public MonitorType monitorType { get; set; }//测点代码 参见 DeviceData.class
        public String chartType { get; set; }//图表类型 参见ChartType.class
        private string _unit;
        public string unit { get { return string.IsNullOrEmpty(_unit) ? monitorType.unit : _unit; } set { _unit = value; } }//测点名称，没有从测点取
        public int cVal { get; set; }//图表类型 参见ComputeType.class
        private string _name;
        public string name { get { return string.IsNullOrEmpty(_name) ? monitorType.name : _name; } set { _name = value; } }//测点名称，没有从测点取
        public float rate { get; set; }//换算率
        public string comareObj { get; set; }//换算率
        public int intervalMins { get; set; }//间隔分钟
    }

    /// <summary>
    /// 多个纬度图表比较服务
    /// </summary>
    public class CompareChartService :BaseChartService
    {
        private static CompareChartService _instance = new CompareChartService();

        private static CompareChartService _appInstance = new CompareChartService();

        private bool fromApp;
        private CompareChartService()
        {
        }

        private CompareChartService(bool fromApp)
        {
            this.fromApp = fromApp;
        }

        public static CompareChartService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new CompareChartService();
            }
            return _instance;
        }

        public static CompareChartService GetAppInstance()
        {
            if (_appInstance == null)
            {
                _appInstance = new CompareChartService(true);
            }
            return _appInstance;
        }

        /// <summary>
        /// 
        /// 比较多个设备的年度数据
        /// </summary>
        /// <param name="chartName"></param>
        /// <param name="devices"></param>
        /// <param name="startYear"></param>
        /// <param name="endYear"></param>
        /// <returns></returns>
        public ChartData compareYearsMultiDeviceMultiMonitor(string chartName, IList<DeviceStuct> devices, int startYear, int endYear)
        {
            IList<string> years = new List<string>();
            if (startYear < endYear && startYear > 0)
            {
                for (int i = startYear; i <= endYear; i++)
                {
                    years.Add(i.ToString());
                }
            }
            else
            {
                years.Add(DateTime.Now.Year.ToString());///如果传值不准确侧使用默认年份
            }
            return compareYearsMultiDeviceMultiMonitor(chartName, devices, years);
        }

        /// <summary>
        /// 比较多个设备的年度数据
        /// </summary>
        /// <param name="chartName"></param>
        /// <param name="devices"></param>
        /// <param name="years"></param>
        /// <returns></returns>
        public ChartData compareYearsMultiDeviceMultiMonitor(string chartName, IList<DeviceStuct> devices, IList<string> years)
        {
            string reportData = string.Empty ;
            //chartName = chartName+" from "+years[0]+" to "+years[years.Count-1];
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();
            
            string[] chartTypes= new string[devices.Count];
            string[] units= new string[devices.Count];
            string[] ynames = new string[devices.Count];
            string[] compareObjs = new string[devices.Count];
            DeviceStuct deviceStuct = null;
            bool hasData = false;
            for (int i=0;i<devices.Count;i++){
                ///所有子站累加
                deviceStuct = devices[i];
                int monitorCode = deviceStuct.monitorType.code;
                string deviceId = deviceStuct.deviceId;
                chartTypes[i] = deviceStuct.chartType;
                compareObjs[i] = deviceStuct.comareObj;
                ynames[i] = "";
                units[i] = deviceStuct.unit;
                Hashtable dataHash = null;
                string curName = "";
                if (deviceStuct.deviceType == ChartDeviceType.PLANT || deviceStuct.deviceType == ChartDeviceType.UNIT)
                {    //电站
                    IList<PlantUnit> plantUnits = getUnitsBydeviceIDs(deviceId, deviceStuct.deviceType);
                    curName = deviceStuct.name;
                    dataHash = CollectorYearDataService.GetInstance().GetYearDatasByUnits(plantUnits);
                    if (deviceStuct.deviceType == ChartDeviceType.PLANT)
                        //add by qhb in 20120928 for 增加电站补偿发电量
                        base.addPlantYearEnergy(dataHash, int.Parse(deviceId));
                }
                else
                {   //设备
                    Device device = DeviceService.GetInstance().get(int.Parse(deviceId));
                    curName = deviceStuct.name;
                    dataHash = DeviceYearDataService.GetInstance().GetTotalDatasByDevice(device);
                    //add by qhb in 20120928 for 补偿发电量
                    base.addDeviceYearEnergy(dataHash, device.id);
                }

                //如果有多个设备进行编辑，没有数据的时候也显示
                //if (dataHash.Count > 0)
                //{
                    KeyValuePair<string, float?[]> data = base.GenerateChartData(curName, years.ToArray(), dataHash, deviceStuct.rate);
                    datas.Add(data);
                //}
                //如果有数据则将有数据标识为true
                if (dataHash.Count > 0)
                {
                    hasData = true;
                }
            }
            //如果所有设备都没数据才清空数据，即图表中显示无数据提示
            if (!hasData) {
                datas.Clear();
            }
            string[] xAxis = years.ToArray<string>();
            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames, chartTypes, units, compareObjs,false);
        }

        public ChartData compareYearMMMultiDeviceMultiMonitor(string chartName, IList<DeviceStuct> devices, string startYearMM, string endYearMM)
        {
            return compareYearMMMultiDeviceMultiMonitor(chartName, devices, startYearMM, endYearMM, ComputeType.None);
        }

        /// <summary>
        /// 比较多个设备多测点跨月度数据
        /// </summary>
        /// <param name="chartName"></param>
        /// <param name="devices"></param>
        /// <param name="startYearMM"></param>
        /// <param name="endYearMM"></param>
        /// <returns></returns>
        public ChartData compareYearMMMultiDeviceMultiMonitor(string chartName, IList<DeviceStuct> devices, string startYearMM, string endYearMM, int computeType)
        {
            string reportData = string.Empty;
            //chartName = chartName + " from " + startYearMM + "to" + endYearMM;
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();

            string[] chartTypes = new string[devices.Count];
            string[] units = new string[devices.Count];
            string[] ic = base.getXseriesFromYYYYMM(startYearMM, endYearMM).ToArray();
            string[] xAxis = formatXaxis(ic, ChartTimeType.YearMonth);
            string[] ynames = new string[devices.Count];
            string[] compareObjs = new string[devices.Count];
            DeviceStuct deviceStuct = null;
            bool hasData = false;
            for (int i = 0; i < devices.Count; i++)
            {
                ///所有子站累加
                deviceStuct = devices[i];
                int monitorCode = deviceStuct.monitorType.code;
                string deviceId = deviceStuct.deviceId;
                chartTypes[i] = deviceStuct.chartType;
                compareObjs[i] = deviceStuct.comareObj;
                units[i] = deviceStuct.unit;
                ynames[i] = "";
                Hashtable dataHash = null;
                int startYear = int.Parse(startYearMM.Substring(0,4));
                int endYear = int.Parse(endYearMM.Substring(0,4));
                string curName = "";
                if (deviceStuct.deviceType == ChartDeviceType.PLANT || deviceStuct.deviceType == ChartDeviceType.UNIT)
                {    //电站
                    IList<PlantUnit> plantUnits = getUnitsBydeviceIDs(deviceId, deviceStuct.deviceType);
                    curName = deviceStuct.name;
                    dataHash = CollectorYearMonthDataService.GetInstance().GetUnitBetweenYearData(plantUnits,startYear,endYear);
                    if (deviceStuct.deviceType == ChartDeviceType.PLANT)
                        //add by qhb in 20120928 for 增加电站补偿发电量
                        base.addPlantMonthEnergy(dataHash, int.Parse(deviceId), startYear.ToString(),endYear.ToString());
                }
                else
                {   //设备
                    Device device = DeviceService.GetInstance().get(int.Parse(deviceId));
                    curName = deviceStuct.name;
                    dataHash = DeviceYearMonthDataService.GetInstance().GetDeviceBetweenYearData(device, startYear, endYear);
                    //add by qhb in 20120928 for 补偿发电量
                    base.addDeviceMonthEnergy(dataHash, int.Parse(deviceId), startYear.ToString(), endYear.ToString());
                }
                //如果有多个设备进行编辑，没有数据的时候也显示
                //if (dataHash.Count > 0 )
                //{
                    KeyValuePair<string, float?[]> data = base.GenerateChartData(curName, ic, dataHash, deviceStuct.rate);
                    datas.Add(data);
                //}

                //如果有数据则将有数据标识为true
                if (dataHash.Count > 0)
                {
                    hasData = true;
                }
            }
            //如果所有设备都没数据才清空数据，即图表中显示无数据提示
            if (!hasData) {
                datas.Clear();
            }
            //如果有计算类型，就要追究相应计算维度
            if (computeType != ComputeType.None && hasData)
            {
                float?[] newDataArr = computeByType(xAxis.ToArray(), datas, computeType);
                KeyValuePair<string, float?[]> newdata = new KeyValuePair<string, float?[]>(LanguageUtil.getDesc("AVERAGE"), newDataArr);
                datas.Add(newdata);
                string[] newChartTypes = new string[chartTypes.Length + 1];
                string[] newUnits = new string[units.Length + 1];
                string[] newYnames = new string[ynames.Length + 1];
                string[] newCompareObjs = new string[compareObjs.Length + 1];
                string[] colors = new string[units.Length + 1];
                ynames.CopyTo(newYnames, 0);
                newYnames[newYnames.Length - 1] = LanguageUtil.getDesc("AVERAGE");
                units.CopyTo(newUnits, 0);
                newUnits[newUnits.Length - 1] = units[0];
                chartTypes.CopyTo(newChartTypes, 0);
                newChartTypes[newChartTypes.Length - 1] = chartTypes[0];
                newCompareObjs.CopyTo(newCompareObjs, 0);
                newCompareObjs[newCompareObjs.Length - 1] = "";
                colors[colors.Length - 1] = "#EE0000";
                return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, newYnames, newChartTypes, newUnits, newCompareObjs, colors,fromApp);
            }
            else
            {
                return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames, chartTypes, units, compareObjs, fromApp);
            }
            //return ReportBuilder.createMultiJsonChartXY(chartName, xAxis.ToArray(), datas, ynames, chartTypes, units, compareObjs);
        }

        public ChartData compareMMDDMultiDeviceMultiMonitor(string chartName, IList<DeviceStuct> devices, string startYearMMDD, string endYearMMDD)
        {
            return compareMMDDMultiDeviceMultiMonitor(chartName, devices, startYearMMDD, endYearMMDD, ComputeType.None);
        }

        /// <summary>
        /// 比较多个设备多测点的月天数据
        /// </summary>
        /// <param name="chartName"></param>
        /// <param name="devices"></param>
        /// <param name="startYearMMDD"></param>
        /// <param name="endYearMMDD"></param>
        /// <returns></returns>
        public ChartData compareMMDDMultiDeviceMultiMonitor(string chartName, IList<DeviceStuct> devices, string startYearMMDD, string endYearMMDD, int computeType)
        {
            string reportData = string.Empty;
            //chartName = chartName + " from " + startYearMMDD + "to" + endYearMMDD;
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();
            string[] ic = base.getXseriesFromYYYYMMDD(startYearMMDD, endYearMMDD).ToArray();
            string[] xAxis = formatXaxis(ic, ChartTimeType.MonthDay);
            string[] chartTypes = new string[devices.Count];
            string[] units = new string[devices.Count];
            string[] ynames = new string[devices.Count];
            string[] compareObjs = new string[devices.Count];
            DeviceStuct deviceStuct = null;
            bool hasData = false;
            for (int i = 0; i < devices.Count; i++)
            {
                ///所有子站累加
                deviceStuct = devices[i];
                int monitorCode = deviceStuct.monitorType.code;
                string deviceId = deviceStuct.deviceId;
                chartTypes[i] = deviceStuct.chartType;
                compareObjs[i] = deviceStuct.comareObj;
                ynames[i] = "";
                units[i] = deviceStuct.unit;
                Hashtable dataHash = null;
                string startYearMM = startYearMMDD.Substring(0, 6);
                string endYearMM = endYearMMDD.Substring(0, 6);
                string curName = "";
                if (deviceStuct.deviceType == ChartDeviceType.PLANT || deviceStuct.deviceType == ChartDeviceType.UNIT)
                {   
                    //电站
                    IList<PlantUnit> plantUnits = getUnitsBydeviceIDs(deviceId, deviceStuct.deviceType);
                    curName = deviceStuct.name;
                    dataHash = CollectorMonthDayDataService.GetInstance().GetUnitBetweenMonthData(plantUnits, startYearMM, endYearMM);
                    if (deviceStuct.deviceType == ChartDeviceType.PLANT)
                        //add by qhb in 20120928 for 增加电站补偿发电量
                        base.addPlantDayEnergy(dataHash, int.Parse(deviceId), startYearMM, endYearMM);
                }
                else
                {   //设备
                    Device device = DeviceService.GetInstance().get(int.Parse(deviceId));
                    curName = deviceStuct.name;
                    dataHash = DeviceMonthDayDataService.GetInstance().DeviceYearMMDDList(device, startYearMMDD, endYearMMDD);
                    //add by qhb in 20120928 for 补偿发电量
                    base.addDeviceDayEnergy(dataHash, int.Parse(deviceId), startYearMM, endYearMM);
                }
                //如果有多个设备进行编辑，没有数据的时候也显示
                //if (dataHash.Count > 0)
                //{
                    KeyValuePair<string, float?[]> data = base.GenerateChartData(curName, ic, dataHash, deviceStuct.rate);
                    datas.Add(data);
                //}

                //如果有数据则将有数据标识为true
                if (dataHash.Count > 0)
                {
                    hasData = true;
                }
            }
            //如果所有设备都没数据才清空数据，即图表中显示无数据提示
            if (!hasData) {
                datas.Clear();
            }
            //如果有计算类型，就要追究相应计算维度
            if (computeType != ComputeType.None && datas.Count>0)
            {
                float?[] newDataArr = computeByType(xAxis.ToArray(), datas, computeType);
                KeyValuePair<string, float?[]> newdata = new KeyValuePair<string, float?[]>(LanguageUtil.getDesc("AVERAGE"), newDataArr);
                datas.Add(newdata);
                string[] newChartTypes = new string[chartTypes.Length + 1];
                string[] newUnits = new string[units.Length + 1];
                string[] newYnames = new string[ynames.Length + 1];
                string[] newCompareObjs = new string[compareObjs.Length + 1];
                string[] colors = new string[units.Length + 1];
                ynames.CopyTo(newYnames, 0);
                newYnames[newYnames.Length - 1] = LanguageUtil.getDesc("AVERAGE");
                units.CopyTo(newUnits, 0);
                newUnits[newUnits.Length - 1] = units[0];
                chartTypes.CopyTo(newChartTypes, 0);
                newChartTypes[newChartTypes.Length - 1] = chartTypes[0];
                newCompareObjs.CopyTo(newCompareObjs, 0);
                newCompareObjs[newCompareObjs.Length - 1] = "";
                colors[colors.Length - 1] = "#EE0000";
                return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, newYnames, newChartTypes, newUnits, newCompareObjs, colors, fromApp);
            }
            else
            {
                return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames, chartTypes, units, compareObjs, fromApp);
            }
            //return ReportBuilder.createMultiJsonChartXY(chartName, xAxis.ToArray(), datas, ynames, chartTypes, units, compareObjs);
        }

        /// <summary>
        /// 比较多个设备多测点的天时数据
        /// 默认不追加计算类型
        /// </summary>
        /// <param name="chartName"></param>
        /// <param name="devices"></param>
        /// <param name="startYearMMDDHH"></param>
        /// <param name="endYearMMDDHH"></param>
        /// <param name="intervalMins"></param>
        /// <param name="rate">值的换算率</param>
        /// <returns></returns>
        public ChartData compareDayHHMultiDeviceMultiMonitor(string chartName, IList<DeviceStuct> devices, string startYearMMDDHH, string endYearMMDDHH, int intervalMins)
        {
            return this.compareDayHHMultiDeviceMultiMonitor(chartName, devices, startYearMMDDHH, endYearMMDDHH, intervalMins, ComputeType.None);
        }

        /// <summary>
        /// 比较多个设备多测点的天时数据
        /// </summary>
        /// <param name="chartName"></param>
        /// <param name="devices"></param>
        /// <param name="startYearMMDDHH"></param>
        /// <param name="endYearMMDDHH"></param>
        /// <param name="intervalMins"></param>
        /// <param name="rate">值的换算率</param>
        /// <param name="computeType">计算类型</param>
        /// <returns></returns>
        public ChartData compareDayHHMultiDeviceMultiMonitor(string chartName, IList<DeviceStuct> devices, string startYearMMDDHH, string endYearMMDDHH, int minIntervalMins, int computeType)
        {
            string reportData = string.Empty;
            //chartName = chartName + " from " + startYearMMDDHH + " to " + endYearMMDDHH;
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();

            string[] ic = base.getXseriesFromYYYYMMDDHH(startYearMMDDHH, endYearMMDDHH, minIntervalMins).ToArray();
            string[] xAxis = formatXaxis(ic, this.fromApp ? ChartTimeType.Hour : ChartTimeType.Day);

            IList<string> chartTypes = new List<string>();
            IList<string> units = new List<string>();
            IList<string> ynames = new List<string>();
            IList<string> compareObjs = new List<string>();
            DeviceStuct deviceStuct = null;
            bool hasData = false;
            for (int i = 0; i < devices.Count; i++)
            {
                ///所有子站累加
                deviceStuct = devices[i];
                int monitorCode = deviceStuct.monitorType.code;
                string deviceId = deviceStuct.deviceId;
                Hashtable dataHash = null;
                string startYearMM = startYearMMDDHH.Substring(0, 6);
                string endYearMM = endYearMMDDHH.Substring(0, 6);
                string curName = deviceStuct.name;
                string[] tmpIc = base.getXseriesFromYYYYMMDDHH(startYearMMDDHH, endYearMMDDHH, deviceStuct.intervalMins).ToArray();
                if (deviceStuct.deviceType == ChartDeviceType.PLANT || deviceStuct.deviceType == ChartDeviceType.COLLECTOR)
                {   
                    //电站
                    IList<PlantUnit> plantUnits;
                    if (deviceStuct.deviceType == ChartDeviceType.PLANT)
                    {
                        KeyValuePair<string, float?[]> alldata = new KeyValuePair<string, float?[]>();
                        string[] plantIDArr = deviceId.Split(',');
                        foreach (string plantID in plantIDArr) {
                            if (string.IsNullOrEmpty(plantID)) continue;
                            Plant plant = PlantService.GetInstance().GetPlantInfoById(int.Parse(plantID));
                            ///结果需要按时间先后排序
                            IList<PlantUnit> ounits = monitorCode == MonitorType.PLANT_MONITORITEM_LINGT_CODE ? plant.sunUnits : plant.allFactUnits;
                            dataHash = CollectorDayDataService.GetInstance().GetUnitDaydataList(tmpIc, ounits, startYearMMDDHH, endYearMMDDHH, deviceStuct.intervalMins, monitorCode);
             
                            //if (dataHash.Count > 0)
                            //{
                                chartTypes.Add(deviceStuct.chartType);
                                compareObjs.Add(deviceStuct.comareObj);
                                units.Add(deviceStuct.unit);
                                ynames.Add("");
                                //先屏蔽了，因为两天跨度的中间部分平滑有问题，但不是对原来是否有影响测试后才知道
                                //base.FirstHandleChartData(tmpIc, dataHash);

                                KeyValuePair<string, float?[]> data = base.GenerateChartData(curName, ic, dataHash,deviceStuct.rate);
                                if (alldata.Key == null)
                                    alldata = data;
                                else
                                {
                                    alldata = new KeyValuePair<string, float?[]>(alldata.Key, mergeHash(alldata.Value, data.Value));
                                }
                            //}
                            //如果有数据则将有数据标识为true
                            if (dataHash.Count > 0)
                            {
                                hasData = true;
                            }
                        }

                        //如果有多个设备进行编辑，没有数据的时候也显示
                        //if (alldata.Key != null) {
                            datas.Add(alldata);
                        //}
                    }
                    else
                    {
                        plantUnits = new List<PlantUnit>() { new PlantUnit() { collector = new Collector() { id = int.Parse(deviceId) } } };
                        dataHash = CollectorDayDataService.GetInstance().GetUnitDaydataList(tmpIc,plantUnits, startYearMMDDHH, endYearMMDDHH, deviceStuct.intervalMins, monitorCode);

                        //如果有多个设备进行编辑，没有数据的时候也显示
                        //if (dataHash.Count > 0)
                        //{
                            chartTypes.Add(deviceStuct.chartType);
                            compareObjs.Add(deviceStuct.comareObj);
                            units.Add(deviceStuct.unit);
                            ynames.Add("");
                            //先屏蔽了，因为两天跨度的中间部分平滑有问题，但不是对原来是否有影响测试后才知道
                            //base.FirstHandleChartData(tmpIc, dataHash);
                            KeyValuePair<string, float?[]> data = base.GenerateChartData(curName, ic, dataHash, deviceStuct.rate);
                            datas.Add(data);
                        //}
                        //如果有数据则将有数据标识为true
                        if (dataHash.Count > 0) {
                            hasData = true;
                        }
                    }
                }
                else
                {   
                    //设备
                    Device device = DeviceService.GetInstance().get(int.Parse(deviceId));
                    dataHash = DeviceDayDataService.GetInstance().GetDaydataList(tmpIc,device, startYearMMDDHH, endYearMMDDHH, deviceStuct.intervalMins, monitorCode);
                    //如果有多个设备进行编辑，没有数据的时候也显示
                    //if (dataHash.Count > 0 || devices.Count > 1)
                    //{
                        chartTypes.Add(deviceStuct.chartType);
                        compareObjs.Add(deviceStuct.comareObj);
                        units.Add(deviceStuct.unit);
                        ynames.Add("");
                        //先屏蔽了，因为两天跨度的中间部分平滑有问题，但不是对原来是否有影响测试后才知道
                        //base.FirstHandleChartData(tmpIc, dataHash);
                        KeyValuePair<string, float?[]> data = base.GenerateChartData(curName, ic, dataHash, deviceStuct.rate);
                        datas.Add(data);
                    //}
                    //如果有数据则将有数据标识为true
                    if (dataHash.Count > 0)
                    {
                        hasData = true;
                    }
                }
            }
            if (!hasData) {//如果所有设备都没数据才清空数据，即图表中显示无数据提示
                datas.Clear();
            }
            //如果有计算类型，就要追究相应计算维度,时间间隔不同的是不能有计算类型处理的
            if (computeType != ComputeType.None && datas.Count>0)
            {
                float?[] newDataArr = computeByType(ic, datas,computeType);
                KeyValuePair<string, float?[]> newdata = new KeyValuePair<string, float?[]>(LanguageUtil.getDesc("AVERAGE"), newDataArr);
                datas.Add(newdata);
                chartTypes.Add(chartTypes[0]);
                units.Add(units[0]);
                ynames.Add(LanguageUtil.getDesc("AVERAGE"));
                compareObjs.Add("");
                string[] colors = new string[units.Count + 1];
                colors[colors.Length - 1] = "#EE0000";
                return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes.ToArray(), units.ToArray(), compareObjs.ToArray(), colors, fromApp);
            }else{
                return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes.ToArray(), units.ToArray(), compareObjs.ToArray(), fromApp);
            }
        }
 

        private IList<PlantUnit> getUnitsBydeviceIDs(string deviceIds,int chartDeviceType) {
            if (chartDeviceType == ChartDeviceType.PLANT)
            {
                string[] deviceIdArr = deviceIds.Split(',');
                IList<Plant> plants = new List<Plant>();
                foreach (string deviceId in deviceIdArr)
                {
                    if (string.IsNullOrEmpty(deviceId)) continue;
                    Plant plant = PlantService.GetInstance().GetPlantInfoById(int.Parse(deviceId));
                    plants.Add(plant);
                }
                return getUnitsByPlantList(plants);
            }else if(chartDeviceType == ChartDeviceType.UNIT){
                IList<PlantUnit> units = new List<PlantUnit>();
                string[] deviceIdArr = deviceIds.Split(',');
                foreach (string deviceId in deviceIdArr)
                {
                    if (string.IsNullOrEmpty(deviceId)) continue;
                    PlantUnit unit = PlantUnitService.GetInstance().GetPlantUnitById(int.Parse(deviceId));
                    units.Add(unit);
                }
                return units;
            }
            return new List<PlantUnit>();
        }

        /// <summary>
        /// 功能：取得多个电站多个年度的年月发电量和比较数据
        /// </summary>
        /// <param name="plantList"></param>
        /// <param name="years"></param>
        /// <param name="mt"></param>
        /// <param name="unit"></param>
        /// <param name="chartType"></param>
        /// <param name="rate"></param>
        /// <returns></returns>
        public ChartData PlantYearCompare(IList<Plant> plantList, IList<int> years, string name, MonitorType mt, string unit, string chartType, float rate)
        {
            IList<PlantUnit> plantUnits = this.getUnitsByPlantList(plantList);
            ICollection<ICollection> keys = new List<ICollection>();
            StringBuilder sb = new StringBuilder();
            //foreach (int year in years)
            //{
               // sb.Append("," + year);
           // }

            string chartName = name ;
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();

            string[] chartTypes = new string[1] { chartType };
            IList<string> units = new List<string>();
            IList<string> ynames = new List<string>();
            string[] ic = null;
            //取得多个年度的发电月数据
            int i = 0;
            bool hasData = false;
            foreach (int year in years)
            {
                units.Add(unit);
                ynames.Add("");
                Hashtable dataHash = null;
                string curName = year.ToString();
                dataHash = CollectorYearMonthDataService.GetInstance().GetUnitBetweenYearData(plantUnits, year, year);
                ic = base.getMMX(year.ToString());

                //如果有多个设备进行编辑，没有数据的时候也显示
                //if (dataHash.Count > 0)
                //{
                    //add by qhb in 20120928 for 补偿发电量
                    base.addPlantYearEnergy(dataHash, plantList);
                    KeyValuePair<string, float?[]> data = GenerateChartData(year.ToString(), ic, dataHash, rate);
                    datas.Add(data);
                //}
                //如果有数据则将有数据标识为true
                if (dataHash.Count > 0)
                {
                    hasData = true;
                }
                i++;
            }
            if (!hasData)
            {//如果所有设备都没数据才清空数据，即图表中显示无数据提示
                datas.Clear();
            }
            ic = base.getMMX("");
            string[] xAxis = formatXaxis(ic, ChartTimeType.Month);

            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes, units.ToArray(), fromApp);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：取得设备多个年度的年月发电量比较数据
        /// 创建时间：2011年02月25日
        /// </summary>
        /// <param name="device"></param>
        /// <param name="years"></param>
        /// <param name="mt"></param>
        /// <param name="unit"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ChartData DeviceYearCompare(Device device, IList<int> years, string name, MonitorType mt, string unit, string chartType, float rate)
        {
            ICollection<ICollection> keys = new List<ICollection>();
            StringBuilder sb = new StringBuilder();
           // //foreach (int year in years)
            //{
              //  sb.Append("," + year);
           // }

            string chartName = name + " " + LanguageUtil.getDesc("CHART_TITLE_COMPARE");
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();

            string[] chartTypes = new string[1] { chartType };
            IList<string> units = new List<string>();
            IList<string> ynames = new List<string>();
            string[] ic = null;

            bool hasData = false;
            //取得多个年度的发电月数据
            int i = 0;
            foreach (int year in years)
            {
                units.Add(unit);
                ynames.Add("");
                Hashtable dataHash = null;
                string curName = year.ToString();
                dataHash = DeviceYearMonthDataService.GetInstance().GetDeviceBetweenYearData(device, year, year);
                ic = base.getMMX(year.ToString());
                //如果有多个设备进行编辑，没有数据的时候也显示
                //if (dataHash.Count > 0)
                //{
                    //add by qhb in 20120928 for 补偿发电量
                    base.addDeviceMonthEnergy(dataHash, device.id,year.ToString(),year.ToString());
                    KeyValuePair<string, float?[]> data = GenerateChartData(year.ToString(), ic, dataHash, rate);
                    datas.Add(data);
                //}
                //如果有数据则将有数据标识为true
                if (dataHash.Count > 0)
                {
                    hasData = true;
                }
                i++;
            }
            if (!hasData)
            {//如果所有设备都没数据才清空数据，即图表中显示无数据提示
                datas.Clear();
            }
            ic = base.getMMX("");
            string[] xAxis = formatXaxis(ic, ChartTimeType.Month);
            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames.ToArray(), chartTypes, units.ToArray(), fromApp);
        }

        /// <summary>
        /// 功能：取得多个电站多个年度的年月发电量和比较数据
        /// </summary>
        /// <param name="plantList"></param>
        /// <param name="years"></param>
        /// <param name="mt"></param>
        /// <param name="unit"></param>
        /// <param name="chartType"></param>
        /// <param name="rate"></param>
        /// <returns></returns>
        public ChartData PlantMMCompare(IList<Plant> plantList, IList<string> yearmms,string name, MonitorType mt, string unit, string chartType, float rate)
        {
            IList<PlantUnit> plantUnits = this.getUnitsByPlantList(plantList);
            ICollection<ICollection> keys = new List<ICollection>();
            StringBuilder sb = new StringBuilder();
            //foreach (string year in yearmms)
            //{
               // sb.Append("," + year);
            //}
            string chartName = name + " " + LanguageUtil.getDesc("CHART_TITLE_COMPARE");
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();

            string[] chartTypes = new string[1] { chartType };
            string[] units = new string[1] { unit };
            string[] ynames = new string[1] { "" };
            string[] ic = null;
            bool hasData = false;
            //取得多个年度的发电月数据
            int i = 0;
            foreach (string yearMM in yearmms)
            {
                Hashtable dataHash = null;
                string curName = yearMM;
                dataHash = CollectorMonthDayDataService.GetInstance().GetUnitBetweenMonthData(plantUnits, yearMM, yearMM);
                string[]  tmpic = base.getXseriesFromYYYYMMDD(yearMM + "01", yearMM + CalenderUtil.getMonthDays(yearMM).ToString("00")).ToArray();
                if (ic==null || tmpic.Length > ic.Length) ic = tmpic;
                //如果有多个设备进行编辑，没有数据的时候也显示
                //if (dataHash.Count > 0)
                //{
                    //add by qhb in 20120928 for 补偿发电量
                    base.addPlantDayEnergy(dataHash, plantList, yearMM, yearMM);
                    KeyValuePair<string, float?[]> data = GenerateChartData(curName, ic, dataHash, rate);
                    datas.Add(data);
                //}
                //如果有数据则将有数据标识为true
                if (dataHash.Count > 0)
                {
                    hasData = true;
                }
                i++;
            }
            if (!hasData)
            {//如果所有设备都没数据才清空数据，即图表中显示无数据提示
                datas.Clear();
            }
            string[] xAxis = formatXaxis(ic, ChartTimeType.MonthDay);
            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames, chartTypes, units, fromApp);
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：取得设备多个年度的年月比较数据
        /// 创建时间：2011年02月25日
        /// </summary>
        /// <param name="device"></param>
        /// <param name="years"></param>
        /// <param name="monitorCode"></param>
        /// <param name="unit"></param>
        /// <param name="chartType"></param>
        /// <returns></returns>
        public ChartData DeviceMMCompare(Device device, IList<string> yearmms, MonitorType mt, string unit, string chartType, float rate)
        {
            ICollection<ICollection> keys = new List<ICollection>();
            StringBuilder sb = new StringBuilder();
           // foreach (string year in yearmms)
            //{
               // sb.Append("," + year);
            //}
            string chartName = mt.name + " " + LanguageUtil.getDesc("CHART_TITLE_COMPARE");
            IList<KeyValuePair<string, float?[]>> datas = new List<KeyValuePair<string, float?[]>>();

            string[] chartTypes = new string[1] { chartType };
            string[] units = new string[1] { unit };
            string[] ynames = new string[1] { "" };
            string[] ic = null;

            bool hasData = false;
            //取得多个年度的发电月数据
            int i = 0;
            foreach (string yearMM in yearmms)
            {
                Hashtable dataHash = null;
                string curName = yearMM;
                dataHash = DeviceMonthDayDataService.GetInstance().DeviceYearMMDDList(device, yearMM, yearMM);
                string[] tmpic = base.getXseriesFromYYYYMMDD(yearMM + "01", yearMM + CalenderUtil.getMonthDays(yearMM).ToString("00")).ToArray();
                if (ic == null || tmpic.Length > ic.Length) ic = tmpic;
                //如果有多个设备进行编辑，没有数据的时候也显示
                //if (dataHash.Count > 0)
                //{
                    //add by qhb in 20120928 for 补偿发电量
                    base.addDeviceDayEnergy(dataHash, device.id, yearMM, yearMM);
                    KeyValuePair<string, float?[]> data = GenerateChartData(curName, ic, dataHash, rate);
                    datas.Add(data);
                //}
                //如果有数据则将有数据标识为true
                if (dataHash.Count > 0)
                {
                    hasData = true;
                }
                i++;
            }
            if (!hasData)
            {
                //如果所有设备都没数据才清空数据，即图表中显示无数据提示
                datas.Clear();
            }
            string[] xAxis = formatXaxis(ic, ChartTimeType.MonthDay);
            return ReportBuilder.createMultiJsonChartXY(chartName, xAxis, datas, ynames, chartTypes, units, fromApp);
        }
    }
}