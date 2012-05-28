using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Protocol
{
    public class EBug : Bug
    {
        public EBug()
        { }
        public EBug(string bug)
        {
            string[] bugs = bug.Split('=');
            if (bugs.Length == 4)
            {
                deviceAddress = bugs[1].Replace("FAULTTYPE", string.Empty);
                faultType = int.Parse(bugs[2].Replace("DATA", string.Empty));
                faultTime = DateTime.Parse(bugs[3].Replace("", string.Empty));
            }
            else
            {
                deviceAddress = "0";
                faultType = 0;
                faultTime = DateTime.Now;
            }
        }
    }
}
