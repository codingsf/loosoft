using System;
using System.Collections;
using System.ServiceProcess;
using System.Diagnostics;
using System.DirectoryServices;
using System.Net;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 系统工具
    /// </summary>
    public class SystemUtil
    {
        /// <summary>
        /// 开始指定服务
        /// </summary>
        /// <param name="serviceName"></param>
        /// <param name="timeoutMilliseconds"></param>
        /// <returns></returns>
        public static bool StartService(string serviceName, int timeoutMilliseconds)
        {
            ServiceController service = new ServiceController(serviceName);
            try
            {
                TimeSpan timeout = TimeSpan.FromMilliseconds(timeoutMilliseconds);
                service.Start();
                service.WaitForStatus(ServiceControllerStatus.Running, timeout);
            }
            catch
            {
                return false;
            }
            return true;
        }
        /// <summary>
        /// 停止制定服务
        /// </summary>
        /// <param name="serviceName"></param>
        /// <param name="timeoutMilliseconds"></param>
        /// <returns></returns>
        public static bool StopService(string serviceName, int timeoutMilliseconds)
        {
            ServiceController service = new ServiceController(serviceName);
            try
            {
                TimeSpan timeout = TimeSpan.FromMilliseconds(timeoutMilliseconds);
                service.Stop();
                service.WaitForStatus(ServiceControllerStatus.Stopped, timeout);
            }
            catch
            {
                return false;
            }
            return true;
        }
        /// <summary>
        /// 判断是否存在同名进程
        /// </summary>
        /// <param name="processName"></param>
        /// <returns></returns>
        public static bool existProcess(string processName)
        {
            try
            {
                System.Diagnostics.Process[] myProcesses = System.Diagnostics.Process.GetProcesses();

                string tmpname = "";
                foreach (System.Diagnostics.Process myProcess in myProcesses)
                {
                    tmpname = myProcess.ProcessName;
                    if (tmpname.Contains(".")) {
                        tmpname = tmpname.Substring(0, tmpname.IndexOf("."));
                    }
                    if (processName.Equals(tmpname))
                        return true;
                }
                return false;
            }
            catch (Exception e)
            {
                return false;
            }
        }


        /// <summary>
        /// 杀进程
        /// </summary>
        /// <param name="processName"></param>
        /// <returns></returns>
        public static bool killProcess(string processName)
        {
            try
            {
                System.Diagnostics.Process[] myProcesses = System.Diagnostics.Process.GetProcesses();

                foreach (System.Diagnostics.Process myProcess in myProcesses)
                {
                    if (processName.Equals(myProcess.ProcessName))
                        myProcess.Kill();
                }
                return true;
            }
            catch (Exception e) {
                return false;
            }
        }

        public static bool startProcess(string processPath, string processName)
        {
            try
            {
                ProcessStartInfo info = new ProcessStartInfo();
                info.FileName = @processPath;
                info.Arguments = "";
                info.WindowStyle = ProcessWindowStyle.Minimized;
                Process pro = Process.Start(info);
                pro.WaitForExit(3000);
                return existProcess(processName) ;
            }
            catch (Exception e) {
                return false;
            }
        }
        /// <summary>
        /// 停止iis应用池
        /// </summary>
        /// <param name="poolname">池名称</param>
        /// <returns></returns>
        public static bool stopApppool(string poolname) {
            return setApppool(poolname, "Stop");
        }

        /// <summary>
        /// 启动iis应用池
        /// </summary>
        /// <param name="poolname">池名称</param>
        /// <returns></returns>
        public static bool startApppool(string poolname) {
            return setApppool(poolname, "Start");
        }

        private static bool setApppool(string poolname,string cmd)
        {
            try
            {
                DirectoryEntry appPool = new DirectoryEntry("IIS://localhost/W3SVC/AppPools");
                DirectoryEntry findPool = appPool.Children.Find(poolname, "IIsApplicationPool");
                findPool.Invoke(cmd, null); // Start|Stop|Recycle [Recycle:应用程序池回收，如果状态为Stop会报错]
                appPool.CommitChanges();
                appPool.Close();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        /// <summary>
        /// 取得web响应时间
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static int getWebResponseTime(string url)  { 
            DateTime start_time = DateTime.Now;
            try
            {
                HttpWebRequest webrequest = (HttpWebRequest)HttpWebRequest.Create(url);
                HttpWebResponse webresponse = (HttpWebResponse)webrequest.GetResponse();
                if (webresponse.StatusCode == HttpStatusCode.OK)
                {
                    DateTime end_time = DateTime.Now;
                    TimeSpan ts = end_time - start_time;
                    int ch = (int)ts.TotalMilliseconds;//响应时间.(毫秒)
                    return ch;
                }
                else {
                    throw new Exception("页面请求错误,请检查网络或者web应用");
                }
            }
            catch (Exception e) {
                throw new Exception("页面请求错误,请检查网络或者web应用" + e.Message);
            }
        }


    }
}
