using System;
using IBatisNet.Common.Utilities;
using IBatisNet.DataAccess;
using IBatisNet.DataAccess.Configuration;
using IBatisNet.DataAccess.Interfaces;
using IBatisNet.DataAccess.DaoSessionHandlers;
using IBatisNet.DataMapper.Configuration.Alias;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    
    public class ServiceConfig
    {
        static private object _synRoot = new Object();
        static private ServiceConfig _instance;

        private IDaoManager _daoManager = null;
        
        private ServiceConfig() { }

        static public ServiceConfig GetInstance()
        {
            if (_instance == null)
            {
                lock (_synRoot)
                {
                    if (_instance == null)
                    {
                        ConfigureHandler handler = new ConfigureHandler(ServiceConfig.Reset);
                        DomDaoManagerBuilder builder = new DomDaoManagerBuilder();
                        builder.ConfigureAndWatch("dao.config", handler);

                        _instance = new ServiceConfig();
                        // TODO:默认为sqlMapDao指定的Context, 要提供对多个Context的支持.
                        _instance._daoManager = IBatisNet.DataAccess.DaoManager.GetInstance("SqlMapDao");
                        
                    }
                }
            }
            return _instance;
        }
        
        static public void Reset(object obj)
        {
            _instance = null;
        }

        public IDaoManager DaoManager
        {
            get
            {
                return _daoManager;
            }
        }

        public IDaoManager GetDaoManager(string contextName)
        {
            return IBatisNet.DataAccess.DaoManager.GetInstance(contextName);
        }
    }
}
