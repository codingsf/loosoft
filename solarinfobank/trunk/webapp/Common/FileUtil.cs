using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace Cn.Loosoft.Zhisou.SunPower.Common
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
            StreamWriter streamWriter = new StreamWriter(fileName,true);
            streamWriter.BaseStream.Seek(0, SeekOrigin.End);
            streamWriter.WriteLine(content);
            streamWriter.Flush();
            streamWriter.Close();
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

        public static IList<string> Readline(string fileName){
            IList<string> lines = new List<string>();
            FileStream   fs=new   FileStream(@fileName,FileMode.Open,FileAccess.Read,FileShare.None); 
            StreamReader sr=new   StreamReader(fs,System.Text.Encoding.Default); 

            sr.BaseStream.Seek(0,SeekOrigin.Begin); 
            string     strLine     =sr.ReadLine(); 
            while(strLine!=null) 
            { 
                strLine=sr.ReadLine();
                lines.Add(strLine);
            }
            sr.Close();
            fs.Close();
            return lines;
        }

        public static bool exist(string fileName) { 
            return File.Exists(fileName);
        }

    }
}
