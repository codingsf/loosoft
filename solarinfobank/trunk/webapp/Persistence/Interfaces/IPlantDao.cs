using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 功能：电站信息接口
    /// 作者：张月
    /// 时间：2011年2月16日 16:09:52
    /// </summary>
    public interface IPlantDao : IBaseDao<Plant>
    {
        /// <summary>
        /// 功能：获取电站信息集合
        /// </summary>
        /// <returns>返回：电站信息集合</returns>
        IList<Plant> GetPlantInfoList();
        /// <summary>
        /// 功能：获取电站的个数
        /// </summary>
        /// <returns></returns>
        int GetPlantNum();
        /// <summary>
        /// 功能：修改电站图片
        /// </summary>
        /// <param name="picname">电站实体</param>
        /// <returns></returns>
        int ModifyPlantPic(Plant plant);

        /// <summary>
        /// 获取制定数量的电站
        /// </summary>
        /// <returns></returns>
        IList<Plant> GetPlantInfoList(int top, string order);

        IList<Plant> GetPlantsByPage(Pager page);

        IList<Plant> QueryPagePlants(Hashtable table);

        IList<Plant> Getplantlikepname(string name);

        /// <summary>
        /// 按照名称取得电站
        /// add by qhb in 20120831 
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        Plant Getplantbyname(string name);

        int UpdataWarningLastSendTime(int pid, DateTime updateTime);

        //虚拟电站开始
        /// <summary>
        /// 批量清楚原有父电站为空
        /// </summary>
        /// <param name="parentId"></param>
        /// <returns></returns>
        int UpdateParentId(int parentId);
    }
}