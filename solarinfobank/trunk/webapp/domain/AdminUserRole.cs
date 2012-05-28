using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [Serializable]
    public class AdminUserRole
    {
        public int id { get; set; }
        public int userId { get; set; }
        public int roleId { get; set; }
        public AdminRole role { get; set; }

    }
}
