using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{

    public interface ICollectorMonthDayDataDao : IBaseDao<CollectorMonthDayData>
    {
        /// <summary>
        /// 取得某个年度的跨月月天发电量数据
        /// </summary>
        /// <param name="year">所在年份</param>
        /// <param name="startMM">开始月份</param>
        /// <param name="endMM">截至</param>
        /// <returns></returns>
        IList<CollectorMonthDayData> GetMonthBetweenData(int collectorID, int year, int startMM, int endMM);
        
        /// <summary>
        /// 更新设备某个id的某个字段天数据
        /// </summary>
        /// <param name="d_column"></param>
        /// <param name="d_value"></param>
        /// <param name="id"></param>
        void UpdateCollectorMonthDayData(int year, string d_column, double d_value, int id);
        /// <summary>
        /// 插入一条记录
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="collectorID"></param>
        /// <param name="month"></param>
        void InsertCollectorMonthDayData(string d_Column, double d_Value, int collectorID, int year, int month);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="year"></param>
        /// <param name="collectorID"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        CollectorMonthDayData GetCollectorMonthDayData(int year, int collectorID, int month);
    }
}
