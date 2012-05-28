using System.Collections.Generic;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class AdminControllerActionType
    {
        public const int USER_INFO = 1;
        public const int PLANT_INFO = 2;
        public const int COLLECTOR_IINFO = 3;
        public const int DEVICE_INFO = 4;
        public const int PIC_INFO = 5;
        public const int MANAGER_INFO = 5 + 1;
        public const int LANGUAGE_INFO = 7;
        public const int DEVICE_TYPE = 5 + 3;
        public const int EMAIL_CONFIG = 5 + 4;
        public const int COUNTRY_CITY_INFO = 10;
        public const int OTHER_CONFIG = 11;
        public const int USERROLE_CONFIG = 12;
        public const int CURRENCIES_CONFIG = 13;
        public static Dictionary<int, string> dictionaries = new Dictionary<int, string>();
        static AdminControllerActionType()
        {
            dictionaries.Add(USER_INFO, "用户信息");
            dictionaries.Add(PLANT_INFO, "电站信息");
            dictionaries.Add(COLLECTOR_IINFO, "采集器列表");
            dictionaries.Add(DEVICE_INFO, "设备列表");
            dictionaries.Add(PIC_INFO, "宣传图片");
            dictionaries.Add(MANAGER_INFO, " 管理员列表");
            dictionaries.Add(LANGUAGE_INFO, "语言列表");
            dictionaries.Add(DEVICE_TYPE, "设备类型");
            dictionaries.Add(EMAIL_CONFIG, "邮箱配置");
            dictionaries.Add(COUNTRY_CITY_INFO, "国家城市");
            dictionaries.Add(USERROLE_CONFIG, "角色配置");
            dictionaries.Add(CURRENCIES_CONFIG, "货币配置");
            dictionaries.Add(OTHER_CONFIG, "其他配置");
        }

        public static string TypeName(int id)
        {
            if (dictionaries.ContainsKey(id))
                return dictionaries[id];
            return string.Empty;
        }



    }
}
