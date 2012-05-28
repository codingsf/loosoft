using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class DeviceRelationSqlMapDao : BaseSqlDao<DeviceRelation>, IDeviceRelationDao
    {
        public IList<DeviceRelation> getFirstDeviceRelation(int plantId,string name)
        {
            Hashtable table = new Hashtable();
            table.Add("plantId", plantId);
            table.Add("name", name);
            return ExecuteQueryForList<DeviceRelation>("devicerelation_get_firstdevice", table);
        }

        public IList<DeviceRelation> getListbyparentDeviceId(int parentDeviceId)
        {
            return ExecuteQueryForList<DeviceRelation>("devicerelation_get_list_parentdeviceId", parentDeviceId);
        }


        public int RemoveRelations(string ids,string name)
        {
            Hashtable talbe = new Hashtable();
            talbe.Add("ids", ids);
            talbe.Add("name", name);
            return ExecuteDelete("devicerelation_delete_dids", talbe);
        }

      
        public IList<DeviceRelation> getNamesPlantId(int plantId)
        {
            return ExecuteQueryForList<DeviceRelation>("devicerelation_get_name_pid", plantId);
            
        }

    }
}
