using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 日补偿
    /// </summary>
   public class DayCompensation
    {
       public int id { get; set; }
       public MonthCompensation monthCompensation { get; set; }//月补偿
       public int day { get; set; }//哪一日 1-31
       public double compensation_value { get; set; }//补偿数值

    }
}
