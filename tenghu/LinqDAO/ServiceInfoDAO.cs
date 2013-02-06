using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace LinqDAO
{
    public class ServiceInfoDAO : BaseDAO<ServiceInfo, DataClasses1DataContext>
    {
        protected override System.Linq.Expressions.Expression<Func<ServiceInfo, bool>> GetIDSelector(int ID)
        {
            return (item) => item.id == ID;
        }

        public IList<ServiceInfo> GetPage(Pager page)
        {
            var objDataContext = CreateContext();
            page.RecordCount = (from i in objDataContext.ServiceInfo select i).Count();
            var result = (from i in objDataContext.ServiceInfo select i).Skip(page.PageIndex).Take(page.PageSize).ToList<ServiceInfo>();
            return result;
        }



        public IList<ServiceInfo> GetList(int id)
        {
            var objDataContext = CreateContext();
            var result = (from i in objDataContext.ServiceInfo where i.areaid.Equals(id) select i).ToList<ServiceInfo>();
            return result.ToList<ServiceInfo>();
        }

        public IList<ServiceInfo> GetList(string kw)
        {
            var objDataContext = CreateContext();
            var result = (from i in objDataContext.ServiceInfo where i.addr.Contains(kw) select i).ToList<ServiceInfo>();
            return result.ToList<ServiceInfo>();
        }

        public IList<ServiceInfo> GetList(int aid, int tid)
        {
            var objDataContext = CreateContext();
            var result = (from i in objDataContext.ServiceInfo where i.areaid.Equals(aid) && i.nettypeid.Equals(tid) select i).ToList<ServiceInfo>();
            return result.ToList<ServiceInfo>();
        }
    }
}
