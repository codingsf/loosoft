using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{

    public interface IDeviceMonthDayDataDao : IBaseDao<DeviceMonthDayData>
    {
        /// <summary>
        /// 取得设备某个年度的跨月月天发电量数据
        /// </summary>
        /// <param name="year">所在年份</param>
        /// <param name="startMM">开始月份</param>
        /// <param name="endMM">截至</param>
        /// <returns></returns>
        IList<DeviceMonthDayData> GetMonthBetweenData(int deviceId, int year, int startMM, int endMM);
        /// <summary>
        /// 更新设备某个id的某个字段天数据
        /// </summary>
        /// <param name="d_column"></param>
        /// <param name="d_value"></param>
        /// <param name="id"></param>
        void UpdateDeviceMonthDayData(int year, string d_column, double d_value, int id);

        /// <summary>
        /// 插入一条记录
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="month"></param>
        void InsertDeviceMonthDayData(string d_Column, double d_Value, int deviceID,int year, int month);

        /// <summary>
        /// 查询某个设备的某个测点月天数据id
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        DeviceMonthDayData GetDeviceMonthDayData(int deviceID, int year, int month);

        IList<DeviceMonthDayData> GetDeviceMonthDayData(Hashtable has);
    }
}
