using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;
using System.Data.Linq;
using Cn.Loosoft.Zhisou.Tenghu.Common;
namespace LinqDAO
{
    public class ImageDAL:BaseDAO<Image,DataClasses1DataContext>
    {
        /*
        private DataLinq.DataClasses1DataContext objDataContext = new DataLinq.DataClasses1DataContext();


        public IList<Image> GetList()
        {
            return (from i in objDataContext.Image select i).ToList<Image>();
        }


        public int Update(Image image)
        {
            return 0;
        }


        public int Insert(Image image)
        {
            return 0;
        }


        public int Remove(int id)
        {
            return 0;
        }


        public Image Get(int id)
        {
            return (from i in objDataContext.Image where i.id.Equals(id) select i).FirstOrDefault<Image>();
        }
        */
        public IList<Image> GetPage(Pager page)
        {
            var objDataContext = CreateContext();
            page.RecordCount = (from i in objDataContext.Image select i).Count();
            var result = (from i in objDataContext.Image select i).Skip(page.PageIndex).Take(page.PageSize).ToList<Image>();
            return result;
        }


        protected override System.Linq.Expressions.Expression<Func<Image, bool>> GetIDSelector(int ID)
        {
            return (Item) => Item.id == ID;
        }
    }
}
