using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using System.Globalization;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 图表时间类型
    /// </summary>
    public abstract class ChartTimeType
    {
        public const int Hour = 0;
        public const int Day = 2;
        public const int MonthDay = 4;
        public const int MonthDayWithMonth = 5;
        public const int YearMonthDay = 3;
        public const int YearMonth = 6;
        public const int Month = 8;
        public const int Year = 10;
        public const int Week = 12;
    }
}