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
    /// 用户自定义报表
    /// </summary>
    [Serializable]
   
    public class ChartGroup
    {
        /// <summary>
        /// 自增ID
        /// </summary>
        public int id { get; set; }

        /// <summary>
        ///分组ID
        /// </summary>
        public string  groupName { get; set; }

        /// <summary>
        ///分组ID
        /// </summary>
        public int userId { get; set; }

        /// <summary>
        /// 分组下的报表
        /// </summary>
        public IList<CustomChart> CustomReports { get; set; }
        
    }
}
