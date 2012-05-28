using System.Configuration;

    public static class SynCacheKeyUtil
    {

        private static string mem_affix = "syn_";

        private static string plantlist = mem_affix + "plantlist";//电站列表


        private static string plantrundata = mem_affix + "plantrundata";//电站实时数据

        /// <summary>
        /// 所有电站列表
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static string buildPlantListKey()
        {
            return plantlist;
        }

        /// <summary>
        /// 电站实时数据key
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static string buildPlantRunDataKey(int plantId)
        {
            return plantrundata+plantId;
        }
    }
