using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;

namespace Intervaler
{
    public class Tool
    {
        /// <summary>
        /// 此处算法变更 报告的lastSendTime原来保存的是上次发送的时间 现在改为保存的是下次发送的时间
        /// 为了时间比较的准确性
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="day"></param>
        /// <param name="hour"></param>
        /// <param name="minute"></param>
        /// <param name="dayofWeek"></param>
        /// <param name="compareDate"></param>
        /// <param name="compareType"></param>
        /// <param name="update"></param>
        /// <returns></returns>
        public static bool DateEquals(string year, string month, string day, string hour, string minute, string dayofWeek, DateTime compareDate, int compareType, ref DateTime update)
        {
            int _year, _month, _day, _hour, _minute;
            _year = string.IsNullOrEmpty(year) ? DateTime.Now.Year : Convert.ToInt32(year);
            _month = string.IsNullOrEmpty(month) ? DateTime.Now.Month : Convert.ToInt32(month);
            _day = string.IsNullOrEmpty(day) ? DateTime.Now.Day : Convert.ToInt32(day);
            _hour = string.IsNullOrEmpty(hour) ? DateTime.Now.Hour : Convert.ToInt32(hour);
            _minute = string.IsNullOrEmpty(minute) ? DateTime.Now.Minute : Convert.ToInt32(minute);

            DateTime temp = new DateTime(_year, _month, _day, _hour, _minute, 0);
            bool returnFlag = false;
            //  if (DateTime.Now.Hour.Equals(temp.Hour))  陈波注释
            {
                switch (compareType)
                {
                    //日报告
                    case 1:
                        //if ((DateTime.Now - compareDate).TotalHours >= 1 && DateTime.Now.Minute >= temp.Minute)
                        if ((DateTime.Now > compareDate))// 如果大于下次发送时间及发送 发送后更改下次发送时间
                        {
                            returnFlag = true;
                            temp = temp.AddDays(1);
                        }
                        break;
                    case 2:
                        //if ((DateTime.Now - compareDate).TotalHours > 1 && DateTime.Now.DayOfWeek.ToString("d").Equals(dayofWeek))
                        if ((DateTime.Now > compareDate) && DateTime.Now.DayOfWeek.ToString("d").Equals(dayofWeek))
                        {
                            returnFlag = true;
                            temp = temp.AddDays(7);//加一周时间
                        }
                        break;
                    case 3:
                    case 4:
                    case 5:
                        //if ((DateTime.Now - compareDate).TotalHours > 1 && DateTime.Now.Month.Equals(temp.Month) && DateTime.Now.Day.Equals(temp.Day))
                        if ((DateTime.Now > compareDate) && DateTime.Now.Month.Equals(temp.Month) && DateTime.Now.Day.Equals(temp.Day))
                        {
                            returnFlag = true;
                            if (compareType == 3)
                                temp = temp.AddMonths(1);//加一月
                            else
                                temp = temp.AddYears(1);//加一年


                        }
                        break;
                    default:
                        break;

                }
            }
            if (returnFlag)
            {
                temp = new DateTime(temp.Year, temp.Month, temp.Day, temp.Hour, 0, 0);
                update = temp;
            }
            return returnFlag;

        }


        public static string LoadContent(string url, string lang)
        {

            HttpWebRequest request = null;
            string returnHtml = string.Empty;
            try
            {
                request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "GET";
                request.UserAgent = "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)";
                request.Accept = "*/*";
                request.KeepAlive = true;
                request.Headers.Add("Accept-Language", string.Format("{0},;q=0.7,zh;q=0.3", lang));

                WebResponse res = request.GetResponse();
                Stream receiveStream = res.GetResponseStream();
                Encoding encode = Encoding.UTF8;
                StreamReader sr = new StreamReader(receiveStream, encode);
                char[] readbuffer = new char[256];
                int n = sr.Read(readbuffer, 0, 256);
                while (n > 0)
                {
                    string str = new string(readbuffer, 0, n);
                    returnHtml += str;
                    n = sr.Read(readbuffer, 0, 256);
                }

            }
            catch
            {
                returnHtml = string.Empty;
            }

            return returnHtml;
        }
    }
}
