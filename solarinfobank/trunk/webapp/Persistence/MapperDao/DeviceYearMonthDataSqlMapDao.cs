using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using IBatisNet.Common.Exceptions;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
 
    public class DeviceYearMonthDataSqlMapDao : BaseSqlDao<DeviceYearMonthData>, IDeviceYearMonthDataDao
    {
        /// <summary>
        /// 取得设备跨月度数据报表
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="startYear"></param>
        /// <param name="endYear"></param>
        /// <returns></returns>
        public IList<DeviceYearMonthData> GetDeviceBetweenYearData(int deviceId, int startYear, int endYear)
        {

            Hashtable whereHash = new Hashtable();
            whereHash.Add("deviceId", deviceId);
            whereHash.Add("startYear", startYear);
            whereHash.Add("endYear", endYear);
            try
            {
                return ExecuteQueryForList<DeviceYearMonthData>("deviceyearmonthdata_list_between", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return new List<DeviceYearMonthData>();
        }

        /// <summary>
        /// 取得设备的开始工作年份
        /// </summary>
        /// <param name="deviceId"></param>
        /// <returns></returns>
        public int GetStartWorkYear(int deviceId)
        {
            return (int)ExecuteQueryForObject("deviceyearmonthdata_min_year", deviceId);
        }

        public IList<DeviceYearMonthData> GetDeviceYearMonthData(Hashtable has)
        {
            return ExecuteQueryForList<DeviceYearMonthData>("GetDeviceYearMonthData", has);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="id"></param>
        public void UpdateDeviceYearMonthData(string d_Column, double d_Value, int id) {
            Hashtable has = new Hashtable();
            has.Add("d_Column", d_Column);
            has.Add("d_Value", d_Value);
            has.Add("id", id);
            ExecuteUpdate<Hashtable>("UpdateDeviceYearMonthData", has);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        public void InsertDeviceYearMonthData(string d_Column, double d_Value, int deviceID, int year) {
            Hashtable has = new Hashtable();
            has.Add("d_Column", d_Column);
            has.Add("d_Value", d_Value);
            has.Add("deviceID", deviceID);
            has.Add("year", year);
            ExecuteInsert<Hashtable>("InsertDeviceYearMonthData", has);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public DeviceYearMonthData GetDeviceYearMonthData(int deviceID, int year)
        {
            Hashtable has = new Hashtable();
            has.Add("year", year);
            has.Add("deviceID", deviceID);
            DeviceYearMonthData obj = ExecuteQueryForObject<DeviceYearMonthData>("GetDeviceYearMonthData", has);
            return obj;
        }
    }
}
