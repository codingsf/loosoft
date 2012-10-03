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
namespace DataAnalyze
{
    /// <summary>
    /// 将生产或测试环境中的消息数据放入本地缓存
    /// </summary>
    public class MoveProcesser
    {
        private static string frommemchached = ConfigurationSettings.AppSettings["msgmemchached"];
        /// <summary>
        /// 定时从缓存中取得要持久化的数据进行定时持久化
        /// </summary>
        public void Processing()
        {
            LogUtil.info("开始迁移数据");
            while (1 == 1)
            {
                MemcachedClientSatat remotemcs = MemcachedClientSatat.getInstance(frommemchached);
                List<string> Keys = remotemcs.GetAllKeys();
                MemcachedClientSatat localmcs = MemcachedClientSatat.getInstance();
                foreach (string key in Keys)
                {
                    //判断此key是否已经被迁移过了
                    if (MemcachedClientSatat.getInstance().isAnalyzed(key))
                    {
                        LogUtil.info("message key is:" + key + " has been moved");
                        continue;
                    }

                    localmcs.Set(key, remotemcs.Get(key));
                    
                    IList<string> analyzedKeys = (List<string>)MemcachedClientSatat.getInstance().Get(MemcachedClientSatat.analyzedkey);
                    MemcachedClientSatat.getInstance(TcpDataProcesser.msgmemchached).deleteAnalyzed(key, analyzedKeys);
                    MemcachedClientSatat.getInstance().remember(key);
                }
                Thread.Sleep(5000);
            }
        }
    }
}
