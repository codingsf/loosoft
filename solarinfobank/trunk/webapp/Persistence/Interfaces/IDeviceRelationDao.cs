using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface IDeviceRelationDao : IBaseDao<DeviceRelation>
    {
        IList<DeviceRelation> getFirstDeviceRelation(int plantId, string name);
        IList<DeviceRelation> getListbyparentDeviceId(int parentDeviceId);
        IList<DeviceRelation> getNamesPlantId(int plantId);
        int RemoveRelations(string ids,string name);
    }
}
