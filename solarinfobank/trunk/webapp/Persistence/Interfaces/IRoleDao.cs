﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface IRoleDao : IBaseDao<Role>
    {
        IList<Role> GetRole_Uid(int uid);
    }
}