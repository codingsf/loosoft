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
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Threading;
using System.Reflection;
namespace DataAnalyze
{

    /// <summary>
    /// 数据解析处理体
    /// </summary>
    public class DataProcess
    {
        private bool _isWork = false;
        public bool isWork
        {
            get
            {
                return _isWork;
            }
        }
        /// <summary>
        /// tcp解析
        /// </summary>
        /// <param name="cacheorbase">获取数据方式</param>
        public void ProcessingTCP()
        {
            Thread.Sleep(1 * 1000);
            while (1 == 1)
            {

                while (!TcpMessagePool.IsNull())
                {
                    _isWork = true;
                    //从消息队里中取得消息
                    MessageVo messageVO = null;
                    try
                    {
                        messageVO = TcpMessagePool.Dequeue();
                    }catch(Exception ee){
                        LogUtil.error("队列:" + ee.Message);
                    }
                    if (messageVO == null)
                    {
                        _isWork = false;
                        break;
                    }
                    try
                    {
                        //解析消息
                        TCPMessage tcpmessage = null;
                        try
                        {
                            tcpmessage = new TCPMessage(messageVO.key,messageVO.message);
                            //add by hbqian int 20130418 for其实0。1分的发电量是昨天，按道理不应该发的，但是现在LOG有个换存，导致0：到15分的这个时间发的发电量可能还是上一天的
                            if (tcpmessage.messageHeader.TimeNow.Hour == 0 && tcpmessage.messageHeader.TimeNow.Minute < 15) {
                                continue;
                            }
                        }
                        catch (Exception ee)
                        {
                            LogUtil.error("解析消息" + messageVO.key +",sn:" + TcpHeader.getSn(messageVO.message)+ ",消息内容：" + messageVO.message + "异常:" + ee.Message);
                            //处理错误的消息入队
                            //处理完从memched中删除此消息
                            if (messageVO.key != null)
                            {
                                IList<string> analyzedKeys = (List<string>)MemcachedClientSatat.getInstance().Get(MemcachedClientSatat.analyzedkey);
                                MemcachedClientSatat.getInstance(TcpDataProcesser.msgmemchached).deleteAnalyzed(messageVO.key, analyzedKeys);
                                MemcachedClientSatat.getInstance().remember(messageVO.key);
                            }
                            continue;
                        }
                         
                        //持久化将数据保存到缓存
                        DateTime curdt = DateTime.Now;
                        CacheHandler.LocalCacheData(tcpmessage);
                        LogUtil.writeline(tcpmessage.messageHeader.CollectorCode+" CacheHandler.LocalCacheData解析用时：" + (DateTime.Now.Subtract(curdt).TotalSeconds));
                        try
                        {
                            //设备发电量先放到map，然后集中处理
                            double tmpvalue = 0;
                            foreach (string key in tcpmessage.deviceEnergyMap.Keys)
                            {
                                tmpvalue = tcpmessage.deviceEnergyMap[key];
                                if (key!=null && TcpDataProcesser.deviceEnergyMap.ContainsKey(key))
                                {
                                    double ovalue = TcpDataProcesser.deviceEnergyMap[key];
                                    if (ovalue < tmpvalue)
                                        TcpDataProcesser.deviceEnergyMap[key] = tmpvalue;
                                }
                                else
                                {
                                    TcpDataProcesser.deviceEnergyMap[key] = tmpvalue;
                                }
                            }
                        }catch (Exception e22){
                            LogUtil.error("device energy map error:"+e22.Message);
                        }
                        
                        try
                        {
                            //采集器天发电量放到map
                            string ekey = tcpmessage.GetCollectorId() + ":" + tcpmessage.messageHeader.year + ":" + tcpmessage.messageHeader.month + ":" + tcpmessage.messageHeader.day;
                            //if (!TcpDataProcesser.collectorEnergyMap.ContainsKey(ekey) || (TcpDataProcesser.collectorEnergyMap.ContainsKey(ekey) && TcpDataProcesser.collectorEnergyMap[ekey] < tcpmessage.messageHeader.DayEnergy))
                            //{
                            //必须添加hasData作为条件，否则会出现新协议的发电量被设备数据产生的空messageHeader冲成0了。
                            if (tcpmessage.messageHeader.hasData && tcpmessage.messageHeader.DayEnergy != null)
                                TcpDataProcesser.collectorEnergyMap[ekey] = tcpmessage.messageHeader.DayEnergy.Value;
                            //}
                        }catch (Exception e223){
                            LogUtil.error("collectorEnergyMap energy map error:" + e223.Message);
                        }

                        //对应采集器发生先放入list，然后集中批处理到缓存
                        try
                        {
                            if (tcpmessage.collectorDataCount != null)
                            {
                                TcpDataProcesser.collectorDataCounts.Add(tcpmessage.collectorDataCount);
                                LogUtil.error("add collector Count Data 完成:collectorId:" + tcpmessage.collectorDataCount.deviceId + ":" + tcpmessage.collectorDataCount.maxValue+"-"+tcpmessage.collectorDataCount.maxTime);
                            }
                        }
                        catch (Exception ddcEe)
                        {
                            LogUtil.error("add collector Count Data exception:" + ddcEe.Message);
                            //处理完从memched中删除此消息
                            if (messageVO.key != null)
                            {
                                IList<string> analyzedKeys = (List<string>)MemcachedClientSatat.getInstance().Get(MemcachedClientSatat.analyzedkey);
                                MemcachedClientSatat.getInstance(TcpDataProcesser.msgmemchached).deleteAnalyzed(messageVO.key,analyzedKeys);
                                MemcachedClientSatat.getInstance().remember(messageVO.key);
                            }
                            continue;
                        }

                        AnalyzeCount.successNum++;
                        AnalyzeCount.curSuccessNum++;
                        AnalyzeCount.total++;
                        AnalyzeCount.curtotal++;
                        // (AnalyzeCount.lasttime.Year==1|| tcpmessage.messageHeader.TimeNow.Subtract(AnalyzeCount.lasttime).TotalSeconds>0)
                        //
                        AnalyzeCount.lasttime = tcpmessage.messageHeader.TimeNow;
                        //
                        LogUtil.writeline("成功处理：" + "sn:" + TcpHeader.getSn(messageVO.message) +",key:" + messageVO.key);
                        //FileLogUtil.info("成功处理：" + "sn:" + TcpHeader.getSn(messageVO.message) + ",key:" + messageVO.key);
                        //设置最后成功处理时间到memcached，以便检测监控程序能判断是否正常运行
                        MemcachedClientSatat.getInstance().Set("monitor_analyze_run_lasttime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                    }
                    catch (Exception ee)
                    {
                        LogUtil.error("异常：" + ee.Message);

                        //处理错误的消息入队
                        //TcpMessagePool.Enqueue(messageVO);
                        //continue;
                        AnalyzeCount.failNum++;
                        AnalyzeCount.curFailNum++;
                    }
                    //处理完从memched中删除此消息
                    if (messageVO.key != null)
                    {
                        IList<string> analyzedKeys = (List<string>)MemcachedClientSatat.getInstance().Get(MemcachedClientSatat.analyzedkey);
                        MemcachedClientSatat.getInstance(TcpDataProcesser.msgmemchached).deleteAnalyzed(messageVO.key, analyzedKeys);
                        MemcachedClientSatat.getInstance().remember(messageVO.key);
                    }
                }

                _isWork = false;
                Thread.Sleep(1 * 100);
            }
        }


        /// <summary>
        /// email解析，暂略
        /// </summary>
        /// <param name="cacheorbase">获取数据方式</param>
        public static void ProcessingEmail()
        {
            //    try
            //    {
            //        int iDataCount = 0;
            //        DateTime datestart = DateTime.Now;

            //        IList<EmailMessage> listemail = new List<EmailMessage>();

            //        if (iCacheDatabaseE > CacheDatabase)
            //        {
            //            listemail = DataProService.GetInstance().GetEmailMessageList();
            //            iCacheDatabaseE = 0;
            //        }
            //        else
            //        {
            //            ///从缓存中取数据；待定
            //            iCacheDatabaseE++;
            //        }

            //        if (listemail.Count > 0)
            //        {
            //            datestart = DateTime.Now;
            //            iDataCount = 0;
            //            foreach (EmailMessage modemail in listemail)
            //            {
            //                try
            //                {
            //                    EMAILMessage email = new EMAILMessage(modemail.content);
            //                    PlantRunData modplan =  EmailToPlantMod(email);
            //                    AddPlantDayData(modplan);

            //                    ///修改逆变器实时数据
            //                    if (email.ListEDevice != null && email.ListEDevice.Count > 0)
            //                    {
            //                        foreach (EDeviceRunInfo body in email.ListEDevice)
            //                        {
            //                            DeviceRunData moddev = new DeviceRunData();
            //                            ///邮件格式有待确定；怎么跟TCP消息内容不一致，乱七八糟
            //                            //moddev.ac_current = (decimal)body.ACI;
            //                            //moddev.ac_voltage = (decimal)body.ACV;
            //                            //moddev.dc_current = (decimal)body.DCI;
            //                            //moddev.dc_voltage = (decimal)body.ACV;
            //                            moddev.deviceAddr = body.DEVAddr;
            //                            moddev.deviceID = body.DEVAddr;
            //                            moddev.subplantID = modplan.subplantID;
            //                            moddev.power = decimal.Parse(body.DevPower);
            //                            moddev.total_energy = decimal.Parse(body.DevEtotal);
            //                            AddDeviceDayData(moddev, modplan);

            //                        }
            //                    }
            //                    ///添加错误日志
            //                    if (email.ListEBug != null && email.ListEBug.Count > 0)
            //                    {
            //                        foreach (EBugInfo tbug in email.ListEBug)
            //                        {
            //                            Fault modfault = new Fault();
            //                            //modfault.address = tbug.DeviceId;///据说已删除该字段
            //                            modfault.content = tbug.FaultType;
            //                            modfault.deviceNO = tbug.DevNo;
            //                            modfault.deviceType = tbug.DevType;
            //                            modfault.subplantID = modplan.subplantID;
            //                            modfault.sendtime = modplan.sendtime;
            //                            modfault.isconfirmed = "0";///未定？？？
            //                            modfault.info_rank = 0;///未定？？？
            //                            modfault.FaultName = ComCode.GetFaultTable(modfault.sendtime.Value.Year, modfault.sendtime.Value.Month);
            //                            DataProService.GetInstance().AddFault(modfault);
            //                        }
            //                    }
            //                    DataProService.GetInstance().UpdateEmailMessage(modemail);
            //                    modemail.flag = "1";
            //                    iDataCount++;
            //                }
            //                catch (Exception ee)
            //                {
            //                    continue;
            //                }
            //            }
            //            System.LogUtil.info("本次共检索出" + listemail.Count + "条邮件消息;\n 成功解析" + iDataCount + "条消息;\n 因为不符合协议格式等原因而未成功解析的数据共有" + (listemail.Count - iDataCount).ToString() + "条；\n 费时" + (DateTime.Now - datestart).TotalSeconds + "秒 ;当前时间:" + DateTime.Now.ToLongTimeString());
            //        }
            //    }
            //    catch (Exception ee)
            //    {
            //        System.LogUtil.info("异常：" + ee.Message);
            //    }
        }


    }
}
