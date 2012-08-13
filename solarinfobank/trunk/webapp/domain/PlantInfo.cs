using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
///
///非持久化类，用户解析器获取的临时电站信息
namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 电站信息类
    /// </summary>
    public class PlantInfo
    {
        /// <summary>
        /// 电站信息来自的采集器id有sn取得
        /// </summary>
        public int collectorId;
        /// <summary>
        /// 电站项目编号
        /// </summary>
        public string projectName;
        /// <summary>
        /// 电站名称
        /// </summary>
        public string name;
        /// <summary>
        /// 电站业主
        /// </summary>
        public string owner;
        /// <summary>
        /// 电站设计功率
        /// </summary>
        public float designPower;
        /// <summary>
        /// 电站所在国家
        /// </summary>
        public string country;
        /// <summary>
        /// 城市
        /// </summary>
        public string city;
        /// <summary>
        /// 电站所在地的邮政编码
        /// </summary>
        public string postCode;
        /// <summary>
        /// 电站时区
        /// </summary>
        public int timezone;
        /// <summary>
        /// 夏令时支持
        /// </summary>
        public bool isxls;
        /// <summary>
        /// 电站经度,度
        /// </summary>
        public int longd;
        /// <summary>
        /// 电站经度分
        /// </summary>
        public int longm;
        /// <summary>
        /// 电站经度秒
        /// </summary>
        public int longs;
        /// <summary>
        /// 电站维度,度
        /// </summary>
        public int latd;
        /// <summary>
        /// 电站维度，分
        /// </summary>
        public int latm;
        /// <summary>
        /// 电站维度,秒
        /// </summary>
        public int lats;
                   

    }
}
