using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    public class VirtualPlant
    {
        public int id { get; set; }
        public string name { get; set; }
        public int parentId { get; set; }
        public string plantIds { get; set; }
        public IList<VirtualPlant> child { get; set; }
        public IList<Plant> plants { get; set; }
    }
}
