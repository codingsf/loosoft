using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace Cn.Loosoft.Zhisou.Tenghu.Domain
{
   public class Product
    {
       public int id { get; set; }
       public int mid { get; set; }
       public int pid { get; set; }
       public string name { get; set; }
       public string descr { get; set; }
       public bool isdisplay { get; set; }
       public string pdfpath { get; set; }
       public DateTime createtime { get; set; }
       public Category category { get; set; }
       public Category maincategory { get; set; }

       public string mainCategoryName 
       {
           get
           {
               if (maincategory == null)
                   return string.Empty;
               return maincategory.name;
           }
       }

       public string childCategoryName
       {
           get
           {
               if (category == null)
                   return string.Empty;
               return category.name;
           }
       }
    



    }
}
