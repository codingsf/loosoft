using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;
using System.IO;
using System.Net;
public static class JsonUtil
{
    /// <summary>
    /// 转换成json
    /// </summary>
    /// <param name="obj"></param>
    /// <param name="type"></param>
    /// <returns></returns>
    public static string convertToJson(object obj,Type type)
    {
        var serializer = new DataContractJsonSerializer(type);
        var stream = new MemoryStream();
        serializer.WriteObject(stream, obj);

        byte[] dataBytes = new byte[stream.Length];

        stream.Position = 0;

        stream.Read(dataBytes, 0, (int)stream.Length);

        string dataString = Encoding.UTF8.GetString(dataBytes);

        return dataString;
    }



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


}