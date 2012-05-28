using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 设备类型信息接口
    /// Author: 赵文辉
    /// Time: 2011年2月16日 11:27:43
    public interface IDeviceModelDao : IBaseDao<DeviceModel>
    {
        IList<DeviceModel> getXhbyDeviceType(int type);

        IList<DeviceModel> GetDevicemodelsByPage(Pager page);
    }
}
