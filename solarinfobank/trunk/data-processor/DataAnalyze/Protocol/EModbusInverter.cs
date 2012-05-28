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
    public class EModbusInverter : DeviceDataBase
    {
        public string DevName = "逆变装置";

        public EModbusInverter()
            : base(DeviceData.TYPE_SUNGROW_INVERTER, ProtocolConst.LENGTH_SUNGROW_INVERTER)
        {
          
        }
        public EModbusInverter(string emailcontent)
        {
            string[] email = emailcontent.Split('=');
            if (email.Length == 36)
            {
                this.deviceAddress = email[2].Replace("DEVTYPE", string.Empty);
                this.protocolType = DeviceData.TYPE_MODBUS_INVERTER;
                this.deviceVersion = email[3].Replace("Devtype", string.Empty);
                this.deviceXh = int.Parse(email[4].Replace("Ratep", string.Empty));

                //Outtype = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[5].Replace("Eday", string.Empty)) * 0.1);
                //Eday = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[6].Replace("Etot", string.Empty)) * 0.1);
                //Etot = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[7].Replace("Ttot", string.Empty)) * 0.1);
                //Ttot = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[8].Replace("Temp", string.Empty)) * 0.1);
                //Temp = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[9].Replace("Templ", string.Empty)) * 0.1);
                //Templ = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[10].Replace("Temph", string.Empty)) * 0.1);
                //Temph = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[11].Replace("Vdc1", string.Empty)) * 0.1);
                //Vdc1 = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[12].Replace("Vdc2", string.Empty)) * 0.1);
                //Vdc2 = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[13].Replace("Vdc3", string.Empty)) * 0.1);
                //Vdc3 = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[14].Replace("Idc1", string.Empty)) * 0.1);
                //Idc1 = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[15].Replace("Idc2", string.Empty)) * 0.1);
                //Idc2 = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[16].Replace("Idc3", string.Empty)) * 0.1);
                //Idc3 = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[17].Replace("Pdc", string.Empty)) * 0.1);
                //Pdc = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[18].Replace("Va", string.Empty)) * 0.1);
                //Va = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[19].Replace("Vb", string.Empty)) * 0.1);
                //Vb = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[20].Replace("Vc", string.Empty)) * 0.1);
                //Vc = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[21].Replace("Ia", string.Empty)) * 0.1);
                //Ia = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[22].Replace("Ib", string.Empty)) * 0.1);
                //Ib = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[23].Replace("Ic", string.Empty)) * 0.1);
                //Ic = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[24].Replace("Pa", string.Empty)) * 0.1);
                //Pa = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[25].Replace("Pb", string.Empty)) * 0.1);
                //Pb = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[26].Replace("Pc", string.Empty)) * 0.1);
                //Pc = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[27].Replace("Pac", string.Empty)) * 0.1);
                //Pac = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[28].Replace("Pre", string.Empty)) * 0.1);
                //Pre = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[29].Replace("Pf", string.Empty)) * 0.1);
                //Pf = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[30].Replace("Fgrid", string.Empty)) * 0.1);
                //Fgrid = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[31].Replace("Eff", string.Empty)) * 0.1);
                //Eff = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[32].Replace("st", string.Empty)) * 0.1);
                //st = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[33].Replace("Time", string.Empty)) * 0.1);
                //Time = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[34].Replace("St1", string.Empty)) * 0.1);
                //St1 = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[35].Replace("St2", string.Empty)) * 0.1);
                //St2 = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[36].Replace("St3", string.Empty)) * 0.1);
                //St3 = new Monitoring(DeviceType.MIC_MODBUS_INVERTER_PRE, int.Parse(email[37].Replace("", string.Empty)) * 0.1);
            }
        }

    }
}
