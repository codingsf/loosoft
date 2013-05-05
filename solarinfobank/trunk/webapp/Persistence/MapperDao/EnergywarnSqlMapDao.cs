using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using IBatisNet.Common.Exceptions;

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

        public Energywarn get(int deviceId, string warndate)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["deviceId"] = deviceId;
            whereHash["warndate"] = warndate;
            try
            {
                return ExecuteQueryForObject<Energywarn>("getbydeviceIdandwarndate", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return null;
        }
    }
}
