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

    public class DeviceMonthDayDataSqlMapDao : BaseSqlDao<DeviceMonthDayData>, IDeviceMonthDayDataDao
    {
        /// <summary>
        /// 更新设备某个id的某个字段天数据
        /// </summary>
        /// <param name="d_column"></param>
        /// <param name="d_value"></param>
        /// <param name="id"></param>
        public void UpdateDeviceMonthDayData(int year, string d_column, double d_value, int id)
        {
            Hashtable has = new Hashtable();
            has.Add("d_Column", d_column);
            has.Add("d_Value", d_value);
            has.Add("id", id);
            has.Add("year", year);
            ExecuteUpdate<Hashtable>("UpdateDeviceMonthDayData", has);
        }
        /// <summary>
        /// 插入一条记录
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="month"></param>
        public void InsertDeviceMonthDayData(string d_Column, double d_Value, int deviceID, int year, int month)
        {
            Hashtable has = new Hashtable();
            has.Add("d_Column", d_Column);
            has.Add("d_Value", d_Value);
            has.Add("deviceID", deviceID);
            has.Add("month", month);
            has.Add("year", year);
            ExecuteInsert<Hashtable>("InsertDeviceMonthDayData", has);
        }
        
        public IList<DeviceMonthDayData> GetDeviceMonthDayData(Hashtable has)
        {
            return ExecuteQueryForList<DeviceMonthDayData>("GetDeviceMonthDayData", has);
        }

        /// <summary>
        /// 查询某个设备的某个测点月天数据id
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public DeviceMonthDayData GetDeviceMonthDayData(int deviceID, int year, int month)
        {
            Hashtable has = new Hashtable();
            has.Add("year", year);
            has.Add("deviceID", deviceID);
            has.Add("month", month);
            return ExecuteQueryForObject<DeviceMonthDayData>("GetDeviceMonthDayData", has);
        }


        /// <summary>
        /// 取得设备某个年度的跨月月天发电量数据
        /// </summary>
        /// <param name="year">所在年份</param>
        /// <param name="startMM">开始月份</param>
        /// <param name="endMM">截至</param>
        /// <returns></returns>
        public IList<DeviceMonthDayData> GetMonthBetweenData(int deviceId, int year, int startMM, int endMM)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["deviceId"] = deviceId;
            whereHash["year"] = year;
            whereHash["startMM"] = startMM;
            whereHash["endMM"] = endMM;
            try
            {
                return ExecuteQueryForList<DeviceMonthDayData>("devicemonthdaydata_list_by_year_startendmm", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return new List<DeviceMonthDayData>();

        }
    }
}
