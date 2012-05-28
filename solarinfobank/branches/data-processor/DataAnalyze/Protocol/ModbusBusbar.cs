using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
namespace Protocol
{
    /// <summary>
    /// 汇流箱装置
    /// </summary>
    public class ModbusBusbar : DeviceDataBase
    {

        public string DevName = "汇流箱装置";
        int deviceDataHeadLength = 5;//5字节
        /// <summary>
        /// 根据逆变器modbus协议解析单个设备数据
        /// </summary>
        public void analysis()
        {
            //deviceData
            //设备型号
            base.deviceXh = (int)SystemCode.HexNumberToDenary(deviceData.Substring(deviceDataHeadLength * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            //地址
            base.deviceAddress = SystemCode.HexNumberToDenary(deviceData.Substring(1 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u').ToString();
            //设备版本
            int largeVersion = (int)SystemCode.HexNumberToDenary(deviceData.Substring(3 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            int smallVersion = (int)SystemCode.HexNumberToDenary(deviceData.Substring(4 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            base.deviceVersion = largeVersion + "." + smallVersion;
            //设备协议类型
            base.protocolType = (int)SystemCode.HexNumberToDenary(deviceData.Substring(2 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            //测点数据串去掉设备数据的头部
            string monitorstr = deviceData.Substring(deviceDataHeadLength * hexbytecharnum);
            //最大接入路数
            int MAXLINE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(2 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_MAXLINE] = MAXLINE;
            //机内温度0.1℃
            double JNTEMPRATURE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(4 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            JNTEMPRATURE = Math.Round(JNTEMPRATURE * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_JNTEMPRATURE] = JNTEMPRATURE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_JNTEMPRATURE))
                historyMonitorMap[MonitorType.MIC_BUSBAR_JNTEMPRATURE] = JNTEMPRATURE;
            //直流母线电压0.1V
            double DCUXVOLT = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(6 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            DCUXVOLT = Math.Round(DCUXVOLT * 0.1, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_DCUXVOLT] = DCUXVOLT;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_DCUXVOLT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_DCUXVOLT] = DCUXVOLT;
            //数字输入
            int ATAINPUT = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(8 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_DIGITALINPUT] = ATAINPUT;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_DIGITALINPUT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_DIGITALINPUT] = ATAINPUT;

            //第一路电流0.01A
            double CURRENT1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(18 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT1 = Math.Round(CURRENT1 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_1CURRENT] = CURRENT1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_1CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_1CURRENT] = CURRENT1;
            //第二路电流0.01A
            double CURRENT2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(20 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT2 = Math.Round(CURRENT2 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_2CURRENT] = CURRENT2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_2CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_2CURRENT] = CURRENT2;
            //第三路电流0.01A
            double CURRENT3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(22 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT3 = Math.Round(CURRENT3 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_3CURRENT] = CURRENT3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_3CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_3CURRENT] = CURRENT3;
            //第四路电流0.01A
            double CURRENT4 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(24 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT4 = Math.Round(CURRENT4 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_4CURRENT] = CURRENT4;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_4CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_4CURRENT] = CURRENT4;

            //第五路电流0.01A
            double CURRENT5 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(26 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT5 = Math.Round(CURRENT5 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_5CURRENT] = CURRENT5;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_5CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_5CURRENT] = CURRENT5;
            //第六路电流0.01A
            double CURRENT6 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(28 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT6 = Math.Round(CURRENT6 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_6CURRENT] = CURRENT6;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_6CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_6CURRENT] = CURRENT6;
            //第七路电流0.01A
            double CURRENT7 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(30 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT7 = Math.Round(CURRENT7 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_7CURRENT] = CURRENT7;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_7CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_7CURRENT] = CURRENT7;
            //第八路电流0.01A
            double CURRENT8 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(32 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT8 = Math.Round(CURRENT8 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_8CURRENT] = CURRENT8;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_8CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_8CURRENT] = CURRENT8;

            //第九路电流0.01A
            double CURRENT9 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(34 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT9 = Math.Round(CURRENT9 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_9CURRENT] = CURRENT9;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_9CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_9CURRENT] = CURRENT9;

            //第十路电流0.01A
            double CURRENT10 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(36 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT10 = Math.Round(CURRENT10 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_10CURRENT] = CURRENT10;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_10CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_10CURRENT] = CURRENT10;
            //第十一路电流0.01A
            double CURRENT11 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(38 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT11 = Math.Round(CURRENT11 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_11CURRENT] = CURRENT11;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_11CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_11CURRENT] = CURRENT11;
            //第十二路电流0.01A
            double CURRENT12 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(40 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT12 = Math.Round(CURRENT12 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_12CURRENT] = CURRENT12;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_12CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_12CURRENT] = CURRENT12;
            //第十三路电流0.01A
            double CURRENT13 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(42 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT13 = Math.Round(CURRENT13 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_13CURRENT] = CURRENT13;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_13CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_13CURRENT] = CURRENT13;
            //第十四路电流0.01A
            double CURRENT14 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(44 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT14 = Math.Round(CURRENT14 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_14CURRENT] = CURRENT14;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_14CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_14CURRENT] = CURRENT14;

            // 第十五路电流0.01A
            double CURRENT15 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(46 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT15 = Math.Round(CURRENT15 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_15CURRENT] = CURRENT15;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_15CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_15CURRENT] = CURRENT15;

            // 第十六路电流0.01A
            double CURRENT16 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(48 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT16 = Math.Round(CURRENT16 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_16CURRENT] = CURRENT16;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_16CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_16CURRENT] = CURRENT16;
            
            //总电流
            double totalC = CURRENT1 + CURRENT2 + CURRENT3 + CURRENT4 + CURRENT5
                + CURRENT6 + CURRENT7 + CURRENT8 + CURRENT9 + CURRENT10 + CURRENT11 + CURRENT12 +
                +CURRENT13 + CURRENT14 + CURRENT15 + CURRENT16;
            realMonitorMap[MonitorType.MIC_BUSBAR_TOTALCURRENT] = totalC;
            historyMonitorMap[MonitorType.MIC_BUSBAR_TOTALCURRENT] = totalC;

            deviceType = TableUtil.HUILIUXIANG;

        }

        public ModbusBusbar(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.analysis();
        }

    }
}
