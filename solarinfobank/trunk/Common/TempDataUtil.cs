namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 临时数据工具
    /// </summary>
    public class TempDataUtil
    {
        /// <summary>
        /// 将数据临时保持到map
        /// </summary>
        /// <param name="key"></param>
        /// <param name="chartData"></param>
        public static void putChartData(string key,  Cn.Loosoft.Zhisou.SunPower.Common.ChartData chartData){
            string cacheKey = CacheKeyUtil.buildChartDataKey(key);
            MemcachedClientSatat.getInstance().Set(cacheKey, chartData);
        }


        /// <summary>
        /// 将数据临时保持到map
        /// </summary>
        /// <param name="key"></param>
        /// <param name="chartData"></param>
        public static ChartData getChartData(string key)
        {
            if (key != null)
            {
                string cacheKey = CacheKeyUtil.buildChartDataKey(key);
                object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
                if (obj != null)
                {
                    return (ChartData)obj;
                }
                else {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }
    }
}