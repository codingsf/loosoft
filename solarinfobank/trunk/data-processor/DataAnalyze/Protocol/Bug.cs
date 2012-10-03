using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Protocol
{
    public class Bug
    {
        public string deviceAddress;//设备地址
        public int faultType;//告警类型
        public int? data1;//状态数据1
        public int? data2;//状态数据2
        public DateTime faultTime;//告警时间
    }
}
