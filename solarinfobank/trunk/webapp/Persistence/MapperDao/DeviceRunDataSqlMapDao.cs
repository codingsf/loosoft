using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class DeviceRunDataSqlMapDao : BaseSqlDao<DeviceRunData>, IDeviceRunDataDao
    {

        #region IDeviceRunDataDao 成员

        ///// <summary>
        ///// 功能：添加一条逆变器设备实时数据信息
        ///// 作者：鄢睿
        ///// 创建时间：2011年02月17日 14:10
        ///// </summary>
        ///// <param name="deviceRunData">逆变器设备实时数据</param>
        ///// <returns>flag小于等于0失败，大于0成功</returns>
        //public int AddDeviceRunData(DeviceRunData deviceRunData)
        //{
        //    int flag = 0;
        //    if (deviceRunData.AcCurrent < 0 && deviceRunData.AcVoltage < 0 &&
        //        deviceRunData.DcCurrent < 0 && deviceRunData.DcVoltage < 0)
        //    {
        //        ExecuteInsert<DeviceRunData>("INSERT_NEED_INFO_DEVICERUNDATA", deviceRunData, out flag);
        //    }
        //    else
        //    {
        //        ExecuteInsert<DeviceRunData>("INSERT_FULL_INFO_DEVICERUNDATA", deviceRunData, out flag);
        //    }
        //    return flag;
        //}

        ///// <summary>
        ///// 功能：通过id删除一条逆变器设备事实上数据
        ///// 作者：鄢睿
        ///// 创建时间：2011年02月17 14:13
        ///// </summary>
        ///// <param name="id">逆变器Id</param>
        ///// <returns>flag小于等于0失败，大于0成功</returns>
        //public int DeleteDeviceRunData(int id)
        //{
        //    int flag = ExecuteDelete("DELETE_DEVICERUNDATA_BY_ID", id);
        //    return flag;
        //}

        ///// <summary>
        ///// 功能：更新一条更新
        ///// 作者：鄢睿
        ///// 创建时间：2011年02月17日 14:19
        ///// </summary>
        ///// <param name="deviceRunData"></param>
        ///// <returns></returns>
        //public int UpdateDeviceRunData(DeviceRunData deviceRunData)
        //{
        //    int flag = 0;
        //    if (deviceRunData.AcCurrent < 0 && deviceRunData.AcVoltage < 0 &&
        //        deviceRunData.DcCurrent < 0 && deviceRunData.DcVoltage < 0)
        //    {
        //        flag = ExecuteUpdate<DeviceRunData>("UPDATE_FULL_INFO_DEVICERUNDATA", deviceRunData);
        //    }
        //    else
        //    {
        //        flag = ExecuteUpdate<DeviceRunData>("UPDATE_NEED_INFO_DEVICERUNDATA", deviceRunData);
        //    }
        //    return flag;
        //}

        ///// <summary>
        ///// 功能：通过实时数据Id获得一条实时数据
        ///// 作者：鄢睿
        ///// 创建时间：2011年02月17日14:24
        ///// </summary>
        ///// <param name="id"></param>
        ///// <returns></returns>
        //public DeviceRunData GetDeviceRunData(int id)
        //{
        //    DeviceRunData deviceRunData = ExecuteQueryForObject<DeviceRunData>("GET_DEVICERUNDATA_BY_ID", id);
        //    return deviceRunData;
        //}
        
        /// <summary>
        /// 功能：获得所有逆变器实时数据列表
        /// 作者：鄢睿
        /// 创建时间：2011年02月17日14:27
        /// </summary>
        /// <returns></returns>
        public IList<DeviceRunData> GetDeviceRunDataList()
        {
            IList<DeviceRunData> deviceRunDataList = ExecuteQueryForList<DeviceRunData>("GET_All_DEVICERUNDATA_LIST", null);
            return deviceRunDataList;
        }

        /// <summary>
        /// 功能：通过电站Id获得该电站所有逆变器实时数据列表
        /// 作者：鄢睿
        /// 创建时间：2011年02月17日14:27
        /// </summary>
        /// <returns></returns>
        public IList<DeviceRunData> GetDeviceRunDataList(int plantId)
        {
            IList<DeviceRunData> deviceRunDataList = ExecuteQueryForList<DeviceRunData>("GET_DEVICERUNDATA_LIST_BY_PlANTID", plantId);
            return deviceRunDataList;
        }

        /// <summary>
        /// 功能：根据设备Id和电站Id获取设备状态
        /// 作者:张月
        /// 时间：2011年2月26日 13:59:51
        /// </summary>
        /// <param name="plantRunData">设备实体</param>
        /// <returns>设备运行状态集合</returns>
        public IList<DeviceRunData> GetDeviceRunDataByPlantIdDeviceId(string deviceId, int plantId)
        {
            Hashtable table = new Hashtable();
            table.Add("deviceId", deviceId);
            table.Add("plantId", plantId);
            return ExecuteQueryForList<DeviceRunData>("DEVICERUNDATA_GET_BY_PLANTID_DEVICEID", table);
        }

        #endregion

        /// <summary>
        /// 所有设备的总发电量
        /// </summary>
        /// <returns></returns>
        public float GetAllTotalEnergy() {
            return (float)ExecuteQueryForObject("devicerundata_get_totalenergy", null);
        }
    }
}