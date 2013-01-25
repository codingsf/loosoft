using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using System.Web;
using sungrow_demo.Service.vo;
using System.Runtime.Serialization.Json;
namespace sungrow_touch
{
    public class JsonUtil
    {
        public static string loadJsonStr(string url, string lang)
        {
            HttpWebRequest request = null;
            string returnHtml = string.Empty;

            request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "GET";
            request.UserAgent = "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)";
            request.Accept = "*/*";
            request.KeepAlive = true;
            request.Headers.Add("Accept-Language", string.Format("{0},;q=0.7,zh;q=0.3", lang));
            WebResponse res = null;
            Stream receiveStream = null;
            StreamReader sr = null;
            try
            {
                res = request.GetResponse();
                receiveStream = res.GetResponseStream();
                Encoding encode = Encoding.UTF8;
                sr = new StreamReader(receiveStream, encode);
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
                return string.Empty;
            }
            finally
            {
                if (res != null)
                    res.Close();
                if (sr != null)
                    sr.Dispose();
                if (receiveStream != null)
                    receiveStream.Dispose();
            }
            return returnHtml;
        }

        public static T Deserialize<T>(string jsonStr)
        {
            T t = default(T);

            try
            {
                using (MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(jsonStr)))
                {

                    DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(T));
                    t = (T)serializer.ReadObject(ms);

                }
            }
            catch { }
            return t;
        }



        public static IList<KeyValuePair<string, float?>> DeserializeChartData(string url)
        {
            string output = JsonUtil.loadJsonStr(url, "en-us");
            IList<KeyValuePair<string, float?>> outputData = new List<KeyValuePair<string, float?>>();
            ChartData data = null;
            data = Deserialize<ChartData>(output);

            if (data != null && data.isHasData)
            {
                for (int i = 0; i < data.categories.Length; i++)
                {
                    outputData.Add(new KeyValuePair<string, float?>(data.categories[i], data.series[0].data[i] == null ? 0 : data.series[0].data[i]));
                }
            }
            return outputData;
        }

    }
}
