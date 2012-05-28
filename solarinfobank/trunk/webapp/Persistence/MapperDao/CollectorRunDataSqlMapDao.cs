using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 作者：陈波
    /// 功能：电站运行时数据接口实现
    /// 创建时间：2011-02-25
    /// </summary>
    public class CollectorRunDataSqlMapDao : BaseSqlDao<CollectorRunData>, ICollectorRunDataDao
    {

        public float GetAllDayEnergy(string yyyyMMdd)
        {
            return (float)ExecuteQueryForObject("collectorrundata_get_dayenergy", yyyyMMdd);
        }

        public float GetAllPower(string yyyyMMdd)
        {
            return (float)ExecuteQueryForObject("collectorrundata_get_power", yyyyMMdd);
        }
    }
}
