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
        static string logpath = System.Environment.CurrentDirectory;
        public static void debug(string msg) {
            msg = "[debug]" + DateTime.Now.ToString("MMdd hh:mm:ss") + "__" + msg;
            if ("info".Equals(logLevel) || "debug".Equals(logLevel)) {
                FileUtil.WriteLine(logpath, getlogFilename(), msg);
            }
        }

        public static void info(string msg)
        {
            msg = "[info]" + DateTime.Now.ToString("MMdd hh:mm:ss") + "__" + msg;
            if ("info".Equals(logLevel))
            {
                FileUtil.WriteLine(logpath, getlogFilename(), msg);
            }
        }

        public static void warn(string msg)
        {
            msg = "[warn]s" + DateTime.Now.ToString("MMdd hh:mm:ss") + "__" + msg;
            if ("info".Equals(logLevel) || "debug".Equals(logLevel) || "warn".Equals(logLevel))
            {
                FileUtil.WriteLine(logpath, getlogFilename(), msg);
            }
        }

        public static void error(string msg)
        {
            msg = "[error]" + DateTime.Now.ToString("MMdd hh:mm:ss") + "__" + msg;
            if ("info".Equals(logLevel) || "debug".Equals(logLevel) || "warn".Equals(logLevel) || "error".Equals(logLevel))
            {
                FileUtil.WriteLine(logpath, getlogFilename(), msg);
            }
        }

        public static string getlogFilename() {
            return "log_demo_" + DateTime.Now.ToString("MMddhh")+".txt";
        }
    }
}
