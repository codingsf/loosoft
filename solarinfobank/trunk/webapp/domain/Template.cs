using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [Serializable]
    public class Template
    {
        public int id { get; set; }
        public string name { get; set; }//名称
        public bool isDefault { get; set; }//是否默认模板
        public string cssFolder { get; set; }//css 文件夹路径
        public string pic { get; set; }//预览图
    }
}
