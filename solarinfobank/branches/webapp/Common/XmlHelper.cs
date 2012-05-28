using System.IO;
using System.Xml.Serialization;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class XmlHelper
    {
        #region 类序列化为XML文档
        public static void SerializerXML<T>(string fileName, T detail)
        {
            string dirPath = fileName.Substring(0, fileName.LastIndexOf('\\'));
            if (!Directory.Exists(dirPath))
            {
                Directory.CreateDirectory(dirPath);
            }
            using (StreamWriter writer = new StreamWriter(fileName))
            {
                XmlSerializer serializer = new XmlSerializer(detail.GetType());
                serializer.Serialize(writer, detail);
                writer.Close();
                writer.Dispose();
            }
        }
        #endregion

        #region XML文档反序列化为类
        public static void DeserializerXML<T>(string fileName, ref T detail)
        {
            using (FileStream reader = new FileStream(fileName, FileMode.Open, FileAccess.Read))
            {
                XmlSerializer serializer = new XmlSerializer(detail.GetType());
                detail = (T)serializer.Deserialize(reader);
                reader.Close();
                reader.Dispose();
            }
        }
        #endregion
    }
}
