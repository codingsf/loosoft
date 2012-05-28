using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
namespace Protocol
{
    /// <summary>
    /// 配电柜装置
    /// </summary>
    public class SungrowCabinet : DeviceDataBase
    {
        public string DevName = "配电柜装置";
        int deviceDataHeadLength = 5;//5字节

        /// <summary>
        /// 根据汇流箱sungorw协议解析单个设备数据
        /// </summary>
        public void analysis()
        {
            //deviceData
            //设备型号 此协议中无此数据
            //base.deviceXh = (int)SystemCode.HexNumberToDenary(deviceData.Substring(deviceDataHeadLength * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            //地址
            base.deviceAddress = SystemCode.HexNumberToDenary(deviceData.Substring(1 * hexbytecharnum, 1 * hexbytecharnum), true, 8, 'u').ToString();
            //设备版本
            int largeVersion = (int)SystemCode.HexNumberToDenary(deviceData.Substring(3 * hexbytecharnum, 1 * hexbytecharnum), true, 8, 'u');
            int smallVersion = (int)SystemCode.HexNumberToDenary(deviceData.Substring(4 * hexbytecharnum, 1 * hexbytecharnum), true, 8, 'u');
            base.deviceVersion = largeVersion + "." + smallVersion;
            //设备协议类型
            base.protocolType = (int)SystemCode.HexNumberToDenary(deviceData.Substring(2 * hexbytecharnum, 1 * hexbytecharnum), true, 8, 'u');

            //测点数据串去掉设备数据的头部
            string monitorstr = deviceData.Substring(deviceDataHeadLength * hexbytecharnum);
            //按照测点在协议中的顺序依次解析具体测点数据
            //第一路电流 0.1A
            double current1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(0 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current1 = Math.Round(current1 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_1CURRENT] = current1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_1CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_1CURRENT] = current1;
            //第二路电流
            double current2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(1 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current2 = Math.Round(current2 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_2CURRENT] = current2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_2CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_2CURRENT] = current2;
            //三路电流
            double current3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(2 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current3 = Math.Round(current3 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_3CURRENT] = current3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_3CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_3CURRENT] = current3;
            //第四路电流
            double current4 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(3 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current4= Math.Round(current4 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_4CURRENT] = current4;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_4CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_4CURRENT] = current4;
            //第五路电流
            double current5 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(4 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current5 = Math.Round(current5 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_4CURRENT] = current5;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_5CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_5CURRENT] = current5;
            //第六路电流
            double current6 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(5 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current6 = Math.Round(current6 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_6CURRENT] = current6;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_6CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_6CURRENT] = current6;
            //第七路电流
            double current7 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(6 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current7 = Math.Round(current7 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_7CURRENT] = current7;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_7CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_7CURRENT] = current7;
            //第八路电流
            double current8 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(7 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current8 = Math.Round(current8 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_8CURRENT] = current8;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_8CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_8CURRENT] = current8;
            //第九路电流
            double current9 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(8 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current9 = Math.Round(current9 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_9CURRENT] = current9;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_9CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_9CURRENT] = current9;
            //第十路电流
            double current10 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(9 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current10 = Math.Round(current10 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_10CURRENT] = current10;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_10CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_10CURRENT] = current10;
            //第十路电流
            double current11 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(10 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current11 = Math.Round(current11 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_11CURRENT] = current11;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_11CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_11CURRENT] = current11;
            //第十二路电流
            double current12 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(11 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current12 = Math.Round(current12 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_12CURRENT] = current12;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_12CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_12CURRENT] = current12;
            //第十三路电流
            double current13 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(12 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current13 = Math.Round(current13 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_13CURRENT] = current13;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_13CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_13CURRENT] = current13;
            //第十四路电流
            double current14 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(13 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current14 = Math.Round(current14 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_14CURRENT] = current14;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_14CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_14CURRENT] = current14;
            //第十五路电流
            double current15 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(14 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current15 = Math.Round(current15 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_15CURRENT] = current15;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_15CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_15CURRENT] = current15;
            //第十六路电流
            double current16 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(15 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            current16 = Math.Round(current16 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_16CURRENT] = current16;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_16CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_16CURRENT] = current16;

            //阵列电压
            int ZLVOILT = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(17 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            current3 = Math.Round(current3 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_ZLVOILT] =ZLVOILT;

            //数字输入
            int DIGITALINPUT = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(19 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_DIGITALINPUT] =DIGITALINPUT;
            //继电器输出
            int JDQOUT = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(20 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_JDQOUT] =JDQOUT;
            //接入传感器路数
            int CGQLINENUM = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(21 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_CGQLINENUM] =CGQLINENUM;
            //通讯类型 bank不显示
            int COMMUNICATION = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(22 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            //realMonitorMap[MonitorType.MIC_BUSBAR_COMMUNICATION] =COMMUNICATION;


            //总电流
            double totalC = current1 + current2 + current3 + current4 + current5
                + current6 + current7 + current8 + current9 + current10 + current11 + current12 +
                +current13 + current14 + current15 + current16;
            realMonitorMap[MonitorType.MIC_BUSBAR_TOTALCURRENT] = totalC;
            historyMonitorMap[MonitorType.MIC_BUSBAR_TOTALCURRENT] = totalC;

            tableType = TableUtil.CABINET;
        }
        public SungrowCabinet(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.analysis();
        }
    }
}
