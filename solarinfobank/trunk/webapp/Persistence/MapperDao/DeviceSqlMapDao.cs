using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;

using Cn.Loosoft.Zhisou.SunPower.Domain;
using IBatisNet.DataMapper;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 功能：实现设备信息接口
    /// 作者：张月
    /// 时间：2011年2月26日 10:41:23
    /// </summary>
    public class DeviceSqlMapDao : BaseSqlDao<Device>, IDeviceDao
    {
        #region IInverter 成员
        /// <summary>
        /// 功能:实现根据电站id查询设备信息
        /// 作者：张月
        /// 时间：2011年2月26日 10:42:08
        /// </summary>
        /// <param name="collertorID">采集器id</param>
        /// <returns>设备列表</returns>
        public IList<Device> GetDeviceByCollectorID(int collertorID)
        {
            return ExecuteQueryForList<Device>("DEVICE_GET_BY_COLLECTORID", collertorID);
        }

        #endregion

        #region IInverter 成员

        /// <summary>
        /// 查询设备类型
        /// </summary>
        /// <returns>设备类型集合</returns>
        public IList<Device> GetDeviceType(int collertorID)
        {
            return ExecuteQueryForList<Device>("GET_DEVICE_TYPE", collertorID);
        }

        /// <summary>
        /// 根据采集数据id和设备地址取得对应的设备
        /// </summary>
        /// <param name="collectorId"></param>
        /// <param name="address"></param>
        /// <returns></returns>
        public Device GetDeviceByCollector2Address(int collectorID, string deviceAddress)
        { 
            Hashtable whereHash = new Hashtable();
            whereHash["collectorID"] = collectorID;
            whereHash["deviceAddress"] = deviceAddress;
            return ExecuteQueryForObject<Device>("device_get_bycollectorId2address", whereHash);
        }

        #endregion


        #region IDeviceDao 成员


        public IList<Device> GetDevicesListPage(Hashtable table)
        {
            if (table.ContainsKey("page"))
                (table["page"] as Pager).RecordCount = (int)ExecuteQueryForObject("device_get_list_type_xh_page_count", table);
            return ExecuteQueryForList<Device>("device_get_list_type_xh_page_list", table);
        }

        #endregion

        #region IDeviceDao 成员


        public int SaveCurrentPower(string id, string power)
        {
            Hashtable table = new Hashtable();
            table.Add("id", id);
            table.Add("power", power);
            return ExecuteUpdate("device_update_currentpower", table);
        }
        public int SetDeviceStatus(string id, string status)
        {
            Hashtable table = new Hashtable();
            table.Add("id", id);
            table.Add("status", status);
            return ExecuteUpdate("device_update_status", table);
        }
        #endregion

        #region IDeviceDao 成员


        public int UpdateDeviceById(Device device)
        {
            return ExecuteUpdate("updateDevice",device);
        }

        #endregion

        public IList<Device> getAllList()
        {
            return ExecuteQueryForList<Device>("device_get_all_list",null);
        
        }

        public IList<Device> getDeviceListLikeName(string name)
        {
            return ExecuteQueryForList<Device>("device_get_like_name", name);
            
        }

    }
}
