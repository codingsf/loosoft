using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
namespace Protocol
{
    /// <summary>
    /// 环境监测仪通讯协议
    /// </summary>
    public class ESungrowDetector : DeviceDataBase
    {
        public string DevName = "逆变装置";

        public ESungrowDetector()
            : base(DeviceData.TYPE_SUNGROW_INVERTER, ProtocolConst.LENGTH_SUNGROW_INVERTER)
        {
        }
        public ESungrowDetector(string emailcontent)
        {
            string[] email = emailcontent.Split('=');
            if (email.Length == 13) {

                this.deviceAddress = email[2].Replace("DEVTYPE", string.Empty).ToString();
                this.protocolType = DeviceData.TYPE_MODBUS_BUSBAR;
                this.deviceVersion = email[3].Replace("Ire", string.Empty);

                //Pyrheliometer = new Monitoring(DeviceType.MIC_SUNGROW_DETECTOR_IRE, int.Parse(email[4].Replace("Pvtemp", string.Empty)));
                //PanelsTemp = new Monitoring(DeviceType.MIC_SUNGROW_DETECTOR_PVTEMP, int.Parse(email[5].Replace("Temp", string.Empty)));
                //AmbientTemp = new Monitoring(DeviceType.MIC_SUNGROW_DETECTOR_TEMP, int.Parse(email[6].Replace("Pvtemph", string.Empty)));
                //PanelsTempHigh = new Monitoring(DeviceType.MIC_SUNGROW_DETECTOR_PVTEMPH, int.Parse(email[7].Replace("Temph", string.Empty)));
                //AmbientTempHigh = new Monitoring(DeviceType.MIC_SUNGROW_DETECTOR_TEMPH, int.Parse(email[8].Replace("Wind", string.Empty)));
                //WindSpeed = new Monitoring(DeviceType.MIC_SUNGROW_DETECTOR_WIND, int.Parse(email[9].Replace("Windh", string.Empty)));
                //WindSpeedHigh = new Monitoring(DeviceType.MIC_SUNGROW_DETECTOR_WINDH, int.Parse(email[10].Replace("Ires", string.Empty)));
                //CantPyrheliometer = new Monitoring(DeviceType.MIC_SUNGROW_DETECTOR_IRES, int.Parse(email[11].Replace("Winddir", string.Empty)));
                //WindDirection = new Monitoring(DeviceType.MIC_SUNGROW_DETECTOR_WINDDIR, int.Parse(email[12].Replace("", string.Empty)));
            }
        }
    }
}
