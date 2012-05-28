using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 设备类型持久化ibatis实现类
    /// Author: 赵文辉
    /// Time: 2011年2月18日 15:00:37  第一次修改
    /// </summary>
    public class DeviceModelSqlMapDao : BaseSqlDao<DeviceModel>, IDeviceModelDao
    {
        #region IDeviceModelDao 成员

        public IList<DeviceModel> getXhbyDeviceType(int type)
        {
            return ExecuteQueryForList<DeviceModel>( "get_xh_by_devicetype",type);
        }
       

        public IList<DeviceModel> GetDevicemodelsByPage(Pager page)
        {
            page.RecordCount = (int)ExecuteQueryForObject("loading_devicemodel_page_count", page);
            return ExecuteQueryForList<DeviceModel>("loading_devicemodel_page_list", page);
        }

        #endregion
    }
}
