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
    public class PlantUserService
    {
        PlantUserService plantUserService = PlantUserService.GetInstance();  //电站单元服务 
        private static PlantUserService _instance = new PlantUserService();
        private IDaoManager _daoManager = null;
        private IPlantUserDao _iplantuserdao = null;

        private PlantUserService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _iplantuserdao = _daoManager.GetDao(typeof(IPlantUserDao)) as IPlantUserDao;
        }

        public static PlantUserService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 获取所有的电站用户关系对应
        /// </summary>
        /// <returns></returns>
        public IList<PlantUser> GetAllPlantUser()
        {
            return _iplantuserdao.GetAllPlantUser();
        }
        /// <summary>
        /// 根据userID查询电站
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public IList<PlantUser> GetAllPlantUserByUserID(PlantUser plantUser)
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
        public PlantUser GetPlantUserByID(int id)
        {
            return _iplantuserdao.Get(new PlantUser { id = id });
        }
        /// <summary>
        /// 添加电站用户关系对应
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public int AddPlantUser(PlantUser plantUser)
        {
            return _iplantuserdao.Insert(plantUser);
        }
        /// <summary>
        /// 修改电站用户关系
        /// </summary>
        /// <param name="plantUser"></param>
        /// <returns></returns>
        public int ModifyPlantUser(PlantUser plantUser)
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
            return _iplantuserdao.Remove(new PlantUser { id = id });
        }
        /// <summary>
        /// 根据plantID，userID查询
        /// </summary>
        /// <param name="plantUser">电站用户关系对应实体</param>
        /// <returns></returns>
        public PlantUser GetPlantUserByPlantIDUserID(PlantUser plantUser)
        {
            return _iplantuserdao.GetPlantUserByPlantIDUserID(plantUser);
        }

        /// <summary>
        /// 取得某个电站分配的关系，共享的
        /// </summary>
        /// <param name="plantId"></param>
        /// <returns></returns>
        public IList<PlantUser> GetOpenPlant(int plantId)
        {
            return _iplantuserdao.GetOpenPlant(plantId);
        }


        public int ClosePlant(int pid,int uid)
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
