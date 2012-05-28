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
using System.Reflection;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace DataAnalyze
{
    /// <summary>
    /// TCP消息
    /// 对应协议版本是1.0
    /// 首先要判断协议版本号，然后进行不同版本消息的不同解析方式，待完善
    /// </summary>
    public class TCPMessage : BaseMessage
    {
        int istart = 0 * hexbytecharnum; //头区开始下标
        int icount = 41 * hexbytecharnum;//头区字符长度，头区在1.0版本协议中为41个字节，十六进制表示，不同

        int versionLength = 19 * hexbytecharnum;//版本在消息中固定开始位置

        /// <summary>
        /// 构造tcp 消息对象，并解析消息
        /// 一个字节两个字符
        /// </summary>
        /// <param name="content"></param>
        public TCPMessage(string msgkey,string content)
        {
            this.msgkey = msgkey;
            this.messageContent = content.Replace("0x", string.Empty).Replace(" ", string.Empty).Replace("\r", string.Empty).Replace("\n", string.Empty);
            string headbefore = this.messageContent.Substring(0, 4);//用头部分4个字符表示协议版本
            if (headbefore.Equals("6868")) {
                largeVersion = 1;
                smallVersion = 0;
            }
            //largeVersion = (int)SystemCode.HexNumberToDenary(this.messageContent.Substring(versionLength, 1 * hexbytecharnum), false, 8, 'u');//协议版本占两个字节， 即两个四个字符,大版本在前
            //smallVersion = (int)SystemCode.HexNumberToDenary(this.messageContent.Substring(versionLength + 1 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');//协议版本占两个字节， 即两个四个字符,大版本在前
            analysis();
        }

        /// <summary>
        /// 解析方法，根据协议调用不同的协议解析方法
        /// </summary>
        public void analysis()
        {
            //根据协议调用不同版本的解析方法
            string analysisMethodName = analysisAffix + largeVersion + "_" + smallVersion;

            //反射调用具体版本对应的方法
            Type ht = this.GetType();
            MethodInfo methodInfo = ht.GetMethod(analysisMethodName);
            if (methodInfo == null)
            {
                LogUtil.info("协议版本不在处理范围之内，传入为" + largeVersion + "." + smallVersion + "，消息为：" + this.messageContent);
            }
            object returnValue = methodInfo.Invoke(this, null);  
        }

        /// <summary>
        /// 起始版本是0.1
        /// </summary>
        public void analysis0_1()
        {
            analysis1_0or0_1();
        }
        /// <summary>
        /// 起始版本是1.0
        /// </summary>
        public void analysis1_0()
        {
            analysis1_0or0_1();
        }

        /// <summary>
        /// 1.0和0.1都用同一种协议解析
        /// </summary>
        private void analysis1_0or0_1()
        {

            int alllength = (int)SystemCode.HexNumberToDenary(this.messageContent.Substring(2 * 2, 2 * 2), true, 32, 'u') * 2;

            if (this.messageContent.Length >= (istart + icount) && alllength == (this.messageContent.Length - 2 * 2))
            {
                messageHeader = new TcpHeader();
                messageHeader.analyze(this.messageContent.Substring(istart, icount));
                istart = istart + icount;

                //循环解析多个设备
                listTcpbody = new List<DeviceDataBase>();
                for (int i = 0; i < this.messageHeader.DevicesNum; i++)
                {
                    DeviceDataBase ddb = null;
                    if (istart > messageContent.Length)
                        break;
                    int type = (int)SystemCode.HexNumberToDenary(this.messageContent.Substring(istart + 2 * 2, 1 * 2), true, 32, 'u');
                    switch (type)
                    {
                        case DeviceData.TYPE_MODBUS_BUSBAR://modbus协议汇流箱
                            icount = ProtocolConst.LENGTH_MODBUS_BUSBAR * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new ModbusBusbar(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_MODBUS15_BUSBAR://光伏阵列汇流箱通讯协议（Modbus）V1.1.1.0-2011.8.30.pdf add by qianhb in 20111220
                            icount = ProtocolConst.LENGTH_MODBUS15_BUSBAR * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new Modbus15Busbar(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_MODBUS_CABINET://modbus协议配电柜
                            icount = ProtocolConst.LENGTH_MODBUS_CABINET * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new ModbusCabinet(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_MODBUS16_CABINET://光伏直流配电柜通信协议（Modbus）V1.0-柴达木-2011.8.30.pdf add by qianhb in 20111220
                            icount = ProtocolConst.LENGTH_MODBUS16_CABINET * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new Modbus16Cabinet(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_MODBUS_DETECTOR://设备类型0x22对应的数据区格式,环境检测仪（MODBUS协议） add by qianhb in 20111220
                            icount = ProtocolConst.LENGTH_MODBUS_DETECTOR * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new ModbusDetector(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_MODBUS_DETECTOR_V1020://设备类型0x23对应的数据区格式,环境检测仪（MODBUS协议） add by qianhb in 20120314
                            icount = ProtocolConst.LENGTH_MODBUS_DETECTOR_1020 * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new ModbusDetector1020(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_MODBUS_INVERTER://modbus协议逆变器
                            icount = ProtocolConst.LENGTH_MODBUS_INVERTER * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new ModbusInverter(this.messageContent.Substring(istart, icount),this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_SUNGROW_BUSBAR://sungrows协议汇流箱
                            icount = ProtocolConst.LENGTH_SUNGROW_BUSBAR * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new SungrowBusbar(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_SUNGROW_CABINET://sungrows协议配电柜
                            icount = ProtocolConst.LENGTH_SUNGROW_CABINET * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new SungrowCabinet(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_SUNGROW_DETECTOR://sungrow协议检测仪
                            icount = ProtocolConst.LENGTH_SUNGROW_DETECTOR * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new SungrowDetector(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_SUNGROW_INVERTER://sungrow协议逆变器
                            icount = ProtocolConst.LENGTH_SUNGROW_INVERTER * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new SungrowInverter(this.messageContent.Substring(istart, icount),this);
                                istart = istart + icount;
                                break;
                            }
                        case DeviceData.TYPE_AMMETER://电表协议
                            icount = ProtocolConst.LENGTH_AMMETER * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new Ammeter(this.messageContent.Substring(istart, icount), this);
                                istart = istart + icount;
                                break;
                            }
                        default:
                            istart = istart + this.messageContent.Length;
                            break;
                    }

                    if (ddb != null)
                        listTcpbody.Add(ddb);
                }

                //取得告警信息
                listTcpbug = new List<Bug>();
                if (this.messageContent.Length > (ProtocolConst.LENGTH_BUG + ProtocolConst.LENGTH_HEAD) * 2)
                {
                    istart = this.messageContent.Length - ProtocolConst.LENGTH_BUG * 2 * (this.messageHeader.BugNum);
                    for (int i = 0; i < this.messageHeader.BugNum; i++)
                    {
                        Bug tcpb = new TcpBug(this.messageContent.Substring(istart + i * ProtocolConst.LENGTH_BUG * 2, ProtocolConst.LENGTH_BUG * 2));
                        listTcpbug.Add(tcpb);
                    }
                }
            }
            else
            {
                base.messageHeader = new TcpHeader();
                listTcpbody = new List<DeviceDataBase>();
                listTcpbug = new List<Bug>();
            }
        }
    }


}