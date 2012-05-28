using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：宣传图片信息
    /// 作者：张月
    /// 时间：2011年4月22日 
    /// </summary>
    [Serializable]
    public class Adpic
    {
        public Adpic() { }
        public Adpic(int id, string picName, string picUrl, string language)
        {
            this.id = id;
            this.picName = picName;
            this.picUrl = picUrl;
            this.language = language;
        }
        public int id { get; set; }//id 自增长
        public string picName { get; set; }//图片名称 非空
        public string picUrl { get; set; }//图片链接
        public string language { get; set; }//图片语言

        private Language _language;

        public Language langInstance
        {
            get
            {
                return _language;
            }
            set
            {
                _language = value;
            }
        }
    }
}
