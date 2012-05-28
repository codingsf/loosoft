using System.Collections.Generic;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 设备逻辑大类型和协议无关，对用户显示的类型
    /// </summary>
    public class DeviceType
    {
        public DeviceType()
        {
        }
        private IList<ProtocolType> _protocolTypeList;//协议
        public int code { get; set; }                 //类型代码
        public string protocolTypes { get; set; }     //包含的协议类型
        public string name                            //类型名称
        {
            get
            {
                return LanguageUtil.getDesc("DEVICETYPE_" + this.code);
            }
        }

        public IList<ProtocolType> protocolTypeList
        {
            get
            {
                if (_protocolTypeList == null)
                {
                    _protocolTypeList = new List<ProtocolType>();

                    string[] mcArr = this.protocolTypes.Split(',');
                    foreach (string mc in mcArr)
                    {
                        _protocolTypeList.Add(DeviceData.getProtocolTypeByCode(int.Parse(mc)));
                    }
                }
                return _protocolTypeList;
            }
        }
    }

    //协议类型
    public class ProtocolType
    {
        public ProtocolType() { }
        public int code { get; set; }      //型号代码
        public string name { get; set; }      //协议名称
        public int typecode { get; set; }      //大型号代码
        public ProtocolType protocolType
        {
            get
            {
                return DeviceData.getProtocolTypeByCode(this.code);
            }
        }//设备逻辑类型

        public DeviceType deviceType
        {
            get
            {
                return DeviceData.getDeviceTypeByCode(this.typecode);
            }
        }   //设备逻辑大类型
    }

}
