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
using System.Threading;
using Protocol;
using Cn.Loosoft.Zhisou.SunPower.Common;
namespace DataAnalyze
{
    /// <summary>
    /// 数据解析启动程序
    /// </summary>
    class ProgramEngine
    {
        static void Main(string[] args)
        {
            //SystemCode.HexNumberToDenary("FC27", false, 16, 's');
            //启动解析线程
            TcpDataProcesser dataProcess = new TcpDataProcesser();
            Thread m_thread = new Thread(new ThreadStart(dataProcess.Processing));
            m_thread.Start();

            //启动清除过期数据线程
            //FlushProcesser flushProcess = new FlushProcesser();
            //Thread m_thread2 = new Thread(new ThreadStart(flushProcess.Processing));
            //m_thread2.Start();
            
            //启动持久化线程
            PersistentProcesser persistProcess = new PersistentProcesser();
            Thread m_thread3 = new Thread(new ThreadStart(persistProcess.Processing));
            m_thread3.Start();


            
            //DataProcess.DataProcessingEmail();

            LogUtil.info("数据解析服务启动成功！");
            string strLine;
            do
            {
                strLine = Console.ReadLine();
            } while (strLine != null && strLine != "exit");

            LogUtil.info("正在退出数据解析服务...");
            LogUtil.info("持久化剩余缓存数据...");
            //持久化尚未持久化的缓存数据后退出
            persistProcess.peristentData();
            LogUtil.info("剩余数据持久化完成...");

            //kill thread
            if (m_thread.IsAlive)
                m_thread.Abort();
            if (m_thread3.IsAlive)
                m_thread3.Abort();
        }
    }
}