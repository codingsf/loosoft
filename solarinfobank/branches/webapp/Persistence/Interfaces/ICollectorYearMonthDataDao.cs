using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using  Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{

    public interface ICollectorYearMonthDataDao : IBaseDao<CollectorYearMonthData>
    {   
       /// <summary>
       /// 
       /// 单元测点跨月度数据
       /// </summary>
       /// <param name="unit"></param>
       /// <param name="startYear"></param>
       /// <param name="endYear"></param>
       /// <param name="monitorCode"></param>
       /// <returns></returns>
        IList<CollectorYearMonthData> GetUnitBetweenYearData(PlantUnit unit, int startYear, int endYear);


        /// <summary>
        /// 
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="id"></param>
        void UpdateCollectorYearMonthData(string d_Column, double d_Value, int id);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        void InsertCollectorYearMonthData(string d_Column, double d_Value, int collectorID, int year);
        /// <summary>
        /// 取得一条记录
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        CollectorYearMonthData GetCollectorYearMonthData(int collectorID, int year);

        IList<CollectorYearMonthData> GetCollectorYearMonthData(Hashtable has);
    }
}
