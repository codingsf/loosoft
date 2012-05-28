using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
namespace Protocol
{

    /// <summary>
    /// 逆变SunGorw协议装置
    /// </summary>
    public class SungrowInverter : DeviceDataBase
    {
        public string DevName = "逆变装置";
        int deviceDataHeadLength = 5;//5字节

        /// <summary>
        /// 根据逆变器sungrow协议解析单个设备数据
        /// </summary>
        public void analysis()
        {
            //deviceData
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
            //交流电压 0.1
            double av = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(0 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            av = Math.Round(av * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_AV] = av;
            historyMonitorMap[MonitorType.MIC_INVERTER_AV] = av;

            //交流电流
            double ac = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(2 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            ac = Math.Round(ac * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_AC] = ac;
            historyMonitorMap[MonitorType.MIC_INVERTER_AC] = ac;
            //直流电压
            double dv = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(4 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            dv = Math.Round(dv * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_DV] = dv;
            historyMonitorMap[MonitorType.MIC_INVERTER_DV] = dv;
            //直流电流
            double dc = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(6 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            dc = Math.Round(dc * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_DC] = dc;
            historyMonitorMap[MonitorType.MIC_INVERTER_DC] = dc;
            //逆变器温度 为补吗是啥意思？
            double invertertemprature = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(8 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            invertertemprature = Math.Round(invertertemprature * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_INVETERTEMPRATURE] = invertertemprature;
            historyMonitorMap[MonitorType.MIC_INVERTER_INVETERTEMPRATURE] = invertertemprature;

            //日发电量
            double todayEnergy = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(10 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            todayEnergy = Math.Round(todayEnergy * 0.1, 3);
            realMonitorMap[MonitorType.MIC_INVERTER_TODAYENERGY] = todayEnergy;
            historyMonitorMap[MonitorType.MIC_INVERTER_TODAYENERGY] = todayEnergy;
            base.todayEnergy = todayEnergy;

            //交流发电量即总发电量
            string acEnergyStr = monitorstr.Substring(12 * hexbytecharnum, 4 * hexbytecharnum);
            long acEnergy = SystemCode.HexNumberToDenary(acEnergyStr, SystemCode.ReversionType_groupinner, 32, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_ACENERGY] = acEnergy;
            historyMonitorMap[MonitorType.MIC_INVERTER_ACENERGY] = acEnergy;
            //状态信息
            int statusinfo = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(16 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_DEVICESTATUS] = statusinfo;
            //电网频率
            double dwpl = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(20 * hexbytecharnum, 2 * hexbytecharnum), true, 16, 'u');
            dwpl = Math.Round(dwpl * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_DWPL] = dwpl;
            historyMonitorMap[MonitorType.MIC_INVERTER_DWPL] = dwpl;

            //总有功功率,协议中无要加工交流电压*交流电流
            double totalygpower = av * ac;
            totalygpower = Math.Round(totalygpower, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_TOTALYGPOWER] = totalygpower;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALYGPOWER))
                historyMonitorMap[MonitorType.MIC_INVERTER_TOTALYGPOWER] = totalygpower;

            //设备型号 25序号的是设备型号,单字节无符号整型
            string xh = monitorstr.Substring(24 * hexbytecharnum, 2 * hexbytecharnum);
            if (!xh.Equals("00") && !xh.Equals("0"))
                base.deviceXh = (int)SystemCode.HexNumberToDenary(xh, true, 8, 'u');

            tableType = TableUtil.INVERTER_TABLE_NAME;
        }

        public SungrowInverter(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.analysis();
        }

    }
}
