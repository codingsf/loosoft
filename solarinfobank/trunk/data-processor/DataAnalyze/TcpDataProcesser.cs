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
        private static string protocol_version = ConfigurationSettings.AppSettings["protocol.version"];
        private static string debug_collector = ConfigurationSettings.AppSettings["debug_collector"];
        
        static int cache_interval = ConfigurationSettings.AppSettings["cache_interval"] == null ? 60 : int.Parse(ConfigurationSettings.AppSettings["cache_interval"]);
        //每一批次解析后的批处理
        public static IList<DeviceDataCount> collectorDataCounts = new List<DeviceDataCount>();
        public static IDictionary<string, double> deviceEnergyMap = new Dictionary<string, double>();
        public static IDictionary<string, double?> collectorEnergyMap = new Dictionary<string, double?>();
        private DateTime lastCacheTime = DateTime.MinValue;//最后缓存到memcached时间

        private static string memkeyList_key = "keylist_2.0_";
        public bool runmark = true;//继续现场运行标识
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

            while (runmark)
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

                    //string xx = "中国";

                    //byte[] trmp = StringUtil.UTF8Encode(xx);
                    //string hex = StringUtil.ByteArray2HexString(trmp);
                    
                    //string yy = StringUtil.UTF8Decode(trmp);
                    //Console.WriteLine(hex);
                    LogUtil.writeline("获取" + batchNum + "笔消息！");
                    //object tcptest = "6868890061616161616161616161616161616100010B04020E28281388000001F40000C350000001006308020120003200000032000190000007D00000FFFFFFFFFFFF28002800280028002800280028000000280028002800280028002800280000002800000028000000280000002800000028002800280028000B000B000B000B000B000B00000000000000";                   
                    //string tcptest = "68 68 19 04 31 32 31 32 31 32 31 31 31 31 31 31 31 31 31 01 00 0b 04 13 0b 34 39 4d 23 00 00 1a 00 00 00 73 01 00 00 0a 00 65 01 02 01 00 00 1f 00 00 00 00 00 1c 00 25 00 00 00 00 00 00 01 d5 00 00 00 00 09 9f 00 24 00 00 00 00 00 00 00 00 00 00 00 00 09 30 00 00 00 00 00 25 00 00 00 00 03 66 00 00 00 00 00 00 00 00 00 00 03 66 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 02 02 01 00 00 1f 00 00 00 00 00 20 00 2b 00 00 00 00 00 00 01 e1 00 00 00 00 0a 5f 00 26 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 2c 00 00 00 00 04 04 00 00 00 00 00 00 00 00 00 00 04 04 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 03 02 01 00 00 1f 00 00 00 00 00 1c 00 25 00 00 00 00 00 00 01 bb 00 00 00 00 09 d7 00 24 00 00 00 00 00 00 00 00 00 00 00 00 09 30 00 00 00 00 00 25 00 00 00 00 03 66 00 00 00 00 00 00 00 00 00 00 03 66 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 04 02 01 00 00 1f 00 00 00 00 00 1f 00 2a 00 00 00 00 00 00 01 ce 00 00 00 00 09 77 00 28 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 2a 00 00 00 00 03 d5 00 00 00 00 00 00 00 00 00 00 03 d5 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 05 02 01 00 00 1f 00 00 00 00 00 1e 00 2a 00 00 00 00 00 00 01 c8 00 00 00 00 0a a6 00 28 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 2d 00 00 00 00 04 1c 00 00 00 00 00 00 00 00 00 00 04 1c 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 06 02 01 00 00 1f 00 00 00 00 00 1b 00 27 00 00 00 00 00 00 01 bb 00 00 00 00 09 8b 00 27 00 00 00 00 00 00 00 00 00 00 00 00 09 30 00 00 00 00 00 29 00 00 00 00 03 c4 00 00 00 00 00 00 00 00 00 00 03 c4 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 07 02 01 00 00 1f 00 00 00 00 00 10 00 1b 00 00 00 00 00 00 01 c1 00 00 00 00 05 e8 00 2d 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 1c 00 00 00 00 02 8e 00 00 00 00 00 00 00 00 00 00 02 8e 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 08 02 01 00 00 1f 00 00 00 00 00 1c 00 2a 00 00 00 00 00 00 01 c1 00 00 00 00 0a cf 00 26 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 2d 00 00 00 00 04 1c 00 00 00 00 00 00 00 00 00 00 04 1c 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 09 02 01 00 00 1f 00 00 00 00 00 19 00 25 00 00 00 00 00 00 01 bb 00 00 00 00 09 f0 00 25 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 28 00 00 00 00 03 a7 00 00 00 00 00 00 00 00 00 00 03 a7 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 0a 02 01 00 00 1f 00 00 00 00 00 10 00 19 00 00 00 00 00 00 01 a8 00 00 00 00 05 e8 00 2d 00 00 00 00 00 00 00 00 00 00 00 00 09 22 00 00 00 00 00 1b 00 00 00 00 02 77 00 00 00 00 00 00 00 00 00 00 02 77 00 00 00 00 00 00 00 00 01 f4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ";
                    //string tcptest = "68 68 8C 00 39 31 31 31 31 31 31 31 31 31 31 31 31 31 32 00 00 0B 0C 01 0f 06 26 AA AF 00 00 40 9C 00 00 B8 0B 00 00 01 00 64 10 02 00 00 00 8E 00 96 00 00 01 2D 0B B8 00 00 00 46 00 00 00 DF 00 F2 00 FB 0E D8 01 8A 0E E4 01 89 0E EF 01 88 3A 83 00 00 08 98 08 A3 08 9D 02 AA 02 A6 02 A8 3A 9C 00 00 3A 8E 00 00 3A 92 00 00 AF AE 00 00 00 5A 00 00 03 E6 01 F4 03 E5 00 00 07 DA 00 0C 00 1F 00 08 00 08 00 08 00 00 00 00 00 00";
                    //string tcptest = "68 68 8C 00 31 32 30 35 30 34 30 37 37 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1B 00 00 00 01 00 64 01 02 01 00 00 28 00 96 00 01 00 00 00 1B 00 00 00 1C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 25 00 07 D0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00";
                    //string tcptest = "68 68 86 04 4C 6F 67 54 65 73 74 32 30 31 32 30 38 31 31 01 01 0C 08 0D 09 32 31 98 52 07 00 FF 7A 00 00 A9 2C 03 00 0B 00 64 01 02 01 00 00 22 00 28 00 00 00 69 03 E6 00 00 00 00 00 00 01 13 00 00 00 00 0B C7 00 86 00 00 00 00 00 00 00 00 0F C8 00 00 08 98 00 00 00 00 00 B5 00 00 00 00 0F 8E 00 00 00 00 00 00 00 00 00 00 0F 8E 00 00 00 00 00 00 00 00 01 F9 00 00 00 00 07 DC 00 08 00 0D 00 09 00 32 00 30 00 00 00 00 00 00 64 02 02 01 00 00 28 00 96 00 01 00 CD 03 FF 00 00 00 00 00 00 01 1D 00 00 00 00 0A F5 00 E0 00 00 00 00 00 00 00 00 18 8B 00 00 04 F6 04 F6 04 F6 00 A2 00 A2 00 A2 18 26 00 00 00 00 00 00 00 00 00 00 18 26 00 00 00 00 00 00 00 00 01 F3 00 00 00 00 07 DC 00 08 00 0D 00 09 00 32 00 30 00 00 00 00 00 00 64 03 02 01 00 00 92 09 C4 00 02 00 CD 03 FF 00 00 00 00 00 00 01 1D 00 00 00 00 0A F5 00 E0 00 00 00 00 00 00 00 00 18 8B 00 00 08 98 08 98 08 98 00 A2 00 A2 00 A2 18 26 00 00 00 00 00 00 00 00 00 00 18 26 00 00 00 00 00 00 00 00 01 F3 00 00 00 00 07 DC 00 08 00 0D 00 09 00 32 00 30 00 00 00 00 00 00 98 04 03 01 00 00 98 18 9C 00 01 03 F0 61 A8 00 00 08 34 00 00 FF 77 04 C4 02 8A 0C 4E 57 E4 00 00 00 00 00 00 00 00 D0 8E 00 0A 0C 4E 0D AC 0C B2 05 DC 07 58 4E 20 B4 AA 00 00 F9 38 00 00 F2 30 00 00 90 72 00 02 3A 97 00 00 FC 27 01 F2 03 D9 00 00 07 DC 00 07 00 1F 00 0F 00 33 00 0C 00 00 00 00 00 00 00 0A 00 0A 00 00 00 00 00 00 00 00 00 00 00 00 2F 12 09 C4 FF 00 00 00 00 00 00 00 03 F2 03 20 03 8E 03 0C 02 8A 04 4C 03 AC 01 5E 01 36 00 00 00 00 00 00 64 05 02 01 00 00 26 00 0A 00 02 27 04 EA 5F 00 00 11 6F 00 01 FF DB 01 FE 03 85 08 98 03 E8 08 66 07 D0 08 B6 0B B8 03 A0 00 02 08 FC 08 CA 09 61 05 DC 05 C8 05 F0 86 C4 00 00 82 14 00 00 8E 8F 00 00 80 C4 00 01 05 DB 00 00 FC 27 01 F2 03 D9 00 00 07 DC 00 08 00 08 00 0B 00 0C 00 0E 0F A0 00 00 00 00 64 06 02 01 00 00 28 00 0A 00 02 27 04 EA 5F 00 00 11 6F 00 01 FF DB 01 FE 03 85 08 98 03 E8 08 66 07 D0 08 B6 0B B8 03 A0 00 02 08 FC 08 CA 09 61 05 DC 05 C8 05 F0 86 C4 00 00 82 14 00 00 8E 8F 00 00 80 C4 00 01 05 DB 00 00 FC 27 01 F2 03 D9 00 00 07 DC 00 08 00 08 00 0A 00 05 00 0C 00 00 00 00 00 00 64 07 02 01 00 00 2A 00 0A 00 02 27 04 EA 5F 00 00 11 6F 00 01 FF DB 01 FE 03 85 08 98 03 E8 08 66 07 D0 08 B6 0B B8 03 A0 00 02 08 FC 08 CA 09 61 05 DC 05 C8 05 F0 86 C4 00 00 82 14 00 00 8E 8F 00 00 80 C4 00 01 05 DB 00 00 FC 27 01 F2 03 D9 00 00 07 DC 00 08 00 08 00 14 00 0B 00 0C 00 00 00 00 00 00 7A 08 15 01 00 00 D1 00 10 00 02 27 04 EA 5F 00 00 02 F4 03 3E 01 CC 01 FE 00 01 06 40 03 52 00 64 00 C8 01 2C 01 90 01 F4 02 58 02 BC 03 20 03 84 03 E8 04 4C 04 B0 05 14 05 78 05 DC 06 40 8E 8F 00 00 35 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 07 DC 00 08 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 09 C4 00 00 76 09 23 01 00 00 E2 02 00 01 00 27 04 EA 5F 00 00 02 F4 00 01 00 00 00 00 00 01 06 40 1E C8 1F B8 01 BA 01 EB 01 90 01 F4 00 2A 00 03 03 84 00 30 00 02 18 1C 00 00 05 14 05 78 C8 2B 00 00 11 A0 11 A2 00 00 11 A4 00 00 00 00 00 00 00 00 00 00 00 0A 00 0A 00 0A 00 0A 00 14 00 00 00 00 00 00 00 14 00 00 00 0A 00 0A 00 00 00 0A 00 00 00 00 00 00 00 00 00 00 46 0A 16 01 00 00 61 00 10 00 00 00 00 00 00 00 00 02 F4 00 00 00 00 00 00 00 01 06 40 00 00 03 E8 07 D0 0B B8 0F A0 13 88 17 70 1B 58 1F 40 23 28 27 10 2A F8 2E E0 32 C8 36 B0 3A 98 3E 80 00 00 00 00 35 20 00 00 2E ED 22 01 00 00 E2 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1F B8 01 A4 01 EA 00 00 00 00 00 28 00 00 01 72";
                    //富士康电表数据，稍后测试 本地能持久化11个设备 不知道服务器为何只有9个 后面两个电表没有持久化
                    //string tcptest = "6868DA0531323031303530363000000000000001000C040E102B1B5D5D00004C0F00005DFC00000B007A0215010000D10000000000000000000016710000000000000001007C006D0076007C007C006F0073007500790073007B007400770000000000000000000000000000008200001D5900000000000000000000000000000140000000000000000000000000000000000000000000000000000008000000000000007A0315010000D1000000000000000000001716000000000000000100800079007700750078007700750078007C007B007C0080007B00790000000000000000000000000092000021BB00000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000007A0415010000D100000000000000000000195D0000000000000001003C00370035003B003300370038003500340031003C0038003800370000000000000000000000000042000010C200000000000000000000000000000140000000000000000000000000000000000000000000000000000000000000000000007A0515010000D10000000000000000000019CF00000000000000010040003300400037003300390036003900330034003B003A003A0000000000000000000000000000003E0000100600000000000000000000000000000140000000000000000000000000000000000000000000000000000008000000000000007A0615010000D10000000000000000000016FE0000000000000001008F0068006B0070006C006C006F008F006A00710070006F00720000000000000000000000000000007D00001CB500000000000000000000000000000140000000000000000000000000000000000000000000000000000008000000000000007A0715010000D10000000000000000000017520000000000000001007D006C0070007100740075007300790078007600790071007D0000000000000000000000000000008100001E3F00000000000000000000000000000180000000000000000000000000000000000000000000000000000008000000000000006409020100009103E80046037C7DE70000002C7B0001830000000019AA00C6000000000000000032D0000010160000000000D80000000022BE0000000000000000000022BE000000000000000001F400000000000000000000000000000000000000000000640A020100009103E800000BD07E7600000B7279000183000000001702015400000000000000004E3A00000FEE000000000170000000003A9F000000000000000000003A9F000000000000000001F300000000000000000000000000000000000000000000AC0B41010000E61387093D0941094000F000E800E515CC00001522000014EB00003FCF000003CF000003840000032000000A6E000016210000156D00001527000040A100002679268726A1269190F80000001A0000174D0000000000009112000090DD0000174D0000174D0000001E00000005000002550000000000001E1400000000000002E4000000000000014B0000000A00000410000000000000717A0000000B00000E05000000000000AC0C41010000E61385095309520951008B008200800C6200000B7C00000B8B00002364000003B6000003F20000030700000AAA00000CEE00000C2600000BEF000024EA0000256924ED25C8257380340000001D0000182300000000000080500000801700001823000018230000001A000000050000023D0000000000001908000000000000033600000000000001130000000B000003F600000000000066000000000C00000EB9000000000000AC0D41010000E61385093E093F093F00DF00DC00D71455000014000000139200003BE200000375000003890000034800000A41000014A000001450000013D800003CB400002681267626862688810500000020000019570000000000008125000080E600001957000019570000001D00000006000002540000000000001B3C000000000000036D00000000000001390000000C0000040C00000000000064730000000D00000F8A000000000000";
                    //电站数据
                    //string tcptest = "69 69 01 00 C3 00 00 00 01 00 01 00 00 00 02 00 0B 00 31 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 32 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00 E4 B8 AD E5 9B BD 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 E5 8C 97 E4 BA AC 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 37 00 00 00 00 00 00 00 00 00 00 00 34 08 00 00 00 AF 00 00 B1 65 C9";
                    //string tcptest = "69 69 01 00 C3 00 00 00 01 00 01 00 01 00 02 00 0B 00 31 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 32 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00 E4 B8 AD E5 9B BD 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 E5 8C 97 E4 BA AC 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 37 00 00 00 00 00 00 00 00 00 00 00 34 08 00 00 00 AF 00 00 B1 5F 1A";
                    //汇总实时数据
                    //string tcptest = "68 68 34 00 73 67 74 73 74 30 30 30 39 00 00 00 00 00 00 01 01 0C 08 11 08 25 0D A8 07 0F 00 04 27 00 00 FF E0 F5 05 00 01 0F 00 01 00 03 00 00 0C 08 11 08 24 37";
                    //逆变器实时数据
                    //string tcptest = "69 69 01 00 4e 00 00 00 01 00 01 00 00 00 04 00 29 00 02 00 00 00 11 02 0c 0d 07 0c 07 00 01 cf 00 d8 13 00 00 01 01 d0 00 4e 02 00 00 01 01 d1 00 94 75 00 00 01 01 db 00 28 6e 00 00 01 01 dc 00 d4 fe ff ff 01 01 dd 00 e8 03 00 00 01 01 de 00 f4 01 00 00 01 0d f7";
                    //string tcptest = "68 68 C6 02 31 32 30 35 30 34 30 37 33 00 00 00 00 00 00 01 01 0C 09 17 08 33 08 35 8D 07 00 DD 35 00 00 B4 91 0A 00 05 00 98 01 03 01 00 00 95 13 88 00 02 0A 0F DE 47 00 03 12 09 00 00 01 35 00 00 00 00 16 1C 11 9A 00 00 00 00 00 00 00 00 E4 44 00 03 09 C2 09 A6 09 A6 17 A3 18 84 17 55 00 00 00 00 00 00 00 00 00 00 00 00 D1 70 00 03 34 A4 00 00 03 E4 01 F4 03 D5 00 00 07 D0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 98 02 03 01 00 00 95 13 88 00 02 07 CA DA 2D 00 03 14 41 00 00 01 3C 00 00 00 00 16 62 0D 5D 00 00 00 00 00 00 00 00 FD DF 00 02 09 CB 09 A1 09 A1 12 2E 12 20 12 1C 00 00 00 00 00 00 00 00 00 00 00 00 EF 66 00 02 48 EA 00 00 03 E3 01 F4 03 D5 00 00 07 D0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 98 03 03 01 00 00 98 18 9C 00 02 24 05 D9 40 00 02 09 F0 00 00 01 44 00 00 00 00 15 FB 03 C7 00 00 00 00 00 00 00 00 D4 8D 00 00 0B 5B 0B 54 0B 54 0E 76 0E 96 0E 9C 00 00 00 00 00 00 00 00 00 00 00 00 D1 06 00 00 38 9F FF FD FE E7 01 F3 03 D7 00 00 07 D0 00 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2E ED 22 01 00 00 E2 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 11 4E 01 0E 01 86 00 00 00 00 00 0A 00 00 04 4C A4 04 42 01 00 20 B0 02 00 01 00 01 5E 00 3C 00 00 03 FC 00 00 03 FC 00 09 00 00 00 09 21 5C 00 00 22 56 27 10 00 55 00 00 00 00 00 00 00 59 00 00 00 AD 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 00 00 00 00 00 00 00 54 00 00 00 A6 00 00 03 D5 00 00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 A9 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 2D 00 00 00 05 00 00 00 00 00 00 00 00 00 00 00 FD 00 00 00 00 00 00 00 00 00 00 00 00 00 00";
                    //TcpMessagePool.Enqueue(new MessageVo() { key = "tc20_plant_sungrowtest3_2222", message = tcptest });
                    //TcpMessagePool.Enqueue(new MessageVo() { key = "tc20666", message = tcptest });
                    //从消息缓存中取得所有数据的key
                    MemcachedClientSatat msgMcs = MemcachedClientSatat.getInstance(msgmemchached);
                    //Console.WriteLine(msgMcs.GetAllKeys().Count);
                    //bool exist = msgMcs.KeyExists("run1collectortotalenergycount_264_2012");
                    //Console.WriteLine(exist);
                    //msgMcs.Delete("run1collectortotalenergycount_264_2012");
                    //exist = msgMcs.KeyExists("run1collectortotalenergycount_264_2012");
                    //Console.WriteLine(exist);
                    //Console.WriteLine(msgMcs.GetAllKeys().Count);
                    //object o = msgMcs.Get("alldevices");
                    //object obj = msgMcs.Get(CacheKeyUtil.buildCollectorRunDataKey(227));
                    //Console.WriteLine(obj);
                    List<string> Keys = new List<string>();
                    try
                    {
                        if (protocol_version.IndexOf(",1,") > -1)
                        {
                            Keys = msgMcs.GetAllKeys("tcp20");
                        }
                        if (protocol_version.IndexOf(",2,") > -1)
                        {
                            Keys.AddRange(msgMcs.GetAllKeys("tcp_20_plant_,tcp_20_device_,tcp_20_run_"));
                        }
                    }
                    catch (Exception meme) {
                        LogUtil.error("从缓存服务器中取得待解析的数据错误：" + meme.Message);
                    }
                    Console.WriteLine("keys count:"+Keys.Count);
                    //顺排key
                    string[] sortKeys = sortCollection(Keys);
                    //string[] sortKeys = Keys.ToArray();
                    object tcp = null;
                    string tcpMessage;
                    for (int i = 0; i < sortKeys.Length; i++)
                    //for (int i = 0; i < 1; i++)
                    //for (int i = sortKeys.Length-1; i >sortKeys.Length-2000; i--)
                    {
                        try
                        {
                            string key = sortKeys[i];
                            if (protocol_version.IndexOf(",2,") > -1){
                                if (!string.IsNullOrEmpty(debug_collector)&&!key.Contains(debug_collector)) continue;
                            }

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
                                tcpMessage = tcpMessage.Replace("0x", string.Empty).Replace(" ", string.Empty).Replace("\r", string.Empty).Replace("\n", string.Empty);

                                if (protocol_version.IndexOf(",1,") > -1)
                                {
                                    string sn = TcpHeader.getSn(tcpMessage);
                                    LogUtil.info("sn" + sn);
                                    //不在待解析的sn，则跳过，debug_collector支持,sn1,sn2,
                                    if (!string.IsNullOrEmpty(debug_collector) && ("," + debug_collector + ",").IndexOf("," + sn + ",") == -1) continue;
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

        int memcahcednum = 0;//缓存次数，完成两次缓存，进行一次持久化数据

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

            memcahcednum++;
            if (memcahcednum == 3) { 
                //进行持久化
                PersistentProcesser.peristentData();
                memcahcednum = 0;
            }
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
