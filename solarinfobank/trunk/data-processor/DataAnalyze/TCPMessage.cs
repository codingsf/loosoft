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
using Protocol20;

namespace DataAnalyze
{
    /// <summary>
    /// TCP消息
    /// 对应协议版本是1.0 和 2.0
    /// 首先要判断协议版本号，然后进行不同版本消息的不同解析方式，待完善
    /// </summary>
    public class TCPMessage : BaseMessage
    {
        int istart = 0 * hexbytecharnum; //头区开始下标
        int icount = 41 * hexbytecharnum;//头区字符长度，头区在1.0版本协议中为41个字节，十六进制表示
        int datalencount20 = 8 * hexbytecharnum;//2.0协议中头区中表示协议号位到数据部分之间的协议固定位数
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
            //add by qhb in 20120415 for 2.0新协议，暂时不处理小版本号，等以后有升级了在做区分
            if (headbefore.Equals("6969"))
            {
                largeVersion = 2;
                smallVersion = 0;
            }else if (headbefore.Equals("6868")) {//1.0旧协议
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
        /// 起始版本是2.0
        /// </summary>
        public void analysis2_0()
        {
            //取得从协议号到数据部分的长度（到具体字符了）
            int datalen = (int)SystemCode.HexNumberToDenary(this.messageContent.Substring(4 * 2, 4 * 2), SystemCode.ReversionType_all, 32, 'u') * 2;
            //先简单做数据长度校验，即协议中给出的数据长度和实际是否一致
            LogUtil.info("msg len:"+messageContent.Length);
            //取得数据
            int istart20 = 8 * hexbytecharnum;
            string data = this.messageContent.Substring(istart20, datalen).Substring(datalencount20);
            //数据类型码
            int datatypecode = (int)SystemCode.HexNumberToDenary(this.messageContent.Substring(14 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            //判断类别标识
            int innertypemark = (int)SystemCode.HexNumberToDenary(data.Substring(0 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            switch (datatypecode)
            {
                case DataType.DataType_plantinfo://电站信息数据
                    if (innertypemark == 11) {
                        //从key中取得sn
                        this.messageHeader = new TcpHeader20();
                        this.messageHeader.CollectorCode = msgkey.Substring(DataType.memcacheddata_affix_plantinfo.Length);
                        this.messageHeader.CollectorCode = this.messageHeader.CollectorCode.Substring(0, this.messageHeader.CollectorCode.IndexOf("_"));
                        this.plantInfo = PlantInfoHandler11.analysis(data);
                    }
                    break;
                case DataType.DataType_rundata:  //实时数据
                    //循环解析多个设备
                    listTcpbody = new List<DeviceDataBase>();
                    if (innertypemark == 41)
                    {
                        //从key中取得sn
                        this.messageHeader = new TcpHeader20();
                        this.messageHeader.CollectorCode = msgkey.Substring(DataType.memcacheddata_affix_run.Length);
                        this.messageHeader.CollectorCode = this.messageHeader.CollectorCode.Substring(0, this.messageHeader.CollectorCode.IndexOf("_"));
                        //取得公共地址
                        int deviceAddress = (int)SystemCode.HexNumberToDenary(data.Substring(2 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
                        if (deviceAddress == 0 || deviceAddress == 65535)//表示是电站实时数据
                        {
                            this.messageHeader.analyze(data);
                        }
                        else
                        {
                            string ssss = data.Substring(6 * 2, 6 * 2);
                            int year = 2000 + (int)SystemCode.HexNumberToDenary(ssss.Substring(10, 2), false, 8, 'u') % 99;
                            int moth = (int)SystemCode.HexNumberToDenary(ssss.Substring(8, 2), false, 8, 'u');
                            if (moth > 12) moth = 12;
                            int day = (int)SystemCode.HexNumberToDenary(ssss.Substring(6, 2), false, 8, 'u');
                            if (day > 31) day = 28;
                            int hh = (int)SystemCode.HexNumberToDenary(ssss.Substring(4, 2), false, 8, 'u');
                            if (hh > 23) hh = 23;
                            int mm = (int)SystemCode.HexNumberToDenary(ssss.Substring(2, 2), false, 8, 'u');
                            if (mm > 60) mm = 59;
                            int ss = (int)SystemCode.HexNumberToDenary(ssss.Substring(0, 2), false, 8, 'u');
                            if (ss > 60) ss = 59;
                            this.messageHeader.TimeNow = new DateTime(year, moth, day, hh, mm, ss);
                            this.messageHeader.issub = true;
                            this.messageHeader.hasData = false;
                            //设备实时数据
                            DeviceDataBase ddb = new DynamicDevice(data, this);
                            if (ddb.deviceType > -1)//设备的所有信息单元都不符合要求则忽略
                            {
                                listTcpbody.Add(ddb);
                            }
                            //故障数据
                            foreach(string[] fault in ddb.faultList){
                                Bug tcpb = new TcpBug20(fault, deviceAddress.ToString());
                                listTcpbug.Add(tcpb);
                            }
                        }
                    }
                    break;
                case DataType.DataType_historydata://历史数据
                    break;
                case DataType.DataType_deviceinfo: //设备数据
                    break;
                default:
                    //do nothing
                    break;
            }
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
                        case DeviceData.TYPE_AMMETER_11://电表协议1.1
                            icount = ProtocolConst.LENGTH_AMMETER_11 * 2;
                            if (istart + icount > this.messageContent.Length)
                            {
                                istart = istart + icount;
                                break;
                            }
                            else
                            {
                                ddb = new Ammeter11(this.messageContent.Substring(istart, icount), this);
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
                        string bugmsg = this.messageContent.Substring(istart + i * ProtocolConst.LENGTH_BUG * 2, ProtocolConst.LENGTH_BUG * 2);
                        try
                        {
                            Bug tcpb = new TcpBug(bugmsg);
                            listTcpbug.Add(tcpb);
                        }
                        catch (Exception buge) {
                            LogUtil.error("告警信息解析错误：" +bugmsg+":"+ buge.Message);
                        }
                        
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