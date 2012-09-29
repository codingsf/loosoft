using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class EnergywarnSqlMapDao : BaseSqlDao<Energywarn>, IEnergywarnDao
    {


        public IList<Energywarn> GetEnergywarnPage(Hashtable table)
        {
            if (table.ContainsKey("page"))
                (table["page"] as Pager).RecordCount = (int)ExecuteQueryForObject("energywarn_get_search_count", table);
            return ExecuteQueryForList<Energywarn>("energywarn_get_search", table);
        }
    }
}
