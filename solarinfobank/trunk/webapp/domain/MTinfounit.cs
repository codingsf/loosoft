using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    public class MTDataType
    {
        public const string UINT = "uint";
        public const string INT = "int";

        public string typeValue { get; set; }

        public string typeName
        {
            get
            {
                foreach (var item in MTDataType.AllDataTypes)
                {
                    if (this.typeValue.Equals(item.Key))
                        return item.Value;
                }
                return "未知类型";
            }
        }


        public static List<KeyValuePair<string, string>> AllDataTypes
        {
            get
            {
                return new List<KeyValuePair<string, string>>{
                new KeyValuePair<string,string>(UINT,"无符号整形"),
                new KeyValuePair<string,string>(INT,"有符号整形")
                };
            }
        }
    }

    public class MTMonitorType
    {
        public const string YM = "ym";
        public const string YC = "yc";

        public string monitorTypeValue { get; set; }

        public string monitorTypeName
        {
            get
            {
                foreach (var item in MTDataType.AllDataTypes)
                {
                    if (this.monitorTypeValue.Equals(item.Key))
                        return item.Value;
                }
                return "未知";
            }
        }


        public static List<KeyValuePair<string, string>> AllMonitorTypes
        {
            get
            {
                return new List<KeyValuePair<string, string>>{
                new KeyValuePair<string,string>(YM,"遥脉"),
                new KeyValuePair<string,string>(YC,"遥测")
                };
            }
        }
    }

    public class MTUnit
    {
        public const string KWH = "1";
        public const string WM2 = "2";
        public const string C = "3";
        public const string KW = "4";
        public const string W = "5";
        public const string H_CH = "6";
        public const string H = "7";
        public const string V = "8";
        public const string A = "9";
        public const string VAR = "10";
        public const string HZ = "11";
        public const string PERCENT = "12";
        public const string M_S = "13";
        public const string KVARH = "14";

        public string unitValue { get; set; }

        public string unitName
        {
            get
            {
                foreach (var item in MTUnit.AllUnits)
                {
                    if (this.unitValue.Equals(item.Key))
                        return item.Value;
                }
                return "未知";
            }
        }

        public static List<KeyValuePair<string, string>> AllUnits
        {
            get
            {
                return new List<KeyValuePair<string, string>>{
                new KeyValuePair<string,string>(KWH,"kWh"),
                new KeyValuePair<string,string>(WM2,"W/m2"),
                new KeyValuePair<string,string>(C,"℃"),
                new KeyValuePair<string,string>(KW,"kw"),
                new KeyValuePair<string,string>(W,"w"),
                new KeyValuePair<string,string>(H_CH,"时"),
                new KeyValuePair<string,string>(H,"h"),
                new KeyValuePair<string,string>(V,"V"),
                new KeyValuePair<string,string>(A,"A"),
                new KeyValuePair<string,string>(VAR,"Var"),
                new KeyValuePair<string,string>(HZ,"Hz"),
                new KeyValuePair<string,string>(PERCENT,"%"),
                new KeyValuePair<string,string>(M_S,"m/s"),
                new KeyValuePair<string,string>(KVARH,"kVarh"),
                };
            }
        }
    }

    [Serializable]
    public class MTinfounit
    {
        public int id { get; set; }

        /// <summary>
        /// 设备类型编码  见devicedata类
        /// </summary>
        public int deviceTypeCode { get; set; }

        /// <summary>
        /// 信息单元地址
        /// </summary>
        public string addressCode { get; set; }
        /// <summary>
        /// 名称 试用于多语言
        /// </summary>
        public string name { get; set; }

        /// <summary>
        /// 默认名称
        /// </summary>
        public string defaultName { get; set; }


        /// <summary>
        /// 数据类型
        /// </summary>
        public MTDataType valueDataType { get; set; }
        /// <summary>
        /// 单位
        /// </summary>
        public MTUnit unit { get; set; }
        /// <summary>
        /// 测点类型
        /// </summary>
        public MTMonitorType monitroType { get; set; }
        /// <summary>
        /// 精度
        /// </summary>
        public string precision { get; set; }




        public string getCodeName(string code)
        {
            if (name == null) return defaultName;
            List<string> keyValues = null;
            List<string> arrayList = name.Split(',').ToList<string>();
            foreach (string array in arrayList)
            {
                keyValues = array.Split(':').ToList<string>();

                if (keyValues[0].ToLower().Equals(code.ToLower()))
                {
                    if (string.IsNullOrEmpty(keyValues[1]))
                        return defaultName;
                    return keyValues[1];
                }
            }
            return defaultName;

        }


    }
}
