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
        public string latlon { get; set; }//逗号分隔经纬度
        public CountryCity Country { get; set; }

        public string lat
        {
            get
            {
                if (string.IsNullOrEmpty(latlon))
                    return string.Empty;
                if (latlon.Split(',').Length > 0)
                    return latlon.Split(',')[0];
                return string.Empty;
            }
        }

        public string lon
        {
            get
            {
                if (string.IsNullOrEmpty(latlon))
                    return string.Empty;
                if (latlon.Split(',').Length > 1)
                    return latlon.Split(',')[1];
                return string.Empty;
            }
        }

    }
}
