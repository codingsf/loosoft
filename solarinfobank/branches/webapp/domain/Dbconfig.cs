using System;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：电站数据分布配置
    /// 作者：张月
    /// 时间：2011年2月22日
    /// </summary>
    /// 
    [Serializable]
    public class Dbconfig
    {
        /// <summary>
        /// 无参构造函数
        /// </summary>
        public Dbconfig() { }

        public int id { get; set; }             //电站ID
        public string year { get; set; }        //年度
        public string url { get; set; }         //数据库地址
        public bool isEnabled { get; set; }     //是否启用
    }
}
