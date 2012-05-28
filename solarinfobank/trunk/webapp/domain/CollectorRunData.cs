using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：采集器状态数据实体
    /// 创建时间：2011-02-23
    /// 更改 陈波 2011-03-06
    /// </summary>
    /// 
    [Serializable]
    public class CollectorRunData
    {
        public CollectorRunData() {}
        public int collectorID { get; set; }  //电站表id 非空 非空
        public DateTime sendTime { get; set; }//发送日期 非空
        public float dayEnergy { get; set; }  //日发电量 非空
        public float totalEnergy { get; set; }//累计发电量 非空用设备的累加代替
        public float power { get; set; }      //功率 非空 
        public int? sunStrength { get; set; } //日照强度 可为空
        public int? windSpeed { get; set; }    //风速（保留） 可为空
        public int? windDirection { get; set; }//风向 可为空
        public float? temperature { get; set; }//环境温度 可为空


        //private bool _changed = true;
        ///// <summary>
        ///// 数据是否有改变
        ///// </summary>
        //public bool changed
        //{
        //    get
        //    {
        //        return _changed;
        //    }
        //    set
        //    {
        //        _changed = value;
        //    }
        //}
    }
}
