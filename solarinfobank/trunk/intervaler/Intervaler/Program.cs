using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Timers;
using System.Text.RegularExpressions;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.IO;

namespace Intervaler
{
    class Program
    {

        private static Timer reportTimer = new Timer(5000);
        private static Timer eventTimer = new Timer(5000);
        private static Timer deviceSenderTimer = new Timer(5000);

        static void Main(string[] args)
        {
            //先设置当前工作目录为进程目录
            Console.WriteLine("原工作目录：" + Directory.GetCurrentDirectory());
            Directory.SetCurrentDirectory(Path.GetDirectoryName(System.Diagnostics.Process.GetCurrentProcess().MainModule.FileName));
            Console.WriteLine("现在工作目录：" + Directory.GetCurrentDirectory());

            Console.WriteLine("starting ... ");
            RunReport runReport = new RunReport();
            EventReport eventReport = new EventReport();
            DeviceWarningSender warningSender = new DeviceWarningSender();
            reportTimer.Elapsed += delegate(Object source, System.Timers.ElapsedEventArgs e)
            {
                reportTimer.Enabled = false;
                runReport.Run();
                reportTimer.Enabled = true;
            };

            eventTimer.Elapsed += delegate(Object source, System.Timers.ElapsedEventArgs e)
            {
                eventTimer.Enabled = false;
                eventReport.Run();
                eventTimer.Enabled = true;
            };

            deviceSenderTimer.Elapsed += delegate(Object source, System.Timers.ElapsedEventArgs e)
            {
                deviceSenderTimer.Enabled = false;
                warningSender.Run();
                deviceSenderTimer.Enabled = true;
            };

            reportTimer.AutoReset = true;
            reportTimer.Enabled = true;
            eventTimer.AutoReset = true;
            eventTimer.Enabled = true;
            deviceSenderTimer.AutoReset = true;
            deviceSenderTimer.Enabled = true;
            Console.WriteLine("started ! ");
            Console.Clear();
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("runing...");
            while (!Console.ReadLine().Equals("exit"))
                Console.ReadLine();

        }
    }
}
