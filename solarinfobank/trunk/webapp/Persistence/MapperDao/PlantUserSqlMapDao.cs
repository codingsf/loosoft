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
    public class PlantUserSqlMapDao:BaseSqlDao<PlantUser>, IPlantUserDao
    {

        /// <summary>
        /// 获取所有的电站用户关系对应
        /// </summary>
        /// <returns></returns>
        public IList<PlantUser> GetAllPlantUser()
        {
            return ExecuteQueryForList<PlantUser>("plantuser_get_list", null);
        }
        /// <summary>
        /// 根据userID查询电站
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public IList<PlantUser> GetAllPlantUserByUserID(PlantUser plantUser)
        {
            return ExecuteQueryForList<PlantUser>("plantuser_get_by_userid", plantUser.userID);
        }
        /// <summary>
        /// 根据plantID，userID删除
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public int DelPlantUserByPlantID(int pid)
        {
            return ExecuteDelete("plantuser_delete_by_plantid", pid);
        }
        /// <summary>
        /// 根据plantID，userID查询
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public PlantUser GetPlantUserByPlantIDUserID(PlantUser plantUser)
        {
            return  ExecuteQueryForObject<PlantUser>("plantuser_get_by_userid_plantid", plantUser);
        }

        #region IPlantUserDao 成员


        public IList<PlantUser> GetOpenPlant(int plantId)
        {
            return  ExecuteQueryForList<PlantUser>("openplant_get_by_plantid", plantId);
           
        }

        #endregion

        #region IPlantUserDao 成员


        public int ClosePlant(int pid, int uid)
        {
            Hashtable table = new Hashtable();
            table.Add("pid", pid);
            table.Add("uid", uid);
            return ExecuteDelete("closeplant", table);
            
        }


        public int DelPlantUserByUserId(int uid)
        {
            return ExecuteDelete("plantuser_delete_by_userid", uid);
            
        }

        #endregion
    }
}