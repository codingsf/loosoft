using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Protocol
{
    public class TcpBug : Bug
    {
        public TcpBug(string bug)
        {
            bug = bug.Replace("0x", string.Empty).Replace(" ", string.Empty).Replace("\r", string.Empty).Replace("\n", string.Empty);
            deviceAddress = SystemCode.HexNumberToDenary(bug.Substring(0, 1 * 2),true,32,'u').ToString();
            faultType = (int)SystemCode.HexNumberToDenary(bug.Substring(1 * 2, 2 * 2), false, 16, 'u');
            faultTime = new DateTime(2000 + (int)SystemCode.HexNumberToDenary(bug.Substring(3 * 2, 1 * 2), true, 32, 'u'),
                (int)SystemCode.HexNumberToDenary(bug.Substring(4 * 2, 1 * 2), true, 32, 'u'),
                 (int)SystemCode.HexNumberToDenary(bug.Substring(5 * 2, 1 * 2), true, 32, 'u'),
               (int)SystemCode.HexNumberToDenary(bug.Substring(6 * 2, 1 * 2), true, 32, 'u'),
               (int)SystemCode.HexNumberToDenary(bug.Substring(7 * 2, 1 * 2), true, 32, 'u'),
               (int)SystemCode.HexNumberToDenary(bug.Substring(8 * 2, 1 * 2), true, 32, 'u'));

        }
    }
}
