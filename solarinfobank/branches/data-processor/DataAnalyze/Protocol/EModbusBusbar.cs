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
    public class EModbusBusbar : DeviceDataBase
    {

        public string DevName = "逆变装置";
        public string numEntry;       
        public int communicationType;
        public int sensorPoems;         
        public EModbusBusbar()
            : base(DeviceData.TYPE_MODBUS_BUSBAR, ProtocolConst.LENGTH_MODBUS_BUSBAR)
        {
            //Current1 = new Monitoring("Current1",DeviceType.MIC_MODBUS_BUSBAR_I1, 0, 1 * 2 * 2, "0.1A");
            //Current2 = new Monitoring("Current2", DeviceType.MIC_MODBUS_BUSBAR_I2, 1, 1 * 2 * 2, "0.1A");
            //Current3 = new Monitoring("Current3", DeviceType.MIC_MODBUS_BUSBAR_I3, 2, 1 * 2 * 2, "0.1A");
            //Current4 = new Monitoring("Current4", DeviceType.MIC_MODBUS_BUSBAR_I4, 3, 1 * 2 * 2, "0.1A");
            //Current5 = new Monitoring("Current5", DeviceType.MIC_MODBUS_BUSBAR_I5, 4, 1 * 2 * 2, "0.1A");
            //Current6 = new Monitoring("Current6", DeviceType.MIC_MODBUS_BUSBAR_I6, 5, 1 * 2 * 2, "0.1A");
            //Current7 = new Monitoring("Current7", DeviceType.MIC_MODBUS_BUSBAR_I7, 6, 1 * 2 * 2, "0.1A");
            //Current8 = new Monitoring("Current8", DeviceType.MIC_MODBUS_BUSBAR_I8, 7, 1 * 2 * 2, "0.1A");
            //Current9 = new Monitoring("Current9", DeviceType.MIC_MODBUS_BUSBAR_I9, 8, 1 * 2 * 2, "0.1A");
            //Current10 = new Monitoring("Current10", DeviceType.MIC_MODBUS_BUSBAR_I10, 9, 1 * 2 * 2, "0.1A");
            //Current11 = new Monitoring("Current11", DeviceType.MIC_MODBUS_BUSBAR_I11, 10, 1 * 2 * 2, "0.1A");
            //Current12 = new Monitoring("Current12", DeviceType.MIC_MODBUS_BUSBAR_I12, 11, 1 * 2 * 2, "0.1A");
            //Current13 = new Monitoring("Current13", DeviceType.MIC_MODBUS_BUSBAR_I13, 12, 1 * 2 * 2, "0.1A");
            //Current14 = new Monitoring("Current14", DeviceType.MIC_MODBUS_BUSBAR_I14, 13, 1 * 2 * 2, "0.1A");
            //Current15 = new Monitoring("Current15", DeviceType.MIC_MODBUS_BUSBAR_I15, 14, 1 * 2 * 2, "0.1A");
            //Current16 = new Monitoring("Current16", DeviceType.MIC_MODBUS_BUSBAR_I16, 15, 1 * 2 * 2, "0.1A");
            //ArrayVoltage = new Monitoring("ArrayVoltage", DeviceType.MIC_MODBUS_BUSBAR_VAC, 18 * 2 * 2, 2 * 2 * 2, "0.1V");
            //MachineTemp = new Monitoring("MachineTemp", DeviceType.MIC_MODBUS_BUSBAR_TEMP, 2 * 2 * 2, 1 * 2 * 2, "0.1℃");
            //numEntry = string.Empty;
            sensorPoems = 0;
            communicationType = 130;
       }
        public EModbusBusbar(string emailcontent)
        {
            string[] email = emailcontent.Split('=');
            if (email.Length == 25)
            {
                //this.deviceAddress = int.Parse(email[2].Replace("DEVTYPE", string.Empty));                
                //this.deviceType = DeviceType.TYPE_MODBUS_BUSBAR;
                //this.deviceVersion = email[3].Replace("MaxIup", string.Empty);
               
                //deviceXh = int.Parse(email[4].Replace("MaxIup", string.Empty));
                //sensorPoems = int.Parse(email[5].Replace("Temp", string.Empty));
                //MachineTemp = new Monitoring("MachineTemp", DeviceType.MIC_MODBUS_BUSBAR_TEMP, 2 * 2 * 2, 1 * 2 * 2, int.Parse(email[6].Replace("Vac", string.Empty)) * 01, "0.1℃");
                //ArrayVoltage = new Monitoring("ArrayVoltage", DeviceType.MIC_MODBUS_BUSBAR_VAC, 9 * 2 * 2, 1 * 2 * 2, int.Parse(email[7].Replace("NumIup", string.Empty)) * 0.1, "0.1A");
                //numEntry = email[8].Replace("I1", string.Empty);
                //Current1 = new Monitoring("Current1", DeviceType.MIC_MODBUS_BUSBAR_I1, 9 * 2 * 2, 1 * 2 * 2, int.Parse(email[9].Replace("I2", string.Empty)) * 0.1, "0.1A");
                //Current2 = new Monitoring("Current2", DeviceType.MIC_MODBUS_BUSBAR_I2, 10 * 2 * 2, 1 * 2 * 2, int.Parse(email[10].Replace("I3", string.Empty)) * 01, "0.1A");
                //Current3 = new Monitoring("Current3", DeviceType.MIC_MODBUS_BUSBAR_I3, 11 * 2 * 2, 1 * 2 * 2, int.Parse(email[11].Replace("I4", string.Empty)) * 01, "0.1A");
                //Current4 = new Monitoring("Current4", DeviceType.MIC_MODBUS_BUSBAR_I4, 12 * 2 * 2, 1 * 2 * 2, int.Parse(email[12].Replace("I5", string.Empty)) * 01, "0.1A");
                //Current5 = new Monitoring("Current5", DeviceType.MIC_MODBUS_BUSBAR_I5, 13 * 2 * 2, 1 * 2 * 2, int.Parse(email[13].Replace("I6", string.Empty)) * 01, "0.1A");
                //Current6 = new Monitoring("Current6", DeviceType.MIC_MODBUS_BUSBAR_I6, 14 * 2 * 2, 1 * 2 * 2, int.Parse(email[14].Replace("I7", string.Empty)) * 01, "0.1A");
                //Current7 = new Monitoring("Current7", DeviceType.MIC_MODBUS_BUSBAR_I7, 15 * 2 * 2, 1 * 2 * 2, int.Parse(email[15].Replace("I8", string.Empty)) * 01, "0.1A");
                //Current8 = new Monitoring("Current8", DeviceType.MIC_MODBUS_BUSBAR_I8, 16 * 2 * 2, 1 * 2 * 2, int.Parse(email[16].Replace("I9", string.Empty)) * 01, "0.1A");
                //Current9 = new Monitoring("Current9", DeviceType.MIC_MODBUS_BUSBAR_I9, 17 * 2 * 2, 1 * 2 * 2, int.Parse(email[17].Replace("I10", string.Empty)) * 01, "0.1A");
                //Current10 = new Monitoring("Current10", DeviceType.MIC_MODBUS_BUSBAR_I10, 18 * 2 * 2, 1 * 2 * 2, int.Parse(email[18].Replace("I11", string.Empty)) * 01, "0.1A");
                //Current11 = new Monitoring("Current11", DeviceType.MIC_MODBUS_BUSBAR_I11, 19 * 2 * 2, 1 * 2 * 2, int.Parse(email[19].Replace("I12", string.Empty)) * 01, "0.1A");
                //Current12 = new Monitoring("Current12", DeviceType.MIC_MODBUS_BUSBAR_I12, 20 * 2 * 2, 1 * 2 * 2, int.Parse(email[20].Replace("I13", string.Empty)) * 01, "0.1A");
                //Current13 = new Monitoring("Current13", DeviceType.MIC_MODBUS_BUSBAR_I13, 21 * 2 * 2, 1 * 2 * 2, int.Parse(email[21].Replace("I14", string.Empty)) * 01, "0.1A");
                //Current14 = new Monitoring("Current14", DeviceType.MIC_MODBUS_BUSBAR_I14, 22 * 2 * 2, 1 * 2 * 2, int.Parse(email[22].Replace("I15", string.Empty)) * 01, "0.1A");
                //Current15 = new Monitoring("Current15", DeviceType.MIC_MODBUS_BUSBAR_I15, 23 * 2 * 2, 1 * 2 * 2, int.Parse(email[23].Replace("I16", string.Empty)) * 01, "0.1A");
                //Current16 = new Monitoring("Current16", DeviceType.MIC_MODBUS_BUSBAR_I16, 24 * 2 * 2, 1 * 2 * 2, int.Parse(email[24].Replace("", string.Empty)) * 01, "0.1A");
            }
        }

    }
}
