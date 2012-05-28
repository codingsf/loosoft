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
namespace DataAnalyze
{
    /// <summary>
    /// 将生产或测试环境中的消息数据放入本地缓存
    /// </summary>
    public class MoveProcesser
    {
        /// <summary>
        /// 定时从缓存中取得要持久化的数据进行定时持久化
        /// </summary>
        public void Processing()
        {
            int i = 0;
            while (i == 0)
            {
                MemcachedClientSatat remotemcs = MemcachedClientSatat.getInstance("61.191.61.220:11211");
                List<string> Keys = remotemcs.GetAllKeys();
                MemcachedClientSatat localmcs = MemcachedClientSatat.getInstance();
                //if (MemcachedClientSatatO.KeyExists("test11"))
                   // MemcachedClientSatatO.Set("test11", "1111");
                //else
                   // MemcachedClientSatatO.Add("test11", "dsf");
                //Console.WriteLine(MemcachedClientSatatO.Get("test11"));
                foreach (string key in Keys)
                {
                    if (key.StartsWith("tcp"))
                    {
                        localmcs.Set(key, remotemcs.Get(key));
                        LogUtil.info(key);
                    }
                }
                i = 1;//结束线程
            }
        }
    }
}
