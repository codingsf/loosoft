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
        public string name { get; set; }//错误名称
    }
}
