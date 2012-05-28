using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class ManagerMonitorCodeSqlMapDao : BaseSqlDao<ManagerMonitorCode>, IManagerMonitorCodeSqlMapDao
    {
        public int HideItemByTid(string tid)
        {
            return ExecuteUpdate("managermonitorcode_set_all_hide", tid);
        }
    }
}
