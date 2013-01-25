using System;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class Util
    {
        public static double ConvertToDouble(Hashtable table)
        {
            if (table == null)
                return 0;
            double temp = 0;
            double sumValue = 0;
            foreach (DictionaryEntry item in table)
            {
                if (item.Value == null)
                    continue;
                temp = 0;
                double.TryParse(item.Value.ToString(), out temp);
                sumValue += temp;
            }
            return sumValue;
        }

        /// <summary>
        /// 生成8到12位数字
        /// </summary>
        /// <returns></returns>
        public static string RandomString()
        {
            string returnValue = string.Empty;
            Random random = new Random();
            returnValue = random.Next(10000, 999999999).ToString();
            returnValue += DateTime.Now.ToString("sss");
            return returnValue;
        }

        /// <summary>
        /// 数值按位进制
        /// </summary>
        /// <param name="value"></param>
        /// <param name="bits"></param>
        /// <returns></returns>
        public static double upDigtal(double value,int bits)
        {
            return Math.Round(value/Math.Pow(10, bits), 2);
        }

        /// <summary>
        /// 数值按千位进制
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static double upDigtal(double value)
        {
            if (value >= 1000000000)
            {
                return upDigtal(value, 9);
            }
            if (value >= 1000000)
            {
                return upDigtal(value, 6);
            }
            if (value >= 1000)
            {
                return upDigtal(value, 3);
            }
            return Math.Round(value, 2);
        }

        /// <summary>
        /// 进制发电量单位
        /// </summary>
        /// <param name="TotalEnergy"></param>
        /// <returns></returns>
        public static string upEnergyUnit(double TotalEnergy)
        {
            if (TotalEnergy >= 1000000000)
                return "TWh";
            else if (TotalEnergy >= 1000000)
                return "GWh";
            else if (TotalEnergy >= 1000)
                return "MWh";
            return "kWh";
        }

        /// <summary>
        /// 进制功率单位
        /// </summary>
        /// <param name="TotalEnergy"></param>
        /// <returns></returns>
        public static string upPowerUnit(double power)
        {
            if (power >= 1000000000)
                return "TW";
            else if (power >= 1000000)
                return "GW";
            else if (power >= 1000)
                return "MW";
            return "kW";
        }

        /// <summary>
        /// 进制co2单位
        /// </summary>
        /// <param name="TotalEnergy"></param>
        /// <returns></returns>
        public static string upCo2Unit(double co2reduction)
        {
            if (co2reduction >= 1000000000000)
                return "Gt";
            if (co2reduction >= 1000000000)
                return "Mt";
            if (co2reduction >= 1000000)
                return "kt";
            if (co2reduction >= 1000)
            {
                return "t";
            }
            return "kg";
        }

        /// <summary>
        /// 经纬度转换函数
        /// </summary>
        /// <param name="d"></param>
        /// <returns></returns>
        public static string DoubleToDegree(double d)
        {
            if (d < 0 || d > 360)
            {
                return string.Empty;
            }
            int degree, minutes, seconds;
            double temp;
            degree = (int)d;
            temp = (d - (double)degree) * 60.0;
            minutes = (int)temp;
            seconds = (int)((temp - minutes) * 60.0);
            return degree.ToString() + "," + minutes.ToString() + "," + seconds.ToString() + ",";
        }
    }
}
