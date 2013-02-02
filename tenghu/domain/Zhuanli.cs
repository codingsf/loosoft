using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.Tenghu.Domain
{
   public class Zhuanli
    {
       public int id { get; set; }
       public string name { get; set; }
       public int type { get; set; }
       public string num { get; set; }
       public string descr { get; set; }
       public string url { get; set; }
       public Category category { get; set; }
    }
}
