using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    public class ElecPrice
    {

        public const int Feng = 1;
        public const int Gu = 2;
        public const int Ping = 3;
        public const int Jian = 4;

        public int id { get; set; }
        public int ptype { get; set; }
        public int plantId { get; set; }
        public string fromHm { get; set; }
        public string toHm { get; set; }
        public string price { get; set; }

        public ElecPrice()
        {
            fromHm = string.Empty;
            toHm = string.Empty;
            price = string.Empty;
        }
    }
}
