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
    public class BaseDayData : BaseLocalTime
    {
        public BaseDayData() { }

        #region Model
        /// <summary>
        /// auto_increment
        /// </summary>
        public int id { get; set; }
        /// <summary>
        /// 发送日1号，2号等
        /// </summary>
        public int sendDay{ set; get;}
        /// <summary>
        /// 数据
        /// 格式：hhmmss:value#hhmmss:value...
        /// </summary>
        public string dataContent { get; set; }
        /// <summary>
        /// 测点
        /// </summary>
        public int monitorCode { get; set; }
        #endregion Model

        /// <summary>
        /// 是否新数据
        /// 非持久化
        /// </summary>
        public bool isNew { get; set; }

        private string _yearmonth;
        /// <summary>
        /// 取得数据发送时间年月
        /// 非持久化，有外部赋值
        /// </summary>
        /// <returns></returns>
        public string yearmonth
        {
            get
            {
                return _yearmonth;
            }
            set {
                _yearmonth = value;
            }
        }
        /// <summary>
        /// 非持久化属性
        /// </summary>
        public DateTime sendtime { get; set; }

        private bool _changed = true;
        /// <summary>
        /// 数据是否有改变
        /// </summary>
        public bool changed
        {
            get
            {
                return _changed;
            }
            set
            {
                _changed = value;
            }
        }
    }
}
