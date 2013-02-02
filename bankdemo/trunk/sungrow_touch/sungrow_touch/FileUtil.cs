using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace sungrow_touch
{
    class FileUtil
    {
        /// <summary>
        /// 写内容到文件，追加方式
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="content"></param>
        public static void WriteLine(string filePath, string fileName, string content)
        {
            if (!Directory.Exists(filePath))
            {
                Directory.CreateDirectory(filePath);
            }
            fileName = Path.Combine(filePath, fileName);
            //FileStream fs = new FileStream(fileName, FileMode.Create);
            StreamWriter streamWriter = new StreamWriter(fileName, true);
            streamWriter.BaseStream.Seek(0, SeekOrigin.End);
            streamWriter.WriteLine(content);
            streamWriter.Flush();
            streamWriter.Close();
            //fs.Close();
        }
        /// <summary>
        /// 写内容到文件，覆盖方式
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="content"></param>
        public static void WriteFile(string filePath, string fileName, string content)
        {
            if (!Directory.Exists(filePath))
            {
                Directory.CreateDirectory(filePath);
            }
            fileName = Path.Combine(filePath, fileName);
            FileStream fs = new FileStream(fileName, FileMode.Create);
            StreamWriter streamWriter = new StreamWriter(fs);
            streamWriter.BaseStream.Seek(0, SeekOrigin.End);
            streamWriter.WriteLine(content);
            streamWriter.Flush();
            streamWriter.Close();
            fs.Close();
        }
        /// <summary>
        /// 读文件
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public static string ReadFile(string fileName)
        {
            StreamReader sr = new StreamReader(fileName);
            string content = sr.ReadToEnd();
            sr.Close();
            return content;
        }

    }
}
