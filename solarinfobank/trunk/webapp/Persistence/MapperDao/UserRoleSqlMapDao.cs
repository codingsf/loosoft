﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class UserRoleSqlMapDao : BaseSqlDao<UserRole>, IUserRoleDao
    {
        public int DeleteRoleId(int roleId)
        {
            return ExecuteDelete("userrole_delete_roleId", roleId);
        }
    }
}
