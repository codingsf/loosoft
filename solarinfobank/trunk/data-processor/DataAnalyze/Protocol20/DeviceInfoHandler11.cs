using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Protocol
{

    /// <summary>
    /// 类别标识为31的设备信息解析处理
    /// </summary>
    public class DeviceInfoHandler31
    {
        private const int hexbytecharnum = 2;//一个十六进制字节占得字符数
        public string DevName = "设备";
        int deviceDataHeadLength = 5;//5字节
        private string deviceData = "";
        /// <summary>
        /// 根据协议解析
        /// </summary>
        public static IList<DeviceInfo> analysis(string deviceData)
        {
            //deviceData = "69 69 01 00 C3 00 00 00 01 00 01 00 00 00 02 00 0B 00 31 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 32 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00 E4 B8 AD E5 9B BD 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 E5 8C 97 E4 BA AC 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 37 00 00 00 00 00 00 00 00 00 00 00 34 08 00 00 00 AF 00 00 B1 65 C9";
            IList<DeviceInfo> devices = new List<DeviceInfo>();

            string infoData = deviceData.Substring(4 * 2);
            //解析多个信息体
            //每个设备信息体开始下标
            int startIndex = 0;
            //每个设备信息体结束下标
            int endIndex = 68;
            if(infoData.Length%(88*2)==0)
                endIndex = 88;
            //逐个取出信息体
            string info;
            DeviceInfo device = null;
            while (infoData.Length > 0)
            {
                device = new DeviceInfo();
                info = infoData.Substring(startIndex * 2, endIndex * 2);
                //没有数据就退出
                if (string.IsNullOrEmpty(info)) return devices;

                //设备地址
                int address = (int)SystemCode.HexNumberToDenary(info.Substring(0 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
                device.address = address;

                //设备型号
                int model = (int)SystemCode.HexNumberToDenary(info.Substring(2 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
                device.typemodel = model;

                //设备名称
                string name = StringUtil.Hex2UTF8(info.Substring(4 * hexbytecharnum, 32 * hexbytecharnum));
                device.name = name;

                //设备厂家      32个字节  UTF-8
                string fac = StringUtil.Hex2UTF8(info.Substring(36 * hexbytecharnum, 32 * hexbytecharnum));
                //device.name = fac;
                if (endIndex == 88)
                {
                    //设备序列号 16个字节 UTF-8
                    string sn = StringUtil.Hex2UTF8(info.Substring(68 * hexbytecharnum, 16 * hexbytecharnum));
                    //device.name = name;

                    //整机版本 4个字节 U8
                    int v1 = (int)SystemCode.HexNumberToDenary(info.Substring(84 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
                    int v2 = (int)SystemCode.HexNumberToDenary(info.Substring(85 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
                    int v3 = (int)SystemCode.HexNumberToDenary(info.Substring(86 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
                    int v4 = (int)SystemCode.HexNumberToDenary(info.Substring(87 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
                    //device.name = name;
                }
                devices.Add(device);

                infoData = infoData.Substring(endIndex * 2);
            }
            return devices;
        }

        public DeviceInfoHandler31()
        {
        }
    }
}
