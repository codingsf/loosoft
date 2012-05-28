using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 功能：子电站和电站对应关系服务
    /// 作者：张月
    /// 时间：2011年3月7日 11:36:33
    /// </summary>
    public class PlantUnitService
    {
        private static PlantUnitService _instance = new PlantUnitService();
        private IDaoManager _daoManager = null;
        private IPlantUnitDao _plantUnit = null;

        private PlantUnitService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _plantUnit = _daoManager.GetDao(typeof(IPlantUnitDao)) as IPlantUnitDao;
        }

        public static PlantUnitService GetInstance()
        {
            return _instance;
        }
        /// <summary>
        /// 功能：根据电站Id获取所有的电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantID">电站Id</param>
        /// <returns>集合</returns>
        public IList<PlantUnit> GetAllPlantUnitsByPlantId(int plantID)
        {
            return _plantUnit.GetAllPlantUnitsByPlantId(plantID);
        }
        /// <summary>
        /// 功能：添加电站单元
        /// 描述：根据电站id和单元id添加
        /// 作者：张月
        /// 时间：2011年3月12日 12:07:53
        /// </summary>
        /// <param name="plantunit">电站单元实体</param>
        /// <returns>添加列</returns>
        public int AddPlantUnit(PlantUnit plantunit)
        {
            //先清理缓存,以便解析器能获取新的对应关系
            string cacheKey = CacheKeyUtil.buildPlantUnitKey();
            MemcachedClientSatat.getInstance().Delete(cacheKey);
            return _plantUnit.Insert(plantunit);
        }
        /// <summary>
        /// 功能：根据主键id修改电站单元
        /// 作者：张月
        /// 时间：2011年3月12日 13:29:21
        /// </summary> 
        /// <param name="plantSubPlant">电站单元实体对象</param>
        /// <returns>成功与否</returns>
        public int EditPlantUnit(PlantUnit plantUnit)
        {
            return _plantUnit.Update(plantUnit);
        }
        /// <summary>
        /// 根据id查询子电站 
        /// </summary>
        /// <param name="id">主键id</param>
        /// <returns>电站单元实体</returns>
        public PlantUnit GetPlantUnitById(int id)
        {
            return _plantUnit.Get(new PlantUnit { id = id });
        }
        /// <summary>
        /// 功能：删除电站单元
        /// 描述：根据电站id和电站单元id删除电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantId">电站Id</param>
        /// <param name="plantUnitId">电站单元Id</param>
        /// <returns>成功与否</returns>
        public int DeletePlantUnit(int plantId, int plantUnitId)
        {
            //先清理缓存,以便解析器能获取新的对应关系
            string cacheKey = CacheKeyUtil.buildPlantUnitKey();
            MemcachedClientSatat.getInstance().Delete(cacheKey);

            return _plantUnit.DeletePlantUnit(plantId, plantUnitId);
        }
        /// <summary>
        /// 功能：根据电站Id和单元Id获取所有的电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="plantID">电站Id</param>
        /// <param name="plantUnitId">电站单元Id</param>
        /// <returns>集合</returns>
        public PlantUnit GetPlantUnitByPlantIdPlantUnitId(int plantID, int plantUnitId)
        {
            return _plantUnit.GetPlantUnitByPlantIdPlantUnitId(plantID, plantUnitId);
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
            //先清理缓存,以便解析器能获取新的对应关系
            string cacheKey = CacheKeyUtil.buildPlantUnitKey();
            MemcachedClientSatat.getInstance().Delete(cacheKey);

            return _plantUnit.DeletePlantUnitByPlant(plantId);
        }
        public IList<PlantUnit> List()
        {
            return _plantUnit.Getlist(new PlantUnit() { });
        }
        /// <summary>
        /// 功能：根据采集器Id获取所在的电站单元
        /// 作者：张月
        /// </summary>
        /// <param name="collectorID"></param>
        /// <returns></returns>
        public PlantUnit GetPlantUnitByCollectorId(int collectorID)
        {
            return _plantUnit.GetPlantUnitByCollectorId(collectorID);
        }

    }
}
