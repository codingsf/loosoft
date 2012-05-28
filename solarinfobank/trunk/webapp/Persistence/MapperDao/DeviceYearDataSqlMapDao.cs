using System;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections.Generic;
using System.Collections;
using IBatisNet.Common.Exceptions;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：设备总量数据访问层实现类
    /// 创建时间：2011-02-26
    /// </summary>
    public class DeviceYearDataSqlMapDao : BaseSqlDao<DeviceYearData>, IDeviceYearDataDao
    {
        #region IInverterTotalDataDao 成员
        
        /// <summary>
        /// 根据设备id取得逆变器的年发电量记录列表
        /// </summary>
        /// <param name="deviceId"></param>
        /// <returns></returns>
        public IList<DeviceYearData> GetListByDeviceID(int deviceId)
        {
            System.Collections.Hashtable whereHash = new Hashtable();
            whereHash.Add("deviceId", deviceId);
            try
            {
                return ExecuteQueryForList<DeviceYearData>("deviceyeardata_list_by_deviceid", whereHash);
            }
            catch (IBatisNetException ie)
            {
                Console.WriteLine("query error:" + ie.Message);
            }
            return new List<DeviceYearData>();

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="year"></param>
        /// <param name="monitorCode"></param>
        /// <returns></returns>
        public DeviceYearData Get(int deviceID,int year)
        {
            Hashtable has = new Hashtable();
            has.Add("deviceID", deviceID);
            has.Add("year", year);
            return ExecuteQueryForObject<DeviceYearData>("GetByDeviceIdYear", has);
        }
        #endregion
    }
}
