using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using IBatisNet.Common.Exceptions;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：电站总量数据访问层实习类
    /// 创建时间：2011-02-22
    /// </summary>
    public class CollectorYearDataSqlMapDao : BaseSqlDao<CollectorYearData>, ICollectorYearDataDao
    {

        #region IPlantTotalDataDao 成员

        /// <summary>
        /// 作者：张月
        /// 功能：单元Id获得各个年度的发电量列表
        /// 时间：2011年2月22日 20:11:33
        /// </summary>
        /// <param name="unitId">电站单元Id</param>
        /// <param name="monitorCode">测点代码</param>
        /// <returns>电站总量列表</returns>
        public IList<CollectorYearData> GetListByCollectorID(int collectorID)
        {
            Hashtable whereHash = new Hashtable();
            whereHash.Add("collectorID", collectorID);
            try
            {
                return ExecuteQueryForList<CollectorYearData>("collectoryeardata_get_list_by_collectorid", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return new List<CollectorYearData>();

        }
        #endregion


        /// <summary>
        /// 
        /// 取得多个单元的最早工作年份
        /// </summary>
        /// <param name="units"></param>
        /// <returns></returns>
        public int GetStartWorkYear(IList<PlantUnit> units)
        {
            string ids = string.Empty;
            StringBuilder sb = new StringBuilder();
            foreach (PlantUnit unit in units)
            {
                sb.Append(",").Append(unit.collectorID);
            }
            if (sb.Length > 0)
            {
                ids = sb.ToString().Substring(1);
            }
            return (int)ExecuteQueryForObject("collectoryeardata_min_year", ids);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="year"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public CollectorYearData GetCollectorYearData(int collectorID, int year)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["collectorID"] = collectorID;
            whereHash["year"] = year;
            return ExecuteQueryForObject<CollectorYearData>("GetCollectorYearData", whereHash);
        }

    }


}
