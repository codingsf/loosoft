using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 设备间关系
    /// </summary>
    public class DeviceRelation
    {
        /// <summary>
        /// 设备id
        /// </summary>
        public int deviceId { get; set; }
        public int id { get; set; }
        /// <summary>
        /// 电站id
        /// </summary>
        public int plantId { get; set; }
        /// <summary>
        /// 上级设备id
        /// </summary>
        public int parentDeviceId { get; set; }
        /// <summary>
        /// 测点
        /// </summary>
        public string monitorCode { get; set; }
        /// <summary>
        /// 下级设备列表
        /// </summary>
        public IList<Device> childDevices { get; set; }
        /// <summary>
        /// 上级设备
        /// </summary>
        public Device parentDevice { get; set; }

        public Device device { get; set; }

        public string name { get; set; }

        public IList<DeviceRelation> childRelation { get; set; }

    }
}
