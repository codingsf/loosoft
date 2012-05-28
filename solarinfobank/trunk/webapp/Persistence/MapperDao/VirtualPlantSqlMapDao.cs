using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class VirtualPlantSqlMapDao : BaseSqlDao<VirtualPlant>, IVirtualPlantDao
    {
        public IList<VirtualPlant> VirtualplantGetUid(string uid)
        {
            return ExecuteQueryForList<VirtualPlant>("virtualplant_get_uid", uid);
        }

        public int UpdateParentId(int parentId)
        {
            return ExecuteUpdate("virtualplant_update_parentid", parentId);
        }

    }
}
