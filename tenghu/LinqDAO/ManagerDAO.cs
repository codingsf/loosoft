using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;

namespace LinqDAO
{
    public class ManagerDAO : BaseDAO<Manager, DataClasses1DataContext>
    {
        protected override System.Linq.Expressions.Expression<Func<Manager, bool>> GetIDSelector(int ID)
        {
            return (item) => item.id.Equals(ID);
        }

        public Manager Get(string uname)
        {
            var db = CreateContext();
            return (from m in db.Manager where m.username.Equals(uname) select m).FirstOrDefault<Manager>();
        }
    }
}
