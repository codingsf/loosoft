using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces
{
    public interface INews : IBaseDao<News>
    {
        IList<News> GetHotNews(int cid,int count);
        IList<News> GetHotNews(int count);
        News GetNewsCategoryId(int category);
        News GetPreNews(int cid,int id);
        News GetNextNews(int cid,int id);
        IList<News> SearchNews(string keyword);

    }
}
