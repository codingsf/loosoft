using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
   public class CountryCity
    {
      
       public int id { get; set; }
       public int pid { get; set; }
       public IList<CountryCity> Cities { get; set; }
       public string name { get; set; }
       public string weather_code { get; set; }
       public string startdate { get; set; }
       public string enddate { get; set; }
       public string hours { get; set; }
       public string code { get; set; }
       public string sort_order { get; set; }
       public CountryCity Country { get; set; }
   
    }
}
