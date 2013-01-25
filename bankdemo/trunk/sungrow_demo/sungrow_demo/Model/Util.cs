using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace sungrow_demo.Model
{
    public class Language
    {
        public string name { get; set; }
        public string code { get; set; }
    }
    public static class LangUtil
    {
        public const string EN = "en";
        public const string Zh = "zh";

        public static ArrayList Languages
        {
            get
            {
                return new ArrayList
                { 
                    new Language{ name = "英文", code =EN } ,
                    new Language{ name = "中文", code = Zh } 
                };
            }
        }
    }
}
