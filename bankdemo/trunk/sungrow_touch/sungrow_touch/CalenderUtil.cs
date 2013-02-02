using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Globalization;
using System.Text.RegularExpressions;
namespace sungrow_touch
{
    class CalenderUtil
    {
        static float loaclTz = 8;
        /// <summary>
        /// 取得某个年月的天数
        /// </summary>
        /// <returns></returns>
        public static int getMonthDays(int year, int month)
        {
            GregorianCalendar gc = new GregorianCalendar();
            return gc.GetDaysInMonth(year, month);
        }

        public static int getMonthDays(string yearmonth)
        {
            int year = int.Parse(yearmonth.Substring(0, 4));
            int month = int.Parse(yearmonth.Substring(4, 2));
            GregorianCalendar gc = new GregorianCalendar();
            return getMonthDays(year, month);
        }
        /// <summary>
        /// 取得当前系统月份的天
        /// </summary>
        /// <returns></returns>
        public static int getCurMonthDays()
        {
            GregorianCalendar gc = new GregorianCalendar();
            return gc.GetDaysInMonth(DateTime.Now.Year, DateTime.Now.Month);
        }

        /// <summary>
        /// 系统当前时间，要考虑时区
        /// </summary>
        /// <returns></returns>
        public static string curDateWithTimeZone(float timezone, string format)
        {
            DateTime dt = DateTime.Now.AddHours(timezone - loaclTz);
            return string.Format("{0:" + format + "}", dt);
        }

        /// <summary>
        /// 系统当前时间，要考虑时区
        /// </summary>
        /// <returns></returns>
        public static string curDateWithTimeZone(float timezone, string startdate, string enddate, double hour, bool enable, string format)
        {
            DateTime start = DateTime.Now;
            DateTime end = DateTime.Now;
            if (enable)
            {
                if ((string.IsNullOrEmpty(startdate) == false) && (string.IsNullOrEmpty(enddate) == false) && Regex.IsMatch(startdate, "^\\d{2}-\\d{2} \\d{2}:00:00$") && Regex.IsMatch(enddate, "^\\d{2}-\\d{2} \\d{2}:00:00$"))
                {
                    startdate=string.Format("{0}-{1}",DateTime.Now.Year,startdate);
                    enddate = string.Format("{0}-{1}", DateTime.Now.Year, enddate);
                    start = DateTime.Parse(startdate);
                    end = DateTime.Parse(enddate);
                }
            }
            DateTime dt = DateTime.Now.AddHours(timezone - loaclTz);
            if (dt < end && dt > start)
                dt = dt.AddHours(hour);
            return string.Format("{0:" + format + "}", dt);
        }



        /// <summary>
        /// 系统当前时间，要考虑时区
        /// </summary>
        /// <returns></returns>
        public static DateTime curDateWithTimeZone(float timezone)
        {
            DateTime dt2 = DateTime.Now.AddHours(2);
            DateTime dt = DateTime.Now.AddHours(-2);
            DateTime dt3 = DateTime.Now.AddHours(-6.5);
            DateTime dt4 = DateTime.Now.AddHours(timezone - loaclTz);
            return dt4;
        }
        /// <summary>
        /// 格式时间
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="format"></param>
        public static string formatDate(DateTime dt, string format)
        {
            return string.Format("{0:" + format + "}", dt);
        }

        private static int DatePart(DateTime dt)
        {
            int weeknow = Convert.ToInt32(dt.DayOfWeek);//今天星期几
            int daydiff = (-1) * (weeknow + 1);//今日与上周末的天数差
            int days = System.DateTime.Now.AddDays(daydiff).DayOfYear;//上周末是本年第几天
            int weeks = days / 7;
            if (days % 7 != 0)
            {
                weeks++;
            }
            //此时，weeks为上周是本年的第几周
            return (weeks + 1);
        }

        //本周起止日期
        public static string[] WeekRange(System.DateTime dt, string format)
        {
            int weeknow = Convert.ToInt32(dt.DayOfWeek);//今天星期几
            int daydiff = (-1) * weeknow;
            int dayadd = 6 - weeknow;
            string dateBegin = System.DateTime.Now.AddDays(daydiff).Date.ToString(format);
            string dateEnd = System.DateTime.Now.AddDays(dayadd).Date.ToString(format);
            return new string[] { dateBegin, dateEnd };
        }

        //计算第几周（重新修改后）
        public static int GetWeekOfCurrDate(DateTime dt)
        {
            int Week = 1;
            int nYear = dt.Year;
            System.DateTime FirstDayInYear = new DateTime(nYear, 1, 1);
            System.DateTime LastDayInYear = new DateTime(nYear, 12, 31);
            int DaysOfYear = Convert.ToInt32(LastDayInYear.DayOfYear);
            int WeekNow = Convert.ToInt32(FirstDayInYear.DayOfWeek) - 1;
            if (WeekNow < 0) WeekNow = 6;
            int DayAdd = 6 - WeekNow;
            System.DateTime BeginDayOfWeek = new DateTime(nYear, 1, 1);
            System.DateTime EndDayOfWeek = BeginDayOfWeek.AddDays(DayAdd);
            Week = 2;
            for (int i = DayAdd + 1; i <= DaysOfYear; i++)
            {
                BeginDayOfWeek = FirstDayInYear.AddDays(i);
                if (i + 6 > DaysOfYear)
                {
                    EndDayOfWeek = BeginDayOfWeek.AddDays(DaysOfYear - i - 1);
                }
                else
                {
                    EndDayOfWeek = BeginDayOfWeek.AddDays(6);
                }

                if (dt.Month == EndDayOfWeek.Month && dt.Day <= EndDayOfWeek.Day)
                {
                    break;
                }
                Week++;
                i = i + 6;
            }
            return Week;
        }

        /// <summary>
        /// 取得前多少天
        /// </summary>
        /// <param name="now"></param>
        /// <param name="format"></param>
        /// <returns></returns>
        public static string getBeforeDay(DateTime now, string format,int days)
        {
            DateTime bdt = now.AddDays(days*-1);
            return bdt.ToString(format);
        }
    }
}
