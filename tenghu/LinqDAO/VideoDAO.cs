using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;

namespace LinqDAO
{
    public class VideoDAO : BaseDAO<Video, DataClasses1DataContext>
    {
        protected override System.Linq.Expressions.Expression<Func<Video, bool>> GetIDSelector(int ID)
        {
            return (item) => item.id.Equals(ID);
        }

        public IList<Video> GetListCategory(int cid)
        {

            var db = CreateContext();
            return (from v in db.Video where v.categoryid.Equals(cid) select v).ToList<Video>();
        }
    }
}
