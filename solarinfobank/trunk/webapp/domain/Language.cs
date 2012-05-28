using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [Serializable]
    public class Language
    {

        //语言类型
        /// <summary>
        /// 美式英语
        /// </summary>
        public const string enUS = "en-US";

        /// <summary>
        /// 中文
        /// </summary>
        public const string zhCN = "zh-CN";

        /// <summary>
        /// 德文
        /// </summary>
        public const string de = "de-DE";

        /// <summary>
        /// 意大利
        /// </summary>
        public const string itCH = "it-ch";

        public static IList<string> lans= new List<string>();

        static Language()
        {
            lans.Add(enUS.ToLower());
            lans.Add(zhCN.ToLower());
            lans.Add(de.ToLower());
            lans.Add(itCH.ToLower());
        }

        /// <summary>
        /// 不带参的构造函数
        /// </summary>
        public Language(){ }

        /// <summary>
        /// 带参的构造函数
        /// </summary>
        /// <param name="id">语言编号</param>
        /// <param name="name">语言名称</param>
        /// <param name="codename">语言代码</param>
        /// <param name="pckagename">语言包名</param>
        /// <param name="isenabled">是否启用</param>
        public Language(int id, string name, string codename, string pckagename, bool isenabled, string currencies)
        {
            this.id = id;
            this.name = name;
            this.codename = codename;
            this.packagename = packagename;
            this.isenabled = isenabled;
            this.currencies = currencies;
        }

        //语言编号 自增
        public int id { get; set; }
        //语言名称
        public string name { get; set; }
        //语言代码
        public string codename { get; set; }
        //语言包名
        public string packagename { get; set; }
        //是否启用 默认为启用
        public bool isenabled { get; set; }

        public string displayName { get; set; }
        //货币种类
        public string currencies { get; set; }

        public bool isEdited { get; set; }
    }
}
