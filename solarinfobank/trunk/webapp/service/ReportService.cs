using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
   /// <summary>
   /// 报表业务类
   /// </summary>
   public class ReportService
    {
        private static ReportService _instance = new ReportService();
        private IDaoManager _daoManager = null;
        private IReportDao _runReportDao = null;

        private ReportService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _runReportDao = _daoManager.GetDao(typeof(IReportDao)) as IReportDao;
        }

        public static ReportService GetInstance()
        {
            return _instance;
        }

        public IList<DefineReport> GetAllReportsList()
        {
            return _runReportDao.GetAllReportsList();
        }
        public IList<DefineReport> GetRunReportsByPageByPlantId(Hashtable table)
        {
            return _runReportDao.GetRunReportsListByPlantId(table);
        }
        public DefineReport GetRunReportById(string id )
        {
            return _runReportDao.GetRunReportById(id);
        }
        
       
        public int DeleteReportById(string id)
        {
            return _runReportDao.DeleteReportById(id);
        }

        public int EditReportById(DefineReport report)
        {
            return _runReportDao.EditReportById(report);
        }

        public DefineReport ShowReportById(string id)
        {
            return _runReportDao.ShowReportById(id);
        }

        public int AddRunReport(DefineReport report)
        {
           return  _runReportDao.AddRunReport(report);
        }
       /// <summary>
       /// 批量创建系统预定义报表
       /// </summary>
       /// <param name="userid"></param>
       /// <param name="plantId"></param>
        ReportConfigService configService = ReportConfigService.GetInstance();
        public void batchCreateSysRunReport(int userid, int plantId)
        {
            if (plantId == 0)//创建所有电站图表
            {
                int rpId = 0;
                Hashtable table = construtAllPlantsReportObj(userid, DataReportType.TODAY_REPORT_CODE, DataItem.TODAY_ENERGY + "," + DataItem.TODAY_REVENUE + "," + DataItem.TODAY_TOTAL_AVOIDED_CO2 + "," + DataItem.TODAY_TOTAL_ENERGY + "," + DataItem.TODAY_TOTAL_REVENUE + "," + DataItem.TODAY_AVOIDED_CO2);
                 rpId = this.AddRunReport((DefineReport)table[0]);
                 (table[1] as ReportConfig).fixedTime = "20,00";
                 ((ReportConfig)table[1]).reportId = rpId;
                configService.UpdateEventReport((ReportConfig)table[1]);

                table = construtAllPlantsReportObj(userid, DataReportType.WEEK_REPORT_CODE, DataItem.WEEK_ENERGY + "," + DataItem.WEEK_REVENUE + "," + DataItem.WEEK_TOTAL_ENERGY + "," + DataItem.WEEK_TOTAL_REVENUE + "," + DataItem.WEEK_AVOIDED_CO2 + "," + DataItem.WEEK_TOTAL_AVOIDED_CO2);
                 rpId = this.AddRunReport((DefineReport)table[0]);
                 ((ReportConfig)table[1]).reportId = rpId;
                 (table[1] as ReportConfig).fixedTime = "1,4";

                configService.UpdateEventReport((ReportConfig)table[1]);

                table = construtAllPlantsReportObj(userid, DataReportType.MONTH_REPORT_CODE, DataItem.MONTH_ENERGY + "," + DataItem.MONTH_REVENUE + "," + DataItem.MONTH_TOTAL_ENERGY + "," + DataItem.MONTH_TOTAL_REVENUE + "," + DataItem.MONTH_TOTAL_AVOIDED_CO2 + "," + DataItem.MONTH_AVOIDED_CO2);
                 rpId = this.AddRunReport((DefineReport)table[0]);
                 ((ReportConfig)table[1]).reportId = rpId;
                 (table[1] as ReportConfig).fixedTime = "1,4";
                configService.UpdateEventReport((ReportConfig)table[1]);

                table = construtAllPlantsReportObj(userid, DataReportType.YEAR_REPORT_CODE, DataItem.YEAR_ENERGY + "," + DataItem.YEAR_REVENUE + "," + DataItem.YEAR_AVOIDED_CO2 + "," + DataItem.YEAR_TOTAL_REVENUE + "," + DataItem.YEAR_TOTAL_ENERGY + "," + DataItem.YEAR_TOTAL_AVOIDED_CO2);
                 rpId = this.AddRunReport((DefineReport)table[0]);
                 ((ReportConfig)table[1]).reportId = rpId;
                 (table[1] as ReportConfig).fixedTime = "1,1,4";
                configService.UpdateEventReport((ReportConfig)table[1]);

                table = construtAllPlantsReportObj(userid, DataReportType.TOTAL_REPORT_CODE, DataItem.TOTAL_ENERGY + "," + DataItem.TOTAL_REVENUE + "," + DataItem.TOTAL_AVOIDED_CO2 );
                 rpId = this.AddRunReport((DefineReport)table[0]);
                 ((ReportConfig)table[1]).reportId = rpId;
                 (table[1] as ReportConfig).fixedTime = "1,1,4";
                configService.UpdateEventReport((ReportConfig)table[1]);
            }
            else
            {
                int rId = 0;
                Hashtable table1 = construtPlantReportObj(plantId, DataReportType.TODAY_REPORT_CODE, DataItem.TODAY_ENERGY + "," + DataItem.TODAY_REVENUE + "," + DataItem.TODAY_AVOIDED_CO2 + "," + DataItem.TODAY_TOTAL_ENERGY + "," + DataItem.TODAY_TOTAL_REVENUE + "," + DataItem.TODAY_TOTAL_AVOIDED_CO2 + ',' + MonitorType.MIC_INVERTER_TODAYENERGY + ',' + MonitorType.MIC_INVERTER_TOTALYGPOWER);
                rId=this.AddRunReport((DefineReport)table1[0]);
                (table1[1] as ReportConfig).fixedTime = "20,00";
                ((ReportConfig)table1[1]).reportId = rId;
                configService.UpdateEventReport((ReportConfig)table1[1]);

                table1 = construtPlantReportObj(plantId, DataReportType.WEEK_REPORT_CODE, DataItem.WEEK_ENERGY + "," + DataItem.WEEK_REVENUE + "," + DataItem.WEEK_TOTAL_ENERGY + "," + DataItem.WEEK_TOTAL_REVENUE + "," + DataItem.WEEK_AVOIDED_CO2 + "," + DataItem.WEEK_TOTAL_AVOIDED_CO2 + "," + DataItem.WEEK_DEVICE_ENERGY);
                rId =this.AddRunReport((DefineReport)table1[0]);
                (table1[1] as ReportConfig).fixedTime = "1,4";
                ((ReportConfig)table1[1]).reportId = rId;
                configService.UpdateEventReport((ReportConfig)table1[1]);

                table1 = construtPlantReportObj(plantId, DataReportType.MONTH_REPORT_CODE, DataItem.MONTH_ENERGY + "," + DataItem.MONTH_REVENUE + "," + DataItem.MONTH_TOTAL_ENERGY + "," + DataItem.MONTH_TOTAL_REVENUE + "," + DataItem.MONTH_TOTAL_AVOIDED_CO2 + "," + DataItem.MONTH_AVOIDED_CO2 + "," + DataItem.MONTH_DEVICE_ENERGY);
                 rId = this.AddRunReport((DefineReport)table1[0]);
                 (table1[1] as ReportConfig).fixedTime = "1,4";

                 ((ReportConfig)table1[1]).reportId = rId;
                configService.UpdateEventReport((ReportConfig)table1[1]);

                table1 = construtPlantReportObj(plantId, DataReportType.YEAR_REPORT_CODE, DataItem.YEAR_ENERGY + "," + DataItem.YEAR_REVENUE + "," + DataItem.YEAR_AVOIDED_CO2 + "," + DataItem.YEAR_TOTAL_ENERGY + "," + DataItem.YEAR_TOTAL_AVOIDED_CO2 + "," + DataItem.YEAR_TOTAL_REVENUE + "," + DataItem.YEAR_DEVICE_ENERGY);
                rId = this.AddRunReport((DefineReport)table1[0]);
                (table1[1] as ReportConfig).fixedTime = "1,1,4";

                ((ReportConfig)table1[1]).reportId = rId;
                configService.UpdateEventReport((ReportConfig)table1[1]);

                table1 = construtPlantReportObj(plantId, DataReportType.TOTAL_REPORT_CODE, DataItem.TOTAL_ENERGY + "," + DataItem.TOTAL_REVENUE + "," + DataItem.TOTAL_AVOIDED_CO2 + "," + DataItem.TOTAL_DEVICE_ENERGY);
                rId = this.AddRunReport((DefineReport)table1[0]);
                (table1[1] as ReportConfig).fixedTime = "1,1,4";

                ((ReportConfig)table1[1]).reportId = rId;
                configService.UpdateEventReport((ReportConfig)table1[1]);
            }
        }


        private Hashtable construtAllPlantsReportObj(int userid, int type, string dataitem)
        {
            Hashtable table = new Hashtable();
            DefineReport report1 = new DefineReport()
            {
                ReportType = type,
                ReportName = "All plants-" + DataReportType.getNameByCode(type),
                SaveTime = DateTime.Now,
                dataitem = dataitem,
                UserId = userid
            };
            ReportConfig config1 = new ReportConfig()
            {
                tinterval = "4",
                sendFormat = "html",
                sendMode = "2",
                email = "",
                reportId = 0,
                plantId = 0

            };
            table.Add(0,report1);
            table.Add(1,config1);
            return table;
        }

        private Hashtable construtPlantReportObj(int plantid, int type, string dataitem)
        {
            Hashtable table = new Hashtable();
            string plantName = PlantService.GetInstance().GetPlantInfoById(plantid).name+" ";
            DefineReport report1 = new DefineReport()
            {
                ReportType = type,
                ReportName =plantName+"-"+DataReportType.getNameByCode(type),
                SaveTime = DateTime.Now,
                dataitem = dataitem,
                PlantId = plantid
            };
            ReportConfig config1 = new ReportConfig()
            {
                sendFormat = "html",
                email = "",
                sendMode = "2",
                reportId = 0,
                plantId = plantid

            };
            table.Add(0, report1);
            table.Add(1, config1);
            return table;
        }
        public IList<DefineReport> GetRunReportsListByUserId(Hashtable table)
        {
            return _runReportDao.GetRunReportsListByUserId(table);
        }

        /// <summary>
        /// 根据数据项代码数组取得对应数据项的数据
        /// </summary>
        /// <param name="itemCodes">数据项代码</param>
        /// <param name="datetime">报表数据的时间，格式yyyyMMdd</param>
        /// <returns>返回map结构，key为数据项名称，value为值</returns>
        public IList<Object> getDatabyItemCodes(DefineReport defineReport, string datetime)
        {
            string[] datearr = convertToDateArr(defineReport.ReportType, datetime);
            IList<Object> resList = new List<Object>();
            Hashtable deviceDataHash = new Hashtable();
            IList<int> plantDatacodeList = new List<int>() ;
            Hashtable plantDataHash = getPlantDatabyReportType(defineReport, datearr[0], datearr[1]);
            //取得设备数据项数组
            IList<int> deviceItemCodes = new List<int>();
            foreach (int itemcode in DataItem.deviceDataItemMap)
            {
                if (defineReport.dataItems.Contains(itemcode.ToString()))
                    deviceItemCodes.Add(itemcode);
            }

            foreach(string itemcode in defineReport.dataItems){
                if (string.IsNullOrEmpty(itemcode)) continue;
                if (!DataItem.deviceDataItemMap.Contains(int.Parse(itemcode))){
                    plantDatacodeList.Add(int.Parse(itemcode));
                }
            }

            //取得设备数据
            if (deviceItemCodes.Count > 0 && defineReport.plant!=null)
            {
                deviceDataHash = this.getPlantDeviceData(defineReport.plant, defineReport.ReportType, deviceItemCodes, datearr[0], datearr[1]);
            }
            resList.Add(plantDatacodeList);
            resList.Add(plantDataHash);
            resList.Add(deviceDataHash);
            resList.Add(deviceItemCodes);
            
            return resList;
        }

       /// <summary>
       /// 将不同类型报表所传时间转成起止时间
       /// </summary>
       /// <param name="reportType"></param>
       /// <param name="datetime"></param>
       /// <returns></returns>
        public string[] convertToDateArr(int reportType, string datetime)
        {
            string[] dataArr = new string[2];
            switch (reportType)
            {
                case DataReportType.TODAY_REPORT_CODE:
                    dataArr[0] = datetime.Replace("-","")+"07";
                    dataArr[1] = datetime.Replace("-", "")+"19";
                    break;
                case DataReportType.WEEK_REPORT_CODE:
                    string[] darr1 = datetime.Split('-');
                    int year1 = int.Parse(darr1[0]);
                    int month1 = int.Parse(darr1[1]);
                    int day1 = int.Parse(darr1[2]);
                    string bTime = new DateTime(year1,month1,day1).AddDays(-6).ToString("yyyy-MM-dd");
                    string[] darr2= bTime.Split('-');
                    string year2 = darr2[0];
                    string month2 = darr2[1];
                    string day2 = darr2[2];
                    string beginTime = year2 + month2 + day2;
                    string endTime = year1 + "" + month1.ToString("00") + "" + day1.ToString("00");
                    string[] t = new string[] {beginTime,endTime };
                    dataArr = t;
                    break;
                case DataReportType.MONTH_REPORT_CODE:
                    string[] darr = datetime.Split('-');
                    int year = int.Parse(darr[0]);
                    int month = int.Parse(darr[1]);
                    dataArr[0] = datetime.Replace("-","") + "01";
                    dataArr[1] = datetime.Replace("-", "") + CalenderUtil.getMonthDays(year, month).ToString("00");

                    break;
                case DataReportType.YEAR_REPORT_CODE:
                    dataArr[0] = datetime + "01";
                    dataArr[1] = datetime + "12";
                    break;
                case DataReportType.TOTAL_REPORT_CODE:
                    dataArr = datetime.Split('-');
                    break;
                default:
                    break;
            }

            return dataArr;
        }

        /// <summary>
        /// 根据具体代码取得对应数据
        /// </summary>
        /// <param name="dataItemCode">数据项代码</param>
        /// <param name="datetime">数据时间,格式：yyyyMMdd</param>
        /// <returns></returns>
        private Hashtable getPlantDatabyReportType(DefineReport defineReport,string startTime, string endTime) {
            Plant plant = defineReport.plant;//所在电站
            User user = defineReport.user;//所属用户
            bool isPlantReport = plant == null?false:true;
            if (isPlantReport)
            {
                User plantUser = UserService.GetInstance().Get(int.Parse(plant.userID.ToString()));
                plant.currencies = plantUser.currencies;
                return getPlantItemData(plant, defineReport.ReportType, startTime, endTime);
            }
            else
                return getUserItemData(user, defineReport.ReportType, startTime, endTime);
        }

        /// <summary>
        /// 单个用户数据项数据
        /// </summary>
        /// <param name="plant">电站</param>
        /// <param name="dataItemCode">数据项代码</param>
        /// <param name="startTime">开始时间，日报表只取开始时间，周报表的时间格式为：yyyyMMdd-yyyyMMdd</param>
        /// <param name="endTime"></param>
        /// <returns>数据项为key</returns>
        private Hashtable getUserItemData(User user, int reportType, string startTime, string endTime)
        {
            Hashtable datahash = new Hashtable();
            double co2Rate = ItemConfigService.GetInstance().getCO2Config();
            switch (reportType)
            {
                //--------日报表数据 start--------------
                case DataReportType.TODAY_REPORT_CODE://日报表
                    //日发电量
                    float energy = CollectorMonthDayDataService.GetInstance().getDayData(user.plantUnits(), startTime);
                    //add发电量
                    datahash.Add(DataItem.TODAY_ENERGY, StringUtil.formatDouble(energy, "0.00") + " " + MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit);
                    //今日CO2减排
                    double co2reduce = Plant.computeCO2Reduce(co2Rate, energy);
                    datahash.Add(DataItem.TODAY_AVOIDED_CO2, StringUtil.formatDouble(co2reduce, "0.00") + " " + Plant.computeReduceUnit(co2Rate * energy));
                    //日收入
                    datahash.Add(DataItem.TODAY_REVENUE, user.currencies+" "+ Currencies.format(user.currencies, energy * user.revenueRate));

                    //累计总发电量
                    datahash.Add(DataItem.TODAY_TOTAL_ENERGY, user.DisplayTotalEnergy + " " + user.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.TODAY_TOTAL_REVENUE, user.currencies+" "+user.DisplayRevenue);

                    //累计CO2减排
                    datahash.Add(DataItem.TODAY_TOTAL_AVOIDED_CO2, StringUtil.formatDouble(user.TotalReductiong, "0.00") + " " + user.TotalReductiongUnit);

                    return datahash;
                //--------周报表数据--------------
                case DataReportType.WEEK_REPORT_CODE:
                    //周发电量
                    float w_energy = 0;
                    double w_revenue = 0;
                    foreach (Plant plant in user.displayPlants)
                    {
                        Hashtable w_dataHash = CollectorMonthDayDataService.GetInstance().GetUnitBetweenMonthData(plant.allFactUnits, startTime, endTime);
                        float tmpenergy = 0;
                        foreach (Object o in w_dataHash.Values)
                        {
                            tmpenergy += StringUtil.stringtoFloat(o.ToString());
                        }
                        w_energy += tmpenergy;
                        w_revenue += tmpenergy * plant.revenueRate;
                    }

                    datahash.Add(DataItem.WEEK_ENERGY, StringUtil.formatDouble(w_energy, "0.00") + " " + MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit);
                    //周CO2减排
                    double co2reduce1 = Plant.computeCO2Reduce(co2Rate, w_energy);
                    datahash.Add(DataItem.WEEK_AVOIDED_CO2, co2reduce1 + " " + Plant.computeReduceUnit(co2Rate * w_energy));
                    //周收益
                    datahash.Add(DataItem.WEEK_REVENUE, user.currencies+" "+Currencies.format(user.currencies, w_revenue));
                    //累计总发电量
                    datahash.Add(DataItem.WEEK_TOTAL_ENERGY, user.DisplayTotalEnergy + " " + user.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.WEEK_TOTAL_REVENUE, user.currencies+" "+user.DisplayRevenue);
                    //累计CO2减排
                    datahash.Add(DataItem.WEEK_TOTAL_AVOIDED_CO2, StringUtil.formatDouble(user.TotalReductiong, "0.00") + " " + user.TotalReductiongUnit);
                    return datahash;
                //--------月报表------------
                case DataReportType.MONTH_REPORT_CODE:
                    float m_energy = 0;
                    double m_revenue = 0;
                    foreach (Plant plant in user.displayPlants)
                    {
                        Hashtable m_dataHash = CollectorMonthDayDataService.GetInstance().GetUnitBetweenMonthData(plant.allFactUnits, startTime, endTime);
                        float tmpenergy = 0;
                        foreach (Object o in m_dataHash.Values)
                        {
                            tmpenergy += StringUtil.stringtoFloat(o.ToString());
                        }
                        m_energy += tmpenergy;
                        m_revenue += tmpenergy * plant.revenueRate;
                    }

                    datahash.Add(DataItem.MONTH_ENERGY, StringUtil.formatDouble(m_energy, "0.00") + " " + MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit);
                    //月CO2减排
                    double co2reduce_m = Plant.computeCO2Reduce(co2Rate, m_energy);
                    datahash.Add(DataItem.MONTH_AVOIDED_CO2, StringUtil.formatDouble(co2reduce_m, "0.00") + " " + Plant.computeReduceUnit(co2Rate * m_energy));
                    //月收益
                    datahash.Add(DataItem.MONTH_REVENUE,user.currencies+" "+ Currencies.format(user.currencies, m_revenue));
                    //累计总发电量
                    datahash.Add(DataItem.MONTH_TOTAL_ENERGY, user.DisplayTotalEnergy + " " + user.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.MONTH_TOTAL_REVENUE, user.currencies+" "+user.DisplayRevenue);
                    //累计CO2减排
                    datahash.Add(DataItem.MONTH_TOTAL_AVOIDED_CO2, StringUtil.formatDouble(user.TotalReductiong, "0.00") + " " + user.TotalReductiongUnit);
                    return datahash;
                //------年报表-----------------
                case DataReportType.YEAR_REPORT_CODE:
                    int startYear = int.Parse(startTime.Substring(0, 4));
                    int endYear = int.Parse(endTime.Substring(0, 4));
                    float y_energy = 0;
                    double y_revenue = 0;
                    foreach (Plant plant in user.displayPlants)
                    {
                        Hashtable y_dataHash = CollectorYearMonthDataService.GetInstance().GetUnitBetweenYearData(user.plantUnits(), startYear, endYear);
                        float tmpenergy = 0;
                        foreach (Object o in y_dataHash.Values)
                        {
                            tmpenergy += StringUtil.stringtoFloat(o.ToString());
                        }
                        y_energy += tmpenergy;
                        y_revenue += tmpenergy * plant.revenueRate;
                    }

                    datahash.Add(DataItem.YEAR_ENERGY, StringUtil.formatDouble(y_energy, "0.00") + " " + MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit);
                    //年CO2减排

                    double co2reduce_y = Plant.computeCO2Reduce(co2Rate,y_energy);
                    datahash.Add(DataItem.YEAR_AVOIDED_CO2, StringUtil.formatDouble(co2reduce_y, "0.00") + " " + Plant.computeReduceUnit(co2Rate * y_energy));
                    //年收益
                    datahash.Add(DataItem.YEAR_REVENUE, user.currencies+" "+Currencies.format(user.currencies, y_revenue));
                    //累计总发电量
                    datahash.Add(DataItem.YEAR_TOTAL_ENERGY, user.DisplayTotalEnergy + " " + user.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.YEAR_TOTAL_REVENUE, user.currencies+" "+user.DisplayRevenue);
                    //累计CO2减排
                    datahash.Add(DataItem.YEAR_TOTAL_AVOIDED_CO2, StringUtil.formatDouble(user.TotalReductiong, "0.00") + " " + user.TotalReductiongUnit);
                    return datahash;
                //------总量报表-----------------
                case DataReportType.TOTAL_REPORT_CODE:
                    //累计总发电量
                    datahash.Add(DataItem.TOTAL_ENERGY, user.DisplayTotalEnergy + " " + user.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.TOTAL_REVENUE, user.currencies+" "+user.DisplayRevenue);
                    //累计CO2减排
                    datahash.Add(DataItem.TOTAL_AVOIDED_CO2, StringUtil.formatDouble(user.TotalReductiong, "0.00") + " " + user.TotalReductiongUnit);
                    return datahash;
                default:
                    return datahash;
            }
        }
        
        /// <summary>
        /// 单个电站数据项数据
        /// </summary>
        /// <param name="plant">电站</param>
        /// <param name="dataItemCode">数据项代码</param>
        /// <param name="startTime">开始时间，日报表只取开始时间，周报表的时间格式为：yyyyMMdd-yyyyMMdd</param>
        /// <param name="endTime"></param>
        /// <returns>数据项为key</returns>
        private Hashtable getPlantItemData(Plant plant, int reportType, string startTime,string endTime)
        {
            Hashtable datahash = new Hashtable();
            float co2Rate = ItemConfigService.GetInstance().getCO2Config();
            switch (reportType)
            {
                //--------日报表数据 start--------------
                case DataReportType.TODAY_REPORT_CODE://日报表
                    //日发电量
                    float energy = CollectorMonthDayDataService.GetInstance().getDayData(plant.allFactUnits, startTime);
                    //add发电量
                    datahash.Add(DataItem.TODAY_ENERGY, StringUtil.formatDouble(energy, "0.00") + " " + MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit);
                    //add日最大功率 和发生时间
                    int year = int.Parse(startTime.Substring(0,4));
                    int month = int.Parse(startTime.Substring(4, 2));
                    int day = int.Parse(startTime.Substring(6, 2));
                    DeviceDataCount ddc = DeviceDataCountService.GetInstance().GetPlantMax(plant.id, MonitorType.PLANT_MONITORITEM_POWER_CODE, year, month, day);
                    string res = LanguageUtil.getDesc("NODATA");
                    if (ddc != null) {
                        res = ddc.maxTime+"("+ddc.maxValue+" " + MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_POWER_CODE).unit+")";
                    }
                    datahash.Add(DataItem.TODAY_MAX_POWER,res);
                    //今日CO2减排

                    double co2reduce = Plant.computeCO2Reduce(co2Rate, energy);
                    datahash.Add(DataItem.TODAY_AVOIDED_CO2, StringUtil.formatDouble(co2reduce, "0.00") + " " + Plant.computeReduceUnit(co2Rate * energy));
                    //日收入
                    datahash.Add(DataItem.TODAY_REVENUE, plant.currencies+" " +Currencies.format(plant.currencies,energy * plant.revenueRate));
 
                    //累计总发电量
                    datahash.Add(DataItem.TODAY_TOTAL_ENERGY, plant.DisplayTotalEnergy + " " + plant.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.TODAY_TOTAL_REVENUE, plant.currencies + " " +plant.DisplayRevenue);

                    //累计CO2减排
                    datahash.Add(DataItem.TODAY_TOTAL_AVOIDED_CO2, StringUtil.formatDouble(plant.Reductiong) + " " + plant.ReductiongUnit);

                    //投资收益
                    datahash.Add(DataItem.TODAY_RATE, Math.Round(energy / plant.design_power, 2) + " kWh/kWp");

                    return datahash;
               //--------周报表数据--------------
                case DataReportType.WEEK_REPORT_CODE:
                    //周发电量
                    Hashtable w_dataHash = CollectorMonthDayDataService.GetInstance().GetUnitBetweenMonthData(plant.allFactUnits, startTime, endTime);
                    float w_energy = 0;
                    foreach (Object o in w_dataHash.Values)
                    {
                        w_energy += StringUtil.stringtoFloat(o.ToString());
                    }
                    datahash.Add(DataItem.WEEK_ENERGY, StringUtil.formatDouble(w_energy, "0.00") + " " + MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit);
                    //周CO2减排
                    double co2reduce1 = Plant.computeCO2Reduce(co2Rate, w_energy);
                    datahash.Add(DataItem.WEEK_AVOIDED_CO2, StringUtil.formatDouble(co2reduce1) + " " + Plant.computeReduceUnit(co2Rate * w_energy));
                    //周收益
                    datahash.Add(DataItem.WEEK_REVENUE, plant.currencies+" "+Currencies.format(plant.currencies, w_energy * plant.revenueRate));
                    //累计总发电量
                    datahash.Add(DataItem.WEEK_TOTAL_ENERGY, plant.DisplayTotalEnergy + " " + plant.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.WEEK_TOTAL_REVENUE, plant.currencies+" "+plant.DisplayRevenue);
                    //累计CO2减排
                    datahash.Add(DataItem.WEEK_TOTAL_AVOIDED_CO2, StringUtil.formatDouble(plant.Reductiong, "0.00") + " " + plant.ReductiongUnit);

                    //投资收益
                    datahash.Add(DataItem.WEEK_RATE, Math.Round(w_energy / plant.design_power, 2) + " kWh/kWp");
                    return datahash;
                //--------月报表------------
                case DataReportType.MONTH_REPORT_CODE:
                    Hashtable m_dataHash = CollectorMonthDayDataService.GetInstance().GetUnitBetweenMonthData(plant.allFactUnits, startTime, endTime);
                    float m_energy = 0;
                    foreach (Object o in m_dataHash.Values)
                    {
                        m_energy += StringUtil.stringtoFloat(o.ToString());
                    }
                    datahash.Add(DataItem.MONTH_ENERGY, StringUtil.formatDouble(m_energy, "0.00") + " " + MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit);
                    //月CO2减排
                    double co2reduce_m = Plant.computeCO2Reduce(co2Rate, m_energy);
                    datahash.Add(DataItem.MONTH_AVOIDED_CO2, StringUtil.formatDouble(co2reduce_m, "0.00") + " " + Plant.computeReduceUnit(co2Rate * m_energy));
                    //月收益
                    datahash.Add(DataItem.MONTH_REVENUE, plant.currencies+" "+Currencies.format(plant.currencies, m_energy * plant.revenueRate));
                    //累计总发电量
                    datahash.Add(DataItem.MONTH_TOTAL_ENERGY, plant.DisplayTotalEnergy + " " + plant.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.MONTH_TOTAL_REVENUE,plant.currencies+" "+plant.DisplayRevenue);
                    //累计CO2减排
                    datahash.Add(DataItem.MONTH_TOTAL_AVOIDED_CO2, StringUtil.formatDouble(plant.Reductiong, "0.00") + " " + plant.ReductiongUnit);

                    //投资收益
                    datahash.Add(DataItem.MONTH_RATE, Math.Round(m_energy / plant.design_power, 2) + " kWh/kWp");
                    return datahash;
                //------年报表-----------------
                case DataReportType.YEAR_REPORT_CODE:
                    int startYear = int.Parse(startTime.Substring(0,4));
                    int endYear = int.Parse(endTime.Substring(0, 4));
                    Hashtable y_dataHash = CollectorYearMonthDataService.GetInstance().GetUnitBetweenYearData(plant.allFactUnits, startYear, endYear);
                    float y_energy = 0;
                    foreach (Object o in y_dataHash.Values)
                    {
                        y_energy += StringUtil.stringtoFloat(o.ToString());
                    }
                    datahash.Add(DataItem.YEAR_ENERGY, StringUtil.formatDouble(y_energy, "0.00") + " " + MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit);
                    //年CO2减排
                    double co2reduce_y = Plant.computeCO2Reduce(co2Rate, y_energy);
                    datahash.Add(DataItem.YEAR_AVOIDED_CO2, co2reduce_y + " " + Plant.computeReduceUnit(co2Rate * y_energy));
                    //年收益
                    datahash.Add(DataItem.YEAR_REVENUE, plant.currencies+" "+Currencies.format(plant.currencies, y_energy * plant.revenueRate));
                    //累计总发电量
                    datahash.Add(DataItem.YEAR_TOTAL_ENERGY, plant.DisplayTotalEnergy + " " + plant.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.YEAR_TOTAL_REVENUE, plant.currencies+" "+plant.DisplayRevenue);
                    //累计CO2减排
                    datahash.Add(DataItem.YEAR_TOTAL_AVOIDED_CO2, StringUtil.formatDouble(plant.Reductiong, "0.00") + " " + plant.ReductiongUnit);
                    //投资收益
                    datahash.Add(DataItem.YEAR_RATE, Math.Round(y_energy / plant.design_power, 2) + " kWh/kWp");
                    return datahash;
                //------总量报表-----------------
                case DataReportType.TOTAL_REPORT_CODE:
                    //累计总发电量
                    datahash.Add(DataItem.TOTAL_ENERGY, plant.DisplayTotalEnergy + " " + plant.TotalEnergyUnit);
                    //累计总收入
                    datahash.Add(DataItem.TOTAL_REVENUE, plant.currencies+" "+plant.DisplayRevenue);
                    //累计CO2减排
                    datahash.Add(DataItem.TOTAL_AVOIDED_CO2, StringUtil.formatDouble(plant.Reductiong) + " " + plant.ReductiongUnit);
                    //投资收益
                    datahash.Add(DataItem.TOTAL_RATE, Math.Round(plant.TotalEnergy / plant.design_power, 2) + " kWh/kWp");
                    return datahash;
                default:
                    return datahash;
            }
        }

        /// <summary>
        /// 取得电站下的设备测点数据
        /// </summary>
        /// <param name="plant"></param>
        /// <param name="reportType">报表类型</param>
        /// <param name="datetime"></param>
        /// <returns></returns>
        private Hashtable getPlantDeviceData(Plant plant, int reportType,IList<int> itemCodes, string startTime, string endTime)
        {
            Hashtable dataHash = new Hashtable();
            switch (reportType)
            {
                case DataReportType.TODAY_REPORT_CODE://日报表
                    IList<string[]> deviceDataList = null;
                    foreach (int dataItemCode in itemCodes)
                    {
                        int intervalMins = 60;
                        deviceDataList = new List<string[]>();
                        if (startTime.Length < 8) continue; ;

                        //首先取得头部标题，即横坐标
                        string[] ic = DeviceChartService.GetInstance().getXseriesFromYYYYMMDDHH(startTime, endTime, intervalMins).ToArray();

                        string[] xAxis = DeviceChartService.GetInstance().formatXaxis(ic, ChartTimeType.Hour);
                        string[] newxAxis = new string[xAxis.Length + 3];
                        xAxis.CopyTo(newxAxis, 2);//最前面添加一个空元素
                        newxAxis[0] = LanguageUtil.getDesc("REPORT_COUNT_ITEM"); newxAxis[1] = LanguageUtil.getDesc("REPORT_COUNT_DEVICE");
                        newxAxis[newxAxis.Length - 1] = LanguageUtil.getDesc("REPORT_COUNT_TODAYSUN");
                        deviceDataList.Add(newxAxis);
                        int monitorCode = dataItemCode;//按照设备数据项和设备测点代码定义规则一致，这里的数据code就是测点code

                        string[] tmpDataArr = new string[newxAxis.Length];

                        //取得电站所有设备
                        foreach (Device device in plant.displayDevices())
                        {
                            if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;//只统计逆变器的
                            tmpDataArr = new string[newxAxis.Length];
                            tmpDataArr[1] = device.fullName;
                            //取得原始数据
                            Hashtable powerHash = DeviceDayDataService.GetInstance().GetDaydataList(device, startTime, endTime, intervalMins, monitorCode);
                            if (powerHash.Count > 0)
                            {
                                //加工数据
                                bool isCount = false;
                                if (dataItemCode == MonitorType.MIC_INVERTER_TODAYENERGY)
                                    isCount = true;
                                HandleData(powerHash, ic, tmpDataArr,isCount);
                            }
                            deviceDataList.Add(tmpDataArr);
                        }
                        dataHash.Add(dataItemCode, deviceDataList);
                    }
                    return dataHash;
                case DataReportType.WEEK_REPORT_CODE://周报表
                    //取得设备发电量列表数据
                    deviceDataList = new List<string[]>();

                    //首先取得头部标题，即横坐标
                    string[] wic = DeviceChartService.GetInstance().getXseriesFromYYYYMMDD(startTime, endTime).ToArray();

                    string[] wxAxis = DeviceChartService.GetInstance().formatXaxis(wic, ChartTimeType.Week);
                    string[] newWxAxis = new string[wxAxis.Length + 3];
                    wxAxis.CopyTo(newWxAxis, 2);//最前面添加一个空元素
                    newWxAxis[0] = LanguageUtil.getDesc("REPORT_COUNT_ITEM"); newWxAxis[1] = LanguageUtil.getDesc("REPORT_COUNT_DEVICE");
                    newWxAxis[newWxAxis.Length - 1] = LanguageUtil.getDesc("REPORT_COUNT_TODAYSUN");
                    deviceDataList.Add(newWxAxis);
                    string[] tmpWDataArr = new string[newWxAxis.Length];

                    //取得电站所有设备
                    foreach (Device device in plant.displayDevices())
                    {
                        if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;//只统计逆变器的
                        tmpWDataArr = new string[newWxAxis.Length];
                        tmpWDataArr[1] = device.fullName;
                        //取得原始数据
                        Hashtable powerHash = DeviceMonthDayDataService.GetInstance().DeviceYearMMDDList(device, startTime, endTime);
                        if (powerHash.Count > 0)
                        {
                            //加工数据
                            HandleData(powerHash, wic, tmpWDataArr, true);
                        }
                        deviceDataList.Add(tmpWDataArr);
                    }
                    dataHash.Add(DataItem.WEEK_DEVICE_ENERGY, deviceDataList);
                    return dataHash;
                case DataReportType.MONTH_REPORT_CODE://月报表
                    //取得设备发电量列表数据
                    deviceDataList = new List<string[]>();

                    //首先取得头部标题，即横坐标
                    string[] mic = DeviceChartService.GetInstance().getXseriesFromYYYYMMDD(startTime, endTime).ToArray();

                    string[] mxAxis = DeviceChartService.GetInstance().formatXaxis(mic, ChartTimeType.MonthDay);
                    string[] newMxAxis = new string[mxAxis.Length + 3];
                    mxAxis.CopyTo(newMxAxis, 2);//最前面添加一个空元素
                    newMxAxis[0] = LanguageUtil.getDesc("REPORT_COUNT_ITEM"); newMxAxis[1] = LanguageUtil.getDesc("REPORT_COUNT_DEVICE");
                    newMxAxis[newMxAxis.Length - 1] = LanguageUtil.getDesc("REPORT_COUNT_TODAYSUN");
                    deviceDataList.Add(newMxAxis);
                    string[] tmpMDataArr = new string[newMxAxis.Length];

                    //取得电站所有设备
                    foreach (Device device in plant.displayDevices())
                    {
                        if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;//只统计逆变器的
                        tmpMDataArr = new string[newMxAxis.Length];
                        tmpMDataArr[1] = device.fullName;
                        //取得原始数据
                        Hashtable powerHash = DeviceMonthDayDataService.GetInstance().DeviceYearMMDDList(device, startTime, endTime);
                        if (powerHash.Count > 0)
                        {
                            //加工数据
                            HandleData(powerHash, mic, tmpMDataArr,true);
                        }
                        deviceDataList.Add(tmpMDataArr);
                    }
                    dataHash.Add(DataItem.MONTH_DEVICE_ENERGY, deviceDataList);
                    return dataHash;
                case DataReportType.YEAR_REPORT_CODE://年报表
                    //取得设备发电量列表数据
                    deviceDataList = new List<string[]>();

                    //首先取得头部标题，即横坐标
                    string[] yic = DeviceChartService.GetInstance().getXseriesFromYYYYMM(startTime,endTime).ToArray();

                    string[] yxAxis = DeviceChartService.GetInstance().formatXaxis(yic, ChartTimeType.YearMonth);
                    string[] newYxAxis = new string[yxAxis.Length + 3];
                    yxAxis.CopyTo(newYxAxis, 2);//最前面添加一个空元素
                    newYxAxis[0] = LanguageUtil.getDesc("REPORT_COUNT_ITEM"); newYxAxis[1] = LanguageUtil.getDesc("REPORT_COUNT_DEVICE");
                    newYxAxis[newYxAxis.Length - 1] = LanguageUtil.getDesc("REPORT_COUNT_TODAYSUN");
                    deviceDataList.Add(newYxAxis);
                    string[] tmpYDataArr = new string[newYxAxis.Length];

                    //取得电站所有设备
                    foreach (Device device in plant.displayDevices())
                    {
                        if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;//只统计逆变器的
                        tmpYDataArr = new string[newYxAxis.Length];
                        tmpYDataArr[1] = device.fullName;
                        //取得原始数据
                        Hashtable powerHash = DeviceYearMonthDataService.GetInstance().GetDeviceBetweenYearData(device, int.Parse(startTime.Substring(0,4)), int.Parse(endTime.Substring(0,4)));
                        if (powerHash.Count > 0)
                        {
                            //加工数据
                            HandleData(powerHash, yic, tmpYDataArr, true);
                        }
                        deviceDataList.Add(tmpYDataArr);
                    }
                    dataHash.Add(DataItem.YEAR_DEVICE_ENERGY, deviceDataList);
                    return dataHash;
                case DataReportType.TOTAL_REPORT_CODE://总量报表
                    //取得设备发电量列表数据
                    deviceDataList = new List<string[]>();

                    //首先取得头部标题，即横坐标
                    IList<string> icList = new List<string>();
                    for (int mm = int.Parse(startTime); mm <= int.Parse(endTime); mm++) {
                        icList.Add(mm.ToString());
                    }
                    string[] tic = icList.ToArray();

                    string[] txAxis = DeviceChartService.GetInstance().formatXaxis(tic, ChartTimeType.Year);
                    string[] newTxAxis = new string[txAxis.Length + 3];
                    txAxis.CopyTo(newTxAxis, 2);//最前面添加一个空元素
                    newTxAxis[0] = LanguageUtil.getDesc("REPORT_COUNT_ITEM"); newTxAxis[1] = LanguageUtil.getDesc("REPORT_COUNT_DEVICE");
                    newTxAxis[newTxAxis.Length - 1] = LanguageUtil.getDesc("REPORT_COUNT_TODAYSUN");
                    deviceDataList.Add(newTxAxis);
                    string[] tmpTDataArr = new string[newTxAxis.Length];

                    //取得电站所有设备
                    foreach (Device device in plant.displayDevices())
                    {
                        if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;//只统计逆变器的
                        tmpTDataArr = new string[newTxAxis.Length];
                        tmpTDataArr[1] = device.fullName;
                        //取得原始数据
                        Hashtable powerHash = DeviceYearDataService.GetInstance().GetTotalDatasByDevice(device);
                        if (powerHash.Count > 0)
                        {
                            //加工数据
                            HandleData(powerHash, tic, tmpTDataArr, true);
                        }
                        deviceDataList.Add(tmpTDataArr);
                    }
                    dataHash.Add(DataItem.TOTAL_DEVICE_ENERGY, deviceDataList);
                    return dataHash;
                default :
                    return dataHash;
            }
        }

       /// <summary>
       /// 简单加工数据
       /// </summary>
       /// <param name="powerHash"></param>
       /// <param name="mic"></param>
       /// <param name="tmpMDataArr"></param>
       /// <param name="isCount">是否统计发电量</param>
        private void HandleData(Hashtable powerHash, string[] mic, string[] tmpMDataArr,bool isCount)
        {
            DeviceChartService.GetInstance().FirstHandleChartData(mic, powerHash);
            double hj = 0;//发电量合计
            double tmpvalue = 0;
            for (int i = 0; i < mic.Length; i++)
            {
                object value = powerHash[mic[i]];
                if (value != null)
                {
                    tmpvalue = StringUtil.stringtoDouble(value.ToString());
                    hj += tmpvalue;
                    tmpMDataArr[i + 2] = Math.Round(tmpvalue + 0.0001, 3).ToString();//从2下表开始，因为前两位是空和设备名称
                }
            }

            //如果是发电量将合计发给最后一个数据元素
            if (isCount)
                tmpMDataArr[tmpMDataArr.Length - 1] = Math.Round(hj + 0.0001, 3).ToString() + " kWh";
        }
    }
}
