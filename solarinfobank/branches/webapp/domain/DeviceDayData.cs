/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月01日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 设备日明细数据
    /// </summary>
    [Serializable]
    public class DeviceDayData : BaseDayData
    {
        public DeviceDayData(){ }

        #region Model
        /// <summary>
        /// 设备表id
        /// </summary>
        public int deviceID { get; set; }
        #endregion
        /// <summary>
        /// 取得数据发送时间年月
        /// 非持久化，有外部赋值
        /// 用于定位属于哪个设备表
        /// </summary>
        /// <returns></returns>
        public string deviceType { get; set; }
    }
}
