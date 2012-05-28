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
using Protocol;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Threading;
using System.IO;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Configuration;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace DataAnalyze
{
    /// <summary>
    /// 数据持久化处理器
    /// 废弃
    /// </summary>
    public class MemcacheProcesser
    {
        //持久化间隔分钟
        static int cache_interval = ConfigurationSettings.AppSettings["cache_interval"] == null ? 60 : int.Parse(ConfigurationSettings.AppSettings["cache_interval"]);
        //每一批次解析后的批处理
        public static IList<DeviceDataCount> collectorDataCounts = new List<DeviceDataCount>();
        public static IDictionary<string, double> deviceEnergyMap = new Dictionary<string, double>();
        public static IDictionary<string, double> collectorEnergyMap = new Dictionary<string, double>();
        /// <summary>
        /// 定时从缓存中取得要持久化的数据进行定时持久化
        /// </summary>
        public void Processing()
        {
            Console.WriteLine("启动Memcached缓存线程");
            while (1 == 1)
            {
                Thread.Sleep(cache_interval * 60 * 1000);
                //持久化数据
                lastHandle();
            }
        }

        /// <summary>
        /// 每一批次的最后处理
        /// </summary>
        private void lastHandle()
        {
            Console.WriteLine("开始缓存数据到Memcached");
            DateTime curdt = DateTime.Now;
            DateTime totaldt = DateTime.Now;
            //将内存中得数据放入缓存
            CacheHandler.CacheData();
            //最后批处理采集器最大值
            try
            {
                IList<DeviceDataCount> tmpList = collectorDataCounts.ToList() ;
                collectorDataCounts.Clear();
                DeviceDataCountService.GetInstance().CacheCollectorCount(tmpList);
            }
            catch (Exception ddccache)
            {
                LogUtil.error("CacheCollectorCount异常：" + ddccache.Message);
            }
            //最后处理发电量统计
            try
            {
                CacheHandler.CacheCountData(deviceEnergyMap, collectorEnergyMap);

            }
            catch (Exception ddccache)
            {
                LogUtil.error("CacheCollectorCount异常：" + ddccache.Message);
            }
            LogUtil.writeline("缓存到memcache处理用时：" + (DateTime.Now.Subtract(curdt).TotalSeconds) + "秒，统计：待处理数量" + AnalyzeCount.curWaittotal + ",总共处理：" + AnalyzeCount.curtotal + ",成功：" + AnalyzeCount.curSuccessNum + ",失败：" + AnalyzeCount.curFailNum + ",最近数据发送时间：" + AnalyzeCount.lasttime.ToString("yyyy-MM-dd HH:mm:ss"));
        }
    }
}
