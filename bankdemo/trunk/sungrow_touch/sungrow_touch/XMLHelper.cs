using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.IO;

namespace sungrow_demo
{
    public class XMLHelper
    {
        #region 类序列化为XML文档
        public static void SerializerXML<T>(string fileName, T detail)
        {
            string dirPath = Path.GetDirectoryName(fileName);
            if ( string.IsNullOrEmpty(dirPath)==false&& !Directory.Exists(dirPath))
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
