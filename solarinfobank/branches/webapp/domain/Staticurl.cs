using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：读取静态服务器xml文档
    /// 作者：张月
    /// 时间：2011年3月3日 17:35:38
    /// </summary>
    public class Staticurl
    {
        public string name { get; set; }//国家名
        public string src { get; set; }//静态服务器地址
    }
    /// <summary>
    /// 存放在集合中
    /// </summary>
    public class URLARRAY
    {
        public List<Staticurl> urls { get; set; }

        public URLARRAY()
        {
            urls = new List<Staticurl>();
        }
    }

}
