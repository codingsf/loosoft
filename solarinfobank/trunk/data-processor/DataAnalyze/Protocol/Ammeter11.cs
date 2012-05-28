using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
namespace Protocol
{
    /// <summary>
    /// 电表协议类
    /// for阳光电表通信协议V1.1(草稿).doc
    /// </summary>
    public class Ammeter11 : DeviceDataBase
    {
        public string DevName = "电表装置";
        int deviceDataHeadLength = 5;//5字节

        /// <summary>
        /// 根据电表协议解析单个设备数据
        /// Rx为采样值， Ubb为电压互感比(电压变比)，Ibb为电流互感比(电流变比)
        /// 适用参量
        /// 对应关系
        /// 电压V1,V2,V3
        /// U=Rx×Ubb
        /// 电流I1,I2,I3
        /// I=Rx×Ibb
        /// 有功功率P1,P2,P3，Psum
        /// P=Rx×Ubb×Ibb
        /// 无功功率Q1,Q2,Q3，Qsum
        /// Q=Rx×Ubb×Ibb
        /// 视在功率S1,S2,S3，Ssum
        /// S=Rx×Ubb×Ibb
        /// 有功电度
        /// Ep=Rx×Ubb×Ibb
        /// 无功电度 
        /// Eq=Rx×Ubb×Ibb
        /// </summary>
        public void analysis()
        {
            //deviceData = "20 B0 02 00 01 00 00 02 00 02 00 00 08 66 08 A2 09 06 00 6E 00 05 00 15 23 32 03 20 00 0A 27 10 24 F9 00 01 14 50 00 00 00 01 00 00 07 E4 00 00 03 E8 00 00 C7 38 00 00 52 6C 00 00 CB 20 00 00 24 FF 00 01 C8 40 00 00 52 6B 00 00 CB 47 00 00 27 0D 00 00 14 51 00 00 13 B7 00 00 00 33 00 00 00 2F 00 00 00 0A 00 00 00 11 00 00 00 0A 00 00 0B E7 00 00 00 00 00 00 00 1B 00 00 00 00 00 00 04 17 00 00 00 79 00 00 04 7B 00 00 00 0B 00 00 20 9B 00 00 13 ED 00 00 0F CF 00 00 00 15 00 00 64 01 02 00 00 00 28 00 96 00 01 01 2D 0B B8 00 00 00 46 00 00 00 DF 00 F2 00 FB 0E D8 01 8A 0E E4 01 89 0E EF 01 88 3A 83 00 00 08 98 08 A3 08 9D 02 AA 02 A6 02 A8 3A 9C 00 00 3A 8E 00 00 3A 92 00 00 AF AE 00 00 00 5A 00 00 03 E6 01 F4 03 E5 00 00 07 DA 00 0C 00 1F 00 08 00 08 00 08 00 00 00 00 00 00";
            //设备型号
            base.deviceXh = (int)SystemCode.HexNumberToDenary(deviceData.Substring(deviceDataHeadLength * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            //电表地址
            base.deviceAddress = SystemCode.HexNumberToDenary(deviceData.Substring(1 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u').ToString();
            //设备版本
            int largeVersion = (int)SystemCode.HexNumberToDenary(deviceData.Substring(3 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            int smallVersion = (int)SystemCode.HexNumberToDenary(deviceData.Substring(4 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            base.deviceVersion = largeVersion + "." + smallVersion;
            //设备协议类型
            base.protocolType = (int)SystemCode.HexNumberToDenary(deviceData.Substring(2 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            //测点数据串去掉设备数据的头部
            string monitorstr = deviceData.Substring(deviceDataHeadLength * hexbytecharnum);//"20B002000100000200020000086608A20906006E0005001523320320000A271024F90001145000000001000007E4000003E80000C7380000526C0000CB20000024FF0001C8400000526B0000CB470000270D00001451000013B7000000330000002F0000000A000000110000000A00000BE7000000000000001B0000000000000417000000790000047B0000000B0000209B000013ED00000FCF0000001500006401020000002800960001012D0BB800000046000000DF00F200FB0ED8018A0EE401890EEF01883A830000089808A3089D02AA02A602A83A9C00003A8E00003A920000AFAE0000005A000003E601F403E5000007DA000C001F000800080008000000000000";
            //电压变比 u16
            string valuestr = monitorstr.Substring(6 * hexbytecharnum, 2 * hexbytecharnum);
            int dybb = (int)SystemCode.HexNumberToDenary(valuestr, false, 16, 'u');

            //电流变比 u16
            valuestr = monitorstr.Substring(8 * hexbytecharnum, 2 * hexbytecharnum);
            int dlbb = (int)SystemCode.HexNumberToDenary(valuestr, false, 16, 'u');

            //系统频率F 0.01Hz u16
            valuestr = monitorstr.Substring(10 * hexbytecharnum, 2 * hexbytecharnum);
            double SYSFREQUENCY = (double)SystemCode.HexNumberToDenary(valuestr, false, 16, 'u');
            SYSFREQUENCY = Math.Round(SYSFREQUENCY * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_SYSFREQUENCY] = SYSFREQUENCY;

            //相电压V1 0.1V U16 电压V1,V2,V3
            /// U=Rx×Ubb
            valuestr = monitorstr.Substring(12 * hexbytecharnum, 2 * hexbytecharnum);
            double PHASEVOLTAGE1 = (double)SystemCode.HexNumberToDenary(valuestr, false, 16, 'u');
            PHASEVOLTAGE1 = PHASEVOLTAGE1 * dybb;
            PHASEVOLTAGE1 = Math.Round(PHASEVOLTAGE1 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE1] = PHASEVOLTAGE1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEVOLTAGE1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE1] = PHASEVOLTAGE1;

            //相电压V2 0.1V U16
            double PHASEVOLTAGE2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(14 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASEVOLTAGE2 = PHASEVOLTAGE2 * dybb;
            PHASEVOLTAGE2 = Math.Round(PHASEVOLTAGE2 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE2] = PHASEVOLTAGE2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEVOLTAGE2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE2] = PHASEVOLTAGE2;

            //相电压V3 0.1V U16
            double PHASEVOLTAGE3 = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(16 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASEVOLTAGE3 = PHASEVOLTAGE3 * dybb;
            PHASEVOLTAGE3 = Math.Round(PHASEVOLTAGE3 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE3] = PHASEVOLTAGE3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEVOLTAGE3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE3] = PHASEVOLTAGE3;

            //相（线）电流I1  0.01A U16
            double PHASECURRENT1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(18 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASECURRENT1 = PHASECURRENT1 * dlbb;
            PHASECURRENT1 = Math.Round(PHASECURRENT1 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT1] = PHASECURRENT1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASECURRENT1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT1] = PHASECURRENT1;

            //相（线）电流I2  0.01A U16
            double PHASECURRENT2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(20 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASECURRENT2 = PHASECURRENT2 * dlbb;
            PHASECURRENT2 = Math.Round(PHASECURRENT2 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT2] = PHASECURRENT2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASECURRENT2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT2] = PHASECURRENT2;

            //相（线）电流I3  0.01A U16
            double PHASECURRENT3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(22 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASECURRENT3 = PHASECURRENT3 * dlbb;
            PHASECURRENT3 = Math.Round(PHASECURRENT3 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT3] = PHASECURRENT3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASECURRENT3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT3] = PHASECURRENT3;

            //分相功率因数PF1 S16 0.0001
            double PHASEPOWERFACTOR1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(24 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            PHASEPOWERFACTOR1 = Math.Round(PHASEPOWERFACTOR1 * 0.0001, 3);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR1] = PHASEPOWERFACTOR1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEPOWERFACTOR1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR1] = PHASEPOWERFACTOR1;
            //分相功率因数PF2 S16 0.0001
            double PHASEPOWERFACTOR2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(26 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            PHASEPOWERFACTOR2 = Math.Round(PHASEPOWERFACTOR2 * 0.0001, 3);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR2] = PHASEPOWERFACTOR2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEPOWERFACTOR2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR2] = PHASEPOWERFACTOR2;
            //分相功率因数PF3 S16 0.0001
            double PHASEPOWERFACTOR3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(28 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            PHASEPOWERFACTOR3 = Math.Round(PHASEPOWERFACTOR3 * 0.0001, 3);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR3] = PHASEPOWERFACTOR3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEPOWERFACTOR3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR3] = PHASEPOWERFACTOR3;
            //系统功率因数PF S16 0.0001
            double SYSPOWERFACTOR1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(30 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            SYSPOWERFACTOR1 = Math.Round(SYSPOWERFACTOR1 * 0.0001, 3);
            realMonitorMap[MonitorType.MIC_AMMETER_SYSPOWERFACTOR1] = SYSPOWERFACTOR1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_SYSPOWERFACTOR1))
                historyMonitorMap[MonitorType.MIC_AMMETER_SYSPOWERFACTOR1] = SYSPOWERFACTOR1;

            //分相有功功率P1 s32 0.1W 
            //有功功率P1,P2,P3，Psum
            //P=Rx×Ubb×Ibb
            double PHASEACTIVEPOWER1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(32 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            PHASEACTIVEPOWER1 = PHASEACTIVEPOWER1 * dybb * dlbb;
            PHASEACTIVEPOWER1 = Math.Round(PHASEACTIVEPOWER1 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER1] = PHASEACTIVEPOWER1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEACTIVEPOWER1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER1] = PHASEACTIVEPOWER1;

            //分相有功功率P2 s32 0.1W
            double PHASEACTIVEPOWER2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(36 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            PHASEACTIVEPOWER2 = PHASEACTIVEPOWER2 * dybb * dlbb;
            PHASEACTIVEPOWER2 = Math.Round(PHASEACTIVEPOWER2 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER2] = PHASEACTIVEPOWER2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEACTIVEPOWER2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER2] = PHASEACTIVEPOWER2;
            
            //分相有功功率P3 s32 0.1W
            double PHASEACTIVEPOWER3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(40 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            PHASEACTIVEPOWER3 = PHASEACTIVEPOWER3 * dybb * dlbb;
            PHASEACTIVEPOWER3 = Math.Round(PHASEACTIVEPOWER3 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER3] = PHASEACTIVEPOWER3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEACTIVEPOWER3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER3] = PHASEACTIVEPOWER3;

            //系统有功功率Psum s32 0.1W
            double SYSACTIVEPOWER = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(44 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            SYSACTIVEPOWER = SYSACTIVEPOWER * dybb * dlbb;
            SYSACTIVEPOWER = Math.Round(SYSACTIVEPOWER * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_SYSACTIVEPOWER] = SYSACTIVEPOWER;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_SYSACTIVEPOWER))
                historyMonitorMap[MonitorType.MIC_AMMETER_SYSACTIVEPOWER] = SYSACTIVEPOWER;

            //分相无功功率Q1 0.1Var S32
            double PHASEREACTIVEPOWER1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(48 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            PHASEREACTIVEPOWER1 = PHASEREACTIVEPOWER1 * dybb * dlbb;
            PHASEREACTIVEPOWER1 = Math.Round(PHASEREACTIVEPOWER1 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER1] = PHASEREACTIVEPOWER1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER1] = PHASEREACTIVEPOWER1;
            //分相无功功率Q2 0.1ar S32
            double PHASEREACTIVEPOWER2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(52 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            PHASEREACTIVEPOWER2 = PHASEREACTIVEPOWER2 * dybb * dlbb;
            PHASEREACTIVEPOWER2 = Math.Round(PHASEREACTIVEPOWER2 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER2] = PHASEREACTIVEPOWER2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER2] = PHASEREACTIVEPOWER2;
            //分相无功功率Q3 0.1Var S32
            double PHASEREACTIVEPOWER3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(56 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            PHASEREACTIVEPOWER3 = PHASEREACTIVEPOWER3 * dybb * dlbb;
            PHASEREACTIVEPOWER3 = Math.Round(PHASEREACTIVEPOWER3 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER3] = PHASEREACTIVEPOWER3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER3] = PHASEREACTIVEPOWER3;

            //系统无功功率Qsum S32 0.1Var
            double SYSREACTIVEPOWER = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(60 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            SYSREACTIVEPOWER = SYSREACTIVEPOWER * dybb * dlbb;
            SYSREACTIVEPOWER = Math.Round(SYSREACTIVEPOWER * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_SYSREACTIVEPOWER] = SYSREACTIVEPOWER;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_SYSREACTIVEPOWER))
                historyMonitorMap[MonitorType.MIC_AMMETER_SYSREACTIVEPOWER] = SYSREACTIVEPOWER;

            //分相视在功率S1 U32 0.1VA
            //视在功率S1,S2,S3，Ssum
            //S=Rx×Ubb×Ibb
            double PHASEAPPARENTPOWER1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(64 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            PHASEAPPARENTPOWER1 = PHASEAPPARENTPOWER1 * dybb * dlbb;
            PHASEAPPARENTPOWER1 = Math.Round(PHASEAPPARENTPOWER1 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER1] = PHASEAPPARENTPOWER1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER1] = PHASEAPPARENTPOWER1;
            //分相视在功率S2 U32 0.1VA
            double PHASEAPPARENTPOWER2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(68 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            PHASEAPPARENTPOWER2 = PHASEAPPARENTPOWER2 * dybb * dlbb;
            PHASEAPPARENTPOWER2 = Math.Round(PHASEAPPARENTPOWER2 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER2] = PHASEAPPARENTPOWER2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER2] = PHASEAPPARENTPOWER2;
            //分相视在功率S1 U32 0.1VA
            double PHASEAPPARENTPOWER3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(72 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            PHASEAPPARENTPOWER3 = PHASEAPPARENTPOWER3 * dybb * dlbb;
            PHASEAPPARENTPOWER3 = Math.Round(PHASEAPPARENTPOWER3 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER3] = PHASEAPPARENTPOWER3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER3] = PHASEAPPARENTPOWER3;

            //系统视在功率Ssum U32 0.1VA
            double _SYSAPPARENTPOWER = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(76 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            _SYSAPPARENTPOWER = _SYSAPPARENTPOWER * dybb * dlbb;
            _SYSAPPARENTPOWER = Math.Round(_SYSAPPARENTPOWER * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_SYSAPPARENTPOWER] = _SYSAPPARENTPOWER;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_SYSAPPARENTPOWER))
                historyMonitorMap[MonitorType.MIC_AMMETER_SYSAPPARENTPOWER] = _SYSAPPARENTPOWER;
            
            //正向有功电度 U32 0.01kWh 
            //有功电度
            //Ep=Rx×Ubb×Ibb
            double POSITIVEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(80 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            POSITIVEACTIVEPOWERDEGREE = POSITIVEACTIVEPOWERDEGREE * dybb * dlbb;
            POSITIVEACTIVEPOWERDEGREE = Math.Round(POSITIVEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE] = POSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE] = POSITIVEACTIVEPOWERDEGREE;
            //反向有功电度 U32 0.01kWh
            double REVERSEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(84 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            REVERSEACTIVEPOWERDEGREE = REVERSEACTIVEPOWERDEGREE * dybb * dlbb;
            REVERSEACTIVEPOWERDEGREE = Math.Round(REVERSEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_REVERSEACTIVEPOWERDEGREE] = REVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_REVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_REVERSEACTIVEPOWERDEGREE] = REVERSEACTIVEPOWERDEGREE;
            //正向无功电度 U32 0.01kVarh
            double _POSITIVEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(88 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            _POSITIVEREACTIVEPOWERDEGREE = _POSITIVEREACTIVEPOWERDEGREE * dybb * dlbb;
            _POSITIVEREACTIVEPOWERDEGREE = Math.Round(_POSITIVEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE] = _POSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE] = _POSITIVEREACTIVEPOWERDEGREE;
            //反向无功电度 U32 0.01kVarh
            double REVERSEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(92 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            REVERSEREACTIVEPOWERDEGREE = REVERSEREACTIVEPOWERDEGREE * dybb * dlbb;
            REVERSEREACTIVEPOWERDEGREE = Math.Round(REVERSEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE] = REVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE] = REVERSEREACTIVEPOWERDEGREE;

            //1.1没有这些测点值
            ////绝对值和有功电度 U32 kWh
            //int ABSOLUTEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(88 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            //realMonitorMap[MonitorType.MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE] = ABSOLUTEACTIVEPOWERDEGREE;
            //if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE))
            //    historyMonitorMap[MonitorType.MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE] = ABSOLUTEACTIVEPOWERDEGREE;
            ////净有功电度 U32 kWh
            //int PUREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(92 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            //realMonitorMap[MonitorType.MIC_AMMETER_PUREACTIVEPOWERDEGREE] = PUREACTIVEPOWERDEGREE;
            //if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PUREACTIVEPOWERDEGREE))
            //    historyMonitorMap[MonitorType.MIC_AMMETER_PUREACTIVEPOWERDEGREE] = PUREACTIVEPOWERDEGREE;
            ////绝对值和无功电度 U32 kVarh
            //int ABSOLUTEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(96 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            //realMonitorMap[MonitorType.MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE] = ABSOLUTEREACTIVEPOWERDEGREE;
            //if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE))
            //    historyMonitorMap[MonitorType.MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE] = ABSOLUTEREACTIVEPOWERDEGREE;
            ////净无功电度 U32 kVarh
            //int PUREREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(100 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            //realMonitorMap[MonitorType.MIC_AMMETER_PUREREACTIVEPOWERDEGREE] = PUREREACTIVEPOWERDEGREE;
            //if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PUREREACTIVEPOWERDEGREE))
            //    historyMonitorMap[MonitorType.MIC_AMMETER_PUREREACTIVEPOWERDEGREE] = PUREREACTIVEPOWERDEGREE;

            
            // 费率波正向有功电度 U32 0.01kWh
            double WAVERATEPOSITIVEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(96 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            WAVERATEPOSITIVEACTIVEPOWERDEGREE = WAVERATEPOSITIVEACTIVEPOWERDEGREE * dybb * dlbb;
            WAVERATEPOSITIVEACTIVEPOWERDEGREE = Math.Round(WAVERATEPOSITIVEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE] = WAVERATEPOSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE] = WAVERATEPOSITIVEACTIVEPOWERDEGREE;
            // 费率波反向有功电度 U32 0.01kWh
            double WAVERATEREVERSEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(100 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            WAVERATEREVERSEACTIVEPOWERDEGREE = WAVERATEREVERSEACTIVEPOWERDEGREE * dybb * dlbb;
            WAVERATEREVERSEACTIVEPOWERDEGREE = Math.Round(WAVERATEREVERSEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE] = WAVERATEREVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE] = WAVERATEREVERSEACTIVEPOWERDEGREE;
            // 费率波正向无功电度 U32 0.01kVarh
            double WAVERATEPOSITIVEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(104 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            WAVERATEPOSITIVEREACTIVEPOWERDEGREE = WAVERATEPOSITIVEREACTIVEPOWERDEGREE * dybb * dlbb;
            WAVERATEPOSITIVEREACTIVEPOWERDEGREE = Math.Round(WAVERATEPOSITIVEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE] = WAVERATEPOSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE] = WAVERATEPOSITIVEREACTIVEPOWERDEGREE;
            // 费率波反向无功电度 U32 0.01kVarh
            double WAVERATEREVERSEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(108 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            WAVERATEREVERSEREACTIVEPOWERDEGREE = WAVERATEREVERSEREACTIVEPOWERDEGREE * dybb * dlbb;
            WAVERATEREVERSEREACTIVEPOWERDEGREE = Math.Round(WAVERATEREVERSEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE] = WAVERATEREVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE] = WAVERATEREVERSEREACTIVEPOWERDEGREE;

            // 费率峰正向有功电度 U32 0.01kWh
            double RATEPEAKPOSITIVEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(112 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATEPEAKPOSITIVEACTIVEPOWERDEGREE = RATEPEAKPOSITIVEACTIVEPOWERDEGREE * dybb * dlbb;
            RATEPEAKPOSITIVEACTIVEPOWERDEGREE = Math.Round(RATEPEAKPOSITIVEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE] = RATEPEAKPOSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE] = RATEPEAKPOSITIVEACTIVEPOWERDEGREE;
            // 费率峰反向有功度 U32 0.01kWh
            double RATEPEAKREVERSEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(116 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATEPEAKREVERSEACTIVEPOWERDEGREE = RATEPEAKREVERSEACTIVEPOWERDEGREE * dybb * dlbb;
            RATEPEAKREVERSEACTIVEPOWERDEGREE = Math.Round(RATEPEAKREVERSEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE] = RATEPEAKREVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE] = RATEPEAKREVERSEACTIVEPOWERDEGREE;
            // 费率峰正向无功电度 U32 0.01kVarh
            double RATEPEAKPOSITIVEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(120 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATEPEAKPOSITIVEREACTIVEPOWERDEGREE = RATEPEAKPOSITIVEREACTIVEPOWERDEGREE * dybb * dlbb;
            RATEPEAKPOSITIVEREACTIVEPOWERDEGREE = Math.Round(RATEPEAKPOSITIVEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE] = RATEPEAKPOSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE] = RATEPEAKPOSITIVEREACTIVEPOWERDEGREE;
            // 费率峰反向无功电度 U32 0.01kVarh
            double RATEPEAKREVERSEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(124 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATEPEAKREVERSEREACTIVEPOWERDEGREE = RATEPEAKREVERSEREACTIVEPOWERDEGREE * dybb * dlbb;
            RATEPEAKREVERSEREACTIVEPOWERDEGREE = Math.Round(RATEPEAKREVERSEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE] = RATEPEAKREVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE] = RATEPEAKREVERSEREACTIVEPOWERDEGREE;

            // 费率谷正向有功电度 U32 0.01kWh
            double RATEVALLEYPOSITIVEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(128 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATEVALLEYPOSITIVEACTIVEPOWERDEGREE = RATEVALLEYPOSITIVEACTIVEPOWERDEGREE * dybb * dlbb;
            RATEVALLEYPOSITIVEACTIVEPOWERDEGREE = Math.Round(RATEVALLEYPOSITIVEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE] = RATEVALLEYPOSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE] = RATEVALLEYPOSITIVEACTIVEPOWERDEGREE;
            //  费率谷反向有功电度 U32 kWh
            double RATEVALLEYREVERSEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(132 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATEVALLEYREVERSEACTIVEPOWERDEGREE = RATEVALLEYREVERSEACTIVEPOWERDEGREE * dybb * dlbb;
            RATEVALLEYREVERSEACTIVEPOWERDEGREE = Math.Round(RATEVALLEYREVERSEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE] = RATEVALLEYREVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE] = RATEVALLEYREVERSEACTIVEPOWERDEGREE;
            // 费率谷正向无功电度 U32 0.01kVarh
            double RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(136 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE = RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE * dybb * dlbb;
            RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE = Math.Round(RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE] = RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE] = RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE;
            // 费率谷反向无功电度 U32 0.01kVarh
            double RATEVALLEYREVERSEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(140 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATEVALLEYREVERSEREACTIVEPOWERDEGREE = RATEVALLEYREVERSEREACTIVEPOWERDEGREE * dybb * dlbb;
            RATEVALLEYREVERSEREACTIVEPOWERDEGREE = Math.Round(RATEVALLEYREVERSEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE] = RATEVALLEYREVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE] = RATEVALLEYREVERSEREACTIVEPOWERDEGREE;

            // 费率平正向有功电度 U32 0.01kWh
            double RATELEVELPOSITIVEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(144 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATELEVELPOSITIVEACTIVEPOWERDEGREE = RATELEVELPOSITIVEACTIVEPOWERDEGREE * dybb * dlbb;
            RATELEVELPOSITIVEACTIVEPOWERDEGREE = Math.Round(RATELEVELPOSITIVEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE] = RATELEVELPOSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE] = RATELEVELPOSITIVEACTIVEPOWERDEGREE;
            // 费率平反向有功电度 U32 0.01kWh
            double RATELEVELREVERSEACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(148 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATELEVELREVERSEACTIVEPOWERDEGREE = RATELEVELREVERSEACTIVEPOWERDEGREE * dybb * dlbb;
            RATELEVELREVERSEACTIVEPOWERDEGREE = Math.Round(RATELEVELREVERSEACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE] = RATELEVELREVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE] = RATELEVELREVERSEACTIVEPOWERDEGREE;
            // 费率平正向无功电度 U32 0.01kVarh
            double RATELEVELPOSITIVEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(152 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATELEVELPOSITIVEREACTIVEPOWERDEGREE = RATELEVELPOSITIVEREACTIVEPOWERDEGREE * dybb * dlbb;
            RATELEVELPOSITIVEREACTIVEPOWERDEGREE = Math.Round(RATELEVELPOSITIVEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE] = RATELEVELPOSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE] = RATELEVELPOSITIVEREACTIVEPOWERDEGREE;          
            // 费率平反向无功电度 U32 0.01kVarh
            double RATELEVELREVERSEREACTIVEPOWERDEGREE = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(156 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            RATELEVELREVERSEREACTIVEPOWERDEGREE = RATELEVELREVERSEREACTIVEPOWERDEGREE * dybb * dlbb;
            RATELEVELREVERSEREACTIVEPOWERDEGREE = Math.Round(RATELEVELREVERSEREACTIVEPOWERDEGREE * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE] = RATELEVELREVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE] = RATELEVELREVERSEREACTIVEPOWERDEGREE;

            tableType = TableUtil.AMMETER;
        }

        public Ammeter11(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.analysis();
        }
    }
}
