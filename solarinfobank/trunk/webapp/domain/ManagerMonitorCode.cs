using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    public class ManagerMonitorCode
    {
        public int id { get; set; }
        public string name { get; set; }
        public int type { get; set; }
        public bool display { get; set; }
        public Int16 sortOrder { get; set; }
    }
}
