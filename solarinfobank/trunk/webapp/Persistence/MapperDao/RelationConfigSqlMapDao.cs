using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class RelationConfigSqlMapDao : BaseSqlDao<RelationConfig>, IRelationConfigDao
    {
        public RelationConfig GetConfig(RelationConfig config)
        {
            return ExecuteQueryForObject<RelationConfig>("relationconfig_get_config", config);
        }
    }
}
