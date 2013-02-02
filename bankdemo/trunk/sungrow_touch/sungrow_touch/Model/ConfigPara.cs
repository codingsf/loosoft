using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using sungrow_demo.Service.vo;

namespace sungrow_demo.model
{
    public class ConfigPara
    {
        public static string[] displayItemsName = new string[] { "cbxPlants", "cbxTodayEnergy", "cbxTotalEnergy", "cbxTotalCo2", "cbxTotalRecome", "cbxTodayPower", "cbxTotalDesignPower", "cbxTotalTrees" };
        public static string[] displayPageName = new string[] { "cboxPageDetail", "cboxPagePowerChart", "cboxPageWeekEnergyChart", "cboxPageMonthEnergyChart" };
        public const string DetailPage = "0";//详细汇总页面
        public const string PowerChartPage = "1";//功率图表页面
        public const string WeekEnergyChartPage = "2";//周发电量图表页面
        public const string MonthEnergyChartPage = "3";//月发电量图表页面
        public static int currentUser = 0;
        public static int system = 1;
        public const int RMB = 0;//人民币
        public const int MY = 1;//美元
        public const int LUBU = 2;//卢布
        public const int HANYUAN = 3;// 韩元;
        public const int OUYUAN = 4;//欧元
        public const int YBANG = 5;//英镑
        public List<PlantInfoVo> PlantsInfo { get; set; }//地图中显示的电站列表
        public List<PlantInfoVo> TipsPlantsInfo { get; set; }//所有自动演示电站列表
        public string MainInterval { get; set; }  //首页自动播放时间间隔
        public string DetailInterval { get; set; }//详细页面自动播放时间间隔
        public string TipsInterval { get; set; }//气泡时间
        public string height { get; set; }//全局高度
        public string domain { get; set; }//URL
        public int CounterType { get; set; }//0 当前用户  1 系统
        public int currencyType { get; set; }//0 人民币  1 美元
        public string CounterUser { get; set; }//统计的用户
        public string sysname { get; set; }//系统名称
        public decimal incomeRate { get; set; }//首页转化率
        public string displayItems { get; set; }
        public string displayPages { get; set; }//配置显示的页面
        public string langInfo { get; set; }
        /// <summary>
        /// 主语言
        /// </summary>
        public string masterLang
        {
            get
            {
                if (string.IsNullOrEmpty(langInfo) == false)
                {
                    string[] langpara = langInfo.Split('-');
                    if (langpara.Length > 0)
                    {
                        return langpara[0];
                    }
                }
                return "zh";
            }
        }
        /// <summary>
        /// 次语言
        /// </summary>
        public string childLang
        {
            get
            {
                if (string.IsNullOrEmpty(langInfo) == false)
                {
                    string[] langpara = langInfo.Split('-');
                    if (langpara.Length > 1)
                    {
                        return langpara[1];
                    }
                }
                return "en";
            }
        }
        public bool containsPage(string page)
        {
            return displayPages.Contains(string.Format("{0}|", page));
        }

    }
}
