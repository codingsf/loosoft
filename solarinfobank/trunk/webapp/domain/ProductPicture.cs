using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：产品图片
    /// 作者：张月
    /// 时间：2011年4月22日 
    /// </summary>
    [Serializable]
    public class ProductPicture
    {
        public ProductPicture() { }
        public ProductPicture(int id, string picName, string picUrl)
        {
            this.id = id;
            this.picName = picName;
            this.picUrl = picUrl;
        }
        public int id { get; set; }//id,自增
        public string picName { get; set; } //图片名称 非空
        public string picUrl { get; set; }  //图片链接 
    }
}
