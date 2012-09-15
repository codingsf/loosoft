using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class CompensationSqlMapDao : BaseSqlDao<Compensation>, ICompensationDao
    {
        public IList<Compensation> searchCompensation(System.Collections.Hashtable table)
        {
            return ExecuteQueryForList<Compensation>("compensation_get_list_dynamic", table);
        }
    }
}
