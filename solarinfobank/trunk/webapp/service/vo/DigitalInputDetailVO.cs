using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Service.vo
{
    /// <summary>
    /// app应用错误
    /// </summary>
    ///         
    public class DigitalInputDetailVO
    {
        /// <summary>
        /// 正常工作状态
        /// </summary>
        public static string status_no = "on";
        /// <summary>
        /// 非正常工作状态
        /// </summary>
        public static string status_off = "off";

        public DigitalInputDetailVO()
        {
        }

        public DigitalInputDetailVO(string status,string statusItem, string desc)
        {
            this.status = status;
            this.statusItem = statusItem;
            this.statusDesc = desc;
        }

        /// <summary>
        /// 状态
        /// </summary>
        public string status { get; set; }
        /// <summary>
        /// 状态项目
        /// </summary>
        public string statusItem { get; set; }
        /// <summary>
        /// 状态值
        /// </summary>
        public string statusDesc { get; set; }

        /// <summary>
        /// 各路状态值
        /// </summary>
        public string[] routeStatus { get; set; }
    }
}
