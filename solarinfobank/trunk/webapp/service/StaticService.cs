using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;
using System.Data;
using System.Reflection;
using System.Xml.Serialization;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;


namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 功能：读取静态服务器地址
    /// 作者：张月
    /// 时间：2011年3月4日 10:43:57
    /// </summary>
    public class StaticService
    {
        /// <summary>
        /// XML文档反序列化为类
        /// </summary>
        /// <param name="fileName">xml文件地址</param>
        /// <param name="detail">xml节点</param>
        public static void DeserializerXML(string fileName, ref URLARRAY detail)
        {
            using (FileStream reader = new FileStream(fileName, FileMode.Open, FileAccess.Read))
            {
                XmlSerializer serializer = new XmlSerializer(detail.GetType());
                detail = (URLARRAY)serializer.Deserialize(reader);
                reader.Close();
                reader.Dispose();
            }
        }
        /// <summary>
        /// 根据用户ip地址查询用静态服务器地址
        /// </summary>
        /// <param name="userIp">用户Ip</param>
        /// <returns>城市</returns>
        public static string GetStaticUrl(string userIp)
        {
            URLARRAY urls = new URLARRAY();
            DeserializerXML(@"F:\project\trunk\webapp\Web\Maps\StaticUrl.xml", ref urls);
            List<Staticurl> list = urls.urls;//从xml文件中取出数据放入list中
            IPScanner objScan = new IPScanner();
            objScan.DataPath = @"F:\project\trunk\webapp\service\qqwry.dat";
            objScan.IP = userIp;
            string addre = objScan.IPLocation();
            string country = objScan.Country;
            string name = "中国";
            string err = objScan.ErrMsg;
            string url = null;
            foreach (var item in list)
            {
                if (country.Equals(item.name))
                {
                    url = item.src;
                    break;
                }
            }
            if (String.IsNullOrEmpty(url))
            {
                foreach (var item in list)
                {
                    if (name.Equals(item.name))
                    {
                        url = item.src;
                        break;
                    }
                }
            }
            return url;
        }
    }
}
