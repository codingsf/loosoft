using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
namespace Protocol
{
    /// <summary>
    /// 汇流箱装置光伏阵列汇流箱通讯协议（Modbus）V1.1.1.0-2011.8.30.pdf
    /// add by qianhb in 20111220
    /// </summary>s
    public class Modbus15Busbar : DeviceDataBase
    {

        public string DevName = "汇流箱装置";
        int deviceDataHeadLength = 5;//5字节
        /// <summary>
        /// 根据逆变器光伏阵列汇流箱通讯协议（Modbus）V1.1.1.0解析单个设备数据
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

            //直流母线电压0.1V
            double DCUXVOLT = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(12 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            DCUXVOLT = Math.Round(DCUXVOLT * 0.1, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_DCUXVOLT] = DCUXVOLT;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_DCUXVOLT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_DCUXVOLT] = DCUXVOLT;

            //机内温度0.1℃
            double JNTEMPRATURE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(14 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            JNTEMPRATURE = Math.Round(JNTEMPRATURE * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_JNTEMPRATURE] = JNTEMPRATURE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_JNTEMPRATURE))
                historyMonitorMap[MonitorType.MIC_BUSBAR_JNTEMPRATURE] = JNTEMPRATURE;

            //数字输入
            int ATAINPUT = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(20 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            //realMonitorMap[MonitorType.MIC_BUSBAR_DIGITALINPUT] = ATAINPUT;
            //if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_DIGITALINPUT))
                //historyMonitorMap[MonitorType.MIC_BUSBAR_DIGITALINPUT] = ATAINPUT;
            //数字输入modify by qhb in 20120825 for 新需求《数据处理新需求整理及工作量评估-调整》这个是U16的，16个字节 ，其中0-4字节用了，其他字节没用，现在要按附录一解析，将一个变量拆成2个 ，分别是防雷器和断路器，界面用2个圆灯表示  ，正常灯是绿色 ，不正常灯是红色，防雷器状态 为1表示正常 ，断路器 为0表示正常。
            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string inputstr = getFullbitstr(ATAINPUT, 16);
            realMonitorMap[MonitorType.MIC_BUSBAR_DIGITALINPUT] = ATAINPUT;
            //modify  end

            //最大电流0.01A
            double maxcurrent = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(22 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            maxcurrent = Math.Round(maxcurrent * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_MAXCURRENT] = maxcurrent;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_MAXCURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_MAXCURRENT] = maxcurrent;

            //平均电流0.01A
            double avgcurrent = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(24 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            avgcurrent = Math.Round(avgcurrent * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_AVGCURRENT] = avgcurrent;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_AVGCURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_AVGCURRENT] = avgcurrent;

            //第一路电流0.01A
            double CURRENT1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(26 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'U');
            CURRENT1 = Math.Round(CURRENT1 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_1CURRENT] = CURRENT1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_1CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_1CURRENT] = CURRENT1;

