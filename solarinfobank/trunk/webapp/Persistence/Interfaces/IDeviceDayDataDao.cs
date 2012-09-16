using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{

    public interface IDeviceDayDataDao : IBaseDao<DeviceDayData>
    {
        /// <summary>
        /// 取得设备跨小时数据
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="YYYYMM"></param>
        /// <param name="startDay"></param>
        /// <param name="endDay"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        IList GetDaydataList(int deviceID, string deviceType, string year, string month, int startDay, int endDay, int monitorCode);

       /// <summary>
       /// 取得设备所有测点数据
       /// add by qhb in 20120915
       /// </summary>
       /// <param name="deviceID"></param>
       /// <param name="deviceType"></param>
       /// <param name="year"></param>
       /// <param name="month"></param>
       /// <param name="startDay"></param>
       /// <param name="endDay"></param>
       /// <returns></returns>
        IList<DeviceDayData> GetDaydataList(int deviceID, string deviceType, string year, string month, int startDay, int endDay);

        /// <summary>
        /// 根据设备，测点和天 取得设备数据对象
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="monitorCode"></param>
        /// <param name="sendDay"></param>
        /// <param name="YYYYMM"></param>
        /// <returns></returns>
        DeviceDayData getDeviceDayData(int deviceID, string deviceType, int monitorCode, int sendDay, string YYYYMM);

        /// <summary>
        /// 取得设备和某天的数据记录数量
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="sendDay"></param>
        /// <param name="YYYYMM"></param>
        /// <returns></returns>
        IList<int> getDeviceDayDataNums(int deviceID, int sendDay, string YYYYMM, string deviceType);
    }
}
