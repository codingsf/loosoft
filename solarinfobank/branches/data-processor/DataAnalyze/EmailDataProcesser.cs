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
namespace DataAnalyze
{
    /// <summary>
    /// 数据解析主程序
    /// </summary>
    public class EmailDataProcesser
    {
        /// <summary>
        /// email解析
        /// </summary>
        /// <param name="cacheorbase">获取数据方式</param>
        public void Processing()
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
            //            System.Console.WriteLine("本次共检索出" + listemail.Count + "条邮件消息;\n 成功解析" + iDataCount + "条消息;\n 因为不符合协议格式等原因而未成功解析的数据共有" + (listemail.Count - iDataCount).ToString() + "条；\n 费时" + (DateTime.Now - datestart).TotalSeconds + "秒 ;当前时间:" + DateTime.Now.ToLongTimeString());
            //        }
            //    }
            //    catch (Exception ee)
            //    {
            //        System.Console.WriteLine("异常：" + ee.Message);
            //    }
        }


    }
}
