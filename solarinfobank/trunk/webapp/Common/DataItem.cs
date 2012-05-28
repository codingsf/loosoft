using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
   /// <summary>
   /// 报表数据项预定义
   /// </summary>
   public class DataItem
    {
        public const int TODAY_ENERGY =1;// 今日发电量
        public const int TODAY_TOTAL_ENERGY = 2;// 累计总发电量
        public const int TODAY_REVENUE=3;// 今日收入
        public const int TODAY_TOTAL_REVENUE = 4;// 累计总收入
        public const int TODAY_AVOIDED_CO2=5;// 今日CO2减排
        public const int TODAY_TOTAL_AVOIDED_CO2 = 6;// 累计CO2减排
        public const int TODAY_MAX_POWER=7;// 今日功率最大值
        public const int SENDTIME=8; //今日功率最大值发送时间
        public const int TODAY_PLANT_POWER_CURVE=9;//本日电站功率曲线
        public const int TODAY_PLANT_LIGHT_INTENSITY_CURVE=10;//本日电站日照曲线
        public const int TODAY_PLANT_HOUR_ENERGY_CURVE=11;//本日小时发电量曲线
        public const int TODAY_RATE = 12;//投资收益率

        public const int WEEK_ENERGY=2094;//7日发电量
        public const int WEEK_TOTAL_ENERGY=2095;//总发电量
        public const int WEEK_REVENUE=2096;//7日收益
        public const int WEEK_TOTAL_REVENUE=2097;//总收益
        public const int WEEK_AVOIDED_CO2=2098;//7日co2减排
        public const int WEEK_TOTAL_AVOIDED_CO2=2099;//总减排
        public const int WEEK_DEVICE_ENERGY = 2100;//周设备发电量
        public const int WEEK_RATE = 2101;//投资收益率

        public const int MONTH_ENERGY=3100;//月发电量
        public const int MONTH_TOTAL_ENERGY=3101;//总发电量
        public const int MONTH_REVENUE=3102;//月受益
        public const int MONTH_TOTAL_REVENUE=3103;//总受益
        public const int MONTH_AVOIDED_CO2=3104;//月co2减排
        public const int MONTH_TOTAL_AVOIDED_CO2=3105;//总减排
        public const int MONTH_DEVICE_ENERGY = 3106;//月度设备发电量
        public const int MONTH_RATE = 3107;//投资收益率

        public const int YEAR_ENERGY=4106;//本年发电量
        public const int YEAR_TOTAL_ENERGY=4107;//累计发电量
        public const int YEAR_REVENUE=4108;//年度收益
        public const int YEAR_TOTAL_REVENUE=4109;//累计收益
        public const int YEAR_AVOIDED_CO2=4110;//年co2减排
        public const int YEAR_TOTAL_AVOIDED_CO2=4111;//总减排
        public const int YEAR_DEVICE_ENERGY = 4112;//年度设备发电量
        public const int YEAR_RATE = 4113;//投资收益率

        public const int TOTAL_ENERGY = 5112;//累计发电量
        public const int TOTAL_REVENUE = 5114;//累计收益
        public const int TOTAL_AVOIDED_CO2 = 5117;//累计co2减排
        public const int TOTAL_DEVICE_ENERGY = 5118;//累计设备发电量
        public const int TOTAL_RATE = 5119;//投资收益率

        public int code { get; set; }                 //数据项代码
   
        public string name                            //数据项名称
        {
            get
            {
                return LanguageUtil.getDesc("DATAITEM_" + this.code);
            }
        }
       
        //报表类型对应在用测点list map
        public static IDictionary<int, IList<DataItem>> dataItemMap = new Dictionary<int, IList<DataItem>>();
        public static IList<int> deviceDataItemMap = new List<int>();//非电站数据项目
        static DataItem()
        {
             //日报表数据
             IList<DataItem> dayReportDataItemList = new List<DataItem>();
             dayReportDataItemList.Add(new DataItem() { code = TODAY_ENERGY });
             dayReportDataItemList.Add(new DataItem() { code = TODAY_TOTAL_ENERGY });
             dayReportDataItemList.Add(new DataItem() { code = TODAY_REVENUE });
             dayReportDataItemList.Add(new DataItem() { code = TODAY_TOTAL_REVENUE });
             dayReportDataItemList.Add(new DataItem() { code = TODAY_RATE });
             dayReportDataItemList.Add(new DataItem() { code = TODAY_AVOIDED_CO2 });
             dayReportDataItemList.Add(new DataItem() { code = TODAY_TOTAL_AVOIDED_CO2 });
             dayReportDataItemList.Add(new DataItem() { code = TODAY_MAX_POWER });
             //dayReportDataItemList.Add(new DataItem() { code = TODAY_PLANT_POWER_CURVE });//暂时注释
             //dayReportDataItemList.Add(new DataItem() { code = TODAY_PLANT_LIGHT_INTENSITY_CURVE });//暂时注释
             //dayReportDataItemList.Add(new DataItem() { code = TODAY_PLANT_HOUR_ENERGY_CURVE });//暂时注释
             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_POWER))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_POWER });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_POWER);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_OUTTYPE))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_OUTTYPE });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_OUTTYPE);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_RUNTIME))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_RUNTIME });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_RUNTIME);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_JNKQTEMPRATURE))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_JNKQTEMPRATURE });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_JNKQTEMPRATURE);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_JNBYQTEMPRATURE))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_JNBYQTEMPRATURE });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_JNBYQTEMPRATURE);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_JNSRQTEMPRATURE))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_JNSRQTEMPRATURE });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_JNSRQTEMPRATURE);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DEVICESTATUS))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DEVICESTATUS });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DEVICESTATUS);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_STATUSTIME))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_STATUSTIME });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_STATUSTIME);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_STATUSDATA1))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_STATUSDATA1 });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_STATUSDATA1);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_STATUSDATA2))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_STATUSDATA2 });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_STATUSDATA2);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_STATUSDATA3))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_STATUSDATA3 });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_STATUSDATA3);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TODAYENERGY))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_TODAYENERGY });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_TODAYENERGY);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALENERGY))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_TOTALENERGY });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_TOTALENERGY);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALDPOWER))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_TOTALDPOWER });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_TOTALDPOWER);
             }
             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALYGPOWER))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_TOTALYGPOWER });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_TOTALYGPOWER);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALWGPOWER))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_TOTALWGPOWER });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_TOTALWGPOWER);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALPOWERFACTOR))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_TOTALPOWERFACTOR });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_TOTALPOWERFACTOR);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DWPL))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DWPL });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DWPL);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV1))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DV1 });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DV1);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC1))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DC1 });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DC1);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV2))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DV2 });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DV2);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC2))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DC2 });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DC2);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC3))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DC3 });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DC3);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV3))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DV3 });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DV3);
             }
             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ADIRECTVOLT))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_ADIRECTVOLT });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_ADIRECTVOLT);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_BDIRECTVOLT))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_BDIRECTVOLT });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_BDIRECTVOLT);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_CDIRECTVOLT))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_CDIRECTVOLT });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_CDIRECTVOLT);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ADIRECTCURRENT))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_ADIRECTCURRENT });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_ADIRECTCURRENT);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_BDIRECTCURRENT))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_BDIRECTCURRENT });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_BDIRECTCURRENT);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_CDIRECTCURRENT))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_CDIRECTCURRENT });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_CDIRECTCURRENT);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ADIRECTPOWER))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_ADIRECTPOWER });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_ADIRECTPOWER);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_BDIRECTPOWER))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_BDIRECTPOWER });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_BDIRECTPOWER);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_CDIRECTPOWER))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_CDIRECTPOWER });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_CDIRECTPOWER);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_AC))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_AC });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_AC);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_AV))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_AV });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_AV);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DC });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DC);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_DV });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_DV);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_INVERTERXL))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_INVERTERXL });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_INVERTERXL);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_INVETERTEMPRATURE))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_INVETERTEMPRATURE });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_INVETERTEMPRATURE);
             }

             if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ACENERGY))
             {
                 dayReportDataItemList.Add(new DataItem() { code = MonitorType.MIC_INVERTER_ACENERGY });
                 deviceDataItemMap.Add(MonitorType.MIC_INVERTER_ACENERGY);
             }

             dataItemMap.Add(DataReportType.TODAY_REPORT_CODE, dayReportDataItemList);

             IList<DataItem> allplantsdayReportDataItemList = new List<DataItem>();
             allplantsdayReportDataItemList.Add(new DataItem() { code = TODAY_TOTAL_ENERGY });
             allplantsdayReportDataItemList.Add(new DataItem() { code = TODAY_ENERGY });
             allplantsdayReportDataItemList.Add(new DataItem() { code = TODAY_REVENUE });
             allplantsdayReportDataItemList.Add(new DataItem() { code = TODAY_TOTAL_REVENUE });
             allplantsdayReportDataItemList.Add(new DataItem() { code = TODAY_AVOIDED_CO2 });
             allplantsdayReportDataItemList.Add(new DataItem() { code = TODAY_TOTAL_AVOIDED_CO2 });
             int newtype = 10 + DataReportType.TODAY_REPORT_CODE;
             dataItemMap.Add(newtype, allplantsdayReportDataItemList);
        
            //周报表数据
            IList<DataItem> weekReportDataItemList = new List<DataItem>();
            weekReportDataItemList.Add(new DataItem() { code = WEEK_ENERGY });
            weekReportDataItemList.Add(new DataItem() { code = WEEK_TOTAL_ENERGY });
            weekReportDataItemList.Add(new DataItem() { code = WEEK_REVENUE });
            weekReportDataItemList.Add(new DataItem() { code = WEEK_TOTAL_REVENUE });
            weekReportDataItemList.Add(new DataItem() { code = WEEK_RATE });
            weekReportDataItemList.Add(new DataItem() { code = WEEK_AVOIDED_CO2 });
            weekReportDataItemList.Add(new DataItem() { code = WEEK_TOTAL_AVOIDED_CO2 });
            weekReportDataItemList.Add(new DataItem() { code = WEEK_DEVICE_ENERGY });
            deviceDataItemMap.Add(WEEK_DEVICE_ENERGY);

            dataItemMap.Add(DataReportType.WEEK_REPORT_CODE, weekReportDataItemList);

            IList<DataItem> allplantsweekReportDataItemList = new List<DataItem>();
            allplantsweekReportDataItemList.Add(new DataItem() { code = WEEK_ENERGY });
            allplantsweekReportDataItemList.Add(new DataItem() { code = WEEK_TOTAL_ENERGY });
            allplantsweekReportDataItemList.Add(new DataItem() { code = WEEK_REVENUE });
            allplantsweekReportDataItemList.Add(new DataItem() { code = WEEK_TOTAL_REVENUE });
            allplantsweekReportDataItemList.Add(new DataItem() { code = WEEK_AVOIDED_CO2 });
            allplantsweekReportDataItemList.Add(new DataItem() { code = WEEK_TOTAL_AVOIDED_CO2 });
            allplantsweekReportDataItemList.Add(new DataItem() { code = WEEK_RATE });
            newtype = 10 + DataReportType.WEEK_REPORT_CODE;
            dataItemMap.Add(newtype, allplantsweekReportDataItemList);

            //月报表数据
            IList<DataItem> monthReportDataItemList = new List<DataItem>();
            monthReportDataItemList.Add(new DataItem() { code = MONTH_ENERGY });
            monthReportDataItemList.Add(new DataItem() { code = MONTH_TOTAL_ENERGY });
            monthReportDataItemList.Add(new DataItem() { code = MONTH_REVENUE });
            monthReportDataItemList.Add(new DataItem() { code = MONTH_TOTAL_REVENUE });
            monthReportDataItemList.Add(new DataItem() { code = MONTH_RATE });
            monthReportDataItemList.Add(new DataItem() { code = MONTH_AVOIDED_CO2 });
            monthReportDataItemList.Add(new DataItem() { code = MONTH_TOTAL_AVOIDED_CO2 });
            monthReportDataItemList.Add(new DataItem() { code = MONTH_DEVICE_ENERGY });

            deviceDataItemMap.Add(MONTH_DEVICE_ENERGY);
            dataItemMap.Add(DataReportType.MONTH_REPORT_CODE, monthReportDataItemList);


            IList<DataItem> allplantsmonthReportDataItemList = new List<DataItem>();
            allplantsmonthReportDataItemList.Add(new DataItem() { code = MONTH_ENERGY });
            allplantsmonthReportDataItemList.Add(new DataItem() { code = MONTH_TOTAL_ENERGY });
            allplantsmonthReportDataItemList.Add(new DataItem() { code = MONTH_REVENUE });
            allplantsmonthReportDataItemList.Add(new DataItem() { code = MONTH_TOTAL_REVENUE });
            allplantsmonthReportDataItemList.Add(new DataItem() { code = MONTH_AVOIDED_CO2 });
            allplantsmonthReportDataItemList.Add(new DataItem() { code = MONTH_TOTAL_AVOIDED_CO2 });
            newtype = 10 + DataReportType.MONTH_REPORT_CODE;
            dataItemMap.Add(newtype, allplantsmonthReportDataItemList);

            //年报表数据
            IList<DataItem> yearReportDataItemList = new List<DataItem>();
            yearReportDataItemList.Add(new DataItem() { code = YEAR_TOTAL_ENERGY });
            yearReportDataItemList.Add(new DataItem() { code = YEAR_ENERGY });
            yearReportDataItemList.Add(new DataItem() { code = YEAR_REVENUE });
            yearReportDataItemList.Add(new DataItem() { code = YEAR_TOTAL_REVENUE });
            yearReportDataItemList.Add(new DataItem() { code = YEAR_RATE });
            yearReportDataItemList.Add(new DataItem() { code = YEAR_AVOIDED_CO2 });
            yearReportDataItemList.Add(new DataItem() { code = YEAR_TOTAL_AVOIDED_CO2 });
            yearReportDataItemList.Add(new DataItem() { code = YEAR_DEVICE_ENERGY });
            deviceDataItemMap.Add(YEAR_DEVICE_ENERGY);
            dataItemMap.Add(DataReportType.YEAR_REPORT_CODE, yearReportDataItemList);
            
            IList<DataItem> allplantsyearReportDataItemList = new List<DataItem>();
            allplantsyearReportDataItemList.Add(new DataItem() { code = YEAR_TOTAL_ENERGY });
            allplantsyearReportDataItemList.Add(new DataItem() { code = YEAR_ENERGY });
            allplantsyearReportDataItemList.Add(new DataItem() { code = YEAR_REVENUE });
            allplantsyearReportDataItemList.Add(new DataItem() { code = YEAR_TOTAL_REVENUE });
            allplantsyearReportDataItemList.Add(new DataItem() { code = YEAR_AVOIDED_CO2 });
            allplantsyearReportDataItemList.Add(new DataItem() { code = YEAR_TOTAL_AVOIDED_CO2 });
            newtype = 10 + DataReportType.YEAR_REPORT_CODE;
            dataItemMap.Add(newtype, allplantsyearReportDataItemList);
            //总体报表数据
             
            IList<DataItem> totalReportDataItemList = new List<DataItem>();
            totalReportDataItemList.Add(new DataItem() { code = TOTAL_ENERGY });
            totalReportDataItemList.Add(new DataItem() { code = TOTAL_REVENUE });
            totalReportDataItemList.Add(new DataItem() { code = TOTAL_RATE });
            totalReportDataItemList.Add(new DataItem() { code = TOTAL_AVOIDED_CO2 });
            totalReportDataItemList.Add(new DataItem() { code = TOTAL_DEVICE_ENERGY });
            deviceDataItemMap.Add(TOTAL_DEVICE_ENERGY);
            dataItemMap.Add(DataReportType.TOTAL_REPORT_CODE, totalReportDataItemList);

            IList<DataItem> allplantstotalReportDataItemList = new List<DataItem>();
            allplantstotalReportDataItemList.Add(new DataItem() { code = TOTAL_ENERGY });
            allplantstotalReportDataItemList.Add(new DataItem() { code = TOTAL_REVENUE });
            allplantstotalReportDataItemList.Add(new DataItem() { code = TOTAL_AVOIDED_CO2 });

            newtype = 10 + DataReportType.TOTAL_REPORT_CODE;
            dataItemMap.Add(newtype, allplantstotalReportDataItemList);
       }

        /// <summary>
        /// 根据数据项代码取得名称
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static string getNameByCode(int code)
        {
            string desc =  LanguageUtil.getDesc("DATAITEM_" + code);
            if (desc.Equals("")) {
                desc = LanguageUtil.getDesc("DEVICEMONITORITEM_" + code);
            }
            return desc;
        }
    }
}
