using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace Cn.Loosoft.Zhisou.Tenghu.Domain
{
   public class News
    {
       public int id { get; set; }
       public int categoryid { get; set; }
       public string title { get; set; }
       public string descr { get; set; }
       public string publicuser { get; set; }
       public DateTime publictime { get; set; }
       public bool ishot { get; set; }
       public int sortorder { get; set; }
       public Category category { get; set; }
       public News prenews{get;set;}
       public News nextnews { get; set; }

       public string imgUrl
       {
           get
           {
               string src = Util.GetImage(descr);
               if (string.IsNullOrEmpty(src))
               {
                   src = string.Format("/img/default/default_{0}.jpg", category != null ? category.id : 0);
               }
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


    }
}
