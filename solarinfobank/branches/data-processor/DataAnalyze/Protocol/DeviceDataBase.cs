using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Protocol
{
    /// <summary>
    /// 设备基类
    /// </summary>
    public class DeviceDataBase
    {

        protected const int hexbytecharnum = 2;//一个十六进制字节占得字符数
        /// <summary>
        /// 设备类型 无符号1字节
        /// </summary>
        public  int protocolType;
        /// <summary>
        /// 数据长度=4+N。1字节
        /// </summary>
        public int dataLength;
        /// <summary>
        /// 设备地址无符号1字节
        /// </summary>
        public string deviceAddress;
        /// <summary>
        /// 设备版本2字节
        /// </summary>
        public string deviceVersion;
        /// <summary>
        /// 协议版本号
        /// </summary>
        public int ProtocolVersion;
        /// <summary>
        /// 数据区
        /// </summary>
        protected string deviceData;
        /// <summary>
        /// 设备状态
        /// </summary>
        public int deviceState;
        /// <summary>
        /// 状态时间
        /// </summary>
        public DateTime deviceStateTime;
        /// <summary>
        /// 设备类型名称对应表名
        /// </summary>
        public string deviceType;

        /// <summary>
        /// 设备今日发电量
        /// </summary>
        public double todayEnergy  = -1;

        /// <summary>
        /// 设备今日增量日照强度 2012/01/13 增加为了计算健康度
        /// </summary>
        public double todaySunshine = -1;

        //实时测点map
        public IDictionary<int, object> realMonitorMap = new Dictionary<int, object>();
        //历史测点数据map
        public IDictionary<int, object> historyMonitorMap = new Dictionary<int, object>();

        public int deviceXh;

        /// <summary>
        /// 
        /// </summary>
        /// <param name="ideviceType"></param>
        /// <param name="ideviceXh"></param>
        /// <param name="idataLength"></param>
        /// <param name="ideviceAddress"></param>
        /// <param name="ideviceVersion"></param>
        /// <param name="iProtocolVersion"></param>
        /// <param name="sdeviceState"></param>
        /// <param name="iyeart"></param>
        /// <param name="imonth"></param>
        /// <param name="iday"></param>
        /// <param name="ihour"></param>
        /// <param name="ifen"></param>
        /// <param name="imiao"></param>
        /// <param name="sdeviceData"></param>
        public DeviceDataBase(int ideviceType, int ideviceXh, int idataLength, string ideviceAddress, string ideviceVersion, int iProtocolVersion, 
            string sdeviceState,int iyeart,int imonth,int iday,int ihour,int ifen,int imiao, string sdeviceData)
        {
            this.protocolType = ideviceType;
            this.dataLength = idataLength;
            this.deviceAddress = ideviceAddress;
            this.deviceVersion = ideviceVersion;
            this.deviceData = sdeviceData;
            this.ProtocolVersion = iProtocolVersion;
            this.deviceState = int.Parse(sdeviceState);
            this.deviceStateTime = new DateTime(iyeart,imonth,iday,ihour,ifen,imiao);
            this.deviceXh = ideviceXh;
        }
        public DeviceDataBase(int ideviceType, int ideviceXh, int idataLength, string ideviceAddress, string ideviceVersion, int iProtocolVersion,
           string sdeviceState, DateTime ddeviceStateTime, string sdeviceData)
        {
            this.protocolType = ideviceType;
            this.dataLength = idataLength;
            this.deviceAddress = ideviceAddress;
            this.deviceVersion = ideviceVersion;
            this.deviceData = sdeviceData;
            this.ProtocolVersion = iProtocolVersion;
            this.deviceState = int.Parse(sdeviceState);
            this.deviceStateTime = ddeviceStateTime;
            this.deviceXh = ideviceXh;
        }

        public DeviceDataBase(int ideviceType, int idataLength)
        {
            this.protocolType = ideviceType;
            this.dataLength = idataLength;
        }
        public DeviceDataBase()
        {
        }
        public DeviceDataBase(string sdeviceData)
        {
            this.deviceData = sdeviceData;
        }
    }
}
