using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using sungrow_demo.Service.vo;
using sungrow_demo;
using System.Windows.Media.Imaging;
using System.Net.Cache;
using sungrow_touch.Service;

namespace sungrow_touch
{
    class DataUtil
    {
        public static IDictionary<string, PlantVO> dataItemMap = new Dictionary<string, PlantVO>();
        public static IDictionary<string, ChartData> chartdataItemMap = new Dictionary<string, ChartData>();
        public static IDictionary<string, IList<KeyValuePair<string, float?>>> energyItemMap = new Dictionary<string, IList<KeyValuePair<string, float?>>>();
        public static IDictionary<string, DateTime> dataDateMap = new Dictionary<string, DateTime>();
        public static IDictionary<string, float> maxEnergyMap = new Dictionary<string, float>();

        public static DateTime lastPicDate = DateTime.Now;//上一次电站图片更新事件
        /// <summary>
        /// 取得功率图表数据
        /// </summary>
        /// <param name="plantId"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static ChartData getPowerData(string plantId, string startDate, string endDate)
        {
            string startDateStr = string.Format("{0}-{1}-{2}", endDate.Substring(0, 4), endDate.Substring(4, 2), endDate.Substring(6, 2));

            double cacheHour = DateTime.Parse(startDateStr) < DateTime.Now.AddDays(-1) ? 24 : 0.5;
            string key = plantId + startDate + endDate;
            ChartData chartData = null;
            DateTime lastDate = dataDateMap.ContainsKey(key) ? dataDateMap[key] : DateTime.Now;
            if (lastDate.AddMinutes(30) > DateTime.Now)
            {
                chartData = chartdataItemMap.ContainsKey(key) ? chartdataItemMap[key] : null;
            }
            if (chartData != null) return chartData;
            string filename = System.Environment.CurrentDirectory + "/data/power/" + key;
            try
            {
                chartData = JsonUtil.getChartData(string.Format("/openapi/plantDayChartData?pid={0}&startdate={1}&enddate={2}", plantId, startDate, endDate));
                if (chartData == null)
                {
                    //从本地磁盘去数据
                    chartData = new ChartData();

                    if (File.Exists(filename))
                    {
                        try
                        {
                            XMLHelper.DeserializerXML<ChartData>(filename, ref chartData);
                        }
                        catch (Exception eee)
                        {
                            LogUtil.error("反向本地缓存 error:" + eee.StackTrace);
                            chartData = null;
                        }
                    }
                    else
                    {
                        return null;
                    }
                }
                else
                {
                    dataDateMap[key] = DateTime.Now;
                    chartdataItemMap[key] = chartData;

                    //写入本地缓存
                    try
                    {
                        if (chartData!=null)
                            XMLHelper.SerializerXML<ChartData>(filename, chartData);
                    }
                    catch (Exception eee)
                    {
                        LogUtil.error("写入本地缓存 error:" + eee.StackTrace);
                    }
                }
            }
            catch (Exception e2)
            {
                LogUtil.error("getPowerData error:" + e2.Message);
                return null;
            }
            return chartData;
        }

        /// <summary>
        /// 取得发电量数据
        /// </summary>
        /// <param name="plantId"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="chartTitle"></param>
        /// <param name="unit"></param>
        /// <returns></returns>
        public static IList<KeyValuePair<string, float?>> getEnergyData(string plantId, string startDate, string endDate, string chartTitle, string unit, out float maxValue)
        {
            string startDateStr = string.Format("{0}-{1}-{2}", endDate.Substring(0, 4), endDate.Substring(4, 2), endDate.Substring(6, 2));

            double cacheHour = DateTime.Parse(startDateStr) < DateTime.Now.AddDays(-1) ? 24 : 0.5;
            maxValue = 0f;
            string key = plantId + startDate + endDate;
            IList<KeyValuePair<string, float?>> chartData = null;
            DateTime lastDate = dataDateMap.ContainsKey(key) ? dataDateMap[key] : DateTime.Now;
            if (lastDate.AddHours(cacheHour) > DateTime.Now)
            {
                chartData = energyItemMap.ContainsKey(key) ? energyItemMap[key] : null;
                maxValue = maxEnergyMap.ContainsKey(key) ? maxEnergyMap[key] : 0f;
            }
            if (chartData != null) return chartData;
            string filename = System.Environment.CurrentDirectory + "/data/energy/" + key;
            try
            {
                ChartData data = JsonUtil.getChartData(string.Format("/openapi/PlantMonthDayChart?pid={0}&startdate={1}&enddate={2}",plantId,startDate,endDate));
                if (data == null)
                {
                    maxValue = 0f;

                    data = new ChartData();
 
                    if (File.Exists(filename))
                    {
                        try
                        {
                            XMLHelper.DeserializerXML<ChartData>(filename, ref data);
                            chartData = JsonUtil.DeserializeChartData(data, out chartTitle, out unit, out maxValue);
                        }
                        catch (Exception eee)
                        {
                            Console.WriteLine(eee.StackTrace);
                            chartData = null;
                        }
                    }
                    else
                    {
                        return null;
                    }
                }
                else
                {
                    chartData = JsonUtil.DeserializeChartData(data, out chartTitle, out unit, out maxValue);
                    dataDateMap[key] = DateTime.Now;
                    energyItemMap[key] = chartData;
                    maxEnergyMap[key] = maxValue;
                    //写入本地缓存
                    try
                    {
                        if (chartData != null)
                            XMLHelper.SerializerXML<ChartData>(filename, data);
                    }
                    catch (Exception eee)
                    {
                        Console.WriteLine(eee.StackTrace);
                    }
                }
            }
            catch (Exception e2)
            {
                LogUtil.error("getEnergyData error:" + e2.Message);
                return null;
            }
            return chartData;
        }

