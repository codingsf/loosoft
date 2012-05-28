using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 协议测点
    /// Author: 赵文辉
    /// 废弃，用Monitortype取代
    /// 
    /// Time: 2011年4月04日 11:20:55
    /// </summary>
    /// 
    [Serializable]
    public class MonitorItem
    {
        //测点语言包中的前缀
        private static string MONITORITEMAFFIX = "DEVICEMONITORITEM_";
        private string _isDisplay = "1";
        /// <summary>
        /// 不带参的构造函数
        /// </summary>
        public MonitorItem(){ }

        //测点编号 非空
        public string code { get; set; }

        //测点所属协议类型  非空
        public int protocolTypeCode { get; set; }

        //设备测点所属协议类型对象  非空
        public ProtocolType protocolType
        {
            get
            {
                return DeviceData.getProtocolTypeByCode(this.protocolTypeCode);
            }
        }

        //名称来自资源包
        public string name { 
            get {
                return LanguageUtil.getDesc(MONITORITEMAFFIX + this.code.ToString());
            } 
        }

        //备注名称用户显示给管理员
        public string noteName { get; set; }

        //测点单位 非空
        public string unit { get; set; }

        //是否统计  非空
        public string isCount { get; set; }

        //是否显示实时数据  非空
        public string isDisplay
        { 
            get { 
                return _isDisplay; 
            } 
            set {
            _isDisplay = value;
            } 
        }
    }
}
