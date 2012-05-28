/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月04日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 采集器各种测点的天数据
    /// </summary>
    [Serializable]
    public class CollectorDayData :BaseDayData
    {
        public CollectorDayData(){ }

        #region Model
        /// <summary>
        /// 设备表id
        /// </summary>
        public int collectorID { get; set; }
        #endregion
    }
}
