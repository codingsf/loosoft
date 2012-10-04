using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Protocol
{
    public class TcpBug11 : Bug
    {
        public TcpBug11(string bug)
        {
            bug = bug.Replace("0x", string.Empty).Replace(" ", string.Empty).Replace("\r", string.Empty).Replace("\n", string.Empty);
            deviceAddress = SystemCode.HexNumberToDenary(bug.Substring(0, 1 * 2),true,32,'u').ToString();
            faultType = (int)SystemCode.HexNumberToDenary(bug.Substring(1 * 2, 2 * 2), false, 16, 'u');
            data1 = (int)SystemCode.HexNumberToDenary(bug.Substring(3 * 2, 2 * 2), false, 16, 'u');
            data2 = (int)SystemCode.HexNumberToDenary(bug.Substring(5 * 2, 2 * 2), false, 16, 'u');
            faultTime = new DateTime(2000 + (int)SystemCode.HexNumberToDenary(bug.Substring(7 * 2, 1 * 2), true, 32, 'u'),
                                    (int)SystemCode.HexNumberToDenary(bug.Substring(8 * 2, 1 * 2), true, 32, 'u'),
                                    (int)SystemCode.HexNumberToDenary(bug.Substring(9 * 2, 1 * 2), true, 32, 'u'),
                                    (int)SystemCode.HexNumberToDenary(bug.Substring(10 * 2, 1 * 2), true, 32, 'u'),
                                    (int)SystemCode.HexNumberToDenary(bug.Substring(11 * 2, 1 * 2), true, 32, 'u'),
                                    (int)SystemCode.HexNumberToDenary(bug.Substring(12 * 2, 1 * 2), true, 32, 'u'));

        }
    }
}
