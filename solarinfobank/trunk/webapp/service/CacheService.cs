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
    /// 缓存业务类
    /// </summary>
    public class CacheService
    {
        private static CacheService _instance = new CacheService();
        private IDaoManager _daoManager = null;
        private ICacheDao _CacheDao = null;

        private CacheService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _CacheDao = _daoManager.GetDao(typeof(ICacheDao)) as ICacheDao;
        }

        public static CacheService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 手工更新设备缓存
        /// </summary>
        public void flushCaches()
        {
            _CacheDao.flushCache();
        }
    }
}
