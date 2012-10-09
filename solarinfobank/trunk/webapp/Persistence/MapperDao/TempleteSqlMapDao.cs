using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class TempleteSqlMapDao : BaseSqlDao<Templete>, ITempleteDao
    {
        public Templete getDefault()
        {
            return ExecuteQueryForObject<Templete>("get_default_templete", null);
        }
    }
}
