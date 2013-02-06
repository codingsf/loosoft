using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace LinqDAO
{
    public class ZhuanliDAO : BaseDAO<Zhuanli, DataClasses1DataContext>
    {
        protected override System.Linq.Expressions.Expression<Func<Zhuanli, bool>> GetIDSelector(int ID)
        {
            return (item) => item.id.Equals(ID);
        }



        public IList<Zhuanli> GetPage(Pager page)
        {
            var objDataContext = CreateContext();
            page.RecordCount = (from i in objDataContext.Zhuanli select i).Count();
            var result = (from i in objDataContext.Zhuanli select i).Skip(page.PageIndex).Take(page.PageSize).ToList<Zhuanli>();
            return result;
        }
    }
}
