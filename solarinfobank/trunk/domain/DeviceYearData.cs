using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 作者：张月
    /// 功能：设备年度统计
    /// 创建时间：2011年2月23日
    /// </summary>
    [Serializable]
    public class DeviceYearData : BaseLocalTime
    {
        /// <summary>
        /// 功能：无参数构造函数
        /// </summary>
        public DeviceYearData() { }
        public int id { get; set; }  //设备总量数据Id 自增长 非空
        public int deviceID { get; set; } //设备ID 非空
        public int year { get; set; } //年
        public float dataValue { get; set; }//数据
        /// <summary>
        /// 最后总发电量，用于缓存丢失后修正发电量数据
        /// </summary>
        public float lastTotalEnergy { get; set; }   
    }
}
