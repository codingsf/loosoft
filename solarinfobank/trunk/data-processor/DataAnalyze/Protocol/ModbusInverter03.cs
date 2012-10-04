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
    /// modbus协议两个字节的高位在前，四个低位在前 逆变器（MODBUS协议） 支持630K机型
    /// </summary>
    public class ModbusInverter03 : DeviceDataBase
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
            double outpower = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(2 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            outpower = Math.Round(outpower * 0.1, 3);
            realMonitorMap[MonitorType.MIC_INVERTER_POWER] = outpower;
            if(MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_POWER)){
                historyMonitorMap[MonitorType.MIC_INVERTER_POWER] = outpower;
            }

            //输出类型 bank不显示改为显示，以便做类型判断逆变器显示方式
            long outtype = SystemCode.HexNumberToDenary(monitorstr.Substring(4 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_OUTTYPE] = outtype;

            //日发电量0.1kWh
            double dayenergy = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(6 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            dayenergy = Math.Round(dayenergy * 0.1, 2);
            realMonitorMap[MonitorType.MIC_INVERTER_TODAYENERGY] = dayenergy;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TODAYENERGY))
                historyMonitorMap[MonitorType.MIC_INVERTER_TODAYENERGY] = dayenergy;
            base.todayEnergy = dayenergy;

            //总发电量
            long totalenergy = SystemCode.HexNumberToDenary(monitorstr.Substring(8 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_TOTALENERGY] = totalenergy;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALENERGY))
                historyMonitorMap[MonitorType.MIC_INVERTER_TOTALENERGY] = totalenergy;

            //总运行时间
            long totalruntime = SystemCode.HexNumberToDenary(monitorstr.Substring(12 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_RUNTIME] = totalruntime;

            //机内空气温度 0.1℃
            double jnkqtemprature = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(16 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            jnkqtemprature = Math.Round(jnkqtemprature * 0.1F, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_JNKQTEMPRATURE] = jnkqtemprature;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_JNKQTEMPRATURE))
                historyMonitorMap[MonitorType.MIC_INVERTER_JNKQTEMPRATURE] = jnkqtemprature;


            //机内变压器温度  0.1℃
            double jnbyqtemprature = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(18 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            jnbyqtemprature = Math.Round(jnbyqtemprature * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_JNBYQTEMPRATURE] = jnbyqtemprature;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_JNBYQTEMPRATURE))
                historyMonitorMap[MonitorType.MIC_INVERTER_JNBYQTEMPRATURE] = jnbyqtemprature;

            //机内散热器温度  0.1℃
            double jnsrqtemprature = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(20 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            jnsrqtemprature = Math.Round(jnsrqtemprature * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_JNSRQTEMPRATURE] = jnsrqtemprature;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_JNSRQTEMPRATURE))
                historyMonitorMap[MonitorType.MIC_INVERTER_JNSRQTEMPRATURE] = jnsrqtemprature;

            //直流电压1 0.1V
            double dv1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(22 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            dv1 = Math.Round(dv1 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_DV1] = dv1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV1))
                historyMonitorMap[MonitorType.MIC_INVERTER_DV1] = dv1;

            //直流电流1 0.1A
            double dc1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(24 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            dc1 = Math.Round(dc1 * 0.1F, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_DC1] = dc1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC1))
                historyMonitorMap[MonitorType.MIC_INVERTER_DC1] = dc1;

            //直流电压2 0.1V
            double dv2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(26 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            dv2 = Math.Round(dv2 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_DV2] = dv2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV2))
                historyMonitorMap[MonitorType.MIC_INVERTER_DV2] = dv2;

            //直流电流2 0.1A
            double dc2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(28 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            dc2 = Math.Round(dc2 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_DC2] = dc2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC2))
                historyMonitorMap[MonitorType.MIC_INVERTER_DC2] = dc2;

            //直流电压3 0.1V
            double dv3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(30 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            dv3 = Math.Round(dv3 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_DV3] = dv3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DV3))
                historyMonitorMap[MonitorType.MIC_INVERTER_DV3] = dv3;

            //直流电流3 0.1A
            double dc3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(32 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            dc3 = Math.Round(dc3 * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_DC3] = dc3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DC3))
                historyMonitorMap[MonitorType.MIC_INVERTER_DC3] = dc3;

            //总直流功率
            int totaldcpower = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(34 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_TOTALDPOWER] = totaldcpower;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALDPOWER))
                historyMonitorMap[MonitorType.MIC_INVERTER_TOTALDPOWER] = totaldcpower;

            //A相电压 0.1V
            double adirectvolt = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(38 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            adirectvolt = Math.Round(adirectvolt * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_ADIRECTVOLT] = adirectvolt;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ADIRECTVOLT))
                historyMonitorMap[MonitorType.MIC_INVERTER_ADIRECTVOLT] = adirectvolt;

            //B相电压 0.1V
            double bdirectvolt = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(40 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            bdirectvolt = Math.Round(bdirectvolt * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_BDIRECTVOLT] = bdirectvolt;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_BDIRECTVOLT))
                historyMonitorMap[MonitorType.MIC_INVERTER_BDIRECTVOLT] = bdirectvolt;

            //C相电压 0.1V
            double cdirectvolt = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(42 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            cdirectvolt = Math.Round(cdirectvolt * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_CDIRECTVOLT] = cdirectvolt;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_CDIRECTVOLT))
                historyMonitorMap[MonitorType.MIC_INVERTER_CDIRECTVOLT] = cdirectvolt;

            //A相电流 0.1V
            double adirectcurrent = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(44 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            adirectcurrent = Math.Round(adirectcurrent * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_ADIRECTCURRENT] = adirectcurrent;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ADIRECTCURRENT))
                historyMonitorMap[MonitorType.MIC_INVERTER_ADIRECTCURRENT] = adirectcurrent;

            //B相电流 0.1V
            double bdirectcurrent = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(46 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            bdirectcurrent = Math.Round(bdirectcurrent * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_BDIRECTCURRENT] = bdirectcurrent;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_BDIRECTCURRENT))
                historyMonitorMap[MonitorType.MIC_INVERTER_BDIRECTCURRENT] = bdirectcurrent;

            //C相电流 0.1V
            double cdirectcurrent = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(48 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            cdirectcurrent = Math.Round(cdirectcurrent * 0.1, 1);
            realMonitorMap[MonitorType.MIC_INVERTER_CDIRECTCURRENT] = cdirectcurrent;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_CDIRECTCURRENT))
                historyMonitorMap[MonitorType.MIC_INVERTER_CDIRECTCURRENT] = cdirectcurrent;

            //A相有功功率
            long adirectygpower = SystemCode.HexNumberToDenary(monitorstr.Substring(50 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_ADIRECTPOWER] = adirectygpower;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ADIRECTPOWER))
                historyMonitorMap[MonitorType.MIC_INVERTER_ADIRECTPOWER] = adirectygpower;

            //B相有功功率
            long bdirectygpower = SystemCode.HexNumberToDenary(monitorstr.Substring(54 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_BDIRECTPOWER] = bdirectygpower;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_BDIRECTPOWER))
                historyMonitorMap[MonitorType.MIC_INVERTER_BDIRECTPOWER] = bdirectygpower;

            //C相有功功率
            long cdirectygpower = SystemCode.HexNumberToDenary(monitorstr.Substring(58 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_CDIRECTPOWER] = cdirectygpower;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_CDIRECTPOWER))
                historyMonitorMap[MonitorType.MIC_INVERTER_CDIRECTPOWER] = cdirectygpower;

            //总有功功率
            long totalygpower = SystemCode.HexNumberToDenary(monitorstr.Substring(62 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_TOTALYGPOWER] = totalygpower;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALYGPOWER))
                historyMonitorMap[MonitorType.MIC_INVERTER_TOTALYGPOWER] = totalygpower;

            //总无功功率
            long totalwgpower = SystemCode.HexNumberToDenary(monitorstr.Substring(66 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            realMonitorMap[MonitorType.MIC_INVERTER_TOTALWGPOWER] = totalwgpower;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALWGPOWER))
                historyMonitorMap[MonitorType.MIC_INVERTER_TOTALWGPOWER] = totalwgpower;

            //总功率因数 0.001
            double totalpowerfactor = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(70 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            totalpowerfactor = Math.Round(totalpowerfactor * 0.001F, 3); 
            realMonitorMap[MonitorType.MIC_INVERTER_TOTALPOWERFACTOR] = totalpowerfactor;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_TOTALPOWERFACTOR))
                historyMonitorMap[MonitorType.MIC_INVERTER_TOTALPOWERFACTOR] = totalpowerfactor;

            //电网频率 0.1Hz
            double dwpl = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(72 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            dwpl = Math.Round(dwpl * 0.1F, 1); 
            realMonitorMap[MonitorType.MIC_INVERTER_DWPL] = dwpl;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DWPL))
                historyMonitorMap[MonitorType.MIC_INVERTER_DWPL] = dwpl;

            //逆变器效率 0.1%
            double inverterxl = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(74 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            inverterxl = Math.Round(inverterxl * 0.1F, 1); 
            realMonitorMap[MonitorType.MIC_INVERTER_INVERTERXL] = inverterxl;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_INVERTERXL))
                historyMonitorMap[MonitorType.MIC_INVERTER_INVERTERXL] = inverterxl;

            //设备状态
            int devicestatus = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(76 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_DEVICESTATUS] = devicestatus;
            base.deviceState = devicestatus;

            //设备时间
            int statusyear = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(78 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statusmonth = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(80 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statusday = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(82 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statushh = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(84 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statusminuts = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(86 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            int statussecond = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(88 * hexbytecharnum, 2 * hexbytecharnum), false, 8, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_STATUSTIME] = "";// statusyear + "/" + statusmonth + "/" + statusday + " " + statushh + ":" + statusminuts + ":" + statussecond;

            //状态数据1
            int statusdata1 = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(90 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_STATUSDATA1] = statusdata1;

            //状态数据2
            int statusdata2 = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(92 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_STATUSDATA2] = statusdata2;

            //状态数据3
            int statusdata3 = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(94 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            realMonitorMap[MonitorType.MIC_INVERTER_STATUSDATA3] = statusdata3;

            //add by qhb in 20120823
            //保留	4字节
            //故障状态	4字节 无符号
            string tempstr = monitorstr.Substring(100 * hexbytecharnum, 4 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffffffff"))//ffffffff不做处理
            {
                int errorstatus = (int)SystemCode.HexNumberToDenary(tempstr, true, 32, 'u');
                realMonitorMap[MonitorType.MIC_INVERTER_ERRORSTATUS] = errorstatus;

            }
            //故障状态2	4字节 无符号
            tempstr = monitorstr.Substring(104 * hexbytecharnum, 4 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffffffff"))//ffffffff不做处理
            {
                int errorstatus2 = (int)SystemCode.HexNumberToDenary(tempstr, true, 32, 'u');
                realMonitorMap[MonitorType.MIC_INVERTER_ERRORSTATUS2] = errorstatus2;
            }
            //保留	8字节
            //保留	4字节
            //保留	4字节
            //电抗器温度	2字节	0.1℃	有符号
            tempstr = monitorstr.Substring(124 * hexbytecharnum, 2 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffff"))//ffffffff不做处理
            {
                double dkqtemp = (double)SystemCode.HexNumberToDenary(tempstr, false, 16, 's');
                dkqtemp = Math.Round(dkqtemp * 0.1D, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_DKQTEMPRATURE] = dkqtemp;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_DKQTEMPRATURE))
                    historyMonitorMap[MonitorType.MIC_INVERTER_DKQTEMPRATURE] = dkqtemp;
            }
            //模块温度1	2字节	0.1℃	有符号
            tempstr = monitorstr.Substring(126 * hexbytecharnum, 2 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffff"))//ffffffff不做处理
            {
                double moduletemp1 = (double)SystemCode.HexNumberToDenary(tempstr, false, 16, 's');
                moduletemp1 = Math.Round(moduletemp1 * 0.1D, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP1] = moduletemp1;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_MODULETEMP1))
                    historyMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP1] = moduletemp1;
            }
            //模块温度2	2字节	0.1℃	有符号
            tempstr = monitorstr.Substring(128 * hexbytecharnum, 2 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffff"))//ffffffff不做处理
            {
                double moduletemp2 = (double)SystemCode.HexNumberToDenary(tempstr, false, 16, 's');
                moduletemp2 = Math.Round(moduletemp2 * 0.1D, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP2] = moduletemp2;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_MODULETEMP2))
                    historyMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP2] = moduletemp2;
            }
            //模块温度3	2字节	0.1℃	有符号
            tempstr = monitorstr.Substring(130 * hexbytecharnum, 2 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffff"))//ffffffff不做处理
            {
                double moduletemp3 = (double)SystemCode.HexNumberToDenary(tempstr, false, 16, 's');
                moduletemp3 = Math.Round(moduletemp3 * 0.1D, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP3] = moduletemp3;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_MODULETEMP3))
                    historyMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP3] = moduletemp3;
            }
            //模块温度4	2字节	0.1℃	有符号
            tempstr = monitorstr.Substring(132 * hexbytecharnum, 2 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffff"))//ffffffff不做处理
            {
                double moduletemp4 = (double)SystemCode.HexNumberToDenary(tempstr, false, 16, 's');
                moduletemp4 = Math.Round(moduletemp4 * 0.1D, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP4] = moduletemp4;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_MODULETEMP4))
                    historyMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP4] = moduletemp4;
            }
            //模块温度5	2字节	0.1℃	有符号
            tempstr = monitorstr.Substring(134 * hexbytecharnum, 2 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffff"))//ffffffff不做处理
            {
                double moduletemp5 = (double)SystemCode.HexNumberToDenary(tempstr, false, 16, 's');
                moduletemp5 = Math.Round(moduletemp5 * 0.1D, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP5] = moduletemp5;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_MODULETEMP5))
                    historyMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP5] = moduletemp5;
            }
            //模块温度6	2字节	0.1℃	有符号
            tempstr = monitorstr.Substring(136 * hexbytecharnum, 2 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffff"))//ffffffff不做处理
            {
                double moduletemp6 = (double)SystemCode.HexNumberToDenary(tempstr, false, 16, 's');
                moduletemp6 = Math.Round(moduletemp6 * 0.1D, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP6] = moduletemp6;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_MODULETEMP6))
                    historyMonitorMap[MonitorType.MIC_INVERTER_MODULETEMP6] = moduletemp6;
            }
            //环境温度1	2字节	0.1℃	有符号
            tempstr = monitorstr.Substring(138 * hexbytecharnum, 2 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffff"))//ffffffff不做处理
            {
                double envtemp1 = (double)SystemCode.HexNumberToDenary(tempstr, false, 16, 's');
                envtemp1 = Math.Round(envtemp1 * 0.1D, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_ENVTEMP1] = envtemp1;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ENVTEMP1))
                    historyMonitorMap[MonitorType.MIC_INVERTER_ENVTEMP1] = envtemp1;
            }
            //环境温度2	2字节	0.1℃	有符号
            tempstr = monitorstr.Substring(140 * hexbytecharnum, 2 * hexbytecharnum);
            if (!tempstr.ToLower().Equals("ffff"))//ffffffff不做处理
            {
                double envtemp2 = (double)SystemCode.HexNumberToDenary(tempstr, false, 16, 's');
                envtemp2 = Math.Round(envtemp2 * 0.1D, 1);
                realMonitorMap[MonitorType.MIC_INVERTER_ENVTEMP2] = envtemp2;
                if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_INVERTER_ENVTEMP2))
                    historyMonitorMap[MonitorType.MIC_INVERTER_ENVTEMP2] = envtemp2;
            }
            //保留	2字节
            //保留	4字节

            tableType = TableUtil.INVERTER_TABLE_NAME;
        }

        public ModbusInverter03(string tcpcontent,BaseMessage message) {
            base.deviceData = tcpcontent;
            this.analysis();
        }
    }
}