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
    /// 清理缓存，处理过期数据
    /// </summary>
    public class FlushProcesser
    {
        
        /// <summary>
        /// 处理过期的缓存数据，避免长时间未读取的缓冲过期数据不能从缓存中移除，占用内存空间，导致在内存
        /// 不足的情况下，未持久化的数据被挤出的现象出现。
        /// </summary>
        public void Processing()
        {
            while (1 == 1)
            {
                List<string> Keys = MemcachedClientSatat.getInstance().GetAllKeys();
                foreach (string key in Keys)
                {
                    //从memcached中取得此数据，利用memcached的内在机制，当读到过期数据时，memcached会将其从缓存中移除
                    //是否内存空间
                    MemcachedClientSatat.getInstance().Get(key);
                }

                Thread.Sleep(60 * 1000);
            }
        }
    }
}
