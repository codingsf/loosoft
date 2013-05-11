using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using IBatisNet.Common.Pagination;
using IBatisNet.DataMapper.MappedStatements;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 功能：实现和电站关系对应接口
    /// 作者：张月
    /// 时间：2011年3月7日 11:33:28
    /// </summary>
    public class PlantUnitSqlMapDao : BaseSqlDao<PlantUnit>, IPlantUnitDao
    {
        PlantUnit plantUnit = new PlantUnit();//创建实体对象

        /// <summary>
        /// 功能：删除电站单元
        /// 描述：根据电站id和电站单元id删除电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantId">电站Id</param>
        /// <param name="plantUnitId">采集器Id</param>
        /// <returns>成功与否</returns>
        public int DeletePlantUnit(int plantId, int collectorId)
        {
            Hashtable table = new Hashtable();
            table.Add("plantID", plantId);
            table.Add("collectorId", collectorId);
            return ExecuteDelete("plantunit_delete", table);
        }
        /// <summary>
        /// 功能：根据电站Id获取所有的电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantID">电站Id</param>
        /// <returns>集合</returns>
        public IList<PlantUnit> GetAllPlantUnitsByPlantId(int plantID)
        {
            //IPaginatedList plantUnits = ExecuteQueryForPaginatedList("plantunit_get_list_by_plantid", plantUnit, 2);
            //return plantUnits.Current(2);
            return ExecuteQueryForList<PlantUnit>("plantunit_get_list_by_plantid", plantID);
        }
        /// <summary>
        /// 功能：根据电站Id和采集器Id获取所有的电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantID">电站Id</param>
        /// <param name="plantUnitId">采集器Id</param>
        /// <returns>集合</returns>
        public PlantUnit GetPlantUnitByPlantIdCollectorId(int plantID, int collectorId)
        {
            Hashtable table = new Hashtable();
            table.Add("plantID", plantID);
            table.Add("collectorId", collectorId);
            return ExecuteQueryForObject<PlantUnit>("plantunit_get_list_by_plantid_collectorid", table);
        }
        /// <summary>
        /// 功能：删除电站单元
        /// 描述：根据电站id删除电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantId">电站Id</param>
        /// <returns>成功与否</returns>
        public int DeletePlantUnitByPlant(int plantId)
        {
            return ExecuteDelete("plantunit_delete_by_plantid", plantId);
        }
        /// <summary>
        /// 功能：根据采集器Id获取所在的电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="collectorID"></param>
        /// <returns></returns>
        public PlantUnit GetPlantUnitByCollectorId(int collectorID)
        {
            return ExecuteQueryForObject<PlantUnit>("plantunit_get_by_collectorID", collectorID);
        }
    }
}
