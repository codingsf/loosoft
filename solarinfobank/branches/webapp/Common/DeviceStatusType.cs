namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 设备测点状态类型
    /// </summary>
    public class DeviceStatusType
    {
        //逆变器modbus输出类型
        /// <summary>
        /// 两相 0x0000
        /// </summary>
        public const int inverter_outtype_liangx = 0;
        /// <summary>
        /// 三相 0x0001
        /// </summary>
        public const int inverter_outtype_sanx = 1;


        //逆变器modbus 设备状态
        /// <summary>
        /// 运行 0x0000
        /// </summary>
        public const int inverter_status_run = 0;
        /// <summary>
        /// 直流过压 0x0001
        /// </summary>
        public const int inverter_status_zlgy = 1;
        /// <summary>
        /// 电网过压 0x0008
        /// </summary>
        public const int inverter_status_dwgy = 8;
        /// <summary>
        /// 电网欠压	0x0010
        /// </summary>
        public const int inverter_status_dyqy = 16;
        /// <summary>
        /// 变压器过温	0x0020
        /// </summary>
        public const int inverter_status_byqgw = 32;
        /// <summary>
        /// 频率异常（保留）	0x0040
        /// </summary>
        public const int inverter_status_plych = 64;
        /// <summary>
        /// 孤岛故障	0x0080
        /// </summary>
        public const int inverter_status_gudgzh = 128;
        /// <summary>
        /// 硬件故障	0x0200
        /// </summary>
        public const int inverter_status_yjgzh= 512;
        /// <summary>
        /// 接地故障	0x0400
        /// </summary>
        public const int inverter_status_jdgzh = 1024;
        /// <summary>
        /// 模块故障	0x0800
        /// </summary>
        public const int inverter_status_mkgzh = 2048;
        /// <summary>
        /// 接触器故障	0x4000
        /// </summary>
        public const int inverter_status_jchqgzh = 16384;
        /// <summary>
        /// 停机	0x8000
        /// </summary>
        public const int inverter_status_tingji = 32768;
        /// <summary>
        /// 初始待机	0x1200
        /// </summary>
        public const int inverter_status_chshidj = 4608;
        /// <summary>
        /// 按键关机	0x1300
        /// </summary>
        public const int inverter_status_ajgj = 4864;
        /// <summary>
        /// 待机	0x1400
        /// </summary>
        public const int inverter_status_daiji = 5120;
        /// <summary>
        /// 紧急停机	0x1500
        /// </summary>
        public const int inverter_status_jjtj = 5376;
        /// <summary>
        /// 启动中	0x1600
        /// </summary>
        public const int inverter_status_startuping = 5632;
        /// <summary>
        /// 电网过频	0x1700
        /// </summary>
        public const int inverter_status_dygp = 5888;
        /// <summary>
        /// 电网欠频	0x1800
        /// </summary>
        public const int inverter_status_dyqp = 6144;
        /// <summary>
        /// 直流母线过压	0x2300
        /// </summary>
        public const int inverter_status_zlmxgy = 8960;
        /// <summary>
        /// 直流母线欠压	0x2400
        /// </summary>
        public const int inverter_status_zlmxqy = 9216;

        /// <summary>
        /// 通信故障	0x2500
        /// </summary>
        public const int inverter_status_txgz = 9472;

        /// <summary>
        /// 逆变过压	0x2700
        /// </summary>
        public const int inverter_status_nbgy = 9984;
        /// <summary>
        /// 输出过载	0x2800
        /// </summary>
        public const int inverter_status_shchgzh = 10240;
        /// <summary>
        /// 蓄电池过压	0x2900
        /// </summary>
        public const int inverter_status_xdchgy = 10496;
        /// <summary>
        /// 蓄电池欠压	0x3000
        /// </summary>
        public const int inverter_status_xdchqy = 122888;

        /// <summary>
        /// 接触器吸合	0x5000
        /// </summary>
        public const int inverter_status_jcqxh = 20480;
        /// <summary>
        /// 接触器断开	0x5100
        /// </summary>
        public const int inverter_status_jcqdk = 20736;
        /// <summary>
        /// 关机中	0x5200
        /// </summary>
        public const int inverter_status_shutdowning = 20992;
        /// <summary>
        /// 直流脱扣	0x5300
        /// </summary>
        public const int inverter_status_zltk = 21248;
        /// <summary>
        /// 交流脱扣	0x5400
        /// </summary>
        public const int inverter_status_jltk = 21504;
        /// <summary>
        /// 硬件故障	0x5500
        /// </summary>
        public const int inverter_status_fault = 21760;

        ///
        /// 模块过温	0x4010
        /// 
        public const int inverter_status_mkgw = 16400;

        ///
        /// GFDI故障	0x4011
        /// 
        public const int inverter_status_gfdigz = 16401;
        ///
        /// 绝缘阻抗	0x4012
        ///
        public const int inverter_status_jyzk = 16402;
        ///
        /// 休眠	0x4013
        /// 
        public const int inverter_status_xiumian = 16403;
        ///
        /// 直流熔断器故障	0x4014
        /// 
        public const int inverter_status_zlrdqgz = 16404;
        ///
        /// 电抗器过温	0x4015
        /// 
        public const int inverter_status_dkqgw = 16405;
        ///
        /// 风机故障	0x4016
        /// 
        public const int inverter_status_fjgz = 16406;

        ///
        /// 防雷器故障	0x4017
        /// 
        public const int inverter_status_flqgz = 16407;

        ///
        /// 降额运行	0x8100
        /// 
        public const int inverter_status_jerun = 33024;

        ///
        /// 调度运行	0x8200
        /// 
        public const int inverter_status_ddrun = 33280;
        /// <summary>
        /// 告警运行	0x9100
        /// </summary>
        public const int inverter_status_gjrun = 37120;

        /// <summary>
        /// 111111： 离线 自定义
        /// </summary>
        public const int device_offline = 111111;

        /// <summary>
        /// 222222： 离线 自定义
        /// </summary>
        public const int device_run = 222222;

        //汇流箱
        /// <summary>
        /// 通讯类型 100
        /// </summary>
        
        public const int busbar_sungrow_txlx_hlx = 256;


        //环境检测仪sungrow

        private string _name;
                 
        public DeviceStatusType()
        {
        }
        public int code { get; set; }                 //类型代码
        public int monitorCode { get; set; }          //所属测点代码
        public string name                            //类型名称
        {
            set {
                this._name = value;
            }
            get
            {
                string res = LanguageUtil.getDesc("DEVICESTATUSTYPE_" + monitorCode + "_" + this.code);
                //取不到状态定义，则借用故障的多语言定义
                if(string.IsNullOrEmpty(res))
                    return LanguageUtil.getDesc("ERRORITEM_" + this.code);

                return res;
            }
        }
    }
}