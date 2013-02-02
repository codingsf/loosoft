/*******************************
/* 项目：数据上传模块
 * 将富士康深圳的数据按照给定接口传到无锡接收服务
 * 上传协议为http
/* 版本：1.0                           
/* 作者：陈波                 
/* 日期：2012年12月14日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Configuration;
using System.Diagnostics;

namespace Updata
{
    /// <summary>
    /// 主启动程序
    /// </summary>
    class ProgramEngine
    {
        static void Main(string[] args)
        {
            
            //启动持久化线程
            UpProcesser upProcess = new UpProcesser();
            Thread m_thread = new Thread(new ThreadStart(upProcess.Processing));
            m_thread.Start();
        }
        
    }

}