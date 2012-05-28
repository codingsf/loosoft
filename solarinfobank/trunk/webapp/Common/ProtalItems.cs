using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class ProtalItems
    {
        public static Dictionary<string, string> items = new Dictionary<string, string>();
        public const string todayEnergy = "1";
        public const string power = "2";
        public const string totalEnergy = "3";
        public const string totalCo2 = "4";
        public const string trees = "5";
        public const string Income = "6";
        public const string temperature = "7";
        public const string sunshine = "8";
        public const string plantCount = "9";
        public const string installPower = "10";

        public const string todayEnergyDisplayName = "今日发电";
        public const string powerDisplayName = "当前功率";
        public const string totalEnergyDisplayName = "累计发电";
        public const string totalCo2DisplayName = "累计CO2减排";
        public const string treesDisplayName = "等效树木";
        public const string incomeDisplayName = "累计收益";
        public const string temperatureDispalyName = "环境温度";
        public const string sunshineDisplayName = "光照强度";
        public const string plantCountDisplayName = "电站数量";
        public const string installPowerDisplayName = "安装功率";

        static ProtalItems()
        {
            items.Add(power, powerDisplayName);
            items.Add(todayEnergy, todayEnergyDisplayName);
            items.Add(totalEnergy, totalEnergyDisplayName);
            items.Add(totalCo2, totalCo2DisplayName);
            items.Add(trees, treesDisplayName);
            items.Add(Income, incomeDisplayName);
            items.Add(temperature, temperatureDispalyName);
            items.Add(sunshine, sunshineDisplayName);
            items.Add(installPower, installPowerDisplayName);
            items.Add(plantCount, plantCountDisplayName);

        }
    }
}
