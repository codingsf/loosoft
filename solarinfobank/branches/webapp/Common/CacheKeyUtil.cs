using System.Configuration;

    public static class CacheKeyUtil
    {
        static string mem_affix = ConfigurationSettings.AppSettings["mem_affix"];
        private static string affix_collecotrrundata = mem_affix + "collectorrundata_";//实时数据缓存key前缀
        private static string affix_devicedaydata = mem_affix + "devicedaydata_";//设备填数据缓存key前缀
        private static string affix_collectordaydata = mem_affix + "collectordaydata_";//采集器天数据缓存key前缀
        private static string affix_devicerundata = mem_affix + "devicerundata_";//采集器天数据缓存key前缀
        private static string affix_devicedatacount = mem_affix + "devicedatacount_";//设备数据统计缓存key前缀
        private static string affix_collectordatacount = mem_affix + "collectordatacount_";//设备采集器统计缓存key前缀

        private static string affix_devicemonthenergycount = mem_affix + "devicemonthenergycount_";//设备发电量缓存key前缀
        private static string affix_collectormonthenergycount = mem_affix + "collectormonthenergycount_";//采集器发电量缓存key前缀
        private static string affix_deviceyearenergycount = mem_affix + "deviceyearenergycount_";//设备发电量年度缓存key前缀
        private static string affix_collectoryearenergycount = mem_affix + "collectoryearenergycount_";//采集器年度发电量缓存key前缀

        private static string affix_devicetotalenergycount = mem_affix + "devicetotalenergycount_";//设备发电量总量缓存key前缀
        private static string affix_collectortotalenergycount = mem_affix + "collectortotalenergycount_";//采集器总量发电量缓存key前缀

        private static string affix_chartdata = mem_affix + "chartdata_";//图表数据缓存key前缀
        private static string affix_mtlist = mem_affix + "mtlist_";//测点缓存key前缀
        private static string affix_plantunitMmap = mem_affix + "plantunit_map";//电站和对应对应前缀

        private static string affix_todaytotalenergy = mem_affix + "todaytotalenergy";//今日日总电量

        private static string affix_collectortotalenergy = mem_affix + "collectortotalenergy";//采集器总电量

        public static string buildTodayTotalEnergy() {
            return affix_todaytotalenergy;
        }

        /// <summary>
        /// 构建设备天数据缓存key
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="yearmonth"></param>
        /// <param name="day"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public static string buildDeviceDayDataKey(int deviceID, string yearmonth, int day, int monitorCode)
        {
            return affix_devicedaydata + deviceID + "_" + yearmonth + "_" + day + "_" + monitorCode;
        }

        /// <summary>
        /// 构建采集器天数据缓存key
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="yearmonth"></param>
        /// <param name="day"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public static string buildCollectorDayDataKey(int collectorID, string yearmonth, int day, int monitorCode)
        {
            return affix_collectordaydata + collectorID + "_" + yearmonth + "_" + day + "_" + monitorCode;
        }



        /// <summary>
        /// 构建测点数据缓存key
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="yearmonth"></param>
        /// <param name="day"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public static string buildMtListKey(int collectorID, int sendDay, string yearmonth)
        {
            return affix_mtlist + collectorID + "_" + sendDay + "_" + yearmonth;
        }
        /// <summary>
        /// 构建图表数据缓存key
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="yearmonth"></param>
        /// <param name="day"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public static string buildChartDataKey(string key)
        {
            return affix_chartdata + key;
        }
        /// <summary>
        /// 构造设备数据统计缓存key
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="day"></param>
        /// <param name="deviceId"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public static string buildDeviceDataCountKey(int year, int month, int day, int deviceId, int monitorCode)
        {
            return affix_devicedatacount + deviceId + "_" + monitorCode + "_" + year + "_" + month + "_" + day;
        }

        /// <summary>
        /// 构造采集器数据统计缓存key
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="day"></param>
        /// <param name="deviceId"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public static string buildCollectorDataCountKey(int year, int month, int day, int collectorId, int monitorCode)
        {
            return affix_collectordatacount + collectorId + "_" + monitorCode + "_" + year + "_" + month + "_" + day;
        }


        /// <summary>
        /// 设备统计数据月度缓存key
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="deviceId"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public static string buildDeviceDataCountMonthKey(int year, int month, int deviceId, int monitorCode)
        {
            return affix_devicedatacount + deviceId + "_" + monitorCode + "_" + year + "_" + month;
        }

        /// <summary>
        /// 构建采集器实时数据key
        /// </summary>
        /// <param name="collecotrId"></param>
        /// <returns></returns>
        public static string buildCollectorRunDataKey(int collecotrId)
        {
            return affix_collecotrrundata + collecotrId;
        }

        /// <summary>
        /// 构建设备实时数据缓存key
        /// </summary>
        /// <param name="deviceId"></param>
        /// <returns></returns>
        public static string buildDeviceRunDataKey(int deviceId)
        {
            return affix_devicerundata + deviceId;
        }

        /// <summary>
        /// 设备统计数据月度缓存key
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="deviceId"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public static string buildDeviceDataCountYearKey(int year, int deviceId, int monitorCode)
        {
            return affix_devicedatacount + deviceId + "_" + monitorCode + "_" + year;
        }

        /// <summary>
        /// 设备月天发电量
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public static string buildDeviceEnergyMonthCountKey(int deviceId, int year, int month)
        {
            return affix_devicemonthenergycount + deviceId + "_" + year + "_" + month;
        }


        /// <summary>
        /// 电站和单元对应关系
        /// </summary>
        /// <returns></returns>
        public static string buildPlantUnitKey()
        {
            return affix_plantunitMmap;
        }
        /// <summary>
        /// 设备年月发电量key
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static string buildDeviceEnergyYearCountKey(int deviceId, int year)
        {
            return affix_deviceyearenergycount + deviceId + "_" + year;
        }

        /// <summary>
        /// 设备总体发电量key
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static string buildDeviceEnergyTotalCountKey(int deviceId, int year)
        {
            return affix_devicetotalenergycount + deviceId + "_" + year;
        }

        /// <summary>
        /// 采集器月天发电量
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public static string buildCollectorEnergyMonthCountKey(int collectorId, int year, int month)
        {
            return affix_collectormonthenergycount + collectorId + "_" + year + "_" + month;
        }
        /// <summary>
        /// 采集器年月发电量key
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static string buildCollectorEnergyYearCountKey(int collectorId, int year)
        {
            return affix_collectoryearenergycount + collectorId + "_" + year;
        }

        /// <summary>
        /// 采集器总体发电量key
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static string buildCollectorEnergyTotalCountKey(int collectorId, int year)
        {
            return affix_collectortotalenergycount + collectorId + "_" + year;
        }
    }
