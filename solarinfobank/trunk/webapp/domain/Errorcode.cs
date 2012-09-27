using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [Serializable]
    public class Errorcode
    {
        public int id { get; set; }//id
        public string code { get; set; }//错误代码
        public int errorType { get; set; }//错误代码
        public string defaultName { get; set; }//默认名称
        public string name { get; set; }//错误名称 对于多语言

        public string getCodeName(string code)
        {
            if (name == null) return defaultName;
            List<string> keyValues = null;
            List<string> arrayList = name.Split(',').ToList<string>();
            foreach (string array in arrayList)
            {
                keyValues = array.Split(':').ToList<string>();

                if (keyValues[0].ToLower().Equals(code.ToLower()))
                {
                    if (string.IsNullOrEmpty(keyValues[1]))
                        return defaultName;
                    return keyValues[1];
                }
            }
            return defaultName;

        }
    }
}
