using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 设备类型
    /// Author: 赵文辉
    /// Time: 2011年4月104日 11:20:55
    /// </summary>
    /// 
    [Serializable]
    public class DeviceModel
    {
        /// <summary>
        /// 不带参的构造函数
        /// </summary>
        public DeviceModel()
        { }

        //设备类型编号 非空
        public int code { get; set; }
        //设备所属大类型  非空
        public int modelTypeCode { get; set; }
        public float designPower { get; set; }//额定功率
        //设备所属大类型对象  非空

        public DeviceType modelType { 
            get {
                return DeviceData.getDeviceTypeByCode(this.modelTypeCode);
            } 
        }
        //类型名称  非空
        public string name { get; set; }

        public int isUsed { get; set; }
    }
}
