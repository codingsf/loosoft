using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAnalyze.Protocol20
{
    /// <summary>
    /// 信息单元地址定义，即设备对应的测点定义，这里的地址定义和bank识别的测点不是一个，但会有对应关系
    /// </summary>
    public class InfoUnitAddress
    {
        /// <summary>
        /// 有符号整形
        /// </summary>
        public const char sign_type_s = 's';
        /// <summary>
        /// 无符号整形
        /// </summary>
        public const char sign_type_u = 'u';
        /// <summary>
        /// 电站信息单元地址
        /// </summary>
        public int address;
        /// <summary>
        /// 对应bank中的设备测点
        /// </summary>
        public int mcode;
        /// <summary>
        /// 信息单元说明
        /// </summary>
        public string desc;
        /// <summary>
        /// 数据符号类型
        /// </summary>
        public char signtype;
        /// <summary>
        /// 小数位数
        /// </summary>
        public int dotnum;
        /// <summary>
        /// 对应信息体类型
        /// </summary>
        public int infotype;
        /// <summary>
        /// 信息地址对应的设备类型
        /// </summary>
        public int deviceType;
        /// <summary>
        /// 翻转类型
        /// 这是就要翻转处理
        /// </summary>
        public int reversionType;
        public InfoUnitAddress() { 
        }

        public InfoUnitAddress(int address, int mcode, string desc, char signtype, int dotnum, int infotype, int deviceType, int reversionType)
        {
            this.address = address;
            this.mcode = mcode;
            this.desc = desc;
            this.signtype = signtype;
            this.dotnum = dotnum;
            this.infotype = infotype;
            this.deviceType = deviceType;
            this.reversionType = reversionType;
        }
    }
}
