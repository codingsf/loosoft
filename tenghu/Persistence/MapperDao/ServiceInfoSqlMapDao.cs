using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Domain;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using System.Collections;

namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao
{
    public class ServiceInfoSqlMapDao : BaseSqlDao<ServiceInfo>, IServiceInfo
    {

        public IList<ServiceInfo> GetList(string aid, string tid)
        {
            Hashtable table = new Hashtable();
            table.Add("aid", aid);
            table.Add("tid", tid);
            return ExecuteQueryForList<ServiceInfo>("serviceinfo_get_list_type", table);
        }



        public IList<ServiceInfo> GetList(string keyword)
        {
            return ExecuteQueryForList<ServiceInfo>("serviceinfo_search", keyword);
            
        }

    }
}
