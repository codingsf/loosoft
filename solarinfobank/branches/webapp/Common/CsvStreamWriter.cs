using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.IO;

namespace Common
{
    /// <summary>
    /// csv生产类
    /// </summary>
    public class CsvStreamWriter
    {
        private ArrayList rowAL;         //行链表,CSV文件的每一行就是一个链
        private string fileName;         //文件名
        private Encoding encoding;       //编码
        public CsvStreamWriter()
        {
            this.rowAL = new ArrayList();   
            this.fileName = "";
            this.encoding = Encoding.Default;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="fileName">文件名,包括文件路径</param>
        public CsvStreamWriter(string fileName)
        {
            this.rowAL = new ArrayList();    
            this.fileName = fileName;
            this.encoding = Encoding.Default;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="fileName">文件名,包括文件路径</param>
        /// <param name="encoding">文件编码</param>
        public CsvStreamWriter(string fileName,Encoding encoding)
        {
            this.rowAL = new ArrayList();  
            this.fileName = fileName;
            this.encoding = encoding;
        }

        /// <summary>
        /// 文件名,包括文件路径
        /// </summary>
        public string FileName
        {
            set
            {
                this.fileName = value;
            }
        }

        /// <summary>
        /// 文件编码
        /// </summary>
        public Encoding FileEncoding
        {
            set
            {
                this.encoding = value;
            }
        }

        /// <summary>
        /// 获取当前最大行
        /// </summary>
        public int CurMaxRow
        {
            get
            {
                return this.rowAL.Count;
            }
        }

        /// <summary>
        /// 获取最大列
        /// </summary>
        public int CurMaxCol
        {
            get
            {
                int maxCol= 0;
                for (int i = 0;i<this.rowAL.Count;i++)
                {
                     ArrayList colAL = (ArrayList) this.rowAL[i];

                     maxCol = (maxCol > colAL.Count)?maxCol:colAL.Count;
                }

                return maxCol;
            }
        }

        
        /// <summary>
        /// 添加表数据到CSV文件中
        /// </summary>
        /// <param name="dataList">list数据，每个元素是逗号分隔的串</param>
        public void AddStrDataList(IList<string> dataList) {
            if (dataList == null)
            {
                throw new Exception("需要添加的表数据为空");
            }
            int curMaxRow = this.rowAL.Count;
            for (int i = 0; i < dataList.Count; i++)
            {
                rowAL.Add(dataList[i]);
            }
        }


        /// <summary>
        /// 添加表数据到CSV文件中
        /// </summary>
        /// <param name="dataList">list数据，每个元素是逗号分隔的串</param>
        public void AddArrDataList(IList<string[]> dataList)
        {
            if (dataList == null)
            {
                throw new Exception("需要添加的表数据为空");
            }
            int curMaxRow = this.rowAL.Count;
            string tmpStr = "";
            for (int i = 0; i < dataList.Count; i++)
            {
                tmpStr = dataList[i].ToString();
                rowAL.Add(tmpStr);
            }
        }

        /// <summary>
        /// 保存数据,如果当前硬盘中已经存在文件名一样的文件，将会覆盖
        /// </summary>
        public void Save()
        {
            try
            {
                //对数据的有效性进行判断
                if (this.fileName == null)
                {
                    throw new Exception("缺少文件名");
                }
                else if (File.Exists(this.fileName))
                {
                    File.Delete(this.fileName);
                }
                if (this.encoding == null)
                {
                    this.encoding = Encoding.UTF8;
                }
                System.IO.StreamWriter sw = new StreamWriter(this.fileName, false, this.encoding);

                for (int i = 0; i < this.rowAL.Count; i++)
                {
                    sw.WriteLine(this.rowAL[i]);
                }
                sw.Close();
            }catch(Exception e){
                
            }
        }

        /// <summary>
        /// 保存数据,如果当前硬盘中已经存在文件名一样的文件，将会覆盖
        /// </summary>
        /// <param name="fileName">文件名,包括文件路径</param>
        public void Save(string fileName)
        {
            this.fileName = fileName;
            Save();
        }

        /// <summary>
        /// 保存数据,如果当前硬盘中已经存在文件名一样的文件，将会覆盖
        /// </summary>
        /// <param name="fileName">文件名,包括文件路径</param>
        /// <param name="encoding">文件编码</param>
        public void Save(string fileName,Encoding encoding)
        {
            this.fileName = fileName;
            this.encoding = encoding;
            Save();
        }


        /// <summary>
        /// 转换成保存行
        /// </summary>
        /// <param name="colAL">一行</param>
        /// <returns></returns>
        public string ConvertToSaveLine(ArrayList colAL)
        {
            string saveLine;

            saveLine = "";
            for (int i = 0;i< colAL.Count;i++)
            {
                if (colAL[i] != null)
                {
                    saveLine += ConvertToSaveCell(colAL[i].ToString());
                }
                else
                {
                    colAL[i] = " ";
                    saveLine += ConvertToSaveCell(colAL[i].ToString());
                }
            //格子间以逗号分割
            if (i < colAL.Count - 1)
            {
             saveLine += ",";
            }    
            }

            return saveLine;
        }

        /// <summary>
        /// 字符串转换成CSV中的格子
        /// 双引号转换成两个双引号，然后首尾各加一个双引号
        /// 这样就不需要考虑逗号及换行的问题
        /// </summary>
        /// <param name="cell">格子内容</param>
        /// <returns></returns>
        public string ConvertToSaveCell(string cell)
        {
            cell = cell.Replace("\"","\"\"");

            return "\"" + cell + "\"";
        }



    }
}
