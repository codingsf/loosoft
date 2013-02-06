using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Common;
using DataLinq;

namespace LinqDAO
{
    public class JobDAO:BaseDAO<Job,DataLinq.DataClasses1DataContext>
    {
        /*
        private DataLinq.DataClasses1DataContext objDataContext = new DataLinq.DataClasses1DataContext();

        public IList<Job> GetJobs()
        {
            return (from job in objDataContext.Job select job).ToList<Job>();
        }
        public Job Get(int id)
        {
            return (from job in objDataContext.Job where job.id.Equals(id) select job).FirstOrDefault<Job>();
        }


        public int Update(Job job)
        {
            return 0;
        }

        public int Insert(Job job)
        {
            return 0;
        }

        public int Remove(int id)
        {
            return 0;

        }*/
        public IList<Job> GetPage(Pager page)
        {
            var objDataContext = CreateContext();
            page.RecordCount = (from i in objDataContext.Job select i).Count();
            var result = (from i in objDataContext.Job select i).Skip(page.PageIndex).Take(page.PageSize).ToList<Job>();
            return result;
        }

        protected override System.Linq.Expressions.Expression<Func<Job, bool>> GetIDSelector(int ID)
        {
            return (Item) => Item.id == ID;
        }
    }
}
