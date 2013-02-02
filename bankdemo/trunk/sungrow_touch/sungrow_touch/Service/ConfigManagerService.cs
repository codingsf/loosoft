using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using sungrow_demo.model;
using System.Configuration;

namespace sungrow_demo.Service
{
    public class ConfigManagerService
    {
        private string path = ConfigurationManager.AppSettings["demo_config_file"];
        private string isDebug = ConfigurationManager.AppSettings["isDebug"];
        private static ConfigManagerService _instance = null;
        private static object locker = new object();
        private ConfigPara cpara = null;
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

        /// <summary>
        /// 加载配置西系统配置文件
        /// </summary>
        /// <returns></returns>
        public ConfigPara LoadConfig()
        {
            string tmppath = path;
            if (isDebug == null || isDebug.Equals("false"))
            {
                tmppath = System.Environment.CurrentDirectory;
            }

            //if (cpara == null)
            //{
                cpara = new ConfigPara();
                XMLHelper.DeserializerXML<ConfigPara>(tmppath + "/config.xml", ref cpara);
            //}
            return cpara;
        }
    }
}
