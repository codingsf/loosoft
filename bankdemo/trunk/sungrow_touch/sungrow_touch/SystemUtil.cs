using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;

namespace sungrow_demo
{
    class SystemUtil
    {
        /// <summary>
        /// 根据进程名杀死进程
        /// </summary>
        /// <param name="processName"></param>
        public static void KillProcess(string processName)
        {
            System.Diagnostics.Process myproc = new System.Diagnostics.Process();
            //得到所有打开的进程
            try
            {
                foreach (Process thisproc in Process.GetProcessesByName(processName))
                //循环查找
                {
                    //if (!thisproc.CloseMainWindow())
                    //{
                    thisproc.Kill();
                    //}
                }
            }
            catch
            {

            }

        }

        /// <summary>
        /// 根据进程名判断进程是否存在
        /// </summary>
        /// <param name="processName"></param>
        public static bool existProcess(string processName)
        {
            System.Diagnostics.Process myproc = new System.Diagnostics.Process();
            //得到所有打开的进程
            try
            {
                foreach (Process thisproc in Process.GetProcessesByName(processName))
                //循环查找
                {
                    return true;
                }
            }
            catch
            {
                return false;
            }
            return false;
        }

    }
}
