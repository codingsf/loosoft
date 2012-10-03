using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
namespace Protocol
{
    /// <summary>
    /// 逆变装置
    /// modbus协议两个字节的高位在前，四个低位在前
    /// </summary>
    public class ModbusInverter : DeviceDataBase
    {
        public string DevName = "逆变装置";

        int deviceDataHeadLength = 5;//5字节

        /// <summary>
        /// 根据逆变器modbus协议解析单个设备数据
        /// </summary>
        public void analysis(){
            //设备型号
            base.deviceXh = (int)SystemCode.HexNumberToDenary(deviceData.Substring(deviceDataHeadLength * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
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

            //实时状态测点数据
            //额定输出功率 0.1kW
            ushort outpowerl = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(2 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (outpowerl != ushort.MaxValue)//最大值无效
            {
                double outpower = Math.Round(outpowerl * 0.1, 3);
                realMonitorMap[MonitorType.MIC_INVERTER_POWER] = outpower;
                if(MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_POWER)){
                    historyMonitorMap[MonitorType.MIC_INVERTER_POWER] = outpower;
                }
            }

            //输出类型 bank不显示改为显示，以便做类型判断逆变器显示方式
            ushort outtype = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(4 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (outtype != ushort.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_OUTTYPE] = outtype;
            }

            //日发电量0.1kWh
            ushort dayenergyl = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(6 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (dayenergyl != ushort.MaxValue)//最大值无效
            {
                double dayenergy = Math.Round(dayenergyl * 0.1, 2);
                realMonitorMap[MonitorType.MIC_INVERTER_TODAYENERGY] = dayenergy;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TODAYENERGY))
                    historyMonitorMap[MonitorType.MIC_INVERTER_TODAYENERGY] = dayenergy;
                base.todayEnergy = dayenergy;
            }

            //总发电量
            uint totalenergy = (uint)SystemCode.HexNumberToDenary(monitorstr.Substring(8 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            if (totalenergy != uint.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_TOTALENERGY] = totalenergy;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALENERGY))
                    historyMonitorMap[MonitorType.MIC_INVERTER_TOTALENERGY] = totalenergy;
            }
            //总运行时间
            uint totalruntime = (uint)SystemCode.HexNumberToDenary(monitorstr.Substring(12 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            if (totalruntime != uint.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_RUNTIME] = totalruntime;
            }

            //机内空气温度 0.1℃
            short jnkqtempraturel = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(16 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            if (jnkqtempraturel != short.MaxValue)//最大值无效
            {
                double jnkqtemprature = Math.Round(jnkqtempraturel * 0.1F, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_JNKQTEMPRATURE] = jnkqtemprature;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_JNKQTEMPRATURE))
                    historyMonitorMap[MonitorType.MIC_INVERTER_JNKQTEMPRATURE] = jnkqtemprature;
            }

            //机内变压器温度  0.1℃
            short jnbyqtempraturel = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(18 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            if (jnbyqtempraturel != short.MaxValue)//最大值无效
            {
                double jnbyqtemprature = Math.Round(jnbyqtempraturel * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_JNBYQTEMPRATURE] = jnbyqtemprature;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_JNBYQTEMPRATURE))
                    historyMonitorMap[MonitorType.MIC_INVERTER_JNBYQTEMPRATURE] = jnbyqtemprature;
            }

            //机内散热器温度  0.1℃
            short jnsrqtempraturel = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(20 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            if (jnsrqtempraturel != short.MaxValue)//最大值无效
            {
                double jnsrqtemprature = Math.Round(jnsrqtempraturel * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_JNSRQTEMPRATURE] = jnsrqtemprature;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_JNSRQTEMPRATURE))
                    historyMonitorMap[MonitorType.MIC_INVERTER_JNSRQTEMPRATURE] = jnsrqtemprature;
            }

