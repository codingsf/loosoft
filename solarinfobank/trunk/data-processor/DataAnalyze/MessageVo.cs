using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Globalization;
namespace DataAnalyze
{
    /// <summary>
    /// 消息vo
    /// </summary>
    public class MessageVo
    {
        /// <summary>
        /// 无参构造函数
        /// </summary>
        public MessageVo() { }

        public string key { get; set; }  //memchaed key
        public string message { get; set; }//消息体
    }
}
