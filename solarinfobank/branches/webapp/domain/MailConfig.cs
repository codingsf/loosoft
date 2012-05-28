using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
   public class MailConfig
    {
       public int id { get; set; }
       public string serverName { get; set; }
       public string emailName { get; set; }
       public string emailPwd { get; set; }
       public int port { get; set; }
    }
}
