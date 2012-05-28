/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月09日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
   
    /// <summary>
    /// 设备（设备和电站）数据最大值统计基类
    /// </summary>
    [Serializable]
    public class DeviceDataCount : BaseLocalTime
    {

        /// <summary>
        /// key,主要用于更新
        /// </summary>
        public int id { get; set; }

        /// <summary>
        /// 设备id，电站或设备
        /// </summary>
        public int deviceId { get; set; }

        /// <summary>
        /// 测点
        /// </summary>
        public int  monitorCode { get; set; }

        /// <summary>
        /// 月份
        /// </summary>
        public int month { get; set; }

        /// <summary>
        /// 天
        /// </summary>
        public int day { get; set; }

        /// <summary>
        /// 最大值
        /// </summary>
        public float maxValue { get; set; }

        /// <summary>
        /// 最大值发生时间
        /// </summary>
        public DateTime maxTime { get; set; }

        /// <summary>
        /// 设备统计数据所在的表
        /// 非持久
        /// </summary>
        public string deviceTable { get; set; }

        /// <summary>
        /// 年度
        /// 非持久
        /// </summary>
        public int year { get; set; }
        
    }
}
