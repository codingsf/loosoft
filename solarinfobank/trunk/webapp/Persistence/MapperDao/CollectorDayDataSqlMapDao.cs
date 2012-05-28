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
    /// <summary>
    /// 电站日功率接口实现
    /// 陈波
    /// 2011-2-27
    /// </summary>
    public class CollectorDayDataSqlMapDao : BaseSqlDao<CollectorDayData>, ICollectorDayDataDao
    {
        /// <summary>
        /// 取得采集器跨天数据
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="startDay"></param>
        /// <param name="endDay"></param>
        /// <returns></returns>
        public IList GetCollectorDaydataList(int collectorID, string year, string month, int startDay, int endDay, int monitorCode)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["collectorID"] = collectorID;
            whereHash["yearmonth"] = year+month;
            whereHash["startDay"] = startDay;
            whereHash["endDay"] = endDay;
            whereHash["monitorCode"] = monitorCode;
            try
            {
                return ExecuteQueryForList("collectordaydata_list_between_day", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return new ArrayList();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="sendDay"></param>
        /// <param name="YYYYMM"></param>
        /// <returns></returns>
        public CollectorDayData getCollectorDayData(int collectorID, int monitorCode, int sendDay, string YYYYMM)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["collectorID"] = collectorID;
            whereHash["sendDay"] = sendDay;
            whereHash["yearmonth"] = YYYYMM;
            whereHash["monitorCode"] = monitorCode;
            try
            {
                return ExecuteQueryForObject<CollectorDayData>("collectordaydata_get_by_collectorid2monitor2sendday", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return null;
            
        }

        /// <summary>
        /// 取得采集器和某天的数据记录数量
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="sendDay"></param>
        /// <param name="YYYYMM"></param>
        /// <returns></returns>
        public IList<int> getCollectorDayDataNums(int collectorID, int sendDay, string YYYYMM)
        {
            Hashtable whereHash = new Hashtable();
            whereHash["collectorID"] = collectorID;
            whereHash["sendDay"] = sendDay;
            whereHash["yearmonth"] = YYYYMM;
            return ExecuteQueryForList<int>("getCollectorDayDataNums", whereHash);
        }
    }
}