            //第二路电流0.01A
            double CURRENT2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(28 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'U');
            CURRENT2 = Math.Round(CURRENT2 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_2CURRENT] = CURRENT2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_2CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_2CURRENT] = CURRENT2;

            //第三路电流0.01A
            double CURRENT3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(30 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT3 = Math.Round(CURRENT3 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_3CURRENT] = CURRENT3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_3CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_3CURRENT] = CURRENT3;

            //第四路电流0.01A
            double CURRENT4 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(32 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT4 = Math.Round(CURRENT4 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_4CURRENT] = CURRENT4;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_4CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_4CURRENT] = CURRENT4;

            //第五路电流0.01A
            double CURRENT5 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(34 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT5 = Math.Round(CURRENT5 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_5CURRENT] = CURRENT5;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_5CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_5CURRENT] = CURRENT5;

            //第六路电流0.01A
            double CURRENT6 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(36 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT6 = Math.Round(CURRENT6 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_6CURRENT] = CURRENT6;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_6CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_6CURRENT] = CURRENT6;

            //第七路电流0.01A
            double CURRENT7 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(38 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT7 = Math.Round(CURRENT7 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_7CURRENT] = CURRENT7;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_7CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_7CURRENT] = CURRENT7;

            //第八路电流0.01A
            double CURRENT8 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(40 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT8 = Math.Round(CURRENT8 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_8CURRENT] = CURRENT8;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_8CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_8CURRENT] = CURRENT8;

            //第九路电流0.01A
            double CURRENT9 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(42 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT9 = Math.Round(CURRENT9 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_9CURRENT] = CURRENT9;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_9CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_9CURRENT] = CURRENT9;

            //第十路电流0.01A
            double CURRENT10 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(44 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT10 = Math.Round(CURRENT10 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_10CURRENT] = CURRENT10;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_10CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_10CURRENT] = CURRENT10;

            //第十一路电流0.01A
            double CURRENT11 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(46 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT11 = Math.Round(CURRENT11 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_11CURRENT] = CURRENT11;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_11CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_11CURRENT] = CURRENT11;

            //第十二路电流0.01A
            double CURRENT12 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(48 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT12 = Math.Round(CURRENT12 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_12CURRENT] = CURRENT12;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_12CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_12CURRENT] = CURRENT12;

            //第十三路电流0.01A
            double CURRENT13 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(50 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT13 = Math.Round(CURRENT13 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_13CURRENT] = CURRENT13;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_13CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_13CURRENT] = CURRENT13;

            //第十四路电流0.01A
            double CURRENT14 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(52 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT14 = Math.Round(CURRENT14 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_14CURRENT] = CURRENT14;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_14CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_14CURRENT] = CURRENT14;

            // 第十五路电流0.01A
            double CURRENT15 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(54 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT15 = Math.Round(CURRENT15 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_15CURRENT] = CURRENT15;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_15CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_15CURRENT] = CURRENT15;

            // 第十六路电流0.01A
            double CURRENT16 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(56 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT16 = Math.Round(CURRENT16 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_16CURRENT] = CURRENT16;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_16CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_16CURRENT] = CURRENT16;

            //总电流0.1A
            double totalC = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(62 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');
            totalC = Math.Round(totalC * 0.1, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_TOTALCURRENT] = totalC;
            historyMonitorMap[MonitorType.MIC_BUSBAR_TOTALCURRENT] = totalC;

            //状态
            int status = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(82 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');
            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string statusstr = getFullbitstr(status, 32);
            realMonitorMap[MonitorType.MIC_BUSBAR_STATUS] = status;
            //historyMonitorMap[MonitorType.MIC_BUSBAR_STATUS] = status;

            //短路数据
            int dxdata = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(86 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');
            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string dxdatastr = getFullbitstr(dxdata, 32);
            realMonitorMap[MonitorType.MIC_BUSBAR_DUANLUDATA] = dxdata;
            //historyMonitorMap[MonitorType.MIC_BUSBAR_DUANLUDATA] = dxdata;

            //电流过高数据
            int dlgg = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(94 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');
            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            ///string dlggstr = getFullbitstr(dlgg, 32);
            realMonitorMap[MonitorType.MIC_BUSBAR_DLGGDATA] = dlgg;
           // historyMonitorMap[MonitorType.MIC_BUSBAR_DLGGDATA] dlgg dlgg;

            //电流过低数据
            int dlgd = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(102 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');

            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string dlgdstr = getFullbitstr(dlgd, 32);

            realMonitorMap[MonitorType.MIC_BUSBAR_DLGDDATA] = dlgd;
            //historyMonitorMap[MonitorType.MIC_BUSBAR_DLGDDATA] = dlgd;

            //开路数据
            int kailudata = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(110 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');

            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string kailudatastr = getFullbitstr(kailudata, 32);

            realMonitorMap[MonitorType.MIC_BUSBAR_KAILUDATA] = kailudata;
            //historyMonitorMap[MonitorType.MIC_BUSBAR_KAILUDATA] = kailudata;

            tableType = TableUtil.HUILIUXIANG;
        }

        public Modbus15Busbar(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.analysis();
        }
    }

    /// <summary>
    /// 汇流箱装置光伏阵列汇流箱通讯协议（Modbus）V1.1.1.0-2011.8.30.pdf
    /// add by qianhb in 20111220
    /// </summary>s
    public class Modbus17Busbar : DeviceDataBase
    {

        public string DevName = "汇流箱装置";
        int deviceDataHeadLength = 5;//5字节
        /// <summary>
        /// 根据逆变器光伏阵列汇流箱通讯协议（Modbus）V1.1.1.0解析单个设备数据
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

            //直流母线电压0.1V
            double DCUXVOLT = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(12 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            DCUXVOLT = Math.Round(DCUXVOLT * 0.1, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_DCUXVOLT] = DCUXVOLT;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_DCUXVOLT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_DCUXVOLT] = DCUXVOLT;

            //机内温度0.1℃
            double JNTEMPRATURE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(14 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            JNTEMPRATURE = Math.Round(JNTEMPRATURE * 0.1, 1);
            realMonitorMap[MonitorType.MIC_BUSBAR_JNTEMPRATURE] = JNTEMPRATURE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_JNTEMPRATURE))
                historyMonitorMap[MonitorType.MIC_BUSBAR_JNTEMPRATURE] = JNTEMPRATURE;

            //数字输入
            int ATAINPUT = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(20 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            //realMonitorMap[MonitorType.MIC_BUSBAR_DIGITALINPUT] = ATAINPUT;
            //if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_DIGITALINPUT))
            //historyMonitorMap[MonitorType.MIC_BUSBAR_DIGITALINPUT] = ATAINPUT;
            //数字输入modify by qhb in 20120825 for 新需求《数据处理新需求整理及工作量评估-调整》这个是U16的，16个字节 ，其中0-4字节用了，其他字节没用，现在要按附录一解析，将一个变量拆成2个 ，分别是防雷器和断路器，界面用2个圆灯表示  ，正常灯是绿色 ，不正常灯是红色，防雷器状态 为1表示正常 ，断路器 为0表示正常。
            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string inputstr = getFullbitstr(ATAINPUT, 16);
            realMonitorMap[MonitorType.MIC_BUSBAR_DIGITALINPUT] = ATAINPUT;
            //modify  end

            //最大电流0.01A
            double maxcurrent = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(22 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            maxcurrent = Math.Round(maxcurrent * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_MAXCURRENT] = maxcurrent;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_MAXCURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_MAXCURRENT] = maxcurrent;

            //平均电流0.01A
            double avgcurrent = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(24 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            avgcurrent = Math.Round(avgcurrent * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_AVGCURRENT] = avgcurrent;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_AVGCURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_AVGCURRENT] = avgcurrent;

            //第一路电流0.01A
            double CURRENT1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(26 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'U');
            CURRENT1 = Math.Round(CURRENT1 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_1CURRENT] = CURRENT1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_1CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_1CURRENT] = CURRENT1;

            //第二路电流0.01A
            double CURRENT2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(28 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'U');
            CURRENT2 = Math.Round(CURRENT2 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_2CURRENT] = CURRENT2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_2CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_2CURRENT] = CURRENT2;

            //第三路电流0.01A
            double CURRENT3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(30 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT3 = Math.Round(CURRENT3 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_3CURRENT] = CURRENT3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_3CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_3CURRENT] = CURRENT3;

            //第四路电流0.01A
            double CURRENT4 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(32 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT4 = Math.Round(CURRENT4 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_4CURRENT] = CURRENT4;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_4CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_4CURRENT] = CURRENT4;

            //第五路电流0.01A
            double CURRENT5 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(34 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT5 = Math.Round(CURRENT5 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_5CURRENT] = CURRENT5;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_5CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_5CURRENT] = CURRENT5;

            //第六路电流0.01A
            double CURRENT6 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(36 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT6 = Math.Round(CURRENT6 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_6CURRENT] = CURRENT6;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_6CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_6CURRENT] = CURRENT6;

            //第七路电流0.01A
            double CURRENT7 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(38 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT7 = Math.Round(CURRENT7 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_7CURRENT] = CURRENT7;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_7CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_7CURRENT] = CURRENT7;

            //第八路电流0.01A
            double CURRENT8 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(40 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT8 = Math.Round(CURRENT8 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_8CURRENT] = CURRENT8;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_8CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_8CURRENT] = CURRENT8;

            //第九路电流0.01A
            double CURRENT9 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(42 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT9 = Math.Round(CURRENT9 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_9CURRENT] = CURRENT9;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_9CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_9CURRENT] = CURRENT9;

            //第十路电流0.01A
            double CURRENT10 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(44 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT10 = Math.Round(CURRENT10 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_10CURRENT] = CURRENT10;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_10CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_10CURRENT] = CURRENT10;

            //第十一路电流0.01A
            double CURRENT11 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(46 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT11 = Math.Round(CURRENT11 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_11CURRENT] = CURRENT11;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_11CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_11CURRENT] = CURRENT11;

            //第十二路电流0.01A
            double CURRENT12 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(48 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT12 = Math.Round(CURRENT12 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_12CURRENT] = CURRENT12;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_12CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_12CURRENT] = CURRENT12;

            //第十三路电流0.01A
            double CURRENT13 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(50 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT13 = Math.Round(CURRENT13 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_13CURRENT] = CURRENT13;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_13CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_13CURRENT] = CURRENT13;

            //第十四路电流0.01A
            double CURRENT14 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(52 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT14 = Math.Round(CURRENT14 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_14CURRENT] = CURRENT14;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_14CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_14CURRENT] = CURRENT14;

            // 第十五路电流0.01A
            double CURRENT15 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(54 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT15 = Math.Round(CURRENT15 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_15CURRENT] = CURRENT15;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_15CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_15CURRENT] = CURRENT15;

            // 第十六路电流0.01A
            double CURRENT16 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(56 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT16 = Math.Round(CURRENT16 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_16CURRENT] = CURRENT16;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_16CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_16CURRENT] = CURRENT16;

            // 第17路电流0.01A
            double CURRENT17 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(182 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT17 = Math.Round(CURRENT17 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_17CURRENT] = CURRENT17;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_17CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_17CURRENT] = CURRENT17;

            // 第18路电流0.01A
            double CURRENT18 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(184 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT18 = Math.Round(CURRENT18 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_18CURRENT] = CURRENT18;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_18CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_18CURRENT] = CURRENT18;

            // 第19路电流0.01A
            double CURRENT19 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(186 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT19 = Math.Round(CURRENT19 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_19CURRENT] = CURRENT19;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_19CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_19CURRENT] = CURRENT19;

            // 第20路电流0.01A
            double CURRENT20 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(188 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT20 = Math.Round(CURRENT20 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_20CURRENT] = CURRENT20;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_20CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_20CURRENT] = CURRENT20;

            // 第21路电流0.01A
            double CURRENT21 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(190 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT21 = Math.Round(CURRENT21 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_21CURRENT] = CURRENT21;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_21CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_21CURRENT] = CURRENT21;

            // 第22路电流0.01A
            double CURRENT22 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(192 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT22 = Math.Round(CURRENT22 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_22CURRENT] = CURRENT22;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_22CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_22CURRENT] = CURRENT22;

            // 第23路电流0.01A
            double CURRENT23 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(194 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT23 = Math.Round(CURRENT23 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_23CURRENT] = CURRENT23;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_23CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_23CURRENT] = CURRENT23;

            // 第24路电流0.01A
            double CURRENT24 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(196 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT24 = Math.Round(CURRENT24 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_24CURRENT] = CURRENT24;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_24CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_24CURRENT] = CURRENT24;

            // 第25路电流0.01A
            double CURRENT25 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(198 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT25 = Math.Round(CURRENT25 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_25CURRENT] = CURRENT25;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_25CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_25CURRENT] = CURRENT25;

            // 第26路电流0.01A
            double CURRENT26 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(200 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT26 = Math.Round(CURRENT26 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_26CURRENT] = CURRENT26;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_26CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_26CURRENT] = CURRENT26;

            // 第27路电流0.01A
            double CURRENT27 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(202 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT27 = Math.Round(CURRENT27 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_27CURRENT] = CURRENT27;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_27CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_27CURRENT] = CURRENT27;

            // 第28路电流0.01A
            double CURRENT28 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(204 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT28 = Math.Round(CURRENT28 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_28CURRENT] = CURRENT28;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_28CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_28CURRENT] = CURRENT28;

            // 第29路电流0.01A
            double CURRENT29 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(206 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT29 = Math.Round(CURRENT29 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_29CURRENT] = CURRENT29;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_29CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_29CURRENT] = CURRENT29;

            // 第30路电流0.01A
            double CURRENT30 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(208 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT30 = Math.Round(CURRENT30 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_30CURRENT] = CURRENT30;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_30CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_30CURRENT] = CURRENT30;

            // 第31路电流0.01A
            double CURRENT31 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(210 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT31 = Math.Round(CURRENT30 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_31CURRENT] = CURRENT31;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_31CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_31CURRENT] = CURRENT31;

            // 第32路电流0.01A
            double CURRENT32 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(212 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            CURRENT32 = Math.Round(CURRENT30 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_32CURRENT] = CURRENT32;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_32CURRENT))
                historyMonitorMap[MonitorType.MIC_BUSBAR_32CURRENT] = CURRENT32;

            // 第1路功率 W
            short Power1 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(118 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_1POWER] = Power1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_1POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_1POWER] = Power1;

            // 第2路功率 W
            short Power2 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(120 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_2POWER] = Power2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_2POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_2POWER] = Power2;

            // 第3路功率 W
            short Power3 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(122 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_3POWER] = Power3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_3POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_3POWER] = Power3;

            // 第4路功率 W
            short Power4 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(124 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_4POWER] = Power4;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_4POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_4POWER] = Power4;

            // 第5路功率 W
            short Power5 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(126 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_5POWER] = Power5;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_5POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_5POWER] = Power5;

            // 第6路功率 W
            short Power6 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(128 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_6POWER] = Power6;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_6POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_6POWER] = Power6;

            // 第7路功率 W
            short Power7 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(130 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_7POWER] = Power7;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_7POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_7POWER] = Power7;

            // 第8路功率 W
            short Power8 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(132 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_8POWER] = Power8;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_8POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_8POWER] = Power8;

            // 第9路功率 W
            short Power9 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(134 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_9POWER] = Power9;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_9POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_9POWER] = Power9;

            // 第10路功率 W
            short Power10 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(136 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_10POWER] = Power10;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_10POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_10POWER] = Power10;

            // 第11路功率 W
            short Power11 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(138 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_11POWER] = Power11;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_11POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_11POWER] = Power11;

            // 第12路功率 W
            short Power12 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(140 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_12POWER] = Power12;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_12POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_12POWER] = Power12;

            // 第13路功率 W
            short Power13 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(142 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_13POWER] = Power13;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_13POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_13POWER] = Power13;

            // 第14路功率 W
            short Power14 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(144 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_14POWER] = Power14;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_14POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_14POWER] = Power14;

            // 第15路功率 W
            short Power15 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(146 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_15POWER] = Power15;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_15POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_15POWER] = Power15;

            // 第16路功率 W
            short Power16 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(148 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_16POWER] = Power16;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_16POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_16POWER] = Power16;

            // 第17路功率 W
            short Power17 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(150 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_17POWER] = Power17;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_17POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_17POWER] = Power17;

            // 第18路功率 W
            short Power18 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(152 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_18POWER] = Power18;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_18POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_18POWER] = Power18;

            // 第19路功率 W
            short Power19 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(154 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_19POWER] = Power19;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_19POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_19POWER] = Power19;

            // 第20路功率 W
            short Power20 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(156 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_20POWER] = Power20;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_20POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_20POWER] = Power20;

            // 第21路功率 W
            short Power21 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(158 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_21POWER] = Power21;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_21POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_21POWER] = Power21;

            // 第22路功率 W
            short Power22 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(160 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_22POWER] = Power22;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_22POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_22POWER] = Power22;

            // 第23路功率 W
            short Power23 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(162 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_23POWER] = Power23;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_23POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_23POWER] = Power23;

            // 第24路功率 W
            short Power24 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(164 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_24POWER] = Power24;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_24POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_24POWER] = Power24;

            // 第25路功率 W
            short Power25 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(166 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_25POWER] = Power25;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_25POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_25POWER] = Power25;

            // 第26路功率 W
            short Power26 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(168 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_26POWER] = Power26;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_26POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_26POWER] = Power26;

            // 第27路功率 W
            short Power27 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(170 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_27POWER] = Power27;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_27POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_27POWER] = Power27;

            // 第28路功率 W
            short Power28 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(172 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_28POWER] = Power28;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_28POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_28POWER] = Power28;

            // 第29路功率 W
            short Power29 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(174 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_29POWER] = Power29;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_29POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_29POWER] = Power29;

            // 第30路功率 W
            short Power30 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(176 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_30POWER] = Power30;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_30POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_30POWER] = Power30;

            // 第31路功率 W
            short Power31 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(178 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_31POWER] = Power31;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_31POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_31POWER] = Power31;

            // 第30路功率 W
            short Power32 = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(180 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_BUSBAR_32POWER] = Power32;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_BUSBAR_32POWER))
                historyMonitorMap[MonitorType.MIC_BUSBAR_30POWER] = Power32;

            //总电流0.1A
            double totalC = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(62 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');
            totalC = Math.Round(totalC * 0.1, 2);
            realMonitorMap[MonitorType.MIC_BUSBAR_TOTALCURRENT] = totalC;
            historyMonitorMap[MonitorType.MIC_BUSBAR_TOTALCURRENT] = totalC;

            //状态
            int status = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(82 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');
            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string statusstr = getFullbitstr(status, 32);
            realMonitorMap[MonitorType.MIC_BUSBAR_STATUS] = status;
            //historyMonitorMap[MonitorType.MIC_BUSBAR_STATUS] = status;

            //短路数据
            int dxdata = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(86 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');
            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string dxdatastr = getFullbitstr(dxdata, 32);
            realMonitorMap[MonitorType.MIC_BUSBAR_DUANLUDATA] = dxdata;
            //historyMonitorMap[MonitorType.MIC_BUSBAR_DUANLUDATA] = dxdata;

            //电流过高数据
            int dlgg = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(94 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');
            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            ///string dlggstr = getFullbitstr(dlgg, 32);
            realMonitorMap[MonitorType.MIC_BUSBAR_DLGGDATA] = dlgg;
            // historyMonitorMap[MonitorType.MIC_BUSBAR_DLGGDATA] dlgg dlgg;

            //电流过低数据
            int dlgd = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(102 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');

            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string dlgdstr = getFullbitstr(dlgd, 32);

            realMonitorMap[MonitorType.MIC_BUSBAR_DLGDDATA] = dlgd;
            //historyMonitorMap[MonitorType.MIC_BUSBAR_DLGDDATA] = dlgd;

            //开路数据
            int kailudata = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(110 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'U');

            //modify by qhb in 20120825 for 将十进制转化为二进制，然后从后开始依次是bit0 bit1
            //string kailudatastr = getFullbitstr(kailudata, 32);

            realMonitorMap[MonitorType.MIC_BUSBAR_KAILUDATA] = kailudata;
            //historyMonitorMap[MonitorType.MIC_BUSBAR_KAILUDATA] = kailudata;

            tableType = TableUtil.HUILIUXIANG;
        }

        public Modbus17Busbar(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.analysis();
  
        }
    }
}
