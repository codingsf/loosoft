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
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Threading;
using System.IO;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Configuration;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 生成设备发电量告警线程
    /// </summary>
    public class EnergywarnProcesser
    {
        protected static string bank_url = ConfigurationSettings.AppSettings["domain"];
        /// <summary>
        /// 生成设备发电量告警线程
        /// </summary>
        public void Processing()
        {
            while (1 == 1) {
                Thread.Sleep(10 * 60 * 1000);//间隔10分钟
                //有新设备要更新bank缓存
                HttpClientUtil.requestUrl(bank_url + "/energywarn/gen");

            }
        }

    }
}
