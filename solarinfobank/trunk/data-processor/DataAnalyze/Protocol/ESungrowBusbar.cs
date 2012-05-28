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
    public class ESungrowBusbar : DeviceDataBase
    {
        public string DevName = "逆变装置";
           
        public ESungrowBusbar()
            : base(DeviceData.TYPE_SUNGROW_BUSBAR, ProtocolConst.LENGTH_SUNGROW_BUSBAR)
        {
            
        }
        public ESungrowBusbar(string emailcontent)
        {
            string[] email = emailcontent.Split('=');
            if (email.Length == 23)
            {
                this.deviceAddress = email[2].Replace("DEVTYPE", string.Empty);
                this.protocolType = DeviceData.TYPE_MODBUS_BUSBAR;
                this.deviceVersion = email[3].Replace("I1", string.Empty);
                //Current1 = new Monitoring(  DeviceType.MIC_SUNGROW_BUSBAR_I1, double.Parse(email[4].Replace("I2", string.Empty)));
                //Current2 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I2, double.Parse(email[5].Replace("I3", string.Empty)));
                //Current3 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I3, double.Parse(email[6].Replace("I4", string.Empty)));
                //Current4 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I4, double.Parse(email[7].Replace("I5", string.Empty)));
                //Current5 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I5, double.Parse(email[8].Replace("I6", string.Empty)));
                //Current6 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I6, double.Parse(email[9].Replace("I7", string.Empty)));
                //Current7 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I7, double.Parse(email[10].Replace("I8", string.Empty)));
                //Current8 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I8, double.Parse(email[11].Replace("I9", string.Empty)));
                //Current9 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I8, double.Parse(email[12].Replace("I10", string.Empty)));
                //Current10 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I10, double.Parse(email[13].Replace("I11", string.Empty)));
                //Current11 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I11, double.Parse(email[14].Replace("I12", string.Empty)));
                //Current12 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I12, double.Parse(email[15].Replace("I13", string.Empty)));
                //Current13 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I13, double.Parse(email[16].Replace("I14", string.Empty)));
                //Current14 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I14, double.Parse(email[17].Replace("I15", string.Empty)));
                //Current15 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I15, double.Parse(email[18].Replace("I16", string.Empty)));
                //Current16 = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_I16, double.Parse(email[19].Replace("Vdc", string.Empty)));
                //ArrayVoltage = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_VDC, double.Parse(email[20].Replace("NumIup", string.Empty)));
                //NumIup = new Monitoring(DeviceType.MIC_SUNGROW_BUSBAR_VDC, double.Parse(email[21].Replace("Devtype", string.Empty)));
                this.deviceXh = int.Parse(email[22].Replace("", string.Empty));
            }
        }
    }
}
