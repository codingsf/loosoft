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
using System.Collections;
using Protocol;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Threading;
using System.IO;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Configuration;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace DataAnalyze
{
    /// <summary>
    /// Tcp数据解析主程序
    /// </summary>
    public class TcpDataProcesser
    {
        private static bool isStart = true;
        public static string msgmemchached = ConfigurationSettings.AppSettings["msgmemchached"];
        private static int batchNum = int.Parse(ConfigurationSettings.AppSettings["batch.num"]);
        private static int threadNum = int.Parse(ConfigurationSettings.AppSettings["thread_num"]);
        private static int analyzeInterval = int.Parse(ConfigurationSettings.AppSettings["analyze_interval"]);
        private static IList<DataProcess> dpList = new List<DataProcess>();
        private static string isinit = ConfigurationSettings.AppSettings["isinit"];
        static int cache_interval = ConfigurationSettings.AppSettings["cache_interval"] == null ? 60 : int.Parse(ConfigurationSettings.AppSettings["cache_interval"]);
        //每一批次解析后的批处理
        public static IList<DeviceDataCount> collectorDataCounts = new List<DeviceDataCount>();
        public static IDictionary<string, double> deviceEnergyMap = new Dictionary<string, double>();
        public static IDictionary<string, double> collectorEnergyMap = new Dictionary<string, double>();
        private DateTime lastCacheTime = DateTime.MinValue;//最后缓存到memcached时间
        /// <summary>
        /// 是否还有线程在工作
        /// </summary>
        /// <returns></returns>
        private bool isWork(){
            foreach(DataProcess dp in dpList){
                if(dp.isWork)return true;
            }
            return false;
        }

        /// <summary>
        /// 处理tcp消息
        /// </summary>
        public void Processing()
        {
            DateTime curdt = DateTime.Now;
            DateTime totaldt = DateTime.Now;

            //启动解析线程
            DataProcess dp ;
            for (int i = 0; i < threadNum; i++)
            {
                dp = new DataProcess();
                dpList.Add(dp);
                Thread m_thread = new Thread(new ThreadStart(dp.ProcessingTCP));
                m_thread.Name = "Analyze Thread-" + i;
                m_thread.Start();
            }

            //初始化数据
            if (isinit.Equals("true"))
            {
                LogUtil.writeline("初始化采集器和设备");
                CollectorInfoService.GetInstance().init();
                DeviceService.GetInstance().init();
            }

            while (1 == 1)
            {
                int curBatchNum = 0;
                if (TcpMessagePool.IsNull())
                {
                    if (!isStart) {
                        while (isWork()) {
                            Thread.Sleep(1000);
                        }
                        lastHandle();
                        LogUtil.writeline("本次解析用时：" + (DateTime.Now.Subtract(curdt).TotalSeconds) + "秒，统计：待处理数量" + AnalyzeCount.curWaittotal + ",总共处理：" + AnalyzeCount.curtotal + ",成功：" + AnalyzeCount.curSuccessNum + ",失败：" + AnalyzeCount.curFailNum + ",最近数据发送时间：" + AnalyzeCount.lasttime.ToString("yyyy-MM-dd HH:mm:ss"));
                        LogUtil.writeline("总共解析用时：" + (DateTime.Now.Subtract(totaldt).TotalSeconds) + "秒，统计：待处理数量" + AnalyzeCount.waittotal + ",总共处理：" + AnalyzeCount.total + ",成功：" + AnalyzeCount.successNum + ",失败：" + AnalyzeCount.failNum + ",最近数据发送时间：" + AnalyzeCount.lasttime.ToString("yyyy-MM-dd HH:mm:ss"));
                        AnalyzeCount.curFailNum = 0;
                        AnalyzeCount.curtotal = 0;
                        AnalyzeCount.curSuccessNum = 0;
                        AnalyzeCount.curWaittotal = 0;
                    }else
                        isStart = false;

                    LogUtil.writeline("获取" + batchNum + "笔消息！");
                    //object tcptest = "6868890061616161616161616161616161616100010B04020E28281388000001F40000C350000001006308020120003200000032000190000007D00000FFFFFFFFFFFF28002800280028002800280028000000280028002800280028002800280000002800000028000000280000002800000028002800280028000B000B000B000B000B000B00000000000000";                   
                    //string tcptest = "68 68 19 04 31 32 31 32 31 32 31 31 31 31 31 31 31 31 31 01 00 0b 04 13 0b 34 39 4d 23 00 00 1a 00 00 00 73 01 00 00 0a 00 65 01 02 01 00 00 1f 00 00 00 00 00 1c 00 25 00 00 00 00 00 00 01 d5 00 00 00 00 09 9f 00 24 00 00 00 00 00 00 00 00 00 00 00 00 09 30 00 00 00 00 00 25 00 00 00 00 03 66 00 00 00 00 00 00 00 00 00 00 03 66 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 02 02 01 00 00 1f 00 00 00 00 00 20 00 2b 00 00 00 00 00 00 01 e1 00 00 00 00 0a 5f 00 26 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 2c 00 00 00 00 04 04 00 00 00 00 00 00 00 00 00 00 04 04 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 03 02 01 00 00 1f 00 00 00 00 00 1c 00 25 00 00 00 00 00 00 01 bb 00 00 00 00 09 d7 00 24 00 00 00 00 00 00 00 00 00 00 00 00 09 30 00 00 00 00 00 25 00 00 00 00 03 66 00 00 00 00 00 00 00 00 00 00 03 66 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 04 02 01 00 00 1f 00 00 00 00 00 1f 00 2a 00 00 00 00 00 00 01 ce 00 00 00 00 09 77 00 28 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 2a 00 00 00 00 03 d5 00 00 00 00 00 00 00 00 00 00 03 d5 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 05 02 01 00 00 1f 00 00 00 00 00 1e 00 2a 00 00 00 00 00 00 01 c8 00 00 00 00 0a a6 00 28 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 2d 00 00 00 00 04 1c 00 00 00 00 00 00 00 00 00 00 04 1c 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 06 02 01 00 00 1f 00 00 00 00 00 1b 00 27 00 00 00 00 00 00 01 bb 00 00 00 00 09 8b 00 27 00 00 00 00 00 00 00 00 00 00 00 00 09 30 00 00 00 00 00 29 00 00 00 00 03 c4 00 00 00 00 00 00 00 00 00 00 03 c4 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 07 02 01 00 00 1f 00 00 00 00 00 10 00 1b 00 00 00 00 00 00 01 c1 00 00 00 00 05 e8 00 2d 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 1c 00 00 00 00 02 8e 00 00 00 00 00 00 00 00 00 00 02 8e 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 08 02 01 00 00 1f 00 00 00 00 00 1c 00 2a 00 00 00 00 00 00 01 c1 00 00 00 00 0a cf 00 26 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 2d 00 00 00 00 04 1c 00 00 00 00 00 00 00 00 00 00 04 1c 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 09 02 01 00 00 1f 00 00 00 00 00 19 00 25 00 00 00 00 00 00 01 bb 00 00 00 00 09 f0 00 25 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 28 00 00 00 00 03 a7 00 00 00 00 00 00 00 00 00 00 03 a7 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 0a 02 01 00 00 1f 00 00 00 00 00 10 00 19 00 00 00 00 00 00 01 a8 00 00 00 00 05 e8 00 2d 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 1b 00 00 00 00 02 77 00 00 00 00 00 00 00 00 00 00 02 77 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ";
                    //string tcptest = "68 68 8C 00 39 31 31 31 31 31 31 31 31 31 31 31 31 31 32 00 00 0B 0C 01 0f 06 26 AA AF 00 00 40 9C 00 00 B8 0B 00 00 01 00 64 10 02 00 00 00 8E 00 96 00 00 01 2D 0B B8 00 00 00 46 00 00 00 DF 00 F2 00 FB 0E D8 01 8A 0E E4 01 89 0E EF 01 88 3A 83 00 00 08 98 08 A3 08 9D 02 AA 02 A6 02 A8 3A 9C 00 00 3A 8E 00 00 3A 92 00 00 AF AE 00 00 00 5A 00 00 03 E6 01 F4 03 E5 00 00 07 DA 00 0C 00 1F 00 08 00 08 00 08 00 00 00 00 00 00";
                    //string tcptest = "68 68 24 01 39 31 31 31 31 31 31 31 31 31 31 31 31 31 31 00 00 0C 02 0A 08 19 2E 98 05 00 00 00 00 00 00 97 13 00 00 07 00 3C ED 21 00 00 ED 03 00 00 00 00 00 00 00 00 00 00 00 00 01 90 00 00 00 CB 00 00 00 0C 00 19 00 1E 01 90 00 64 00 00 00 00 00 00 00 00 00 00 00 0D 00 82 00 20 00 00 00 00 3C 00 00 0D 1F 01 01 00 00 9B 08 0D 00 DB 0E 49 00 DF 00 67 00 EB 03 00 00 00 00 00 00 F7 01 00 00 00 1F 00 1F 02 01 00 00 9B 08 0D 00 DB 0E 49 00 DF 00 67 00 EB 03 00 00 00 00 00 00 F7 01 00 00 00 1F 00 1F 03 01 00 00 9B 08 0D 00 DB 0E 49 00 DF 00 67 00 EB 03 00 00 00 00 00 00 F7 01 00 00 00 1F 00 1F 04 01 00 00 9B 08 0D 00 DB 0E 49 00 DF 00 67 00 EB 03 00 00 00 00 00 00 F7 01 00 00 00 1F 00 1F 05 01 00 00 9B 08 0D 00 DB 0E 49 00 DF 00 67 00 EB 03 00 00 00 00 00 00 F7 01 00 00 00 1F 00 1F 06 11 00 00 0A 0C 85 19 3F 1E 55 59 14 64 62 7B 59 63 63 DF 14 00 61 00 01 00 00 64 0A 00 00";
                    //string ammeterdata = "68 68 07 06 31 31 31 32 30 32 30 33 30 78 75 73 61 00 00 01 00 0C 03 15 0B 08 21 EA 38 04 00 2A 2C 00 00 EC 53 01 00 0E 00 64 01 02 01 00 00 22 00 28 00 00 00 69 03 E6 00 00 00 00 00 00 01 13 00 00 00 00 0B C7 00 86 00 00 00 00 00 00 00 00 0F C8 00 00 08 98 00 00 00 00 00 B5 00 00 00 00 0F 8E 00 00 00 00 00 00 00 00 00 00 0F 8E 00 00 00 00 00 00 00 00 01 F9 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 64 02 02 01 00 00 28 00 96 00 00 00 CD 03 FF 00 00 00 00 00 00 01 1D 00 00 00 00 0A F5 00 E0 00 00 00 00 00 00 00 00 18 8B 00 00 08 98 00 00 00 00 01 19 00 00 00 00 18 26 00 00 00 00 00 00 00 00 00 00 18 26 00 00 00 00 00 00 00 00 01 F3 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 46 03 16 01 00 00 61 00 10 00 00 00 00 00 00 00 00 02 F4 00 00 00 00 00 00 00 03 06 40 00 00 00 64 00 C8 01 2C 01 90 01 F4 02 58 02 BC 03 20 03 84 03 E8 04 4C 04 B0 05 14 05 78 05 DC 06 40 00 00 00 00 35 20 00 00 64 04 02 01 00 00 98 18 9C 00 01 03 F0 61 A8 00 00 08 34 00 00 FF 77 04 C4 02 8A 0C 4E 57 E4 00 00 00 00 00 00 00 00 D0 8E 00 0A 0C 4E 0D AC 0C B2 05 DC 07 58 4E 20 B4 AA 00 00 F9 38 00 00 F2 30 00 00 90 72 00 02 3A 97 00 00 FC 27 01 F2 03 D9 55 00 07 DB 00 0A 00 13 00 0F 00 0B 00 0C 07 D0 00 00 00 00 64 05 02 01 00 00 26 00 0A 00 02 27 04 EA 5F 00 00 11 6F 00 01 FF DB 01 FE 03 85 08 98 03 E8 08 66 07 D0 08 B6 0B B8 03 A0 00 02 08 FC 08 CA 09 61 05 DC 05 C8 05 F0 86 C4 00 00 82 14 00 00 8E 8F 00 00 80 C4 00 01 05 DB 00 00 03 D9 01 F2 03 D9 54 00 07 DB 00 0A 00 13 00 0F 00 0B 00 0C 05 DC 00 00 00 00 7A 06 15 01 00 00 D1 00 10 00 02 27 04 EA 5F 00 00 02 F4 00 E6 01 CC 01 FE 00 01 06 40 03 52 00 64 00 C8 01 2C 01 90 01 F4 02 58 02 BC 03 20 03 84 03 E8 04 4C 04 B0 05 14 05 78 05 DC 06 40 8E 8F 00 00 35 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 07 DB 00 0A 01 E1 00 00 40 00 00 00 05 DC 00 00 2E 0D 00 00 00 00 00 00 00 F2 00 00 12 49 00 00 11 00 00 00 09 C4 00 00 2E 07 22 01 00 00 E2 00 01 00 00 27 04 EA 5F 00 00 02 F4 00 01 00 00 00 00 00 01 06 40 1E C8 1F B8 01 BA 01 EB 01 90 01 F4 00 2A 00 03 03 84 7A 08 15 01 00 00 D1 00 10 00 00 00 00 00 00 00 00 02 F4 00 00 00 00 00 00 00 01 06 40 03 52 00 64 00 C8 01 2C 01 90 01 F4 02 58 02 BC 03 20 03 84 03 E8 04 4C 04 B0 05 14 05 78 05 DC 06 40 00 00 00 00 05 50 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2E 09 22 01 00 00 E2 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 13 88 00 96 01 2C 00 00 00 00 00 11 00 00 00 26 7A 0A 15 01 00 00 D1 00 00 00 00 00 00 00 00 00 00 19 82 00 00 00 00 00 00 00 01 04 B0 02 8A 00 64 00 C8 01 2C 01 90 01 F4 02 58 02 BC 03 20 03 84 03 E8 04 4C 04 B0 00 00 00 00 00 00 00 00 00 00 00 00 03 0C 00 00 D4 C0 00 01 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1F 00 00 00 00 00 00 AC 0B 41 01 00 00 E6 13 24 27 10 27 10 27 10 00 32 00 64 00 96 18 6A 00 00 1D 4C 00 00 13 88 00 00 92 7C 00 00 F6 3C FF FF E7 96 FF FF EC 78 FF FF A8 1C FF FF 18 6A 00 00 1D 4C 00 00 13 88 00 00 BE 6E 00 00 22 C4 17 B6 F6 3C 1F 4A 00 7D 00 00 00 7D 00 00 00 0D 00 00 00 0D 00 00 00 FA 00 00 00 FA 00 00 00 0D 00 00 00 0D 00 00 01 77 00 00 01 77 00 00 01 77 00 00 01 77 00 00 00 FA 00 00 00 FA 00 00 00 FA 00 00 00 FA 00 00 00 3F 00 00 00 3F 00 00 00 68 00 00 00 BC 00 00 00 53 00 00 00 53 00 00 00 A7 00 00 00 BC 00 00 AC 0C 41 01 00 00 E6 13 24 27 10 27 10 27 10 00 32 00 64 00 96 18 6A 00 00 1D 4C 00 00 13 88 00 00 92 7C 00 00 F6 3C FF FF E7 96 FF FF EC 78 FF FF A8 1C FF FF 18 6A 00 00 1D 4C 00 00 13 88 00 00 BE 6E 00 00 22 C4 17 B6 F6 3C 1F 4A 00 7D 00 00 00 7D 00 00 00 0D 00 00 00 0D 00 00 00 FA 00 00 00 FA 00 00 00 0D 00 00 00 0D 00 00 01 77 00 00 01 77 00 00 01 77 00 00 01 77 00 00 00 FA 00 00 00 FA 00 00 00 FA 00 00 00 FA 00 00 00 3F 00 00 00 3F 00 00 00 68 00 00 00 BC 00 00 00 53 00 00 00 53 00 00 00 A7 00 00 00 BC 00 00 AC 0D 41 01 00 00 E6 13 24 27 10 27 10 27 10 00 32 00 64 00 96 18 6A 00 00 1D 4C 00 00 13 88 00 00 92 7C 00 00 F6 3C FF FF E7 96 FF FF EC 78 FF FF A8 1C FF FF 18 6A 00 00 1D 4C 00 00 13 88 00 00 BE 6E 00 00 22 C4 17 B6 F6 3C 1F 4A 00 7D 00 00 00 7D 00 00 00 0D 00 00 00 0D 00 00 00 FA 00 00 00 FA 00 00 00 0D 00 00 00 0D 00 00 01 77 00 00 01 77 00 00 01 77 00 00 01 77 00 00 00 FA 00 00 00 FA 00 00 00 FA 00 00 00 FA 00 00 00 3F 00 00 00 3F 00 00 00 68 00 00 00 BC 00 00 00 53 00 00 00 53 00 00 00 A7 00 00 00 BC 00 00 2E ED 22 01 00 00 E2 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1F B8 01 A4 01 EA 00 00 00 00 00 28 00 00 01 72";
                    //TcpMessagePool.Enqueue(new MessageVo() { key = "dsfdsf", message = ammeterdata });
                    //从消息缓存中取得所有数据的key
                    MemcachedClientSatat msgMcs = MemcachedClientSatat.getInstance(msgmemchached);
    
                    List<string> Keys = msgMcs.GetAllKeys();
                    //顺排key
                    string[] sortKeys = sortCollection(Keys);


                    object tcp = null;
                    string tcpMessage;
                    for (int i = 0; i < sortKeys.Length; i++)
                    //for (int i = 0; i < 1; i++)
                    //for (int i = sortKeys.Length-1; i >sortKeys.Length-1000; i--)
                    {
                        try
                        {
                            string key = sortKeys[i];

                            //判断此key是否已经被解析过了
                            if (MemcachedClientSatat.getInstance().isAnalyzed(key))
                            {
                                LogUtil.info("message key is:" + key + " has been analyzed");
                                continue;
                            }

                            tcp = msgMcs.Get(key);
                            if (tcp == null) continue;

                            tcpMessage = tcp.ToString();
                            if (!string.IsNullOrEmpty(tcpMessage))
                            {
                                if (!tcpMessage.StartsWith("6")) {
                                    tcpMessage = tcpMessage.Substring(1);
                                }
                                LogUtil.info("prepare handle message key is:" + key + " ## message length is " + tcpMessage.Length + " ## " + i);
                                //将待解析的消息放入消息队列
                                TcpMessagePool.Enqueue(new MessageVo() { key = key, message = tcpMessage });

                                //增加总获取数量
                                AnalyzeCount.waittotal++;
                                AnalyzeCount.curWaittotal++;
                                curBatchNum++;
                                if (curBatchNum == batchNum) break;
                            }
                        }
                        catch (Exception ee)
                        {
                            LogUtil.error("get message exception:" + ee.Message);
                        }
                    }

                    LogUtil.writeline("本次共获取要解析的消息：" + curBatchNum);
                    LogUtil.writeline(threadNum + "数据解析线程开始解析.......");
                    curdt = DateTime.Now;
                }

                Thread.Sleep(analyzeInterval);
            }
        }

        /// <summary>
        /// 每一批次的最后处理
        /// </summary>
        private void lastHandle()
        {
            if (DateTime.Now < lastCacheTime.AddMinutes(cache_interval))
            {
                return;
            }
            Console.WriteLine("开始缓存数据到Memcached");
            DateTime curdt = DateTime.Now;
            DateTime totaldt = DateTime.Now;
            //将内存中得数据放入缓存
            CacheHandler.CacheData();
            //最后批处理采集器最大值
            try
            {
                DeviceDataCountService.GetInstance().CacheCollectorCount(collectorDataCounts);
                //电站统计，必须保证所有采集器都在，即每次都统计完整的电站单元，所以不能清空。
                collectorDataCounts.Clear();
            }
            catch (Exception ddccache)
            {
                LogUtil.error("CacheCollectorCount异常：" + ddccache.Message);
            }
            //最后处理发电量统计
            try
            {
                CacheHandler.CacheCountData(deviceEnergyMap, collectorEnergyMap);
            }
            catch (Exception ddccache)
            {
                LogUtil.error("CacheCollectorCount异常：" + ddccache.Message);
            }
            LogUtil.writeline("缓存到memcache处理用时：" + (DateTime.Now.Subtract(curdt).TotalSeconds) + "秒，统计：待处理数量" + AnalyzeCount.curWaittotal + ",总共处理：" + AnalyzeCount.curtotal + ",成功：" + AnalyzeCount.curSuccessNum + ",失败：" + AnalyzeCount.curFailNum + ",最近数据发送时间：" + AnalyzeCount.lasttime.ToString("yyyy-MM-dd HH:mm:ss"));
            lastCacheTime = DateTime.Now;
        }

        /// <summary>
        /// 顺排序集合
        /// </summary>
        /// <param name="ic"></param>
        /// <returns></returns>
        private string[] sortCollection(ICollection ic)
        {
            string[] objArr = new string[ic.Count];
            ic.CopyTo(objArr, 0);
            Array.Sort<string>(objArr, (a, b) => { return string.Compare(a, b); });
            return objArr;
        }
    }
}
