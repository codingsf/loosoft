using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace Cn.Loosoft.Zhisou.Tenghu.Domain
{
   public class ServiceInfo
    {
       public int id { get; set; }
       public int areaid { get; set; }
       public int nettypeid { get; set; }
       public string addr { get; set; }
       public string post { get; set; }
       public string tel { get; set; }
       public string descr { get; set; }
       public bool issale { get; set; }
       public string latitude { get; set; }
       public string longitude { get; set; }

       public string area
       {
           get
           {
               foreach (SelectListItem item in Comm.Area)
               {
                   if(item.Value.Equals(areaid.ToString())&&areaid>0)
                       return item.Text;
               }
               return string.Empty;
           }
       }

       public string nettype
       {
           get
           {
               foreach (var item in Comm.NetworkType)
               {
                   if (item.Value.Equals(nettypeid.ToString()) && nettypeid > 0)
                       return item.Text;
               }
               return string.Empty;
           }
       }

    }
}
