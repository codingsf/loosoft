using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using IBatisNet.Common.Pagination;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 采集器信息接口
    /// Author: 赵文辉
    /// Time: 2011年2月16日 11:27:43
    public interface ICollectorDao : IBaseDao<Collector>
    {
        /// <summary>
        /// 采集器验证
        /// </summary>
        /// <param name="guid">采集器编号</param>
        /// <param name="password">密码</param>
        /// <returns>是否通过验证 false失败 true成功</returns>
        Collector Exists(string guid, string password);

        /// <summary>
        /// 修改采集器信息
        /// </summary>
        /// <param name="collectorInfo">采集器实体</param>
        void UpdateCollector(Collector collectorInfo);

        /// <summary>
        /// 删除采集器信息
        /// </summary>
        /// <param name="code">采集器编号</param>
        /// <returns>是否删除成功 0失败 1成功</returns>
        int DeleteCollector(string code);


        /// <summary>
        /// 根据采集器编号查询采集器信息
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns>采集器对象</returns>
        Collector GetCollectorById(int id);

        /// <summary>
        /// 根据采集器编号查询采集器ID
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns>采集器id，没有则为0</returns>
        Collector GetCollectorByCode(string code);

        /// <summary>
        /// 查询所有采集器信息
        /// </summary>
        /// <returns>所有采集器信息</returns>
        IList<Collector> GetColloectorInfos();

        /// <summary>
        /// 功能：根据采集器编号和密码查询
        /// 作者：张月
        /// 时间：2011年3月12日 11:42:04
        /// </summary>
        /// <param name="collector">采集器实体</param>
        /// <returns></returns>
        Collector GetClollectorByCodePass(Collector collector);


        IPaginatedList GetPageCollectors();

        IList<Collector> GetCollectorsByPage(Hashtable hashPara);


        int CheckCollectorExists(string code);

        IList<Collector> GetCollectorsByUid(int uid);

    }
}
