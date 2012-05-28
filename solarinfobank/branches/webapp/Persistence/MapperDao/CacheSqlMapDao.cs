using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;

using Cn.Loosoft.Zhisou.SunPower.Domain;
using IBatisNet.DataMapper;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// ibatis缓存数据库操作
    /// </summary>
    public class CacheSqlMapDao : BaseSqlMapDao, ICacheDao
    {
        /// <summary>
        /// 手工更新设备缓存
        /// </summary>
        public void flushCache() {
            ISqlMapper sqlMap = GetLocalSqlMap();
            sqlMap.FlushCaches();
        }
    }
}
