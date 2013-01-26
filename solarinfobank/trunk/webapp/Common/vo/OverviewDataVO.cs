using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;

namespace Cn.Loosoft.Zhisou.SunPower.Common.vo
{

    //-----------------开放接口apivo-----------------------
    [DataContract(Namespace = " http://www.solarinfobank.com ")]
    [Serializable]
    public class OverviewDataVO
    {
        public OverviewDataVO() { }
        [DataMember(Order = 0)]
        public string DisplayTotalDayEnergy { get; set; }
        [DataMember(Order = 1)]
        public string TotalDayEnergyUnit { get; set; }
        [DataMember(Order = 2)]
        public string Temperature { get; set; }
        [DataMember(Order = 3)]
        public string TemperatureType { get; set; }
        [DataMember(Order = 4)]
        public string Sunstrength { get; set; }
        [DataMember(Order = 5)]
        public string SunstrengthUnit { get; set; }
        [DataMember(Order = 6)]
        public string totalEnergy { get; set; }
        [DataMember(Order = 7)]
        public string TotalEnergyUnit { get; set; }
        [DataMember(Order = 8)]
        public string Reductiong { get; set; }
        [DataMember(Order = 9)]
        public string ReductiongUnit { get; set; }
        [DataMember(Order = 10)]
        public string currencies { get; set; }
        [DataMember(Order = 11)]
        public string DisplayRevenue { get; set; }
        [DataMember(Order = 12)]
        public string TotalTrees { get; set; }
    }

}