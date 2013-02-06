using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;

using System.Collections;

namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao
{
    public class NewsSqlMapDao : BaseSqlDao<News>, INews
    {

        public IList<News> GetHotNews(int cid,int count)
        {
            Hashtable table = new Hashtable();
            table.Add("cid", cid);
            table.Add("count", count);
            return ExecuteQueryForList<News>("news_get_hot_cid", table);
        }

        public IList<News> GetHotNews(int count)
        {
            return ExecuteQueryForList<News>("news_get_hot", count);
        }


        public News GetNewsCategoryId(int category)
        {
            return ExecuteQueryForObject<News>("news_get_categoryid", category);
        }


        public News GetPreNews(int cid, int id)
        {
            Hashtable table = new Hashtable();
            table.Add("cid", cid);
            table.Add("id", id);
            return ExecuteQueryForObject<News>("news_get_pre", table);
           
        }

        public News GetNextNews(int cid, int id)
        {
            Hashtable table = new Hashtable();
            table.Add("cid", cid);
            table.Add("id", id);
            return ExecuteQueryForObject<News>("news_get_next", table);
           
        }

        public IList<News> SearchNews(string keyword)
        {
            return ExecuteQueryForList<News>("news_search", keyword);
        }

    }
}
