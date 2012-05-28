using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [Serializable]

  public  class AdminControllerActionRole
    {
      public int id { get; set; }
      public int roleId { get; set; }
      public int controllerActionId { get; set; }
      //public AdminControllerAction ControllerAction { get; set; }
    }
}
