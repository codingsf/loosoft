using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class RoleSqlMapDao : BaseSqlDao<Role>, IRoleDao
    {

        public IList<Role> GetRole_Uid(int uid)
        {
            return ExecuteQueryForList<Role>("get_role_uid", uid);
        }
    }
}
