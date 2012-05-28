using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
   /// <summary>
   /// 数据报表类型
   /// </summary>
   public class DataReportType
    {
       public const int TODAY_REPORT_CODE = 1;//日报表
       public const int WEEK_REPORT_CODE = 2; //周报表
       public const int MONTH_REPORT_CODE = 3;//月报表
       public const int YEAR_REPORT_CODE = 4; //年报表
       public const int TOTAL_REPORT_CODE = 5;//总量报表

       static DataReportType()
       {
       }
       /// <summary>
       /// 根据类型代码取得名称
       /// </summary>
       /// <param name="code"></param>
       /// <returns></returns>
       public static string getNameByCode(int code)                            
       {
           return LanguageUtil.getDesc("REPORT_TYPE_" + code);
       }
    }
}
