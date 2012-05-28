using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 电站数据分布配置接口
    /// Author: 赵文辉
    /// Time: 2011年2月24日
    /// </summary>
    public interface IDbConfigDao:IBaseDao<Dbconfig>
    {
        /// <summary>
        /// 查询所有数据分布信息
        /// </summary>
        /// <returns>所有数据分布信息</returns>
        IList<Dbconfig> GetDbconfigs();

        /// <summary>
        /// 根据Id查询电站数据分布信息
        /// </summary>
        /// <param name="Id">电站Id</param>
        /// <returns>该电站信息</returns>
        Dbconfig GetDbconfigById(int Id);

        /// <summary>
        /// 根据Id删除电站数据分布信息
        /// </summary>
        /// <param name="id">电站Id</param>
        void Delete(int id);
    }
}
