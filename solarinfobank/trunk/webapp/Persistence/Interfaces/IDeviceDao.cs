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
    /// 功能：设备接口
    /// 作者：张月
    /// 时间：2011年2月26日 10:36:27
    /// </summary>
    public interface IDeviceDao:IBaseDao<Device>
    {
        /// <summary>
        /// 取得采集器下设备列表
        /// </summary>
        /// <param name="collertorID"></param>
        /// <returns></returns>
        IList<Device> GetDeviceByCollectorID(int collertorID);
        /// <summary>
        /// 查询设备类型
        /// </summary>
        /// <returns>设备集合</returns>
        IList<Device> GetDeviceType(int collertorID);

        /// <summary>
        /// 根据采集数据id和设备地址取得对应的设备
        /// </summary>
        /// <param name="collectorID"></param>
        /// <param name="address"></param>
        /// <returns></returns>
        Device GetDeviceByCollector2Address(int collectorID, string deviceAddress);


        IList<Device> GetDevicesListPage(Hashtable table);

        int SaveCurrentPower(string id, string power);

        int SetDeviceStatus(string id, string status);
        int UpdateDeviceById(Device device);
        /// <summary>
        /// 取得所有设备
        /// </summary>
        /// <returns></returns>
        IList<Device> getAllList();
    }
}
