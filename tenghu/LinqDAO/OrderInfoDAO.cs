using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;

namespace LinqDAO
{
    public class OrderInfoDAO : BaseDAO<OrderInfo, DataClasses1DataContext>
    {
        protected override System.Linq.Expressions.Expression<Func<OrderInfo, bool>> GetIDSelector(int ID)
        {
            return (item) => item.id.Equals(ID);
        }
    }
}
