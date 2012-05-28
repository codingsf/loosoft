using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
namespace Protocol
{
    /// <summary>
    /// 设备类型0x22对应的数据区格式,环境检测仪（MODBUS协议）
    /// add by qianhb in 20111220
    /// </summary>
    public class ModbusDetector : DeviceDataBase
    {
        public string DevName = "环境检测仪装置";
        int deviceDataHeadLength = 5;//5字节
        BaseMessage message = null;
        /// <summary>
        /// 根据环境检测仪MODBUS协议解析单个设备数据
        /// </summary>
        public void analysis()
        {
            //deviceData
            //设备型号 此协议中无此数据
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
            //按照测点在协议中的顺序依次解析具体测点数据
            //16每个数据的高位字节在前，低位字节在后
            //32双“字”数据前低后高。“字节”为前高后低

            //日照强度（0.1W/m2)
            double SUNLINGHT = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(26 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            SUNLINGHT = Math.Round(SUNLINGHT * 0.1, 1);
            realMonitorMap[MonitorType.MIC_DETECTOR_SUNLINGHT] = SUNLINGHT;
            historyMonitorMap[MonitorType.MIC_DETECTOR_SUNLINGHT] = SUNLINGHT;
            message.realMonitorMap[MonitorType.PLANT_MONITORITEM_LINGT_CODE] = SUNLINGHT;
            message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_LINGT_CODE] = SUNLINGHT;


            //环境温度0.1 ℃
            double ENRIONMENTTEMPRATURE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(28 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            ENRIONMENTTEMPRATURE = Math.Round(ENRIONMENTTEMPRATURE * 0.1, 1);
            realMonitorMap[MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE] = ENRIONMENTTEMPRATURE;
            historyMonitorMap[MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE] = ENRIONMENTTEMPRATURE;
            message.realMonitorMap[MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE] = ENRIONMENTTEMPRATURE;
            message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE] = ENRIONMENTTEMPRATURE;

            //电池板温度0.1 ℃
            double PANELTEMPRATURE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(30 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            PANELTEMPRATURE = Math.Round(PANELTEMPRATURE * 0.1, 1);
            realMonitorMap[MonitorType.MIC_DETECTOR_PANELTEMPRATURE] = PANELTEMPRATURE;
            historyMonitorMap[MonitorType.MIC_DETECTOR_PANELTEMPRATURE] = PANELTEMPRATURE;

            //风速（0.1 m/s）
            double WINDSPEED = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(36 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            WINDSPEED = Math.Round(WINDSPEED * 0.1, 1);
            realMonitorMap[MonitorType.MIC_DETECTOR_WINDSPEED] = WINDSPEED;
            historyMonitorMap[MonitorType.MIC_DETECTOR_WINDSPEED] = WINDSPEED;
            message.realMonitorMap[MonitorType.PLANT_MONITORITEM_WINDSPEED] = WINDSPEED;
            message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_WINDSPEED] = WINDSPEED;

            //风向度数	U16	0.1 度暂不考虑

            //风向7 位格雷码是啥意思？
            //int WINDDIRECTION = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(40 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            //realMonitorMap[MonitorType.MIC_DETECTOR_WINDDIRECTION] = WINDDIRECTION;
            //historyMonitorMap[MonitorType.MIC_DETECTOR_WINDDIRECTION] = WINDDIRECTION;
            //message.realMonitorMap[MonitorType.PLANT_MONITORITEM_WINDDIRECTION] = WINDDIRECTION;
            //message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_WINDDIRECTION] = WINDDIRECTION;

            deviceType = TableUtil.DETECTOR;
        }

        public ModbusDetector(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.message = message;
            this.analysis();
        }
    }
}
