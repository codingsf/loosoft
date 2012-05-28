using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    public class StructPoint
    {
        public const string typeCodePlant = "p";
        public const string typeCodeUnit = "u";


        public string x { get; set; }
        public string y { get; set; }
        public string id { get; set; }
        public string type { get; set; }
        public string displayName { get; set; }
        public string targetUrl { get; set; }
    }
}
