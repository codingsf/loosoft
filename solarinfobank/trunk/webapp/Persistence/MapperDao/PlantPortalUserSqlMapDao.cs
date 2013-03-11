using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 功能：电站用户关系对应接口实现
    /// 作者：张月
    /// 时间：2011年4月24日
    /// </summary>
    public class PlantPortalUserSqlMapDao : BaseSqlDao<PlantPortalUser>, IPlantPortalUserDao
    {

        /// <summary>
        /// 获取所有的电站用户关系对应
        /// </summary>
        /// <returns></returns>
        public IList<PlantPortalUser> GetAllPlantUser()
        {
            return ExecuteQueryForList<PlantPortalUser>("plantuser_get_list", null);
        }
        /// <summary>
        /// 根据userID查询电站
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public IList<PlantPortalUser> GetAllPlantUserByUserID(PlantPortalUser plantUser)
        {
            return ExecuteQueryForList<PlantPortalUser>("plantportaluser_get_by_userid", plantUser.userID);
        }
        /// <summary>
        /// 根据plantID，userID删除
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public int DelPlantUserByPlantID(int pid)
        {
            return ExecuteDelete("plantportaluser_delete_by_plantid", pid);
        }
        /// <summary>
        /// 根据plantID，userID查询
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public PlantPortalUser GetPlantUserByPlantIDUserID(PlantPortalUser plantUser)
        {
            return ExecuteQueryForObject<PlantPortalUser>("plantportaluser_get_by_userid_plantid", plantUser);
        }

        #region IPlantUserDao 成员

        /// <summary>
        /// 取得开放给别人的电站
        /// </summary>
        /// <param name="plantId"></param>
        /// <returns></returns>
        public IList<PlantPortalUser> GetOpenPlant(int plantId)
        {
            return ExecuteQueryForList<PlantPortalUser>("openportalplant_get_by_plantid", plantId);

        }

        #endregion

        #region IPlantUserDao 成员


        public int ClosePlant(int pid, long uid)
        {
            Hashtable table = new Hashtable();
            table.Add("pid", pid);
            table.Add("uid", uid);
            return ExecuteDelete("portalcloseplant", table);

        }

        public int DelPlantUserByUserId(long uid)
        {
            return ExecuteDelete("plantportaluser_delete_by_userid", uid);

        }

        #endregion
        /// <summary>
        /// 取得某个共享电站取得对应的用户
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public IList<User> GetusersByplantid(int pid)
        {
            return ExecuteQueryForList<User>("getportalusers_byplantid", pid);
        }
   }
}