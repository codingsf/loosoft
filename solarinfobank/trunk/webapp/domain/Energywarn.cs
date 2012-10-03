using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 发电量告警
    /// 有定时器处理所有设备前一天发电量生成
    /// </summary>
    [Serializable]
    public class Energywarn
    {
        public int id { get; set; }//id
        public int deviceId { get; set; }//设备id
        public int collectorId { get; set; }//所属采集器id
        public double averageValue { get; set; }//平均值
        public double factValue { get; set; }//实际值
        public double upRate { get; set; }//高系数
        public double downRate { get; set; }//低系数
        public String factRate { get; set; }//实际系数
        public DateTime warndate { get; set; }//告警日期
        public Device device{ get; set; }//告警设备

    }
}
