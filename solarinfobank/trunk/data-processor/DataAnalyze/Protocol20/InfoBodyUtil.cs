using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Protocol;

namespace DataAnalyze.Protocol20
{
    class InfoBodyUtil
    {

        /// <summary>
        /// 取得多个信息体串的第一个信息体类型
        /// </summary>
        /// <param name="bodys"></param>
        /// <returns></returns>
        public static int getInfotype(string bodys)
        {
            return  (int)SystemCode.HexNumberToDenary(bodys.Substring(0, 2), false, 8, 'u');
        }
        /// <summary>
        /// 取得某种类型信息体结构长度
        /// </summary>
        /// <param name="infoType"></param>
        /// <returns></returns>
        public static int getInfotypeLen(int infoType)
        {
            switch (infoType)
            {
                case DataType.yaoce:
                    return DataType.yaocelength;
                case DataType.yaoxin:
                    return DataType.yaoxinlength;
                case DataType.yaomai:
                    return DataType.yaomailength;
                default:
                    return 0;
            }
        }
        /// <summary>
        /// 取得单个信息体的解析规则
        /// </summary>
        /// <param name="body"></param>
        /// <returns></returns>
        public static InfoUnitAddress getInfoUnitAddress(string body)
        {
            try
            {
                //取出测点
                int address = (int)SystemCode.HexNumberToDenary(body.Substring(1 * 2, 2 * 2), true, 16, 'u');
                //取得不同信息单元地址对应的解析规则
                DataType dy = new DataType();
                if (DataType.deviceTypeMap.ContainsKey(address))
                {
                    return (InfoUnitAddress)DataType.deviceTypeMap[address];
                }
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
            }
            return null;
        }

        /// <summary>
        /// 解析单个信息体
        /// </summary>
        /// <param name="body"></param>
        /// <returns></returns>
        public static string[] analyze(string body, int infoType, InfoUnitAddress infounitAddress)
        {
            string valuestr = "",value="";
            switch (infoType)
            {
                case DataType.yaoce:
                    valuestr = body.Substring(3 * 2, 4 * 2);
                    value = getValue(valuestr, infounitAddress, 32);
                    break;
                case DataType.yaoxin://对于遥信的信息体，放回值和时间
                    valuestr = body.Substring(3 * 2, 1 * 2);
                    value = getValue(valuestr, infounitAddress, 8);
                    //再取得故障时间
                    valuestr = body.Substring(5 * 2, 7 * 2);
                    int year = 2000 + (int)SystemCode.HexNumberToDenary(valuestr.Substring(12, 2), false, 8, 'u') % 99;
                    int moth = (int)SystemCode.HexNumberToDenary(valuestr.Substring(10, 2), false, 8, 'u');
                    if (moth > 12) moth = 12;
                    int day = (int)SystemCode.HexNumberToDenary(valuestr.Substring(8, 2), false, 8, 'u');
                    if (day > 31) day = 28;
                    int hh = (int)SystemCode.HexNumberToDenary(valuestr.Substring(6, 2), false, 8, 'u');
                    if (hh > 23) hh = 23;
                    int mm = (int)SystemCode.HexNumberToDenary(valuestr.Substring(4, 2), false, 8, 'u');
                    if (mm > 60) mm = 59;
                    int ss = (int)SystemCode.HexNumberToDenary(valuestr.Substring(2, 2), false, 8, 'u');
                    if (ss > 60) ss = 59;
                    value+=":"+new DateTime(year, moth, day, hh, mm, ss).ToString("yyyy-mm-dd HH:mm:ss");
                    break;
                case DataType.yaomai:
                    valuestr = body.Substring(3 * 2, 4 * 2);
                    value = getValue(valuestr, infounitAddress, 32);
                    break;
                default:
                    break;
            }
            return (infounitAddress.address + ":" + value).Split(':');
        }

        /// <summary>
        /// 取得当个信息地址的值，字符串表示
        /// </summary>
        /// <param name="valuestr"></param>
        /// <param name="infounitAddress"></param>
        /// <param name="bytetype"></param>
        /// <returns></returns>
        private static string getValue(string valuestr, InfoUnitAddress infounitAddress,int bytetype)
        { 
            double value = (double)SystemCode.HexNumberToDenary(valuestr, infounitAddress.reversionType, bytetype, infounitAddress.signtype);
            if(infounitAddress.dotnum>0){
                value = Math.Round(value /Math.Pow(10,infounitAddress.dotnum), 1);
            }
            return value.ToString();
        }



    }
}
