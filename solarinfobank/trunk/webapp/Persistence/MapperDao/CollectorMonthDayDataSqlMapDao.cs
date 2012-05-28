using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.Common.Exceptions;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 作者:陈波
    /// 2011-2-25
    /// 电站月数据接口实现
    /// </summary>
    public class CollectorMonthDayDataSqlMapDao : BaseSqlDao<CollectorMonthDayData>, ICollectorMonthDayDataDao
    { 
        /// <summary>
        /// 取得某个年度的跨月月天发电量数据
        /// </summary>
        /// <param name="year">所在年份</param>
        /// <param name="startMM">开始月份</param>
        /// <param name="endMM">截至</param>
        /// <returns></returns>
        public IList<CollectorMonthDayData> GetMonthBetweenData(int collectorID, int year, int startMM, int endMM) 
        {
            Hashtable whereHash = new Hashtable();
            whereHash["collectorID"] = collectorID;
            whereHash["year"] = year;
            whereHash["startMM"] = startMM;
            whereHash["endMM"] = endMM;

            try
            {
                return ExecuteQueryForList<CollectorMonthDayData>("collectormonthdaydata_list_by_year_startendmm", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return new List<CollectorMonthDayData>();
        }

        /// <summary>
        /// 更新设备某个id的某个字段天数据
        /// </summary>
        /// <param name="d_column"></param>
        /// <param name="d_value"></param>
        /// <param name="id"></param>
        public void UpdateCollectorMonthDayData(int year, string d_column, double d_value, int id)
        {
            Hashtable has = new Hashtable();
            has.Add("d_Column", d_column);
            has.Add("d_Value", d_value);
            has.Add("id", id);
            has.Add("year", year);
            ExecuteUpdate<Hashtable>("UpdateCollectorMonthDayData", has);
        }
        /// <summary>
        /// 插入一条记录
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="month"></param>
        public void InsertCollectorMonthDayData(string d_Column, double d_Value, int collectorID, int year, int month)
        {
            Hashtable has = new Hashtable();
            has.Add("d_Column", d_Column);
            has.Add("d_Value", d_Value);
            has.Add("collectorID", collectorID);
            has.Add("month", month);
            has.Add("year", year);
            ExecuteInsert<Hashtable>("InsertCollectorMonthDayData", has);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="year"></param>
        /// <param name="subplantID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public CollectorMonthDayData GetCollectorMonthDayData(int year, int collectorID, int month)
        {
            Hashtable has = new Hashtable();
            has.Add("year", year);
            has.Add("collectorID", collectorID);
            has.Add("month", month);
            return ExecuteQueryForObject<CollectorMonthDayData>("GetCollectorMonthDayData", has);
        }
    }
}
