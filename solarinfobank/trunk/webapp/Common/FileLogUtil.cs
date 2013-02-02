using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class FileLogUtil
    {
        static string logLevel = ConfigurationSettings.AppSettings["log.level"];
        static string logpath = System.Environment.CurrentDirectory+"/logs";
        public static void debug(string msg) {
            try
            {
                msg = "[debug]" + DateTime.Now.ToString("MMdd HH:mm:ss") + "__" + msg;
                if ("info".Equals(logLevel) || "debug".Equals(logLevel))
                {
                    FileUtil.WriteLine(logpath, getlogFilename(), msg);
                }
            }
            catch (Exception ee) {
                Console.WriteLine(ee.Message);
            }
        }

        public static void info(string msg)
        {
            try
            {
                msg = "[info]" + DateTime.Now.ToString("MMdd HH:mm:ss") + "__" + msg;
                FileUtil.WriteLine(logpath, getlogFilename(), msg);
            }
            catch (Exception ee) {
                Console.WriteLine(ee.Message);
            }
        }

        public static void warn(string msg)
        {
            try
            {
                msg = "[warn]" + DateTime.Now.ToString("MMdd HH:mm:ss") + "__" + msg;
                if ("info".Equals(logLevel) || "debug".Equals(logLevel) || "warn".Equals(logLevel))
                {
                    FileUtil.WriteLine(logpath, getlogFilename(), msg);
                }
            }
            catch (Exception ee) {
                Console.WriteLine(ee.Message);
            }
        }

        public static void error(string msg)
        {
            try
            {
                msg = "[error]" + DateTime.Now.ToString("MMdd HH:mm:ss") + "__" + msg;
                if ("info".Equals(logLevel) || "debug".Equals(logLevel) || "warn".Equals(logLevel) || "error".Equals(logLevel))
                {
                    FileUtil.WriteLine(logpath, getlogFilename(), msg);
                }
            }
            catch (Exception ee) {
                Console.WriteLine(ee.Message);
            }
        }

        public static string getlogFilename() {
            return "log_" + DateTime.Now.ToString("MMddHH")+".txt";
        }
    }
}
