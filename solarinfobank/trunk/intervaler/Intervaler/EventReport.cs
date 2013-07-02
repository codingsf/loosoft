using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Threading;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Intervaler
{
    public class EventReport
    {
        private static IList<ReportConfig> eventConfigs = new List<ReportConfig>();
        private static DateTime lastModified = DateTime.Now;
        private const int cacheHour = 3;
        private const int logLength = 50;
        IntervalFaultService faultService = IntervalFaultService.GetInstance();

        /// <summary>
        /// 初始化时间报表配置列表
        /// </summary>
        private void Init()
        {

            if (eventConfigs.Count <= 0 || (DateTime.Now - lastModified).TotalHours > cacheHour)
            {
                lastModified = DateTime.Now;
                eventConfigs.Clear();
                eventConfigs = ReportConfigService.GetInstance().GetEventReportConfigs();
               // Console.WriteLine(eventConfigs.Count);

            }
        }


      
        private void UpdataLastModified(ReportConfig config)
        {
            ReportConfigService.GetInstance().UpdateReportConfig(config);
        }

        /// <summary>
        /// 更新事件报告最后一次发送时间
        /// </summary>
        /// <param name="config"></param>
        private void UPdateReportLastSendTime(ReportConfig config)
        {
            ReportConfigService.GetInstance().UPdateReportLastSendTime(config);
        }

        private IList<Fault> LoadEventLogs(int pid, DateTime lastModified)
        {
            return faultService.GetEventReportLogs(PidToCids(pid), lastModified);
        }

        /// <summary>
        /// 电站ID获取电站下所有采集器ID
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        private string PidToCids(int pid)
        {
            string str = string.Empty;
            IList<PlantUnit> units = PlantUnitService.GetInstance().GetAllPlantUnitsByPlantId(pid);
            foreach (PlantUnit unit in units)
            {
                str += string.Format("{0},", unit.collectorID);
            }
            return str = str.Length > 1 ? str.Substring(0, str.Length - 1) : "-1";
        }

        private object[] BulidContent(string plantName, IEnumerable<Fault> faults, string format)
        {
            object[] resArr = new object[2];
            StringBuilder sb = new StringBuilder();
            DateTime lastModified = DateTime.MinValue;
            try
            {
                IOrderedEnumerable<Fault> sortFault = faults.OrderBy(m => m.sendTime);
                switch (format.ToLower())
                {
                    case "html":
                    case "txt":
                        foreach (Fault fault in sortFault)
                        {
                            if(lastModified<fault.sendTime)
                                lastModified = fault.sendTime;
                            if (string.IsNullOrEmpty(plantName) || string.IsNullOrEmpty(fault.deviceName)
                                || string.IsNullOrEmpty(fault.errorTypeName) || string.IsNullOrEmpty(fault.content))
                                continue;
                            sb.AppendFormat("{0}&nbsp;{1}&nbsp;{2}&nbsp;{3}&nbsp; <br />", plantName+"-"+fault.deviceName, fault.sendTime.ToString("yyyy-MM-dd HH:mm:ss"), fault.errorTypeName, fault.content);
                        }
                        break;
                    default:
                        break;
                }
            }
            catch (Exception e) {
                Console.WriteLine("buildConent error:"+e.Message);
            }
            resArr[0] = sb.ToString();
            resArr[1] = lastModified; 
            return resArr;
        }

        private bool Save(EmailQueue queue)
        {
            return EmailQueueService.GetInstance().Save(queue);
        }

        public void Run()
        {
            Init();
            IList<Fault> faults = null;
            foreach (ReportConfig config in eventConfigs)
            {
                if (string.IsNullOrEmpty(config.email)) {
                    Console.WriteLine("event report email is empty!");
                    continue;
                }
                //if ((DateTime.Now - config.lastSendTime).TotalMinutes < 30)
                //    continue;
                Plant plant = PlantService.GetInstance().GetPlantInfoById(config.plantId);
                if (plant == null)
                    continue;
                Console.WriteLine("start handle event report of "+plant.name+" last send time is :"+config.lastSendTime);
                faults = LoadEventLogs(config.plantId, config.lastSendTime);
                //Console.WriteLine("fault count is :"+faults.Count);
                //if (faults == null || faults.Count < logLength)
                if (faults == null || faults.Count == 0)
                    continue;
                string lang = "en-us";
                User user = UserService.GetInstance().Get(int.Parse(config.sendMode));
                if (user!=null&&user.Language != null && string.IsNullOrEmpty(user.Language.codename) == false)
                {
                    lang = user.Language.codename.ToLower();
                }
                Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(lang);

                int count=faults.Count;
                int index = 0;
                Console.WriteLine("start handle " + faults.Count+" fault");
                while (true)
                {
                    IList<Fault> temp = null;
                    if (count >= logLength * (index + 1))
                    {
                        temp = faults.Skip((index * logLength)).Take(logLength).ToList<Fault>();
                        index++;
                        //Console.WriteLine("count >50 ");
                    }
                    else
                    {
                        temp = faults.Skip(index * logLength).Take((count % logLength)).ToList<Fault>();
                       // Console.WriteLine("get  "+temp.Count+" record");
                    }
                    EmailQueue queue = new EmailQueue();
                    object[] resArr = BulidContent(plant.name, temp, config.sendFormat == null ? "html" : config.sendFormat);
                    queue.content = (string)resArr[0];

                    if (string.IsNullOrEmpty(queue.content)) {
                        //Console.WriteLine("queue.content is empty ");
                        continue;
                    }
                    //Console.WriteLine("put .content into queue ");
                    queue.receiver = config.email;
                    queue.state = 0;
                    queue.title = plant.name + " event report " + CalenderUtil.formatDate(DateTime.Now, "yyyy-MM-dd");
                    queue.sender = "admin@suninfobank.com";
                    if (Save(queue))
                    {
                        Console.WriteLine(string.Format("a event report has been created {0}", DateTime.Now));
                    }
                    else
                    {
                        Console.WriteLine("fail insert");
                    }
                    config.lastSendTime = (DateTime)resArr[1];
                    Thread.Sleep(1000);
                    if(faults.Last().id.Equals(temp.Last().id))
                    {
                        UPdateReportLastSendTime (config);
                        break;
                    }
                }
            }
        }
    }
}
