using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Intervaler
{
    public class DeviceWarningSender
    {


        PlantService plantService = PlantService.GetInstance();
        IntervalFaultService faultService = IntervalFaultService.GetInstance();
        private static IList<Plant> allPlants = null;
        private const int cacheMinutes = 30;
        private static DateTime lastModified;
        private readonly string domainUrl = System.Configuration.ConfigurationSettings.AppSettings["url"];
        /// <summary>
        /// 获取所有电站
        /// </summary>
        private void InitData()
        {
            if (allPlants == null || allPlants.Count == 0 || (DateTime.Now - lastModified).TotalMinutes > cacheMinutes)
            {
                lastModified = DateTime.Now;
                if (allPlants != null)
                    allPlants.Clear();
                allPlants = plantService.GetPlantInfoList();
            }
            Console.WriteLine("loading plant successed " + allPlants.Count);
        }

        public void Run()
        {
            try
            {
                InitData();
                Hashtable table = new Hashtable();
                string inforank = ErrorType.ERROR_TYPE_INFORMATRION + "," + ErrorType.ERROR_TYPE_FAULT + "," + ErrorType.ERROR_TYPE_ERROR + "," + ErrorType.ERROR_TYPE_WARN;
                DateTime endTime = DateTime.Now.AddDays(1);//结束时间
                DateTime startTime = DateTime.Now.AddDays(-1);//开始时间
                Pager page = new Pager() { PageIndex = 1, PageSize = 50 };

                Fault fault = new Fault() { sendTime = startTime, confirmed = "1,0", inforank = inforank };
                table.Add("page", page);
                table.Add("fault", fault);
                table.Add("endTime", endTime);
                table.Add("fromview", true);
                if (allPlants != null && allPlants.Count > 0)

                    foreach (Plant plant in allPlants)
                    {
                        if (plant.plantUnits == null || plant.plantUnits.Count == 0 || plant.hasFaultDevice == false)
                            continue;
                        string collectorString = string.Empty;

                        foreach (PlantUnit unit in plant.plantUnits)
                        {
                            if (unit.collector == null)
                                continue;
                            collectorString += string.Format("{0},", unit.collector.id);//电站下所有采集器
                        }
                        if (collectorString.Length > 1)
                            collectorString = collectorString.Substring(0, collectorString.Length - 1);
                        if (string.IsNullOrEmpty(collectorString)) continue;
                        fault.collectorString = collectorString;
                        IList<Fault> plantFaults = null;
                        try
                        {
                            plantFaults = faultService.GetPlantLoglist(table);//查询时间是倒序排列 
                            if (plantFaults.Count == 0)
                            {
                                ConsoleColor color = Console.ForegroundColor;
                                Console.ForegroundColor = ConsoleColor.Blue;
                                Console.WriteLine(string.Format("there was no fault msg in the plant of {0}", plant.name));
                                Console.ForegroundColor = color;

                            }
                        }
                        catch
                        {
                            throw;
                        }
                        if (plantFaults != null && plantFaults.Count > 0)
                            if (plantFaults[0].sendTime > plant.waringLastSendTime)
                            {
                                User user = UserService.GetInstance().Get((int)plant.userID);
                                if (user != null)
                                {
                                    string lang = "en-us";
                                    if (user.Language != null)
                                        lang = user.Language.codename;
                                    SendWarningHtml(lang, plant.id, plant.name, user.email, user.id);
                                    //更新最后发送时间
                                    plantService.UpdataWarningLastSendTime(plant.id, DateTime.Now);
                                    plant.waringLastSendTime = DateTime.Now;
                                    ConsoleColor color = Console.ForegroundColor;
                                    Console.ForegroundColor = ConsoleColor.Blue;
                                    Console.WriteLine(string.Format("warning device list of plant {0} sent success", plant.name));
                                    Console.ForegroundColor = color;
                                }
                            }
                    }
            }
            catch (Exception e )
            {
                Console.WriteLine(e.Message);
            }
        }


        private void SendWarningHtml(string lang, int pid, string pname, string email, int uid)
        {
            string url = string.Format("{0}/plant/warningfilter/?pid={1}&uid={2}", domainUrl, pid, uid);
            string html = Tool.LoadContent(url, lang);
            EmailQueue queue = new EmailQueue();
            queue.title = pname + " Warning Report";
            queue.content = html;
            queue.receiver = email;
            queue.state = 0;
            queue.sender = "admin@suninfobank.com";
            EmailQueueService.GetInstance().Save(queue);
        }
    }
}
