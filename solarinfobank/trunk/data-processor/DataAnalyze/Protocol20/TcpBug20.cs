using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Protocol;

namespace Protocol20
{
    public class TcpBug20 : Bug
    {
        public TcpBug20(string[] bugArr,string deviceAddress)
        {
            base.deviceAddress = deviceAddress;
            faultType = int.Parse(bugArr[1]);
            DateTime.TryParse(bugArr[2],out base.faultTime);
        }
    }
}
