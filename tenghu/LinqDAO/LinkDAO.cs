using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;

namespace LinqDAO
{
    public class LinkDAO : BaseDAO<Link, DataLinq.DataClasses1DataContext>
    {
        protected override System.Linq.Expressions.Expression<Func<Link, bool>> GetIDSelector(int ID)
        {
            return (Item) => Item.id == ID;
        }
    }
}
