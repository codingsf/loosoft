using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq;
using System.Linq.Expressions;

namespace LinqDAO
{
    public abstract class BaseDAO<TEntityType, TContextType>
        where TEntityType : class
        where TContextType : DataContext, new()
    {
        protected abstract Expression<Func<TEntityType, bool>> GetIDSelector(int ID);


        protected virtual TContextType CreateContext()
        {
            var context = new TContextType();
            return context;
        }

        public IList<TEntityType> GetList()
        {
            return GetEntityTable(CreateContext()).ToList<TEntityType>();
        }


        private Table<TEntityType> GetEntityTable(DataContext context)
        {
            return (Table<TEntityType>)context.GetTable(typeof(TEntityType));
        }

        public void Insert(TEntityType eneiey)
        {
            var db = CreateContext();
            {
                db.GetTable<TEntityType>().InsertOnSubmit(eneiey);
                db.SubmitChanges();
            }
        }


        public void Update(TEntityType entity)
        {
            var db = CreateContext();
            db.GetTable<TEntityType>().Attach(entity);
            db.Refresh(RefreshMode.KeepCurrentValues, entity);
            db.SubmitChanges(ConflictMode.ContinueOnConflict);
        }


        public TEntityType Get(int id)
        {
            DataContext Context = CreateContext();
            return Load(id, Context);
        }


        public void Remove(int id)
        {
            var db = CreateContext();
            db.GetTable<TEntityType>().DeleteOnSubmit(Load(id, db));
            db.SubmitChanges();
        }

        protected TEntityType Load(int ID, DataContext context)
        {
            if (ID == 0)
            {
                return null;
            }
            return GetEntityTable(context).Single(GetIDSelector(ID));
        }


    }
}
