/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年2月16日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Threading;
using System.Reflection;
using System.Configuration;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 数据解析处理体
    /// </summary>
    public class LogUtil
    {
        private static string INFO = "info";
        private static string WARN = "warn";
        private static string ERROR = "error";

        static string loglevel = ConfigurationSettings.AppSettings["log.level"];
        /// <summary>
        /// 记录info日志
        /// </summary>
        /// <param name="message"></param>
        public static void info(string message)
        {
            if (loglevel.Equals(INFO))
                Console.WriteLine(Thread.CurrentThread.Name + ":" + message);
        }

        /// <summary>
        /// 记录info日志
        /// </summary>
        /// <param name="message"></param>
        public static void warn(string message)
        {
            if (loglevel.Equals(INFO) || loglevel.Equals(WARN))
                Console.WriteLine(Thread.CurrentThread.Name + ":" + message);
        }

        /// <summary>
        /// 记录info日志
        /// </summary>
        /// <param name="message"></param>
        public static void error(string message)
        {
            if (loglevel.Equals(INFO) || loglevel.Equals(WARN) || loglevel.Equals(ERROR))
                Console.WriteLine(Thread.CurrentThread.Name + ":" + message);
        }
        /// <summary>
        /// 固定输出日志
        /// </summary>
        /// <param name="message"></param>
        public static void writeline(string message)
        {
            Console.WriteLine(Thread.CurrentThread.Name + ":" + message);
        }
    }
}
