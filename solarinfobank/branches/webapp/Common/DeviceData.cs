
using System.Collections.Generic;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 定义设备类型，设备型号和测点
    /// </summary>
    public class DeviceData
    {
        //设备类型CODE
        /// <summary>
        /// 电站设备
        /// </summary>
        public const int PLANT_CODE = 0;
        /// <summary>
        /// 逆变器
        /// </summary>
        public const int INVERTER_CODE = 1;
        /// <summary>
        /// 汇流箱设备
        /// </summary>
        public const int HUILIUXIANG_CODE = 3;
        /// <summary>
        /// 环境检测仪
        /// </summary>
        public const int ENVRIOMENTMONITOR_CODE = 5;
        /// <summary>
        /// 直流配电柜
        /// </summary>
        public const int CABINET_CODE = 7;
        /// <summary>
        /// 电表
        /// </summary>
        public const int AMMETER_CODE = 9;



        //----协议类型编码定义-------//
        /// <summary>
        /// 0x01逆变器 （SUNGROW协议）
        /// </summary>
        public const int TYPE_SUNGROW_INVERTER = 0x01;
        /// <summary>
        /// 0x02	逆变器（MODBUS协议）
        /// </summary>
        public const int TYPE_MODBUS_INVERTER = 0x02;

        /// <summary>
        /// 0x11 汇流箱（SUNGROW协议）
        ///</summary>
        public const int TYPE_SUNGROW_BUSBAR = 0x11;
        /// <summary>
        /// 0x12 汇流箱（MODBUS协议）
        /// </summary>
        public const int TYPE_MODBUS_BUSBAR = 0x12;
        /// <summary>
        /// 0x15 光伏阵列汇流箱通讯协议（Modbus）V1.1.1.0-2011.8.30.pdf
        /// </summary>
        public const int TYPE_MODBUS15_BUSBAR = 0x15;

        /// <summary>
        /// 0x13 直流配电柜（SUNGROW协议）
        ///</summary>
        public const int TYPE_SUNGROW_CABINET = 0x13;
        /// <summary>
        ///0x14	直流配电柜（MODBUS协议）
        /// </summary>
        public const int TYPE_MODBUS_CABINET = 0x14;

        /// <summary>
        ///0x16	光伏直流配电柜通信协议（Modbus）V1.0-柴达木-2011.8.30.pdf
        /// </summary>
        public const int TYPE_MODBUS16_CABINET = 0x16;

        /// <summary>
        /// 0x21	环境检测仪（SUNGROW协议）
        /// </summary>
        public const int TYPE_SUNGROW_DETECTOR = 0x21;

        /// <summary>
        /// 0x22	环境检测仪（MODBUS协议）
        /// </summary>
        public const int TYPE_MODBUS_DETECTOR = 0x22;
        /// <summary>
        /// 0x23 MODBUS V1.0.2.0版协议
        /// </summary>
        public const int TYPE_MODBUS_DETECTOR_V1020 = 0x23;

        /// <summary>
        /// 0x41 阳光电表通信协议V1.0
        /// </summary>
        public const int TYPE_AMMETER = 0x41;


        //设备类型map
        public static IDictionary<int, DeviceType> deviceTypeMap = new Dictionary<int, DeviceType>();
        //协议类型map
        public static IDictionary<int, ProtocolType> protocolTypeMap = new Dictionary<int, ProtocolType>();

        //有状态的测点List
        public static IList<int> statusMonitorList = new List<int>();

        //有状态的测点对应的设备状态list map
        public static IDictionary<int, IList<DeviceStatusType>> monitorStatusMap = new Dictionary<int, IList<DeviceStatusType>>();

        static DeviceData()
        {
            //将设备类型代码和对象加入map
            deviceTypeMap.Add(INVERTER_CODE, new DeviceType() { code = INVERTER_CODE, protocolTypes = TYPE_SUNGROW_INVERTER + "," + TYPE_MODBUS_INVERTER });
            deviceTypeMap.Add(HUILIUXIANG_CODE, new DeviceType() { code = HUILIUXIANG_CODE, protocolTypes = TYPE_SUNGROW_BUSBAR + "," + TYPE_MODBUS_BUSBAR });
            deviceTypeMap.Add(ENVRIOMENTMONITOR_CODE, new DeviceType() { code = ENVRIOMENTMONITOR_CODE, protocolTypes = TYPE_SUNGROW_DETECTOR + "," + TYPE_MODBUS_DETECTOR + "," + TYPE_MODBUS_DETECTOR_V1020 });
            deviceTypeMap.Add(CABINET_CODE, new DeviceType() { code = CABINET_CODE, protocolTypes = TYPE_SUNGROW_CABINET + "," + TYPE_MODBUS_CABINET });
            deviceTypeMap.Add(AMMETER_CODE, new DeviceType() { code = AMMETER_CODE, protocolTypes = TYPE_AMMETER.ToString() });

            //将协议类型代码和对象加入map
            protocolTypeMap.Add(TYPE_SUNGROW_INVERTER, new ProtocolType() { code = TYPE_SUNGROW_INVERTER, typecode = INVERTER_CODE, name = "逆变器SUNGROW协议" });
            protocolTypeMap.Add(TYPE_MODBUS_INVERTER, new ProtocolType() { code = TYPE_MODBUS_INVERTER, typecode = INVERTER_CODE, name = "逆变器MODBUS协议" });

            protocolTypeMap.Add(TYPE_SUNGROW_BUSBAR, new ProtocolType() { code = TYPE_SUNGROW_BUSBAR, typecode = HUILIUXIANG_CODE, name = "汇流箱SUNGROW协议" });
            protocolTypeMap.Add(TYPE_MODBUS_BUSBAR, new ProtocolType() { code = TYPE_MODBUS_BUSBAR, typecode = HUILIUXIANG_CODE, name = "汇流箱MODEBUS协议" });
            protocolTypeMap.Add(TYPE_MODBUS15_BUSBAR, new ProtocolType() { code = TYPE_MODBUS15_BUSBAR, typecode = HUILIUXIANG_CODE, name = "汇流箱装置光伏阵列汇流箱通讯协议（Modbus）V1.1.1.0" });

            protocolTypeMap.Add(TYPE_SUNGROW_DETECTOR, new ProtocolType() { code = TYPE_SUNGROW_DETECTOR, typecode = ENVRIOMENTMONITOR_CODE, name = "环境检测仪SUNGROW协议" });
            protocolTypeMap.Add(TYPE_MODBUS_DETECTOR, new ProtocolType() { code = TYPE_MODBUS_DETECTOR, typecode = ENVRIOMENTMONITOR_CODE, name = "环境检测仪MODBUS协议" });
            protocolTypeMap.Add(TYPE_MODBUS_DETECTOR_V1020, new ProtocolType() { code = TYPE_MODBUS_DETECTOR_V1020, typecode = ENVRIOMENTMONITOR_CODE, name = "环境检测仪MODBUS V1.0.2.0版协议" });

            protocolTypeMap.Add(TYPE_SUNGROW_CABINET, new ProtocolType() { code = TYPE_SUNGROW_CABINET, typecode = CABINET_CODE, name = "直流配电柜SUNGROW协议" });
            protocolTypeMap.Add(TYPE_MODBUS_CABINET, new ProtocolType() { code = TYPE_MODBUS_CABINET, typecode = CABINET_CODE, name = "直流配电柜MODEBUS协议" });
            protocolTypeMap.Add(TYPE_MODBUS16_CABINET, new ProtocolType() { code = TYPE_MODBUS16_CABINET, typecode = CABINET_CODE, name = "光伏直流配电柜通信协议（Modbus）V1.0-柴达木-2011.8.30.pdf" });

            protocolTypeMap.Add(TYPE_AMMETER, new ProtocolType() { code = TYPE_AMMETER, typecode = AMMETER_CODE, name = "阳光电表通信协议V1.0" });

            //将有状态的测点代码加入list
            statusMonitorList.Add(MonitorType.MIC_INVERTER_OUTTYPE);
            statusMonitorList.Add(MonitorType.MIC_BUSBAR_COMMUNICATION);
            statusMonitorList.Add(MonitorType.MIC_INVERTER_DEVICESTATUS);
            statusMonitorList.Add(MonitorType.MIC_BUSBAR_STATUS);

            //将有状态的测点对应的测点列表加入map
            //逆变器输出类型测点
            IList<DeviceStatusType> outtypeList = new List<DeviceStatusType>();
            outtypeList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_outtype_liangx, monitorCode = MonitorType.MIC_INVERTER_OUTTYPE, name = "两相" });
            outtypeList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_outtype_sanx, monitorCode = MonitorType.MIC_INVERTER_OUTTYPE, name = "三相" });
            monitorStatusMap.Add(MonitorType.MIC_INVERTER_OUTTYPE, outtypeList);

            //逆变器modbus设备状态测点
            IList<DeviceStatusType> invertStatusList = new List<DeviceStatusType>();
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_run, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "运行" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_ajgj, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "按键关机" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_byqgw, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_chshidj, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_daiji, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_dwgy, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "按键关机" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_dygp, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_dyqp, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_dyqy, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_gudgzh, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "按键关机" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_jchqgzh, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_jdgzh, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_jjtj, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_mkgzh, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "按键关机" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_nbgy, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_plych, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_shchgzh, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_startuping, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "按键关机" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_tingji, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_xdchgy, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "变压器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_xdchqy, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "蓄电池欠压" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_yjgzh, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "硬件故障" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_zlgy, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "直流过压" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_zlmxgy, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "直流母线过压" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_zlmxqy, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "直流母线欠压" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_jcqxh, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "接触器吸合" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_jcqdk, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "接触器断开" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_shutdowning, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "关机中" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_zltk, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "直流脱扣" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_jltk, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "交流脱扣" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_fault, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "硬件故障" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_txgz, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "通信故障" });
            

            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_jerun, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "降额运行" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_ddrun, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "调度运行" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_gjrun, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "告警运行" });
            
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_mkgw, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "模块过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_gfdigz, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "GFDI故障" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_jyzk, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "绝缘阻抗" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_xiumian, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "休眠" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_zlrdqgz, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "直流熔断器故障" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_dkqgw, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "电抗器过温" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_fjgz, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "风机故障" });
            invertStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.inverter_status_flqgz, monitorCode = MonitorType.MIC_INVERTER_DEVICESTATUS, name = "防雷器故障" });

            monitorStatusMap.Add(MonitorType.MIC_INVERTER_DEVICESTATUS, invertStatusList);

            //汇流箱sungrow设备状态测点
            IList<DeviceStatusType> BusbarSungrowStatusList = new List<DeviceStatusType>();
            BusbarSungrowStatusList.Add(new DeviceStatusType() { code = DeviceStatusType.busbar_sungrow_txlx_hlx, monitorCode = MonitorType.MIC_BUSBAR_COMMUNICATION, name = "变压器过温" });
            monitorStatusMap.Add(MonitorType.MIC_BUSBAR_COMMUNICATION, BusbarSungrowStatusList);
        }

        /// <summary>
        /// 根据设备类型代码取得设备类型对象
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static DeviceType getDeviceTypeByCode(int code)
        {
            return deviceTypeMap[code];
        }

        /// <summary>
        /// 根据协议类型代码取得协议类型对象
        /// </summary>
        /// <param name="code">协议类型代码</param>
        /// <returns></returns>
        public static ProtocolType getProtocolTypeByCode(int code)
        {
            if (protocolTypeMap.ContainsKey(code))
                return protocolTypeMap[code];
            else
                return new ProtocolType();
        }

        /// <summary>
        /// 取得所有设备类型对象列表，不包括电站的
        /// </summary>
        /// <param name="code">协议类型代码</param>
        /// <returns></returns>
        public static ICollection<DeviceType> getDeviceTypeList()
        {
            return deviceTypeMap.Values;
        }

        /// <summary>
        /// 取得所有协议类型对象列表
        /// </summary>
        /// <returns></returns>
        public static ICollection<ProtocolType> getProtocolTypeList()
        {
            return protocolTypeMap.Values;
        }
    }
}