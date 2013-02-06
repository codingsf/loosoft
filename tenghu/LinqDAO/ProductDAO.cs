using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace LinqDAO
{
    public class ProductDAO : BaseDAO<Product, DataLinq.DataClasses1DataContext>
    {
        protected override System.Linq.Expressions.Expression<Func<Product, bool>> GetIDSelector(int ID)
        {
            return (item) => item.id.Equals(ID);
        }

        public IList<Product> GetPageList(Pager page)
        {
            var objDataContext = CreateContext();
            page.RecordCount = (from i in objDataContext.Product select i).Count();
            var result = (from i in objDataContext.Product select i).Skip(page.PageIndex).Take(page.PageSize).ToList<Product>();
            return result;
        }



        public IList<Product> GetProductsCategory(int cid)
        {
            var objDataContext = CreateContext();
            var result = (from i in objDataContext.Product where i.mid.Equals(cid) orderby i.id descending select i);
            return result.ToList<Product>();
        }
    }
}
