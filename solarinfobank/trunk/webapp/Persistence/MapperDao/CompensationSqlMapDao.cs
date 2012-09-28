using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class CompensationSqlMapDao : BaseSqlDao<Compensation>, ICompensationDao
    {
        public IList<Compensation> searchCompensation(System.Collections.Hashtable table)
        {
            return ExecuteQueryForList<Compensation>("compensation_get_list_dynamic", table);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="objectId"></param>
        /// <param name="isPlant"></param>
        /// <param name="type"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public IList<Compensation> getCompensations(int objectId,bool isPlant,int type,string year, string month)
        {
            Hashtable table = new Hashtable();
            table["isplant"] = isPlant?1:0;
            table["plantid"] = objectId;
            table["type"] = type;
            if (year != null)
                table["year"] = int.Parse(year);
            if (month != null)
                table["month"] = int.Parse(month);

            return ExecuteQueryForList<Compensation>("compensation_get_list_by", table);
        }
    }
}
