using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 门户对象，每个一般用户只能创建一个门户
    /// </summary>
    public class Protal
    {
        public int uid { get; set; }
        public int id { get; set; }
        public string name { get; set; }
        public string logo { get; set; }
        public string footer { get; set; }
        public string items { get; set; }
        public string rate { get; set; }
        public string markPic { get; set; }
        /// <summary>
        /// 获取门户的地图图标图片
        /// </summary>
        public string MapPic
        {
            get
            {
                if(string.IsNullOrEmpty(markPic))
                {
                    return "/images/gf/china_map.jpg";
                }
                return markPic;
            }
        }

    }
}
