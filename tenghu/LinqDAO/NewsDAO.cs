using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLinq;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace LinqDAO
{
    public class NewsDAO : BaseDAO<News, DataClasses1DataContext>
    {
        protected override System.Linq.Expressions.Expression<Func<News, bool>> GetIDSelector(int ID)
        {
            return item => item.id.Equals(ID);
        }




        public News GetNewsCategory(int id)
        {
            //select *  from  news where categoryid=#value# limit 0,1

            var db = CreateContext();
            return (from n in db.News where n.categoryid.Equals(id) select n).FirstOrDefault<News>();
            //  return _newsDao.GetNewsCategoryId(id);
        }


        public IList<News> GetPage(Pager page)
        {
            var objDataContext = CreateContext();
            page.RecordCount = (from i in objDataContext.News select i).Count();
            var result = (from i in objDataContext.News select i).Skip(page.PageIndex).Take(page.PageSize).ToList<News>();
            return result;
        }


        public IList<News> Search(string keyword)
        {
            var objDataContext = CreateContext();
            return (from n in objDataContext.News where n.title.Contains(keyword) select n).ToList<News>();
        }


        public News PreNews(int cid, int id)
        {
            var db = CreateContext();
            //select *  from  news where categoryid=#cid# and id<#id# order by id desc limit 0,1
            return (from n in db.News where n.categoryid.Equals(cid) && n.id < id orderby n.id descending select n).FirstOrDefault<News>();
        }

        public News NextNews(int cid, int id)
        {
            //select *  from  news where categoryid=#cid# and  id>#id# order by id asc limit 0,1 
            var db = CreateContext();
            return (from n in db.News where n.categoryid.Equals(cid) && n.id > id orderby n.id descending select n).FirstOrDefault<News>();
        }

        public IList<News> GetHotNews(int cid, int count)
        {
            //select  *  from  news where categoryid=#cid# order by publictime desc limit 0,$count$
            var db = CreateContext();
            return (from n in db.News where n.categoryid.Equals(cid) orderby n.publictime descending select n).Skip(0).Take(count).ToList<News>();
        }

        public IList<News> GetHotNews(int count)
        {
            //select *  from  news where title !='null' order by publictime desc limit 0,$count$
            var db = CreateContext();
            return (from n in db.News where ((n.title)!=null ) orderby n.publictime descending select n).Skip(0).Take(count).ToList<News>();

        }



    }
}
