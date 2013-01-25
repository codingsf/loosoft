using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using sungrow_demo.model;

namespace sungrow_demo.Service
{
    public class ConfigManagerService
    {
        private static ConfigManagerService _instance = null;
        private static object locker = new object();
        private ConfigManagerService()
        {

        }

        public static ConfigManagerService GetInstance()
        {
            if (_instance == null)
            {
                lock (locker)
                {
                    if (_instance == null)
                    {
                        _instance = new ConfigManagerService();
                    }
                }
            }
            return _instance;
        }

        public ConfigPara LoadConfig()
        {
            ConfigPara cpara = new ConfigPara();
            XMLHelper.DeserializerXML<ConfigPara>("config.xml", ref cpara);
            return cpara;
        }

    }
}
