using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class MonitorConfigService
    {
        private static MonitorConfigService _instance = new MonitorConfigService();
        private IDaoManager _daoManager = null;
        private IMonitorConfigDao _mconfigDao = null;

        /// <summary>
        /// 创建一个不带参的构造函数
        /// </summary>
        private MonitorConfigService()
        {
            //获取采集器接口
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _mconfigDao = _daoManager.GetDao(typeof(IMonitorConfigDao)) as IMonitorConfigDao;
        }

        /// <summary>
        /// 创建电站数据分布服务
        /// </summary>
        /// <returns>服务对象</returns>
        public static MonitorConfigService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new MonitorConfigService();
            }
            return _instance;
        }


        public int Save(MonitorConfig config)
        {
            if (config.id > 0)
                return _mconfigDao.Update(config);
            return _mconfigDao.Insert(config);
        }

        public int Remove(MonitorConfig config)
        {
            return _mconfigDao.Remove(config);
        }

        public MonitorConfig Get(int code)
        {
            return _mconfigDao.Get(new MonitorConfig() { code=code });
        }
    }
}
