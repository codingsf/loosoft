using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 功能：电站用户对应关系服务
    /// 作者：张月
    /// 时间：2011年4月24日
    /// </summary>
    public class PlantPortalUserService
    {
        PlantPortalUserService plantUserService = PlantPortalUserService.GetInstance();  //电站单元服务 
        private static PlantPortalUserService _instance = new PlantPortalUserService();
        private IDaoManager _daoManager = null;
        private IPlantPortalUserDao _iplantuserdao = null;

        private PlantPortalUserService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _iplantuserdao = _daoManager.GetDao(typeof(IPlantPortalUserDao)) as IPlantPortalUserDao;
        }

        public static PlantPortalUserService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 获取所有的电站用户关系对应
        /// </summary>
        /// <returns></returns>
        public IList<PlantPortalUser> GetAllPlantUser()
        {
            return _iplantuserdao.GetAllPlantUser();
        }
        /// <summary>
        /// 根据userID查询电站
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public IList<PlantPortalUser> GetAllPlantUserByUserID(PlantPortalUser plantUser)
        {

            return _iplantuserdao.GetAllPlantUserByUserID(plantUser);
        }

        /// <summary>
        /// 根据plantID，userID删除
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public int DelPlantUserByPlantID(int pid)
        {
            return _iplantuserdao.DelPlantUserByPlantID(pid);
        }
        /// <summary>
        /// 根据id查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public PlantPortalUser GetPlantUserByID(int id)
        {
            return _iplantuserdao.Get(new PlantPortalUser { id = id });
        }
        /// <summary>
        /// 添加电站用户关系对应
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public int AddPlantPortalUser(PlantPortalUser plantUser)
        {
            return _iplantuserdao.Insert(plantUser);
        }
        /// <summary>
        /// 修改电站用户关系
        /// </summary>
        /// <param name="plantUser"></param>
        /// <returns></returns>
        public int ModifyPlantUser(PlantPortalUser plantUser)
        {
            return _iplantuserdao.Update(plantUser);
        }
        /// <summary>
        /// 根据id删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int DelPlantUserById(int id)
        {
            return _iplantuserdao.Remove(new PlantPortalUser { id = id });
        }
        /// <summary>
        /// 根据plantID，userID查询
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public PlantPortalUser GetPlantUserByPlantIDUserID(PlantPortalUser plantUser)
        {
            return _iplantuserdao.GetPlantUserByPlantIDUserID(plantUser);
        }


        public IList<PlantPortalUser> GetOpenPlant(int plantId)
        {
            return _iplantuserdao.GetOpenPlant(plantId);
        }

        /// <summary>
        /// 删除电站和用户对应关系
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="uid"></param>
        /// <returns></returns>
        public int ClosePlant(int pid, int uid)
        {
            return _iplantuserdao.ClosePlant(pid, uid);
        }

        public int DelPlantUserByUserId(int uid)
        {
            return _iplantuserdao.DelPlantUserByUserId(uid);
        }

        /// <summary>
        /// 根据电站id取得分配的用户,特指共享用户，不包括自身
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public IList<User> GetusersByplantid(int pid)
        {
            return _iplantuserdao.GetusersByplantid(pid);

        }
    }
}
