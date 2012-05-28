using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：定义实时数据
    /// 创建时间：2011-02-22
    /// </summary>
    public  interface IDeviceRunDataDao:IBaseDao<DeviceRunData>
    {
        //int AddDeviceRunData(DeviceRunData deviceRunData);
        //int DeleteDeviceRunData(int id);
        //int UpdateDeviceRunData(DeviceRunData deviceRunData);
        //DeviceRunData GetDeviceRunData(int id);
        /// <summary>
        /// 作者：鄢睿
        /// 功能：获得所有设备实时数据列表
        /// 创建时间：2011-02-22
        /// </summary>
        /// <returns></returns>
        IList<DeviceRunData> GetDeviceRunDataList();
        /// <summary>
        /// 作者：鄢睿
        /// 功能：通过电站ID获得电站具有的设备列表
        /// 创建时间：2011-02-22
        /// </summary>
        /// <param name="plantId"></param>
        /// <returns></returns>
        IList<DeviceRunData> GetDeviceRunDataList(int plantId);

        /// <summary>
        /// 功能：根据设备Id和电站Id获取设备状态
        /// 作者:张月
        /// 时间：2011年2月26日 13:59:51
        /// </summary>
        /// <param name="plantRunData">设备实体</param>
        /// <returns>设备运行状态集合</returns>
        IList<DeviceRunData> GetDeviceRunDataByPlantIdDeviceId(string deviceId, int plantId);

        /// <summary>
        /// 所有设备的总发电量
        /// </summary>
        /// <returns></returns>
        float GetAllTotalEnergy();
    }
}