            //直流电压1 0.1V
            ushort dv1l = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(22 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (dv1l != ushort.MaxValue)//最大值无效
            {
                double dv1 = Math.Round(dv1l * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_DV1] = dv1;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV1))
                    historyMonitorMap[MonitorType.MIC_INVERTER_DV1] = dv1;
            }

            //直流电流1 0.1A
            ushort dc1l = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(24 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (dc1l != ushort.MaxValue)//最大值无效
            {
                double dc1 = Math.Round(dc1l * 0.1F, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_DC1] = dc1;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC1))
                    historyMonitorMap[MonitorType.MIC_INVERTER_DC1] = dc1;
            }
            //直流电压2 0.1V
            ushort dv2l = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(26 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (dv2l != ushort.MaxValue)//最大值无效
            {
                double dv2 = Math.Round(dv2l * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_DV2] = dv2;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV2))
                    historyMonitorMap[MonitorType.MIC_INVERTER_DV2] = dv2;
            }
            //直流电流2 0.1A
            ushort dc2l = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(28 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (dc2l != ushort.MaxValue)//最大值无效
            {
                double dc2 = Math.Round(dc2l * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_DC2] = dc2;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC2))
                    historyMonitorMap[MonitorType.MIC_INVERTER_DC2] = dc2;
            }

            //直流电压3 0.1V
            ushort dv3l = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(30 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (dv3l != ushort.MaxValue)//最大值无效
            {
                double dv3 = Math.Round(dv3l * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_DV3] = dv3;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV3))
                    historyMonitorMap[MonitorType.MIC_INVERTER_DV3] = dv3;
            }

            //直流电流3 0.1A
            ushort dc3l = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(32 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (dc3l != ushort.MaxValue)//最大值无效
            {
                double dc3 = Math.Round(dc3l * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_DC3] = dc3;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC3))
                    historyMonitorMap[MonitorType.MIC_INVERTER_DC3] = dc3;
            }

            //总直流功率
            uint totaldcpower = (uint)SystemCode.HexNumberToDenary(monitorstr.Substring(34 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            if (totaldcpower != uint.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_TOTALDPOWER] = totaldcpower;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALDPOWER))
                    historyMonitorMap[MonitorType.MIC_INVERTER_TOTALDPOWER] = totaldcpower;
            }

            //A相电压 0.1V
            ushort adirectvoltl = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(38 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (adirectvoltl != ushort.MaxValue)//最大值无效
            {
                double adirectvolt = Math.Round(adirectvoltl * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_ADIRECTVOLT] = adirectvolt;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ADIRECTVOLT))
                    historyMonitorMap[MonitorType.MIC_INVERTER_ADIRECTVOLT] = adirectvolt;
            }
            //B相电压 0.1V
            ushort bdirectvoltl = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(40 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (bdirectvoltl != ushort.MaxValue)//最大值无效
            {
                double bdirectvolt = Math.Round(bdirectvoltl * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_BDIRECTVOLT] = bdirectvolt;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_BDIRECTVOLT))
                    historyMonitorMap[MonitorType.MIC_INVERTER_BDIRECTVOLT] = bdirectvolt;
            }
            //C相电压 0.1V
            ushort cdirectvoltl = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(42 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (cdirectvoltl != ushort.MaxValue)//最大值无效
            {
                double cdirectvolt = Math.Round(cdirectvoltl * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_CDIRECTVOLT] = cdirectvolt;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_CDIRECTVOLT))
                    historyMonitorMap[MonitorType.MIC_INVERTER_CDIRECTVOLT] = cdirectvolt;
            }

            //A相电流 0.1V
            ushort adirectcurrentl = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(44 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (adirectcurrentl != ushort.MaxValue)//最大值无效
            {
                double adirectcurrent = Math.Round(adirectcurrentl * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_ADIRECTCURRENT] = adirectcurrent;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ADIRECTCURRENT))
                    historyMonitorMap[MonitorType.MIC_INVERTER_ADIRECTCURRENT] = adirectcurrent;
            }

            //B相电流 0.1V
            ushort bdirectcurrentl = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(46 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (bdirectcurrentl != ushort.MaxValue)//最大值无效
            {
                double bdirectcurrent = Math.Round(bdirectcurrentl * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_BDIRECTCURRENT] = bdirectcurrent;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_BDIRECTCURRENT))
                    historyMonitorMap[MonitorType.MIC_INVERTER_BDIRECTCURRENT] = bdirectcurrent;
            }

            //C相电流 0.1V
            ushort cdirectcurrentl = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(48 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (cdirectcurrentl != ushort.MaxValue)//最大值无效
            {
                double cdirectcurrent = Math.Round(cdirectcurrentl * 0.1, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_CDIRECTCURRENT] = cdirectcurrent;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_CDIRECTCURRENT))
                    historyMonitorMap[MonitorType.MIC_INVERTER_CDIRECTCURRENT] = cdirectcurrent;
            }

            //A相有功功率
            uint adirectygpower = (uint)SystemCode.HexNumberToDenary(monitorstr.Substring(50 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            if (adirectygpower != uint.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_ADIRECTPOWER] = adirectygpower;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ADIRECTPOWER))
                    historyMonitorMap[MonitorType.MIC_INVERTER_ADIRECTPOWER] = adirectygpower;
            }

            //B相有功功率
            uint bdirectygpower = (uint)SystemCode.HexNumberToDenary(monitorstr.Substring(54 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            if (bdirectygpower != uint.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_BDIRECTPOWER] = bdirectygpower;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_BDIRECTPOWER))
                    historyMonitorMap[MonitorType.MIC_INVERTER_BDIRECTPOWER] = bdirectygpower;
            }

            //C相有功功率
            uint cdirectygpower = (uint)SystemCode.HexNumberToDenary(monitorstr.Substring(58 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            if (cdirectygpower != uint.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_CDIRECTPOWER] = cdirectygpower;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_CDIRECTPOWER))
                    historyMonitorMap[MonitorType.MIC_INVERTER_CDIRECTPOWER] = cdirectygpower;
            }

            //总有功功率
            uint totalygpower = (uint)SystemCode.HexNumberToDenary(monitorstr.Substring(62 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            if (totalygpower != uint.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_TOTALYGPOWER] = totalygpower;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALYGPOWER))
                    historyMonitorMap[MonitorType.MIC_INVERTER_TOTALYGPOWER] = totalygpower;
            }

            //总无功功率
            int totalwgpower = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(66 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            if (totalwgpower != int.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_TOTALWGPOWER] = totalwgpower;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALWGPOWER))
                    historyMonitorMap[MonitorType.MIC_INVERTER_TOTALWGPOWER] = totalwgpower;
            }

            //总功率因数 0.001
            short totalpowerfactorl = (short)SystemCode.HexNumberToDenary(monitorstr.Substring(70 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            if (totalpowerfactorl != short.MaxValue)//最大值无效
            {
                double totalpowerfactor = Math.Round(totalpowerfactorl * 0.001F, 3);
                realMonitorMap[MonitorType.MIC_INVERTER_TOTALPOWERFACTOR] = totalpowerfactor;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALPOWERFACTOR))
                    historyMonitorMap[MonitorType.MIC_INVERTER_TOTALPOWERFACTOR] = totalpowerfactor;
            }

            //电网频率 0.1Hz
            ushort dwpll = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(72 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (dwpll != ushort.MaxValue)//最大值无效
            {
                double dwpl = Math.Round(dwpll * 0.1F, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_DWPL] = dwpl;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DWPL))
                    historyMonitorMap[MonitorType.MIC_INVERTER_DWPL] = dwpl;
            }

            //逆变器效率 0.1%
            ushort inverterxll = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(74 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (inverterxll != ushort.MaxValue)//最大值无效
            {
                double inverterxl = Math.Round(inverterxll * 0.1F, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_INVERTERXL] = inverterxl;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_INVERTERXL))
                    historyMonitorMap[MonitorType.MIC_INVERTER_INVERTERXL] = inverterxl;
            }

            //设备状态
            ushort devicestatus = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(76 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (devicestatus != ushort.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_DEVICESTATUS] = devicestatus;
                base.deviceState = devicestatus;
            }

            //设备时间
            int statusyear = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(78 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statusmonth = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(80 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statusday = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(82 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statushh = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(84 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statusminuts = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(86 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statussecond = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(88 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_STATUSTIME] = "";// statusyear + "/" + statusmonth + "/" + statusday + " " + statushh + ":" + statusminuts + ":" + statussecond;

            //状态数据1
            ushort statusdata1 = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(90 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (statusdata1 != ushort.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_STATUSDATA1] = statusdata1;
            }

            //状态数据2
            ushort statusdata2 = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(92 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (statusdata2 != ushort.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_STATUSDATA2] = statusdata2;
            }
            //状态数据3
            ushort statusdata3 = (ushort)SystemCode.HexNumberToDenary(monitorstr.Substring(94 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            if (statusdata3 != ushort.MaxValue)//最大值无效
            {
                realMonitorMap[MonitorType.MIC_INVERTER_STATUSDATA3] = statusdata3;
            }
            tableType = TableUtil.INVERTER_TABLE_NAME;
        }

        public ModbusInverter(string tcpcontent,BaseMessage message) {
            base.deviceData = tcpcontent;
            this.analysis();
        }
    }
}
