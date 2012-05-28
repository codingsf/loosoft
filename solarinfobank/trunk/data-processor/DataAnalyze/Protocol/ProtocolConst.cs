using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
namespace Protocol
{
    public static class ProtocolConst
    {
        public const int LENGTH_BUG = 9;
        public const int LENGTH_HEAD = 18;

        /// <summary>
        /// 0x01逆变器 （SUNGROW协议）
        /// </summary>
        public const int LENGTH_SUNGROW_INVERTER = 5 + 27;
        /// <summary>
        /// 0x02	逆变器（MODBUS协议）
        /// </summary>
        public const int LENGTH_MODBUS_INVERTER = 5 + 96;


        /// <summary>
        /// 0x11	汇流箱（SUNGROW协议）
        ///</summary>
        public const int LENGTH_SUNGROW_BUSBAR = 5 + 27;
        /// <summary>
        ///0x12	汇流箱（MODBUS协议）
        /// </summary>
        public const int LENGTH_MODBUS_BUSBAR = 5 + 50;
        /// <summary>
        ///0x15	光伏阵列汇流箱通讯协议（Modbus）V1.1.1.0-2011.8.30.pdf
        /// </summary>
        public const int LENGTH_MODBUS15_BUSBAR = 5 + 118;

        /// <summary>
        /// 0x13 配电柜（SUNGROW协议）
        ///</summary>
        public const int LENGTH_SUNGROW_CABINET = 5 + 27;
        /// <summary>
        ///0x14	配电柜（MODBUS协议）
        /// </summary>
        public const int LENGTH_MODBUS_CABINET = 5 + 50;
        /// <summary>
        ///0x16	光伏直流配电柜通信协议（Modbus）V1.0-柴达木-2011.8.30.pdf
        /// </summary>
        public const int LENGTH_MODBUS16_CABINET = 5 + 66;

        /// <summary>
        /// 0x21	环境检测仪（SUNGROW协议）
        /// </summary>
        public const int LENGTH_SUNGROW_DETECTOR = 5 + 56;
        /// <summary>
        /// 0x22	环境检测仪（MODBUS协议）
        /// </summary>
        public const int LENGTH_MODBUS_DETECTOR = 5 + 42;

        /// <summary>
        /// 0x23	环境检测仪（MODBUS协议）
        /// </summary>
        public const int LENGTH_MODBUS_DETECTOR_1020 = 5 + 114;
        /// <summary>
        /// 0x41	电表协议
        /// </summary>
        public const int LENGTH_AMMETER = 5 + 168;

        /// <summary>
        /// 0x42	电表协议1.1
        /// </summary>
        public const int LENGTH_AMMETER_11 = 5 + 160;

        /// <summary>
        /// 根据设备类型获取数据长度
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public static int GetDataLengthByType(int type)
        {
            int length = 0;

            switch (type)
            {
                case Cn.Loosoft.Zhisou.SunPower.Common.DeviceData.TYPE_SUNGROW_INVERTER:
                    length = LENGTH_SUNGROW_INVERTER;
                    break;
                case DeviceData.TYPE_MODBUS_INVERTER:
                    length = LENGTH_MODBUS_INVERTER;
                    break;

                case DeviceData.TYPE_SUNGROW_BUSBAR:
                    length = LENGTH_SUNGROW_BUSBAR;
                    break;
                case DeviceData.TYPE_MODBUS_BUSBAR:
                    length = LENGTH_MODBUS_BUSBAR;
                    break;

                case DeviceData.TYPE_SUNGROW_DETECTOR:
                    length = LENGTH_SUNGROW_DETECTOR;
                    break;
                case DeviceData.TYPE_MODBUS_DETECTOR:
                    length = LENGTH_MODBUS_DETECTOR;
                    break;
                default:
                    break;
            }
            return length;
        }
    }

}
