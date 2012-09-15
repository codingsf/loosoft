using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 月补偿
    /// </summary>
    public class MonthCompensation
    {
        public int id { get; set; }
        public YearCompensation yearCompensation{get;set;}//年补偿
        public int month{get;set;}//哪一月  1-12
        public double compensation_value{get;set;}//补偿数值
        public IList<DayCompensation> dayCompensationes { get; set; }

    }
}
