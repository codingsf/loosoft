using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 电站日功率接口
    /// 陈波
    /// 2011-2-27
    /// </summary>
    public interface ICollectorDayDataDao : IBaseDao<CollectorDayData>
    {

        /// <summary>
        /// 取得采集器跨天数据
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="YYYYMM"></param>
        /// <param name="startDay"></param>
        /// <param name="endDay"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        IList GetCollectorDaydataList(int collectorID, string year, string month, int startDay, int endDay, int monitorCode);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="sendDay"></param>
        /// <param name="YYYYMM"></param>
        /// <returns></returns>
        CollectorDayData getCollectorDayData(int collectorID, int monitorCode, int sendDay, string YYYYMM);

       /// <summary>
        /// 取得采集器和某天的数据记录数量
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="sendDay"></param>
        /// <param name="YYYYMM"></param>
        /// <returns></returns>
        IList<int> getCollectorDayDataNums(int collectorID, int sendDay, string YYYYMM);
    }
}
