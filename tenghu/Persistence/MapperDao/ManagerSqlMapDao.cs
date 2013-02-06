using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;


namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao
{
    public class ManagerSqlMapDao : BaseSqlDao<Manager>, IManager
    {

        #region IManager 成员

        public Manager Get(string uname)
        {
            return ExecuteQueryForObject<Manager>("manager_get_uname", uname);
        }

        #endregion
    }
}
