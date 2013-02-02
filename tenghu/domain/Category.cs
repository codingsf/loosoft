using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace Cn.Loosoft.Zhisou.Tenghu.Domain
{
   public class Category
    {
       public int id { get; set; }
       public string name { get; set; }
       public int pid { get; set; }
       public string url { get; set; }
       public bool isDisplay { get; set; }
       public int sortOrder { get; set; }
       public string descr { get; set; }
       public string img
       {
           get
           {
               string src = Util.GetImage(descr);
               if (string.IsNullOrEmpty(src))
                   src = string.Format("/img/default/default_{0}.jpg", id);
               return src;

           }
       }
       public string text
       {
           get
           {
               return Util.FilterHtml(descr);
           }
       }


       public IList<Category> ChildCategory { get; set; }

    }
}
