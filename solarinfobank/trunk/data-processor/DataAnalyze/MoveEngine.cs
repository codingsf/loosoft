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
namespace DataAnalyze
{
    /// <summary>
    /// 数据解析移动缓存启动程序
    /// </summary>
    class MoveEngine
    {
        static void Main(string[] args)
        {
            //启动解析线程
            MoveProcesser dataProcess = new MoveProcesser();
            Thread m_thread = new Thread(new ThreadStart(dataProcess.Processing));
            m_thread.Start();

            Console.WriteLine("移动服务启动成功！");
            string strLine;
            do
            {
                strLine = Console.ReadLine();
            } while (strLine != null && strLine != "exit");

            Console.WriteLine("移动服务结束...");

            //kill thread
            if (m_thread.IsAlive)
                m_thread.Abort();


        }
    }
}