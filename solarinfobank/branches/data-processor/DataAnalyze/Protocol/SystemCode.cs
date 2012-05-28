/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年2月18日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Protocol
{
   /// <summary>
   /// 进制转换类
   /// </summary>
    public class SystemCode
    {
        /// <summary>
        /// 十六进制向十进制转化
        /// </summary>
        /// <param name="ejz">十六进制数据</param>
        /// <returns>十进制数据</returns>
        public static double HexToDenary(string hex)
        {
            double ten = 0;

            if (hex.Trim().Length % 2 == 0)
            {
                for (int i = 0, j = 0; i + 2 <= hex.Length; i = i + 2, j++)
                {
                    ten += Hex2Ten(hex.Substring(i, 2)) * System.Math.Pow(2, 8 * j);
                }
            }
            return ten;
        }

        /// <summary>
        /// 十六进制向十进制转化
        /// </summary>
        /// <param name="ejz">十六进制数据</param>
        /// <returns>十进制数据</returns>
        public static double Hex2Ten(string hex)
        {
            double ten = 0;
            for (int i = 0, j = hex.Length - 1; i < hex.Length; i++)
            {
                ten += HexChar2Value(hex.Substring(i, 1)) * (Math.Pow(16, j));
                j--;
            }
            return ten;
        }

        /// <summary>
        /// 按位转换函数
        /// </summary>
        /// <param name="hexChar"></param>
        /// <returns></returns>
        private static int HexChar2Value(string hexChar)
        {
            switch (hexChar)
            {
                case "0":
                case "1":
                case "2":
                case "3":
                case "4":
                case "5":
                case "6":
                case "7":
                case "8":
                case "9":
                    return Convert.ToInt32(hexChar);
                case "a":
                case "A":
                    return 10;
                case "b":
                case "B":
                    return 11;
                case "c":
                case "C":
                    return 12;
                case "d":
                case "D":
                    return 13;
                case "e":
                case "E":
                    return 14;
                case "f":
                case "F":
                    return 15;
                default:
                    return 0;
            }
        }
        /// <summary>
        /// 转换规则按照两个字节为一个单位进行反转顺便
        /// 比如01020304 转成03040102
        /// </summary>
        /// <param name="hex"></param>
        /// <returns></returns>
        public static string Reversion(string hex)
        {
            hex = hex.Trim();
            StringBuilder strret = new StringBuilder();
            var step = hex.Length > 4 ? 4 : 2;
            int twonum = hex.Trim().Length % step == 0 ? hex.Trim().Length / step : (hex.Trim().Length / step) + 1;
            string[] resArr = new string[twonum];
            for (int i=0;i<twonum;i++)
            {
                resArr[i] = hex.Substring(i * step, step);
            }
            for (int i = twonum-1; i >=0; i--)
            {
                strret.Append(resArr[i]);
            }
            return strret.ToString();
        }

        /// <summary>
        /// 转换规则按照两个字节为一个单位进行反转顺便,字节内部仍然排序
        /// 比如01020304 转成04030201
        /// </summary>
        /// <param name="hex"></param>
        /// <returns></returns>
        public static string ReversionTwo(string hex)
        {
            hex = hex.Trim();
            StringBuilder strret = new StringBuilder();
            var step = hex.Length > 4 ? 4 : 2;
            int twonum = hex.Trim().Length % step == 0 ? hex.Trim().Length / step : (hex.Trim().Length / step) + 1;
            string[] resArr = new string[twonum];
            string tmp = "";
            for (int i = 0; i < twonum; i++)
            {
                //内部反排
                tmp = hex.Substring(i * step, step);
                if(tmp.Length==4){
                    tmp = tmp.Substring(2, 2) + tmp.Substring(0, 2);
                }
                resArr[i] = tmp;
            }
            for (int i = twonum - 1; i >= 0; i--)
            {
                strret.Append(resArr[i]);
            }
            return strret.ToString();
        }

        /// <summary>
        /// 完全倒序
        /// </summary>
        /// <param name="hex"></param>
        /// <returns></returns>
        public static string ReversionAll(string hex)
        {
            hex = hex.Trim();
            StringBuilder strret = new StringBuilder();
            var step = 2;
            int twonum = hex.Trim().Length % step == 0 ? hex.Trim().Length / step : (hex.Trim().Length / step) + 1;
            string[] resArr = new string[twonum];
            for (int i = 0; i < twonum; i++)
            {
                resArr[i] = hex.Substring(i * step, step);
            }
            for (int i = twonum - 1; i >= 0; i--)
            {
                strret.Append(resArr[i]);
            }
            return strret.ToString();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="shex"></param>
        /// <param name="isReversion"></param>
        /// <param name="itype"></param>
        /// <param name="cSign"></param>
        /// <returns></returns>
        public static long HexNumberToDenary(string shex, bool isReversion, int itype, char cSign)
        {
            long ret = 0;
            string hex = shex;
            if (isReversion)
            {
                hex = Reversion(hex);
            }

            if (cSign.ToString().ToUpper().Equals("S"))
            {
                switch (itype)
                {
                    case 16:
                        ret = Int16.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    case 32:
                        ret = Int32.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    case 64:
                        ret = Int64.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    default:
                        ret = int.Parse(Convert.ToSByte(hex, 16).ToString());//
                        //ret = int.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                }
            }
            else if (cSign.ToString().ToUpper().Equals("U"))
            {
                switch (itype)
                {
                    case 16:
                        ret = UInt16.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    case 32:
                        ret = UInt32.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    case 64:
                        ret = (long)UInt64.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    default:
                        ret = (long)HexToDenary(hex);
                        break;
                }
            }
            return ret;
        }

        public static long HexNumberToDenary(string shex, bool isReversion, char cSign)
        {
            int itype = (shex.Length / 2) * 16;
            long ret = 0;
            string hex = shex;
            if (isReversion)
            {
                hex = Reversion(shex);
            }

            if (cSign.ToString().ToUpper().Equals("S"))
            {
                switch (itype)
                {
                    case 16:
                        ret = Int16.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    case 32:
                        ret = Int32.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    case 64:
                        ret = Int64.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    default:
                        ret = (long)HexToDenary(hex);
                        break;
                }
            }
            else if (cSign.ToString().ToUpper().Equals("U"))
            {
                switch (itype)
                {
                    case 16:
                        ret = UInt16.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    case 32:
                        ret = UInt32.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    case 64:
                        ret = (long)UInt64.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                        break;
                    default:
                        ret = (long)HexToDenary(hex);
                        break;
                }
            }
            return ret;
        }

        public static long HexNumberToDenary(string shex, bool isReversion)
        {
            int itype = (shex.Length / 2) * 16;
            long ret = 0;
            string hex = shex;
            if (isReversion)
            {
                hex = Reversion(shex);
            }

            switch (itype)
            {
                case 16:
                    ret = Int16.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                    break;
                case 32:
                    ret = Int32.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                    break;
                case 64:
                    ret = Int64.Parse(hex, System.Globalization.NumberStyles.HexNumber);
                    break;
                default:
                    ret = (long)HexToDenary(hex);
                    break;
            }
            return ret;
        }
    }

}
