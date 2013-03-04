using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 功能：电站用户关系对应接口
    /// 作者：张月
    /// 时间：2011年4月24日
    /// </summary>
    public interface IPlantPortalUserDao : IBaseDao<PlantPortalUser>
    {
        /// <summary>
        /// 获取所有的电站用户关系对应
        /// </summary>
        /// <returns></returns>
        IList<PlantPortalUser> GetAllPlantUser();
        /// <summary>
        /// 根据userID查询电站
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        IList<PlantPortalUser> GetAllPlantUserByUserID(PlantPortalUser plantUser);
        /// <summary>
        /// 根据plantID，userID删除
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        int DelPlantUserByPlantID(int pid);
        /// <summary>
        /// 根据plantID，userID查询
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        PlantPortalUser GetPlantUserByPlantIDUserID(PlantPortalUser plantUser);

        IList<PlantPortalUser> GetOpenPlant(int plantId);
        /// <summary>
        /// 删除电站和用户对应关系
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="uid"></param>
        /// <returns></returns>
        int ClosePlant(int pid, long uid);
        /// <summary>
        /// 根据用户删除电站用户对应关系
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        int DelPlantUserByUserId(long uid);
        /// <summary>
        /// 根据电站id取得分配的用户
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        IList<User> GetusersByplantid(int pid);
    }
}
