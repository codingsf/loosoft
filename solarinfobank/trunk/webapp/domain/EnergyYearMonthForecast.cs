using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [Serializable]
    public class EnergyYearMonthForecast
    {
        public int id { get; set; }
        public int yearId { get; set; }//如果标示年此字段为空(null)否则关联id  yearid暂时没用 直接存储到datakey中
        public string dataKey { get; set; }//年四位 eg:2012 月2为:02 yearid暂时没用 直接存储到datakey中 yyyyMM
        public int plantId { get; set; }//电站id
        public double dataValue { get; set; }//补偿值

        public string formatKey
        {
            get
            {
                if (dataKey.Length.Equals(6))
                {
                    return string.Format("{0}-{1}", dataKey.Substring(0, 4), dataKey.Substring(4));
                }
                return string.Empty;
            }
        }
    }
}
