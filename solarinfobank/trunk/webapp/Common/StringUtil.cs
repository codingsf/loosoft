
using System;
using System.Text;
using System.Globalization;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 字符串工具
    /// </summary>
    public class StringUtil
    {
        /// <summary>
        /// 截取指定长度的字符串，支持中英文
        /// </summary>
        /// <param name="s">字符串</param>
        /// <param name="l">截取长度</param>
        /// <param name="endStr">截取后，后缀处理方式</param>
        /// <returns></returns>
        public static string cutStr(string s, int l, string endStr)
        {
            if (string.IsNullOrEmpty(s))
                return string.Empty;
            string temp = s.Substring(0, (s.Length < l + 1) ? s.Length : l + 1);
            byte[] encodedBytes = System.Text.ASCIIEncoding.ASCII.GetBytes(temp);

            string outputStr = "";
            int count = 0;

            for (int i = 0; i < temp.Length; i++)
            {
                if ((int)encodedBytes[i] == 63)
                    count += 2;
                else
                    count += 1;

                if (count <= l - endStr.Length)
                    outputStr += temp.Substring(i, 1);
                else if (count > l)
                    break;
            }

            if (count <= l)
            {
                outputStr = temp;
                endStr = "";
            }

            outputStr += endStr;

            return outputStr;
        }
        /// <summary>
        /// 将浮点型转成字符串，无格式
        /// </summary>
        /// <param name="d"></param>
        /// <returns></returns>
        public static string formatFloat(float d)
        {
            CultureInfo ci = new CultureInfo("zh-CN");
            ci.NumberFormat.CurrencyDecimalSeparator = ".";
            return d.ToString(ci);
        }
        /// <summary>
        /// 将浮点型转化成字符串，带格式
        /// </summary>
        /// <param name="d"></param>
        /// <param name="format"></param>
        /// <returns></returns>
        public static string formatFloat(float d, string format)
        {
            CultureInfo ci = new CultureInfo("zh-CN");
            ci.NumberFormat.CurrencyDecimalSeparator = ".";
            return d.ToString(format, ci);
        }

        /// <summary>
        /// 将双精度转成字符串，无格式
        /// </summary>
        /// <param name="d"></param>
        /// <returns></returns>
        public static string formatDouble(double d)
        {
            CultureInfo ci = new CultureInfo("zh-CN");
            ci.NumberFormat.CurrencyDecimalSeparator = ".";
            return d.ToString(ci);
        }

        /// <summary>
        /// 将双精度转化成字符串，带格式
        /// </summary>
        /// <param name="d"></param>
        /// <param name="format"></param>
        /// <returns></returns>
        public static string formatDouble(double d, string format)
        {
            CultureInfo ci = new CultureInfo("zh-CN");
            ci.NumberFormat.CurrencyDecimalSeparator = ".";
            //NumberStyles style = NumberStyles.AllowDecimalPoint | NumberStyles.AllowThousands | NumberStyles.Float;
            return d.ToString(format, ci);
        }
        /// <summary>
        /// 将字符串转化成浮点想
        /// </summary>
        /// <param name="d"></param>
        /// <returns></returns>
        public static float stringtoFloat(string d)
        {
            //System.Globalization.CultureInfo cul = new System.Globalization.CultureInfo("zh-CN");
            CultureInfo ci = (CultureInfo)CultureInfo.CurrentCulture.Clone();
            ci.NumberFormat.CurrencyDecimalSeparator = ".";
            //NumberStyles style = NumberStyles.AllowDecimalPoint | NumberStyles.AllowThousands | NumberStyles.Float;
            return float.Parse(d, NumberStyles.Any, ci);
        }
        /// <summary>
        /// 将字符串转换成双精度
        /// </summary>
        /// <param name="d"></param>
        /// <returns></returns>
        public static double stringtoDouble(string d)
        {
            CultureInfo ci = (CultureInfo)CultureInfo.CurrentCulture.Clone();
            ci.NumberFormat.CurrencyDecimalSeparator = ".";
            //NumberStyles style = NumberStyles.AllowDecimalPoint | NumberStyles.AllowThousands | NumberStyles.Float;
            return double.Parse(d, NumberStyles.Any, ci);
        }

        /// <summary>
        /// 十六进制字符串到2进制,剔除00
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static byte[] HexString2ByteArray(string s)
        {
            s = s.Replace(" ", "").Replace("00","");
            byte[] buffer = new byte[s.Length / 2];
            for (int i = 0; i < s.Length; i += 2)
                buffer[i / 2] = (byte)Convert.ToByte(s.Substring(i, 2), 16);
            return buffer;
        }

        /// <summary>
        /// 二进制到16进制字符串
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string ByteArray2HexString(byte[] data)
        {
            StringBuilder sb = new StringBuilder(data.Length * 3);
            foreach (byte b in data)
                sb.Append(Convert.ToString(b, 16).PadLeft(2, '0').PadRight(3, ' '));
            return sb.ToString().ToUpper();
        }

        /// <summary>
        /// 将字符串转换成2进制字节
        /// </summary>
        /// <param name="strValue"></param>
        /// <returns></returns>
        public static byte[] UTF8Encode(string strValue)
        {
            UTF8Encoding utf8Temp = new UTF8Encoding();
            return utf8Temp.GetBytes(strValue);
        }

        /// <summary>
        /// 将二进制字节转换成utf8
        /// </summary>
        /// <param name="byValue"></param>
        /// <returns></returns>
        public static string UTF8Decode(byte[] byValue)
        {
            UTF8Encoding utf8Temp = new UTF8Encoding();
            String decodedString = utf8Temp.GetString(byValue);
            return decodedString;
        }

        /// <summary>
        /// 十六进制转换成utf
        /// </summary>
        /// <param name="hex"></param>
        /// <returns></returns>
        public static string Hex2UTF8(string hex){
            byte[] trmp = HexString2ByteArray(hex);
            return UTF8Decode(trmp);

        }
        public void Main(string[] args)
        {
            //string xx = "68 49 32 12";
            //byte[] byteArray = StrToHex(xx);
            //byte[] byteArray = new byte[] { 0x01, 0x20 };
            //string s = ByteArray2HexString(byteArray);
            //byte[] array = HexString2ByteArray(s);
           // Convert.ToInt32("FF", 16);

            string xx = "中国";
            
            byte[] trmp = UTF8Encode(xx);
            string hex = ByteArray2HexString(trmp);
            string yy = UTF8Decode(trmp);

        }


        /// <summary>
        /// 将十进制数值，转换为二进制字符串并前面用0补齐到指定位数
        /// add by qhb in 20120825
        /// </summary>
        /// <param name="num10"></param>
        /// <param name="fullbits"></param>
        /// <returns></returns>
        public static string getFullbitstr(int num10)
        {
            string inputstr = Convert.ToString(num10, 2);
            int bits = inputstr.Length;
            return getStr(32 - bits) + inputstr;
        }

        /// <summary>
        /// 按照传入的位数取得相应位数的0组成的字符串
        /// add by qhb in 20120825 fro 新汇流箱处理
        /// </summary>
        /// <param name="bits"></param>
        /// <returns></returns>
        private static string getStr(int bits)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bits; i++)
            {
                sb.Append("0");
            }
            return sb.ToString();
        }

        /// <summary>
        /// 将数值转成指定位数的字符串，用0补齐
        /// </summary>
        /// <param name="num"></param>
        /// <param name="bits"></param>
        /// <returns></returns>
        public static string getstr(string numstr, int bits) {
            if (numstr.Length > bits) return numstr;
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bits; i++)
            {
                sb.Append("0");
            }
            sb.Append(numstr);
            return sb.ToString(sb.Length - bits,bits);
        }
    }
}
