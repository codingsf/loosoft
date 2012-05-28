using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
namespace Protocol
{
    /// <summary>
    /// 逆变装置
    /// </summary>
    public class ESungrowInverter : DeviceDataBase
    {
        public string DevName = "逆变装置";

        public ESungrowInverter()
            : base(DeviceData.TYPE_SUNGROW_INVERTER, ProtocolConst.LENGTH_SUNGROW_INVERTER)
        {
        }
        public ESungrowInverter(string emailcontent)
        { 
            string[] email = emailcontent.Split('=');
            if (email.Length == 13)
            {
                this.deviceAddress = email[2].Replace("DEVTYPE", string.Empty);
                this.protocolType = DeviceData.TYPE_MODBUS_BUSBAR;
                this.deviceVersion = email[3].Replace("Vac", string.Empty);
                //VAC = new Monitoring(DeviceType.MIC_SUNGROW_INVERTER_VAC, double.Parse(email[4].Replace("Iac", string.Empty)));
                //AC = new Monitoring(DeviceType.MIC_SUNGROW_INVERTER_IAC, double.Parse(email[5].Replace("Vdc", string.Empty)));
                //VDC = new Monitoring(DeviceType.MIC_SUNGROW_INVERTER_VDC, double.Parse(email[6].Replace("Idc", string.Empty)));
                //DCA = new Monitoring(DeviceType.MIC_SUNGROW_INVERTER_IDC, double.Parse(email[7].Replace("Temp", string.Empty)));
                //Temp = new Monitoring(DeviceType.MIC_SUNGROW_INVERTER_TEMP, double.Parse(email[8].Replace("Eday", string.Empty)));
                //DEnergy = new Monitoring(DeviceType.MIC_SUNGROW_INVERTER_EDAY, double.Parse(email[9].Replace("Etot", string.Empty)));
                //EEnergy = new Monitoring(DeviceType.MIC_SUNGROW_INVERTER_ETOT, double.Parse(email[10].Replace("St", string.Empty)));
                //Status = new Monitoring(DeviceType.MIC_SUNGROW_INVERTER_ST, double.Parse(email[10].Replace("Fgrid", string.Empty)));
                //Frequency = new Monitoring(DeviceType.MIC_SUNGROW_INVERTER_FGRID, double.Parse(email[11].Replace("Devtype", string.Empty)));
                this.deviceXh = int.Parse(email[12].Replace("", string.Empty));
            }
        }

    }
}
