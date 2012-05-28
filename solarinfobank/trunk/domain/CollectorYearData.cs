using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：采集器年发电量
    /// 创建时间：2011-01-22
    /// </summary>
    /// 
    [Serializable]
    public class CollectorYearData : BaseLocalTime
    {
        public CollectorYearData() { }

        public int id { get; set; }          //电站总量数据Id 自增长 非空
        public int collectorID { get; set; } //电站ID 非空
        public int year { get; set; }        //年
        public float dataValue { get; set; } //电站总量
        /// <summary>
        /// 最后总发电量，用于缓存丢失后修正发电量数据
        /// </summary>
        public float lastTotalEnergy { get; set; }  
     }
}
