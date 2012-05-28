using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    public class RelationConfig
    {
        public const int PlantType = 1;//电站
        public const int DeviceType = 2;//设备接线图类型
        public const int VirtualPlant = 3;//组合电站类型
        public const int AllPlant = 4;//所有电站
        public int id { get; set; }
        public int uid { get; set; }
        public int relationId { get; set; }
        public int relationType { get; set; }
        public string width { get; set; }
        public string height { get; set; }
        public string config3 { get; set; }
        public string config4 { get; set; }
        public string config5 { get; set; }
    }
}
