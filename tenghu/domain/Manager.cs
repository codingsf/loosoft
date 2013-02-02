using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.Tenghu.Domain
{
    [Serializable]
   public class Manager
    {
       public int id { get; set; }
       public string username { get; set; }
       public string password { get; set; }
       public bool islocked { get; set; }
       public bool issuper { get; set; }
    }
}
