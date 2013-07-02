using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;

namespace Cn.Loosoft.Zhisou.SunPower.Common.vo
{
    public class PlantPaymentVO
    {
        public const int Expired = 1;
        public const int Expire_Soon = 2;

        public int Id { get; set; }
        public string Name { get; set; }
        public int Type { get; set; }
        public DateTime LimitDate { get; set; }
    }

}