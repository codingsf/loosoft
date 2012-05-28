using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
   [Serializable]
   public class UserRole
    {
       public int id { get; set; }
       public int userId { get; set; }
       public int roleId { get; set; }
       public Role Role { get; set; }
       private IList<RoleFunction> _roleFunctions;
       public IList<RoleFunction> RoleFunctions
       {
           set { _roleFunctions = value; }
           get { return _roleFunctions; }
       }

       public bool isDeny(int code)
       {
           foreach (RoleFunction function in RoleFunctions)
           {
               if (function.functionCode.Equals(code))
                   return true;
           }
           return false;
       }
    }
}
