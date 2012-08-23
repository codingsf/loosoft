using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
   /// <summary>
   /// 视频监控
   /// </summary>
    [Serializable]    
    public class VideoMonitor
    {
       public int id { get; set; }
       public string name { get; set; }
       public string url { get; set; }
       public int plantId { get; set; }
       public string folder { get; set; }
       public string videofolder { get; set; }
    }
}
