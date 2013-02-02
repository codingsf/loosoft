using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace sungrow_touch
{
    public class DataStrUtil
    {
        public static IList<string> AnalData(string str)
        {
   
            IList<string> strArray = new List<string>();
            if (str == null || str.Equals("")) return strArray;

            for (int i = 0; i < str.Length; i++)
            {
                if (str[i].Equals('.'))
                    strArray.Add("dot");
                else
                    strArray.Add(str[i].ToString());
            }
            return strArray;
        }
    }
}
