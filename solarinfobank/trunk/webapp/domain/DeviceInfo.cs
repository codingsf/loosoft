using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
///
///非持久化类，用户解析器获取的临时设备信息
namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 设备信息类
    /// </summary>
    public class DeviceInfo
    {
        /// <summary>
        /// 设备对应数据设备id
        /// </summary>
        public int deviceid;
        /// <summary>
        /// 设备地址
        /// </summary>
        public int address;
        /// <summary>
        /// 设备名称
        /// </summary>
        public string name;
        /// <summary>
        /// 设备型号
        /// </summary>
        public int typemodel;                   

    }
}
