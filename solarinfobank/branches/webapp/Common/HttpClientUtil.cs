using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 发送http get请求
    /// </summary>
    public class HttpClientUtil
    {
        public static void requestUrl(string uri){
            try
            {
                if (String.IsNullOrEmpty(uri)) return;
                WebClient wc = new WebClient();
                Console.WriteLine("Sending an HTTP GET request to " + uri);
                Stream st = wc.OpenRead(uri);
                StreamReader sr = new StreamReader(st);
                string res = sr.ReadToEnd();
                sr.Close();
                st.Close();
                Console.WriteLine("HTTP Response is ");
                Console.WriteLine(res);
            }
            catch (Exception ee) {
                LogUtil.error("request url error :" + ee.Message);
            }
        }
    }
}
