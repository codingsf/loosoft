using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;
using IBatisNet.Common.Pagination;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 采集器信息实现
    /// Author: 赵文辉
    /// Time: 2011年2月18日 15:00:37  第一次修改
    /// </summary>
    public class CollectorSqlMapDao : BaseSqlDao<Collector>, ICollectorDao
    {

        #region ICollectorInfoDao 成员

        /// <summary>
        /// 采集器验证
        /// </summary>
        /// <param name="guid">采集器编号</param>
        /// <param name="password">密码</param>
        /// <returns>是否通过验证 false失败 true成功</returns>
        public Collector Exists(string guid, string password)
        {
            Hashtable para = new Hashtable();
            para.Add("Code", guid);
            para.Add("PASSWORD", password);
            return ExecuteQueryForObject<Collector>("CHECK_COLLECTORINFO_EXISTS", para);
        }

        /// <summary>
        /// 根据采集器编号查询采集器信息
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns>采集器对象</returns>
        public Collector GetCollectorById(int id)
        {
            return ExecuteQueryForObject<Collector>("collector_get", id);
        }

        /// <summary>
        /// 根据采集器编号查询采集器ID
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns>采集器id，没有则为0</returns>
        public Collector GetCollectorByCode(string code)
        {
            return base.ExecuteQueryForObject<Collector>("collector_get_bycode", code);
        }

        /// <summary>
        /// 添加采集器信息
        /// </summary>
        /// <param name="collectorInfo">采集器实体</param>
        public void Add(Collector collectorInfo)
        {
            base.ExecuteInsert<Collector>("COLLECTORINFO_INSERT", collectorInfo);
        }

        /// <summary>
        /// 修改采集器信息
        /// </summary>
        /// <param name="collectorInfo">采集器实体</param>
        public void UpdateCollector(Collector collectorInfo)
        {
            base.ExecuteUpdate<Collector>("collector_update", collectorInfo);
        }

        /// <summary>
        /// 删除采集器信息
        /// </summary>
        /// <param name="code">采集器编号</param>
        /// <returns>是否删除成功 0失败 1成功</returns>
        public int DeleteCollector(string code)
        {
            return ExecuteDelete("COLLECTORINFO_DELETE", code);
        }

        /// <summary>
        /// 查询所有采集器信息
        /// </summary>
        /// <returns>所有采集器信息</returns>
        public IList<Collector> GetColloectorInfos()
        {
            return ExecuteQueryForList<Collector>("collector_get_list", null);
        }

        /// <summary>
        /// 功能：根据采集器编号和密码查询
        /// 作者：张月
        /// 时间：2011年3月12日 11:42:04
        /// </summary>
        /// <param name="collector">采集器实体</param>
        /// <returns></returns>
        public Collector GetClollectorByCodePass(Collector collector)
        {
            return ExecuteQueryForObject<Collector>("COLLECTOR_GET_BY_CODE_PASS", collector);
        }

        #endregion

        #region ICollectorDao 成员


        public IPaginatedList GetPageCollectors()
        {
            return ExecuteQueryForPaginatedList("get_page_list", null, 1);
        }

        #endregion

        #region ICollectorDao 成员


        public IList<Collector> GetCollectorsByPage(Hashtable hashPara)
        {
            Pager page = hashPara["page"] as Pager;
            page.RecordCount = (int)ExecuteQueryForObject("loading_collector_page_count", hashPara);
            return ExecuteQueryForList<Collector>("loading_collector_page_list", hashPara);
        }

        #endregion

        #region ICollectorDao 成员

        public int CheckCollectorExists(string code)
        {
            return ExecuteQueryForObject<int>("check_collector_exists_bycode", code);
        }

        #endregion


        #region ICollectorDao 成员


        public IList<Collector> GetCollectorsByUid(int uid)
        {
            return ExecuteQueryForList<Collector>("collector_get_list_byuid", uid);
        }

        #endregion
    }
}
