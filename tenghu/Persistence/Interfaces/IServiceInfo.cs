using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces
{
    public interface IServiceInfo : IBaseDao<ServiceInfo>
    {
        IList<ServiceInfo> GetList(string aid, string tid);
        IList<ServiceInfo> GetList(string keyword);
    }
}
