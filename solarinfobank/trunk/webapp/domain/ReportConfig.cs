using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 报告配置
    /// </summary>
    [Serializable]
    
    public class ReportConfig
    {
        public int id { get; set; }
        public string sendFormat { set; get; }
        public string sendMode { set; get; }
        public string tinterval { set; get; }
        public string email { get; set; }
        public int reportId { set; get; }
        public string fixedTime { set; get; }
        public DefineReport defineReport { set; get; }

        public int plantId { set; get; }
        public DateTime lastSendTime { set;get;  }

        //public int timer
        //{
        //    get
        //    {
        //        int temp = 0;
        //        switch (intervalFormat)
        //        {
        //            case "min.":
        //                temp = interval;
        //                break;
        //            case "hour":
        //                temp = interval*60;
        //                break;
        //            case "day":
        //                temp = interval * 60*24;
        //                break;
        //            default:
        //                break;
        //        }
        //        return temp;
        //    }
        //}
    }

}
