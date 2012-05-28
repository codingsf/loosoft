/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年2月17日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Protocol;
using Cn.Loosoft.Zhisou.SunPower.Common;
namespace DataAnalyze
{
    /// <summary>
    /// Email消息
    /// </summary>
    public class EmailMessage : BaseMessage
    {
        public EmailMessage(string content)
        {
            this.messageContent = content.Replace("0x", string.Empty).Replace(" ", string.Empty).Replace("\r", string.Empty).Replace("\n", string.Empty);
            int istart = this.messageContent.IndexOf("[DATALOG]");
            int istatrt2 = this.messageContent.IndexOf("[DEV1]");
            if (istatrt2 < 0)
            {
                istatrt2 = this.messageContent.IndexOf("[FAULT1]");
                if (istatrt2 < 0)
                {
                    istatrt2 = this.messageContent.Length - 1;
                }
            }
            int icount = istatrt2 - istart;

            base.messageHeader = new EmailHeader();
            messageHeader.analyze(this.messageContent.Substring(istart, icount));
            istart = istart + icount;


            listTcpbody = new List<DeviceDataBase>();
            for (int i = 1; i <= messageHeader.DevicesNum; i++)
            {
                DeviceDataBase ddb = new DeviceDataBase();
                if (istart > messageContent.Length)
                    break;
                istart = this.messageContent.IndexOf("[DEV" + i + "]");
                if (istart < 0)
                    continue;

                istatrt2 = this.messageContent.IndexOf("[DEV" + (i + 1).ToString() + "]");
                if (istatrt2 < 0)
                {
                    istatrt2 = this.messageContent.IndexOf("[FAULT1]");
                    if (istatrt2 < 0)
                    {
                        istatrt2 = this.messageContent.Length - 1;
                    }
                }

                icount = istatrt2 - istart;

                string baby = this.messageContent.Substring(istart, icount).Replace("[DEV" + i + "]", string.Empty);

                istart = baby.IndexOf("DEVTYPE=");
                istatrt2 = baby.IndexOf("DEVVER=");
                icount = istatrt2 - istart;
                int type = int.Parse(baby.Substring(istart, icount).Replace("DEVTYPE=", string.Empty));

                switch (type)
                {
                    case DeviceData.TYPE_MODBUS_BUSBAR:
                        ddb = new EModbusBusbar(baby);
                        break;
                    case DeviceData.TYPE_MODBUS_DETECTOR://协议暂时不知道
                        //ddb = new ModbusDetector(this.messageContent.Substring(istar, icount));
                        //istar = istar + icount;
                        istart = istart + this.messageContent.Length;
                        break;
                    case DeviceData.TYPE_MODBUS_INVERTER:
                        ddb = new EModbusInverter(baby);
                        break;
                    case DeviceData.TYPE_SUNGROW_BUSBAR:
                        ddb = new ESungrowBusbar(baby);
                        break;
                    case DeviceData.TYPE_SUNGROW_DETECTOR:
                        ddb = new ESungrowDetector(baby);
                        break;
                    case DeviceData.TYPE_SUNGROW_INVERTER:
                        ddb = new ESungrowInverter(baby);
                        break;
                    default:
                        istart = istart + this.messageContent.Length;
                        break;
                }
                listTcpbody.Add(ddb);
            }
            listTcpbug = new List<Bug>();
            istart = this.messageContent.Length - ProtocolConst.LENGTH_BUG * 2 * (this.messageHeader.BugNum);
            for (int i = 1; i <= this.messageHeader.BugNum; i++)
            {
                istart = this.messageContent.IndexOf("[FAULT" + i + "]");
                istatrt2 = this.messageContent.IndexOf("[FAULT" + (i + 1) + "]");
                if (istatrt2 < 0)
                {
                    istatrt2 = this.messageContent.Length - 1;
                }
                icount = istatrt2 - istart;
                EBug emailb = new EBug(this.messageContent.Substring(istart, icount).Replace("[FAULT" + i + "]", string.Empty));
                listTcpbug.Add(emailb);
            }
        }
    }
}