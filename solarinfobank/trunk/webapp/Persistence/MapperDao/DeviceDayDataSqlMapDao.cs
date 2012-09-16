using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using IBatisNet.Common.Exceptions;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{


    public class DeviceDayDataSqlMapDao : BaseSqlDao<DeviceDayData>, IDeviceDayDataDao
    {
        /// <summary>
        /// 取得设备跨小时数据
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="startDay"></param>
        /// <param name="endDay"></param>
        /// <param name="startHH"></param>
        /// <param name="endHH"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public IList GetDaydataList(int deviceID, string deviceType, string year, string month, int startDay, int endDay, int monitorCode)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["deviceID"] = deviceID;
            whereHash["yearmonth"] = year + month;
            whereHash["startDay"] = startDay;
            whereHash["endDay"] = endDay;
            whereHash["monitorCode"] = monitorCode;
            whereHash["deviceType"] = deviceType;
            try
            {
                return ExecuteQueryForList("devicedaydata_list_between_day", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return new ArrayList();

        }

       /// <summary>
       /// 取得设备所有测点数据
       /// add by qhb in 20120915
       /// </summary>
       /// <param name="deviceID"></param>
       /// <param name="deviceType"></param>
       /// <param name="year"></param>
       /// <param name="month"></param>
       /// <param name="startDay"></param>
       /// <param name="endDay"></param>
       /// <param name="monitorCode"></param>
       /// <returns></returns>
        public IList<DeviceDayData> GetDaydataList(int deviceID, string deviceType, string year, string month, int startDay, int endDay)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["deviceID"] = deviceID;
            whereHash["yearmonth"] = year + month;
            whereHash["startDay"] = startDay;
            whereHash["endDay"] = endDay;
            whereHash["deviceType"] = deviceType;
            try
            {
                return ExecuteQueryForList<DeviceDayData>("multidevicedaydata_list_between_day", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return new List<DeviceDayData>();

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="sendDay"></param>
        /// <param name="YYYYMM"></param>
        /// <returns></returns>
        public DeviceDayData getDeviceDayData(int deviceID, string deviceType, int monitorCode, int sendDay, string YYYYMM)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["deviceID"] = deviceID;
            whereHash["sendDay"] = sendDay;
            whereHash["yearmonth"] = YYYYMM;
            whereHash["deviceType"] = deviceType;
            whereHash["monitorCode"] = monitorCode;
            return ExecuteQueryForObject<DeviceDayData>("devicedaydata_get_by_deviceid2monitor2sendday", whereHash); 
        }

        /// <summary>
        /// 取得设备和某天的数据记录数量
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="sendDay"></param>
        /// <param name="YYYYMM"></param>
        /// <returns></returns>
        public IList<int> getDeviceDayDataNums(int deviceID, int sendDay, string YYYYMM,string deviceType)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["deviceID"] = deviceID;
            whereHash["sendDay"] = sendDay;
            whereHash["yearmonth"] = YYYYMM;
            whereHash["deviceType"] = deviceType;
            return ExecuteQueryForList<int>("getDeviceDayDataNums", whereHash);
        }
    }
}
