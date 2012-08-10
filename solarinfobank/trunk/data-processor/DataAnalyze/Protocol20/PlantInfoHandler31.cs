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
    public class PlantInfoHandler11
    {
        private const int hexbytecharnum = 2;//一个十六进制字节占得字符数
        public string DevName = "电站信息";
        int deviceDataHeadLength = 5;//5字节
        private string deviceData = "";
        /// <summary>
        /// 根据协议解析
        /// </summary>
        public static PlantInfo analysis(string deviceData)
        {
            //deviceData = "69 69 01 00 C3 00 00 00 01 00 01 00 00 00 02 00 0B 00 31 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 32 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00 E4 B8 AD E5 9B BD 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 E5 8C 97 E4 BA AC 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 37 00 00 00 00 00 00 00 00 00 00 00 34 08 00 00 00 AF 00 00 B1 65 C9";
            PlantInfo plant = new PlantInfo();

            //电站项目编号
            string projectName = StringUtil.Hex2UTF8(deviceData.Substring(2 * hexbytecharnum, 32 * hexbytecharnum));
            //电站名称
            string plantName = StringUtil.Hex2UTF8(deviceData.Substring(34 * hexbytecharnum, 32 * hexbytecharnum));
            plant.name = plantName;
            //电站业主
            string plantOwner = StringUtil.Hex2UTF8(deviceData.Substring(66 * hexbytecharnum, 32 * hexbytecharnum));
            plant.owner = plantOwner;
            //电站设计功率
            float designPower = (float)SystemCode.HexNumberToDenary(deviceData.Substring(98 * hexbytecharnum, 4 * hexbytecharnum), SystemCode.ReversionType_all, 32, 'u');
            plant.designPower = designPower;
            //电站所在国家
            string country = StringUtil.Hex2UTF8(deviceData.Substring(102 * hexbytecharnum, 32 * hexbytecharnum));
            plant.country = country;
            //城市
            string city = StringUtil.Hex2UTF8(deviceData.Substring(134 * hexbytecharnum, 32 * hexbytecharnum));
            plant.city = city;
            //电站所在地的邮政编码
            string postCode = StringUtil.Hex2UTF8(deviceData.Substring(166 * hexbytecharnum, 12 * hexbytecharnum));
            plant.postCode = postCode;

            //电站时区
            int timezone = (int)SystemCode.HexNumberToDenary(deviceData.Substring(178 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 's');
            timezone = timezone / 100;
            plant.timezone = timezone;

            //夏令时支持
            int xls = (int)SystemCode.HexNumberToDenary(deviceData.Substring(180 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            plant.isxls = xls==1?true:false;
            //电站经纬度  6*U8 = 6字节
            //纬度秒
            int ws = (int)SystemCode.HexNumberToDenary(deviceData.Substring(181 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 's');
            int wm = (int)SystemCode.HexNumberToDenary(deviceData.Substring(182 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 's');
            int wh = (int)SystemCode.HexNumberToDenary(deviceData.Substring(183 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 's');
            plant.latd = wh;
            plant.latm = wm;
            plant.lats = ws;

            //精度秒
            int js = (int)SystemCode.HexNumberToDenary(deviceData.Substring(184 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 's');
            int jm = (int)SystemCode.HexNumberToDenary(deviceData.Substring(185 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 's');
            int jh = (int)SystemCode.HexNumberToDenary(deviceData.Substring(186 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 's');
            plant.longd = jh;
            plant.longm = jm;
            plant.longs = js;
            return plant;
        }

        public PlantInfoHandler11()
        {
        }
    }
}
