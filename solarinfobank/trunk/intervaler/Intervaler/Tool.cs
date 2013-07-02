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

       public static bool DateEquals(string year, string month, string day, string hour, string minute, string dayofWeek, DateTime compareDate, int compareType,ref DateTime update)
       {
           int _year, _month, _day, _hour, _minute;
           _year = string.IsNullOrEmpty(year) ? DateTime.Now.Year : Convert.ToInt32(year);
           _month = string.IsNullOrEmpty(month) ? DateTime.Now.Month : Convert.ToInt32(month);
           _day = string.IsNullOrEmpty(day) ? DateTime.Now.Day : Convert.ToInt32(day);
           _hour = string.IsNullOrEmpty(hour) ? DateTime.Now.Hour : Convert.ToInt32(hour);
           _minute = string.IsNullOrEmpty(minute) ? DateTime.Now.Minute : Convert.ToInt32(minute);

           DateTime temp = new DateTime(_year, _month, _day, _hour, _minute, 0);
           bool returnFlag = false;
           if (DateTime.Now.Hour.Equals(temp.Hour))
           {
               switch (compareType)
               {
                   case 1:
                       if ((DateTime.Now - compareDate).TotalHours >= 1 && DateTime.Now.Minute >= temp.Minute)
                           returnFlag = true;
                       break;
                   case 2:
                       if ((DateTime.Now - compareDate).TotalHours > 1 && DateTime.Now.DayOfWeek.ToString("d").Equals(dayofWeek))
                           returnFlag = true;
                       break;
                   case 3:
                   case 4:
                   case 5:
                       if ((DateTime.Now - compareDate).TotalHours > 1 && DateTime.Now.Month.Equals(temp.Month) && DateTime.Now.Day.Equals(temp.Day))
                           returnFlag = true;
                       break;
                   default:
                       break;

               }
           }
           if (returnFlag)
               update = temp;
           return returnFlag;

       }


       public static string LoadContent(string url,string lang)
       {
         
           HttpWebRequest request=null;
           string returnHtml = string.Empty;
           try
           {
               request = (HttpWebRequest)WebRequest.Create(url);
               request.Method = "GET";
               request.UserAgent = "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)";
               request.Accept = "*/*";
               request.KeepAlive = true;
               request.Headers.Add("Accept-Language", string.Format("{0},;q=0.7,zh;q=0.3",lang));

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
