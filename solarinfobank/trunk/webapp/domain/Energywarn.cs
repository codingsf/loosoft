using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 发电量告警
    /// 有定时器处理所有设备前一天发电量生成,方便查询，而不是和用户菜单那里的实时计算
    /// </summary>
    [Serializable]
    public class Energywarn
    {
        public int id { get; set; }//id
        public int deviceId { get; set; }//设备id
        public double averageValue { get; set; }//平均值
        public double factValue { get; set; }//实际值
        public double upRate { get; set; }//高系数
        public double downRate { get; set; }//低系数
        public String factRate { get; set; }//实际系数
        public String warndate { get; set; }//告警日期yyyy-MM-dd
        public Device device{ get; set; }//告警设备

    }
}
