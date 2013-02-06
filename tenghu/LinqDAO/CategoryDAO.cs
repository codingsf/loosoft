using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;
using System.Data.Linq;
namespace LinqDAO
{
    public class CategoryDAO : BaseDAO<Category, DataClasses1DataContext>
    {
        /*
        private DataLinq.DataClasses1DataContext objDataContext = new DataLinq.DataClasses1DataContext();

        public IList<Category> GetList()
        {
            return (from c in objDataContext.Category
                    select c).ToList();
        }

        public Category Get(int id)
        {
            return (from c in objDataContext.Category
                    where c.id.Equals(id)
                    select c).FirstOrDefault<Category>();
        }

        public IList<Category> GetList(string cid)
        {
            return (from c in objDataContext.Category
                    where c.pid.Equals(cid)
                    select c).ToList();
        }

        public int Update(Category category)
        {
            return 0;
        }


        public int Insert(Category category)
        {
            return 0;
        }

        public int Remove(int id)
        {
            return 0;
        }*/
        protected override System.Linq.Expressions.Expression<Func<Category, bool>> GetIDSelector(int ID)
        {
            return (Item) => Item.id == ID;
        }



        public IList<Category> GetList(int cid)
        {
            var db = CreateContext();
            if (cid.Equals(0))
                return (from c in db.Category where c.pid == null select c).ToList<Category>();

            return (from c in db.Category where c.pid.Equals(cid) select c).ToList<Category>();
        }
    }
}
