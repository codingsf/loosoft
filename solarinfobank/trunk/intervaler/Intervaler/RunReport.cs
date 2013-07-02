using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml.Serialization;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Threading;
using System.Net;

namespace Intervaler
{
    public class RunReport
    {
        ReportService reportService = ReportService.GetInstance();
        private static IList<DefineReport> normalReport = new List<DefineReport>();
        private const int cacheMinutes = 5;
        private static DateTime lastModified;
        private readonly string domainUrl = System.Configuration.ConfigurationSettings.AppSettings["url"];
        /// <summary>
        /// 获取所有定义报表
        /// </summary>
        private void InitData()
        {
            if (normalReport.Count == 0 || (DateTime.Now - lastModified).TotalMinutes > cacheMinutes)
            {
                lastModified = DateTime.Now;
                normalReport.Clear();
                IList<DefineReport> defineReports = reportService.GetAllReportsList();
                foreach (DefineReport report in defineReports)
                {
                    if (report.config != null)
                    {
                        normalReport.Add(report);
                    }
                }
            }
        }

        public void Run()
        {
            InitData();
            foreach (DefineReport report in normalReport)
            {
                if (string.IsNullOrEmpty(report.config.email))
                    continue;
                if (string.IsNullOrEmpty(report.config.sendMode))
                    continue;
                bool isSuccess = false;
                switch (report.config.sendMode.ToLower())//报告发送模式 1循环 2定时
                {
                    case "1":
                        Console.WriteLine("处理模式1运行时报告" + report.config.id);
                        if ((DateTime.Now - report.config.lastSendTime).TotalHours > Convert.ToDouble(report.config.tinterval))
                        {
                            report.config.lastSendTime = DateTime.Now.AddSeconds(0 - DateTime.Now.Second);
                            isSuccess = true;
                        }
                        Console.WriteLine("处理模式1运行时报告,isSuccess is " + isSuccess);
                        break;
                    case "2":
                        string[] para = new string[6];
                        string[] t = null;
                        t = report.config.fixedTime.Split(',');
                        switch (report.ReportType)
                        {
                            case 1://日报表
                                para[3] = t[0];
                                para[4] = t[1];
                                break;
                            case 2://周报表
                                para[5] = t[0];
                                para[3] = t[1];
                                break;
                            case 3://月报表
                                para[2] = t[0];
                                para[3] = t[1];
                                break;
                            case 4://年报表
                            case 5:
                                para[1] = t[0];
                                para[2] = t[1];
                                para[3] = t[2];
                                break;
                            default:
                                break;
                        }
                        if (para == null || para.Length < 6)
                            para = new string[6];
                        DateTime update = DateTime.Now;
                        Console.WriteLine("处理模式2运行时报告" + report.config.id);
                        if (Tool.DateEquals(para[0], para[1], para[2], para[3], para[4], para[5], report.config.lastSendTime, report.ReportType, ref update))
                        {
                            report.config.lastSendTime = update;
                            isSuccess = true;
                        }
                        Console.WriteLine("处理模式2运行时报告,isSuccess is " + isSuccess);
                        break;
                }
                if (isSuccess)
                {

                    string culture = "en-us";
                    if (report.user == null)
                    {
                        Plant plant = PlantService.GetInstance().GetPlantInfoById(report.PlantId);
                        if (plant != null)
                            report.user = UserService.GetInstance().Get(Convert.ToInt32(plant.userID));
                    }
                    if (report.user != null && report.user.Language != null && (string.IsNullOrEmpty(report.user.Language.codename) == false))
                        culture = report.user.Language.codename;

                    string url = string.Format("{5}/reports/viewreport?rId={0}&cTime={1}&tId={2}&pId={3}&type=email&lang={4}", report.Id, DateTime.Now.ToString("yyyy-MM-dd"), report.ReportType, report.config.plantId == 0 ? "" : report.config.plantId.ToString(), culture.ToLower(), domainUrl);
                    string html = Tool.LoadContent(url, culture);
                    EmailQueue queue = new EmailQueue();
                    queue.title = report.ReportName;
                    queue.content = html;
                    if (string.IsNullOrEmpty(queue.content)) continue;
                    queue.receiver = report.config.email;
                    queue.state = 0;
                    queue.sender = "admin@suninfobank.com";
                    EmailQueueService.GetInstance().Save(queue);
                    ReportConfigService.GetInstance().UPdateReportLastSendTime(report.config);//更新最后发送时间
                    Console.WriteLine(string.Format("{0}-({1})-{2}", url, report.ReportName, DateTime.Now));
                }
            }
        }

    }
}
