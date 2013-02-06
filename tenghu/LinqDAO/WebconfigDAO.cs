using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;

namespace LinqDAO
{
    public class WebconfigDAO : BaseDAO<Webconfig, DataClasses1DataContext>
    {
        protected override System.Linq.Expressions.Expression<Func<Webconfig, bool>> GetIDSelector(int ID)
        {
            return (item) => item.id.Equals(ID);
        }
    }
}
