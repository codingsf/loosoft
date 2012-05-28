using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public static class TableUtil
    {
        /// <summary>
        /// 逆变器
        /// </summary>
        public const string INVERTER_TABLE_NAME = "inverter";
        /// <summary>
        /// 汇流箱设备
        /// </summary>
        public const string HUILIUXIANG = "hlx";
        /// <summary>
        /// 环境检测仪
        /// </summary>
        public const string DETECTOR = "detector";

        /// <summary>
        /// 配电柜设备
        /// </summary>
        public const string CABINET = "cabinet";

        /// <summary>
        /// 电表
        /// </summary>
        public const string AMMETER = "ammeter";

        /// <summary>
        /// 电站
        /// </summary>
        public const string PLANT = "plant";

        /// <summary>
        /// 设备
        /// </summary>
        public const string DEVICE = "device";

        /// <summary>
        /// 将数字转换成字符月份
        /// </summary>
        /// <param name="num"></param>
        public static string convertIntToMnthStr(int num)
        {
            return num.ToString("00");

        }
        /// <summary>
        /// 根据设备类型取得对应表前缀，用户动态组织表名
        /// </summary>
        /// <param name="deviceType"></param>
        /// <returns></returns>
        public static string getTableNamebyDeviceType(int deviceType) {
            switch (deviceType) { 
                case DeviceData.AMMETER_CODE:
                    return AMMETER ;
                case DeviceData.CABINET_CODE:
                    return CABINET;
                case DeviceData.HUILIUXIANG_CODE:
                    return HUILIUXIANG;
                case DeviceData.INVERTER_CODE:
                    return INVERTER_TABLE_NAME;
                case DeviceData.ENVRIOMENTMONITOR_CODE:
                    return DETECTOR;
                default:
                    return "";
            }
        }

    }
}