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
    /// 功能：设备发电量总量数据访问层接口
    /// 创建时间：2011-02-26
    /// </summary>
    public interface IDeviceYearDataDao : IBaseDao<DeviceYearData>
    {
        /// <summary>
        /// 根据设备id取得逆变器的年发电量记录列表
        /// </summary>
        /// <param name="deviceId"></param>
        /// <returns></returns>
        IList<DeviceYearData> GetListByDeviceID(int deviceId);

        /// <summary>
        /// 取得年数据
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="year"></param>
        DeviceYearData Get(int deviceID,int year);

    }
}