        //电站图片map
        private static IDictionary<string, BitmapImage> plantPicMap = new Dictionary<string, BitmapImage>();
        /// <summary>
        /// 取得电站图片，缓存2小时
        /// </summary>
        /// <param name="plantId"></param>
        /// <param name="imageArray"></param>
        /// <returns></returns>
        public static BitmapImage loadPlantImg(string plantId, string imageArray){
            BitmapImage bmp = null;
            try
            {
                if (!plantPicMap.ContainsKey(plantId) || lastPicDate.AddHours(2) < DateTime.Now)
                {
                    Uri urlPlant = null;
                    try
                    {
                        urlPlant = new Uri(imageArray);
                    }
                    catch (Exception ee)
                    {
                        LogUtil.error("loadPlantImg error:" + ee.StackTrace);
                        string path = System.Environment.CurrentDirectory + "/Resources/Images/{0}";
                        urlPlant = new Uri(string.Format(path, "plant2.jpg"));
                    }
                    bmp = new BitmapImage(urlPlant, new RequestCachePolicy(RequestCacheLevel.CacheIfAvailable));
                    plantPicMap[plantId] = bmp;
                    lastPicDate = DateTime.Now;
                }
                else
                {
                    bmp = plantPicMap[plantId];
                }
 
            }
            catch (Exception ee)
            {
                LogUtil.error("loadPlantImg error:" + ee.StackTrace);
            }
            return bmp;
        }

        /// <summary>
        /// 取得电站信息
        /// </summary>
        /// <param name="plantId"></param>
        /// <returns></returns>
        public static PlantVO getPlantInfo(string plantId)
        {
            PlantVO pvo = null;
            DateTime lastDate = dataDateMap.ContainsKey(plantId) ? dataDateMap[plantId] : DateTime.Now;
            if (lastDate.AddMinutes(30) > DateTime.Now)
            {
                pvo = dataItemMap.ContainsKey(plantId) ? dataItemMap[plantId] : null;
            }
            if (pvo != null) return pvo;
            string filename = System.Environment.CurrentDirectory + "/data/info/" + plantId;
            try
            {
                string jsonStr = JsonUtil.loadJsonStr(string.Format("/openapi/plantinfo?pid={0}", plantId), "en-us");
                pvo = JsonUtil.Deserialize<PlantVO>(jsonStr);
                if (pvo == null)
                {
                    pvo = new PlantVO();

                    if (File.Exists(filename))
                    {
                        try
                        {
                            XMLHelper.DeserializerXML<PlantVO>(filename, ref pvo);
                        }
                        catch (Exception eee)
                        {
                            Console.WriteLine(eee.StackTrace);
                            pvo = null;
                        }
                    }
                    else
                    {
                        return null;
                    }
                }
                else
                {
                    dataDateMap[plantId] = DateTime.Now;
                    dataItemMap[plantId] = pvo;
                    //写入本地缓存
                    try
                    {
                        if (pvo != null)
                            XMLHelper.SerializerXML<PlantVO>(filename, pvo);
                    }
                    catch (Exception eee) {
                        Console.WriteLine(eee.StackTrace);
                    }
                }
            }
            catch (Exception e2)
            {
                LogUtil.error("getPlantInfo error:" + e2.StackTrace);
                return null;
            }
            return pvo;
        }
    }
}
