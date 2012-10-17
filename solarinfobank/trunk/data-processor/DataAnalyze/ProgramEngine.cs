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
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Configuration;
using System.Diagnostics;
using SolarInfoBase;
//using SolarInfoBase;

namespace DataAnalyze
{
    /// <summary>
    /// 数据解析启动程序
    /// </summary>
    class ProgramEngine
    {
        static void Main(string[] args)
        {
            //从后台维护数据表中设置错误码静态数据
            ErrorcodeService.GetInstance().setErrorStaticData();

            string validdog = ConfigurationSettings.AppSettings["validdog"];//是否验证狗
            //启动解析线程
            TcpDataProcesser dataProcess = new TcpDataProcesser();
            Thread m_thread = new Thread(new ThreadStart(dataProcess.Processing));
            m_thread.Start();

            
            //启动持久化线程
            PersistentProcesser persistProcess = new PersistentProcesser();
            Thread m_thread3 = new Thread(new ThreadStart(persistProcess.Processing));
            m_thread3.Start();

            //启动发电量告警线程
            string energywarn = ConfigurationSettings.AppSettings["energywarn"];//是否启动发电量告警生成
            Thread m_thread4 = null;
            if (energywarn == null || energywarn.Equals("true"))
            {
                EnergywarnProcesser energywarnProcesser = new EnergywarnProcesser();
                m_thread4 = new Thread(new ThreadStart(energywarnProcesser.Processing));
                m_thread4.Start();
            }

            LogUtil.info("服务启动成功！");

            //解析程序自启动部分
            string restart_interval = ConfigurationSettings.AppSettings["restart_interval"];
            int interval = string.IsNullOrEmpty(restart_interval) ? 60 : int.Parse(restart_interval);//默认60分钟
            int tmpinterval = 0;
            while (1==1)
            {
                tmpinterval++;
                if (tmpinterval >= interval)
                {
                    Process process = System.Diagnostics.Process.GetCurrentProcess();
                    System.Diagnostics.Process.Start(System.Reflection.Assembly.GetExecutingAssembly().Location);  //重新开启当前程序
                    process.Kill();
                }

                //循环狗检测程序，这个就要求必须将狗一直插入才能正常运行软件
                if (validdog == null || validdog.Equals("true"))
                {
                    LogUtil.info("开始检测加密狗");
                    string result = monitordog();
                    if (!string.IsNullOrEmpty(result))
                    {
                        LogUtil.info(result);

                        //kill thread
                        if (dataProcess!=null)
                            dataProcess.runmark = false;

                        if (m_thread!=null)
                            if (m_thread.IsAlive)
                                m_thread.Abort();

                        if (persistProcess != null)
                            persistProcess.runmark = false;

                        if (m_thread3 != null)
                            if (m_thread3.IsAlive)
                                m_thread3.Abort();

                        if (m_thread4 != null)
                            if (m_thread4!=null && m_thread4.IsAlive)
                                m_thread4.Abort();

                        LogUtil.info("软件已经停止服务！");
                    }
                }
                Thread.Sleep(60*1000);//线程休息1分钟
            }
        }
        


        /// <summary>
        /// 检测狗
        /// </summary>
        private static string monitordog()
        {
            String pwd = "1111111111111111";//软件狗密钥，每套软件不一样，用词制作对应软件的狗
            string result = "请插入加密狗，没有狗请联系软件提供商！";
            SoftKeyManager obj = SoftKeyManagerSelector.getSoftKeyObj(pwd);
            obj.MonitorDog();
            if (obj.HasSoftKEY == false)
            {
                result = "请插入加密狗，没有狗请联系软件提供商！";
                //MessageBox.Show("无狗");
                if (obj.DeadDays <= 0)
                {
                    result = "软件已经到期，请联系软件提供商！";
                    //MessageBox.Show("到期¨²");
                }
            }
            //obj.Dispose();
            return result;
        }
    }

}