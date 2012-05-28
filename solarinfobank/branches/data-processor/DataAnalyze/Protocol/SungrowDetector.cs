using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
namespace Protocol
{
    /// <summary>
    /// 环境监测仪通讯协议
    /// </summary>
    public class SungrowDetector : DeviceDataBase
    {
        public string DevName = "环境检测仪装置";
        int deviceDataHeadLength = 5;//5字节
        BaseMessage message = null;
        /// <summary>
        /// 根据环境检测仪sungrow协议解析单个设备数据
        /// </summary>
        public void analysis()
        {
            //deviceData
            //设备型号 此协议中无此数据
            //base.deviceXh = (int)SystemCode.HexNumberToDenary(deviceData.Substring(deviceDataHeadLength * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
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
            //按照测点在协议中的顺序依次解析具体测点数据
            //每个数据的高位字节在前，低位字节在后
            /// <summary>
            /// Soi（ED）
            /// </summary>
            int SOI = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(0 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            realMonitorMap[MonitorType.MIC_DETECTOR_SOI] = SOI;
            //Adr
            int ADR = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(1 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            realMonitorMap[MonitorType.MIC_DETECTOR_ADR] = deviceAddress;
            //日照强度（W/m2
            int SUNLINGHT= (int)SystemCode.HexNumberToDenary(monitorstr.Substring(12 * hexbytecharnum, 4 * hexbytecharnum), false, 32, 'u');
            realMonitorMap[MonitorType.MIC_DETECTOR_SUNLINGHT] = SUNLINGHT;
            historyMonitorMap[MonitorType.MIC_DETECTOR_SUNLINGHT] = SUNLINGHT;
            message.realMonitorMap[MonitorType.PLANT_MONITORITEM_LINGT_CODE] = SUNLINGHT;
            message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_LINGT_CODE] = SUNLINGHT;

            //电池板温度
            double PANELTEMPRATURE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(19 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 's');
            PANELTEMPRATURE = Math.Round(PANELTEMPRATURE, 1);
            realMonitorMap[MonitorType.MIC_DETECTOR_PANELTEMPRATURE] = PANELTEMPRATURE;
            historyMonitorMap[MonitorType.MIC_DETECTOR_PANELTEMPRATURE] = PANELTEMPRATURE;

            //环境温度
            double ENRIONMENTTEMPRATURE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(23 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 's');
            ENRIONMENTTEMPRATURE = Math.Round(ENRIONMENTTEMPRATURE , 1);
            realMonitorMap[MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE] = ENRIONMENTTEMPRATURE;
            historyMonitorMap[MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE] = ENRIONMENTTEMPRATURE;
            message.realMonitorMap[MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE] = ENRIONMENTTEMPRATURE;
            message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE] = ENRIONMENTTEMPRATURE;

            //电池板温度（0.1℃）高精度
            double PANELTEMPRATUREHIGH = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(24 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            PANELTEMPRATUREHIGH = Math.Round(PANELTEMPRATUREHIGH * 0.1, 1);
            realMonitorMap[MonitorType.MIC_DETECTOR_PANELTEMPRATUREHIGH] = PANELTEMPRATUREHIGH;
            historyMonitorMap[MonitorType.MIC_DETECTOR_PANELTEMPRATUREHIGH] = PANELTEMPRATUREHIGH;


            //环境温度（0.1℃）高精度
            double NRIONMENTTEMPRATUREHIGH = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(26 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            NRIONMENTTEMPRATUREHIGH = Math.Round(NRIONMENTTEMPRATUREHIGH * 0.1, 1);
            realMonitorMap[MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATUREHIGH] = NRIONMENTTEMPRATUREHIGH;
            historyMonitorMap[MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATUREHIGH] = NRIONMENTTEMPRATUREHIGH;

            //风速（m/s）
            int WINDSPEED= (int)SystemCode.HexNumberToDenary(monitorstr.Substring(40 * hexbytecharnum, 4 * hexbytecharnum), false, 32, 'u');
            realMonitorMap[MonitorType.MIC_DETECTOR_WINDSPEED] = WINDSPEED;
            historyMonitorMap[MonitorType.MIC_DETECTOR_WINDSPEED] = WINDSPEED;
            message.realMonitorMap[MonitorType.PLANT_MONITORITEM_WINDSPEED] = WINDSPEED;
            message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_WINDSPEED] = WINDSPEED;

            //风速（0.1m/s）高精度
            double WINDSPEEDHIGH = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(44 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            WINDSPEEDHIGH = Math.Round(WINDSPEEDHIGH * 0.1, 1);
            realMonitorMap[MonitorType.MIC_DETECTOR_WINDSPEEDHIGH] = WINDSPEEDHIGH;
            historyMonitorMap[MonitorType.MIC_DETECTOR_WINDSPEEDHIGH] = WINDSPEEDHIGH;

            //斜面日照强度（W/m2）
            int XMRZQD = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(46 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_DETECTOR_XMRZQD] = XMRZQD;
            historyMonitorMap[MonitorType.MIC_DETECTOR_XMRZQD] = XMRZQD;

            //风向7 位格雷码是啥意思？
            //int WINDDIRECTION = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(52 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            //realMonitorMap[MonitorType.MIC_DETECTOR_WINDDIRECTION] = WINDDIRECTION;
            //historyMonitorMap[MonitorType.MIC_DETECTOR_WINDDIRECTION] = WINDDIRECTION;
            //message.realMonitorMap[MonitorType.PLANT_MONITORITEM_WINDDIRECTION] = WINDDIRECTION;
            //message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_WINDDIRECTION] = WINDDIRECTION;

            deviceType = TableUtil.DETECTOR;

        }

        public SungrowDetector(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.message = message;
            this.analysis();
        }
    }
}
