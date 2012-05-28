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
    /// 设备测点信息接口
    /// Author: 赵文辉
    /// Time: 2011年2月16日 11:27:43
    public interface IMonitorItemDao : IBaseDao<MonitorItem>
    {

        IList<MonitorItem> GetlistByHas(Hashtable has);

        IList<int> GetlistStats();

        IList<MonitorItem> GetMonitorItemsByPage(Pager page);


    }
}
