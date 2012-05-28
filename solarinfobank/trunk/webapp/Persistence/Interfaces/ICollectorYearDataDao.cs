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
    /// 作者：鄢睿
    /// 功能：电站总量数据访问层接口定义
    /// 创建时间：2011-02-22
    /// </summary>
    public interface ICollectorYearDataDao : IBaseDao<CollectorYearData>
    {
        /// <summary>
        /// 作者：张月
        /// 功能：单元Id获得各个年度的发电量列表
        /// 时间：2011年2月22日 20:11:33
        /// </summary>
        /// <param name="collectorID">电站采集器Id</param>
        /// <param name="monitorCode">测点代码</param>
        /// <returns>电站总量列表</returns>
        IList<CollectorYearData> GetListByCollectorID(int collectorID);

        /// <summary>
        /// 
        /// 取得多个单元的最早工作年份
        /// </summary>
        /// <param name="units"></param>
        /// <returns></returns>
        int GetStartWorkYear(IList<PlantUnit> units);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="year"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        CollectorYearData GetCollectorYearData(int collectorID, int year);

    }
}
