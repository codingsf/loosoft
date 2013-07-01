using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：项目配置实体
    /// 作者：鄢睿
    /// 创建时间：2011年02月20日
    /// </summary>
    ///     
    [Serializable]
    public class ItemConfig
    {
        public const string CO2 = "二氧化碳减排";
        public const string Tree = "等效树木";
        public const string Payment = "提前时间";
        public const int maxCollectorCountId = 48;//每天生成采集器数量 ID
        public const int maxexpiredDaysId = 49;//生成采集器过期天数 ID
        public const float defaultreductionRate = 0.6F;//默认减排率
        public static float reductionRate = defaultreductionRate;//实时减排率
        public static float treeConvert = 40;
        public ItemConfig()
        {

        }

        public int id { get; set; } //项目配置ID 自增长 非空
        public string name { get; set; } //项目名称 非空
        public float value { get; set; } //项目值 非空
        public int type { get; set; }//设置类型
    }
}
