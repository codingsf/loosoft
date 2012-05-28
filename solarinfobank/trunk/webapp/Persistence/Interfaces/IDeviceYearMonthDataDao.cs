/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月03日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{

    public interface IDeviceYearMonthDataDao : IBaseDao<DeviceYearMonthData>
    {
        /// <summary>
        /// 取得设备跨月度数据报表
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="startYear"></param>
        /// <param name="endYear"></param>
        /// <returns></returns>
        IList<DeviceYearMonthData> GetDeviceBetweenYearData(int deviceId, int startYear, int endYear);
       
        /// <summary>
        /// 取得设备的开始工作年份
        /// </summary>
        /// <param name="deviceId"></param>
        /// <returns></returns>
        int GetStartWorkYear(int deviceId);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="id"></param>
        void UpdateDeviceYearMonthData(string d_Column, double d_Value, int id);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="d_Column"></param>
        /// <param name="d_Value"></param>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        void InsertDeviceYearMonthData(string d_Column, double d_Value, int deviceID, int year);
        /// <summary>
        /// 取得一条记录
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        DeviceYearMonthData GetDeviceYearMonthData(int deviceID, int year);

        IList<DeviceYearMonthData> GetDeviceYearMonthData(Hashtable has);
    }
}
