using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 功能：子电站和电站的对应
    /// 作者：张月
    /// 时间：2011年3月7日 11:23:44
    /// </summary>
    public interface IPlantUnitDao : IBaseDao<PlantUnit>
    {
        /// <summary>
        /// 功能：根据电站Id获取所有的电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantID">电站Id</param>
        /// <returns>集合</returns>
        IList<PlantUnit> GetAllPlantUnitsByPlantId(int plantID);
        /// <summary>
        /// 功能：根据电站Id和单元Id获取所有的电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantID">电站Id</param>
        /// <param name="plantUnitId">电站单元Id</param>
        /// <returns>集合</returns>
        PlantUnit GetPlantUnitByPlantIdPlantUnitId(int plantID, int plantUnitId);
        /// <summary>
        /// 功能：删除电站单元
        /// 描述：根据电站id和电站单元id删除电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantId">电站Id</param>
        /// <param name="plantUnitId">电站单元Id</param>
        /// <returns>成功与否</returns>
        int DeletePlantUnit(int plantId,int plantUnitId);
            /// <summary>
        /// 功能：删除电站单元
        /// 描述：根据电站id删除电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantId">电站Id</param>
        /// <returns>成功与否</returns>
        int DeletePlantUnitByPlant(int plantId);
        /// <summary>
        /// 功能：根据采集器Id获取所在的电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="collectorID"></param>
        /// <returns></returns>
        PlantUnit GetPlantUnitByCollectorId(int collectorID);
    }
}
