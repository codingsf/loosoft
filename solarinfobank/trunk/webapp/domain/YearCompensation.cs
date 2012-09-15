using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 年补偿
    /// </summary>
   public class YearCompensation 
    {
       public int id { get; set; }
       public int year { get; set; }//那一年 
       public double compensation_value { get; set; }//补偿值
       public IList<MonthCompensation> monthCompensationes { get; set; }
    }
}
