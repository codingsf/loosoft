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
    /// </summary>
    public class Ammeter : DeviceDataBase
    {
        public string DevName = "电表装置";
        int deviceDataHeadLength = 5;//5字节

        /// <summary>
        /// 根据电表协议解析单个设备数据
        /// </summary>
        public void analysis()
        {
            //deviceData
            //设备型号
            base.deviceXh = (int)SystemCode.HexNumberToDenary(deviceData.Substring(deviceDataHeadLength * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            //电表无地址
            base.deviceAddress = SystemCode.HexNumberToDenary(deviceData.Substring(1 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u').ToString();
            //设备版本
            int largeVersion = (int)SystemCode.HexNumberToDenary(deviceData.Substring(3 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            int smallVersion = (int)SystemCode.HexNumberToDenary(deviceData.Substring(4 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            base.deviceVersion = largeVersion + "." + smallVersion;
            //设备协议类型
            base.protocolType = (int)SystemCode.HexNumberToDenary(deviceData.Substring(2 * hexbytecharnum, 1 * hexbytecharnum), false, 8, 'u');
            //测点数据串去掉设备数据的头部
            string monitorstr = deviceData.Substring(deviceDataHeadLength * hexbytecharnum);

            //系统频率F 0.01Hz
            double SYSFREQUENCY = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(2 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            SYSFREQUENCY = Math.Round(SYSFREQUENCY * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_SYSFREQUENCY] = SYSFREQUENCY;

            //相电压V1 0.1V U16
            double PHASEVOLTAGE1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(4 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASEVOLTAGE1 = Math.Round(PHASEVOLTAGE1 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE1] = PHASEVOLTAGE1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEVOLTAGE1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE1] = PHASEVOLTAGE1;

            //相电压V2 0.1V U16
            double PHASEVOLTAGE2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(6 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASEVOLTAGE2 = Math.Round(PHASEVOLTAGE2 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE2] = PHASEVOLTAGE2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEVOLTAGE2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE2] = PHASEVOLTAGE2;

            //相电压V3 0.1V U16
            double PHASEVOLTAGE3 = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(8 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASEVOLTAGE3 = Math.Round(PHASEVOLTAGE3 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE3] = PHASEVOLTAGE3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEVOLTAGE3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEVOLTAGE3] = PHASEVOLTAGE3;

            //相（线）电流I1  0.1A U16
            double PHASECURRENT1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(10 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASECURRENT1 = Math.Round(PHASECURRENT1 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT1] = PHASECURRENT1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASECURRENT1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT1] = PHASECURRENT1;

            //相（线）电流I2  0.1A U16
            double PHASECURRENT2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(12 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASECURRENT2 = Math.Round(PHASECURRENT2 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT2] = PHASECURRENT2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASECURRENT2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT2] = PHASECURRENT2;

            //相（线）电流I3  0.1A U16
            double PHASECURRENT3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(14 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 'u');
            PHASECURRENT3 = Math.Round(PHASECURRENT3 * 0.1, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT3] = PHASECURRENT3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASECURRENT3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASECURRENT3] = PHASECURRENT3;

            //分相有功功率P1 s32 W
            double PHASEACTIVEPOWER1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(16 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            //PHASEACTIVEPOWER1 = Math.Round(PHASEACTIVEPOWER1 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER1] = PHASEACTIVEPOWER1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEACTIVEPOWER1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER1] = PHASEACTIVEPOWER1;

            //分相有功功率P2 s32 W
            double PHASEACTIVEPOWER2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(20 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
           // CURRENT5 = Math.Round(CURRENT5 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER2] = PHASEACTIVEPOWER2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEACTIVEPOWER2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER2] = PHASEACTIVEPOWER2;
            
            //分相有功功率P3 s32 W
            double PHASEACTIVEPOWER3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(24 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            // CURRENT5 = Math.Round(CURRENT5 * 0.01, 2);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER3] = PHASEACTIVEPOWER3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEACTIVEPOWER3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEACTIVEPOWER3] = PHASEACTIVEPOWER3;

            //系统有功功率Psum s32 W
            double SYSACTIVEPOWER = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(28 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            realMonitorMap[MonitorType.MIC_AMMETER_SYSACTIVEPOWER] = SYSACTIVEPOWER;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_SYSACTIVEPOWER))
                historyMonitorMap[MonitorType.MIC_AMMETER_SYSACTIVEPOWER] = SYSACTIVEPOWER;

            //分相无功功率Q1 Var S32
            double PHASEREACTIVEPOWER1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(32 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER1] = PHASEREACTIVEPOWER1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER1] = PHASEREACTIVEPOWER1;
            //分相无功功率Q2 Var S32
            double PHASEREACTIVEPOWER2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(36 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER2] = PHASEREACTIVEPOWER2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER2] = PHASEREACTIVEPOWER2;
            //分相无功功率Q3 Var S32
            double PHASEREACTIVEPOWER3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(40 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER3] = PHASEREACTIVEPOWER3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEREACTIVEPOWER3] = PHASEREACTIVEPOWER3;


            //系统无功功率Qsum S32 Var
            double SYSREACTIVEPOWER = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(44 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 's');
            realMonitorMap[MonitorType.MIC_AMMETER_SYSREACTIVEPOWER] = SYSREACTIVEPOWER;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_SYSREACTIVEPOWER))
                historyMonitorMap[MonitorType.MIC_AMMETER_SYSREACTIVEPOWER] = SYSREACTIVEPOWER;

            //分相视在功率S1 U32 VA
            double PHASEAPPARENTPOWER1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(48 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER1] = PHASEAPPARENTPOWER1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER1] = PHASEAPPARENTPOWER1;
            //分相视在功率S2 U32 VA
            double PHASEAPPARENTPOWER2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(52 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER2] = PHASEAPPARENTPOWER2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER2] = PHASEAPPARENTPOWER2;
            //分相视在功率S1 U32 VA
            double PHASEAPPARENTPOWER3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(56 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER3] = PHASEAPPARENTPOWER3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEAPPARENTPOWER3] = PHASEAPPARENTPOWER3;


            //系统视在功率Ssum U32 VA
            double _SYSAPPARENTPOWER = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(60 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_SYSAPPARENTPOWER] = _SYSAPPARENTPOWER;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_SYSAPPARENTPOWER))
                historyMonitorMap[MonitorType.MIC_AMMETER_SYSAPPARENTPOWER] = _SYSAPPARENTPOWER;

            //分相功率因数PF1 S16 0.0001
            double PHASEPOWERFACTOR1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(64 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            PHASEPOWERFACTOR1 = Math.Round(PHASEPOWERFACTOR1 * 0.0001, 3);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR1] = PHASEPOWERFACTOR1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEPOWERFACTOR1))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR1] = PHASEPOWERFACTOR1;
            //分相功率因数PF1 S16 0.0001
            double PHASEPOWERFACTOR2 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(66 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            PHASEPOWERFACTOR2 = Math.Round(PHASEPOWERFACTOR2 * 0.0001, 3);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR2] = PHASEPOWERFACTOR2;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEPOWERFACTOR2))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR2] = PHASEPOWERFACTOR2;
            //分相功率因数PF3 S16 0.0001
            double PHASEPOWERFACTOR3 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(68 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            PHASEPOWERFACTOR3 = Math.Round(PHASEPOWERFACTOR3 * 0.0001, 3);
            realMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR3] = PHASEPOWERFACTOR3;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PHASEPOWERFACTOR3))
                historyMonitorMap[MonitorType.MIC_AMMETER_PHASEPOWERFACTOR3] = PHASEPOWERFACTOR3;
            //系统功率因数PF S16 0.0001
            double SYSPOWERFACTOR1 = (double)SystemCode.HexNumberToDenary(monitorstr.Substring(70 * hexbytecharnum, 2 * hexbytecharnum), false, 16, 's');
            SYSPOWERFACTOR1 = Math.Round(SYSPOWERFACTOR1 * 0.0001, 3);
            realMonitorMap[MonitorType.MIC_AMMETER_SYSPOWERFACTOR1] = SYSPOWERFACTOR1;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_SYSPOWERFACTOR1))
                historyMonitorMap[MonitorType.MIC_AMMETER_SYSPOWERFACTOR1] = SYSPOWERFACTOR1;
            
            //向有功电度 U32 kWh
            int POSITIVEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(74 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE] = POSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE] = POSITIVEACTIVEPOWERDEGREE;
            //反向有功电度 U32 kWh
            int REVERSEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(78 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_REVERSEACTIVEPOWERDEGREE] = REVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_REVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_REVERSEACTIVEPOWERDEGREE] = REVERSEACTIVEPOWERDEGREE;
            //正向无功电度 U32 kVarh
            int _POSITIVEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(82 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE] = _POSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_POSITIVEREACTIVEPOWERDEGREE] = _POSITIVEREACTIVEPOWERDEGREE;
            //反向无功电度 U32 kVarh
            int REVERSEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(84 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE] = REVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_REVERSEREACTIVEPOWERDEGREE] = REVERSEREACTIVEPOWERDEGREE;
            //绝对值和有功电度 U32 kWh
            int ABSOLUTEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(88 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE] = ABSOLUTEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_ABSOLUTEACTIVEPOWERDEGREE] = ABSOLUTEACTIVEPOWERDEGREE;
            //净有功电度 U32 kWh
            int PUREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(92 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_PUREACTIVEPOWERDEGREE] = PUREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PUREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_PUREACTIVEPOWERDEGREE] = PUREACTIVEPOWERDEGREE;
            //绝对值和无功电度 U32 kVarh
            int ABSOLUTEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(96 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE] = ABSOLUTEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_ABSOLUTEREACTIVEPOWERDEGREE] = ABSOLUTEREACTIVEPOWERDEGREE;
            //净无功电度 U32 kVarh
            int PUREREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(100 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_PUREREACTIVEPOWERDEGREE] = PUREREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_PUREREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_PUREREACTIVEPOWERDEGREE] = PUREREACTIVEPOWERDEGREE;

            
            // 费率波正向有功电度 U32 kWh
            int WAVERATEPOSITIVEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(104 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE] = WAVERATEPOSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_WAVERATEPOSITIVEACTIVEPOWERDEGREE] = WAVERATEPOSITIVEACTIVEPOWERDEGREE;
             // 费率波反向有功电度 U32 kWh
            int WAVERATEREVERSEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(108 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE] = WAVERATEREVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_WAVERATEREVERSEACTIVEPOWERDEGREE] = WAVERATEREVERSEACTIVEPOWERDEGREE;
            // 费率波正向无功电度 U32 kVarh
            int WAVERATEPOSITIVEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(112 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE] = WAVERATEPOSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_WAVERATEPOSITIVEREACTIVEPOWERDEGREE] = WAVERATEPOSITIVEREACTIVEPOWERDEGREE;          
            // 费率波反向无功电度 U32 kVarh
            int WAVERATEREVERSEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(116 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE] = WAVERATEREVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_WAVERATEREVERSEREACTIVEPOWERDEGREE] = WAVERATEREVERSEREACTIVEPOWERDEGREE;

            // 费率峰正向有功电度 U32 kWh
            int RATEPEAKPOSITIVEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(120 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE] = RATEPEAKPOSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEACTIVEPOWERDEGREE] = RATEPEAKPOSITIVEACTIVEPOWERDEGREE;
            // 费率峰反向有功度 U32 kWh
            int RATEPEAKREVERSEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(124 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE] = RATEPEAKREVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKREVERSEACTIVEPOWERDEGREE] = RATEPEAKREVERSEACTIVEPOWERDEGREE;
            // 费率峰正向无功电度 U32 kVarh
            int RATEPEAKPOSITIVEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(128 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE] = RATEPEAKPOSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKPOSITIVEREACTIVEPOWERDEGREE] = RATEPEAKPOSITIVEREACTIVEPOWERDEGREE;          
            // 费率峰反向无功电度 U32 kVarh
            int RATEPEAKREVERSEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(132 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE] = RATEPEAKREVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEPEAKREVERSEREACTIVEPOWERDEGREE] = RATEPEAKREVERSEREACTIVEPOWERDEGREE;

            // 费率谷正向有功电度 U32 kWh
            int RATEVALLEYPOSITIVEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(136 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE] = RATEVALLEYPOSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEACTIVEPOWERDEGREE] = RATEVALLEYPOSITIVEACTIVEPOWERDEGREE;
            //  费率谷反向有功电度 U32 kWh
            int RATEVALLEYREVERSEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(140 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE] = RATEVALLEYREVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYREVERSEACTIVEPOWERDEGREE] = RATEVALLEYREVERSEACTIVEPOWERDEGREE;
            // 费率谷正向无功电度 U32 kVarh
            int RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(144 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE] = RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE] = RATEVALLEYPOSITIVEREACTIVEPOWERDEGREE;          
            // 费率谷反向无功电度 U32 kVarh
            int RATEVALLEYREVERSEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(148 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE] = RATEVALLEYREVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATEVALLEYREVERSEREACTIVEPOWERDEGREE] = RATEVALLEYREVERSEREACTIVEPOWERDEGREE;

            // 费率平正向有功电度 U32 kWh
            int RATELEVELPOSITIVEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(152 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE] = RATELEVELPOSITIVEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATELEVELPOSITIVEACTIVEPOWERDEGREE] = RATELEVELPOSITIVEACTIVEPOWERDEGREE;
            // 费率平反向有功电度 U32 kWh
            int RATELEVELREVERSEACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(156 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE] = RATELEVELREVERSEACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATELEVELREVERSEACTIVEPOWERDEGREE] = RATELEVELREVERSEACTIVEPOWERDEGREE;
            // 费率平正向无功电度 U32 kVarh
            int RATELEVELPOSITIVEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(160 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE] = RATELEVELPOSITIVEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATELEVELPOSITIVEREACTIVEPOWERDEGREE] = RATELEVELPOSITIVEREACTIVEPOWERDEGREE;          
            // 费率平反向无功电度 U32 kVarh
            int RATELEVELREVERSEREACTIVEPOWERDEGREE = (int)SystemCode.HexNumberToDenary(monitorstr.Substring(164 * hexbytecharnum, 4 * hexbytecharnum), true, 32, 'u');
            realMonitorMap[MonitorType.MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE] = RATELEVELREVERSEREACTIVEPOWERDEGREE;
            if (MonitorType.historyMonitorList.Contains(MonitorType.MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE))
                historyMonitorMap[MonitorType.MIC_AMMETER_RATELEVELREVERSEREACTIVEPOWERDEGREE] = RATELEVELREVERSEREACTIVEPOWERDEGREE;


            deviceType = TableUtil.AMMETER;

        }

        public Ammeter(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.analysis();
        }

    }
}
