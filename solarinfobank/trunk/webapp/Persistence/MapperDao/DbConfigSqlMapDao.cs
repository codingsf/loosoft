using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 电站数据分布实现
    /// Author: 赵文辉
    /// Time: 2011年2月24日
    /// </summary>
    public class DbConfigSqlMapDao:BaseSqlDao<Dbconfig>,IDbConfigDao
    {
        /// <summary>
        /// 查询所有电站数据分布信息
        /// </summary>
        /// <returns>所有电站数据分布信息</returns>
        public IList<Dbconfig> GetDbconfigs()
        {
            return ExecuteQueryForList<Dbconfig>("GET_DBCONFIG", null);
        }

        /// <summary>
        /// 根据Id查询电站分布信息
        /// </summary>
        /// <param name="id">电站Id</param>
        /// <returns>电站分布信息</returns>
        public Dbconfig GetDbconfigById(int id)
        {
            return ExecuteQueryForObject<Dbconfig>("GET_DBCONFIG_BY_ID", id);
        }

        /// <summary>
        /// 根据电站Id删除电站数据分布信息
        /// </summary>
        /// <param name="Id">电站Id</param>
        public void Delete(int Id)
        {
            ExecuteDelete("dbconfig_delete", Id);
        }
    }
}
