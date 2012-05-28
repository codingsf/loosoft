/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月01日           
/*******************************/
using System;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 带有本地时间的基类
    /// </summary>
    [Serializable]
    public class BaseLocalTime
    {
        public BaseLocalTime() { }

        /// <summary>
        /// 本地接收时间
        /// 非持久化属性
        /// 用于做时间差值比较，这样避免时区问题
        /// </summary>
        public DateTime localAcceptTime { get; set; }

        /// <summary>
        /// 是否不再被持久化
        /// 非持久化
        /// </summary>
        public bool dontPersitent { get; set; }
    }
}
