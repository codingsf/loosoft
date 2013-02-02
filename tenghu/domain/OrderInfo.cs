using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace Cn.Loosoft.Zhisou.Tenghu.Domain
{
   public class OrderInfo
    {
       public int id { get; set; }
       public string area { get; set; }
       public Category category { get; set; }
       public Product product { get; set; }
       public string time { get; set; }
       public string payment { get; set; }
       public string type { get; set; }
       public string uname { get; set; }
       public string company { get; set; }
       public string tel { get; set; }
       public string email { get; set; }
       public string address { get; set; }
       public string comment { get; set; }

       public string areaname
       {
           get
           {
               foreach (SelectListItem item in Comm.Area)
               {
                   if (item.Value.Equals(area))
                       return item.Text;
               }
               return string.Empty;
           }
       }

    }
}
