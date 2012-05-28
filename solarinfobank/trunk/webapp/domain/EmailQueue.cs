using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [XmlRoot("TEMPLETE")]
    [Serializable]
    public  class EmailQueue
    {
      public int id { get; set; }
      public string title { get; set; }
      public string content { get; set; }
      public string receiver { get; set; }
      public string sender { get; set; }
      public int state { get; set; }
    }
}
