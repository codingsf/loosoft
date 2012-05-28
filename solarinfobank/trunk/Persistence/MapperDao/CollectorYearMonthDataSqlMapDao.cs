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
    public class CollectorYearMonthDataSqlMapDao : BaseSqlDao<CollectorYearMonthData>, ICollectorYearMonthDataDao
    {

        /// <summary>
        /// 取得单元跨月度数据报表
        /// </summary>
        /// <param name="has">collectorID,startYear,endYear</param>
        /// <returns>年度数据列表</returns>
        public IList<CollectorYearMonthData> GetUnitBetweenYearData(PlantUnit unit, int startYear, int endYear)
        {
            Hashtable has = new Hashtable();
            has["collectorID"] = unit.collector.id;
            has["startYear"] = startYear;
            has["endYear"] = endYear;
            try
            {
                return ExecuteQueryForList<CollectorYearMonthData>("collectoryearmonthdata_get_between", has);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return new List<CollectorYearMonthData>();

        }

        public IList<CollectorYearMonthData> GetCollectorYearMonthData(Hashtable has)
        {
            return ExecuteQueryForList<CollectorYearMonthData>("GetCollectorYearMonthData", has);
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="id"></param>
        public void UpdateCollectorYearMonthData(string d_Column, double d_Value, int id)
        {
            Hashtable has = new Hashtable();
            has.Add("d_Column", d_Column);
            has.Add("d_Value", d_Value);
            has.Add("id", id);
            ExecuteUpdate<Hashtable>("UpdateCollectorYearMonthData", has);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        public void InsertCollectorYearMonthData(string d_Column, double d_Value, int collectorID, int year)
        {
            Hashtable has = new Hashtable();
            has.Add("d_Column", d_Column);
            has.Add("d_Value", d_Value);
            has.Add("year", year);
            has.Add("collectorID", collectorID);
            ExecuteInsert<Hashtable>("InsertCollectorYearMonthData", has);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public CollectorYearMonthData GetCollectorYearMonthData(int collectorID, int year)
        {
            Hashtable has = new Hashtable();
            has.Add("year", year);
            has.Add("collectorID", collectorID);
            CollectorYearMonthData obj = ExecuteQueryForObject<CollectorYearMonthData>("GetCollectorYearMonthData", has);
            return obj;
        }
    }
}
