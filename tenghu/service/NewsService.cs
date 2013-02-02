using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.Tenghu.Domain;
namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class NewsService
    {
        private static NewsService _instance;
        private IDaoManager _daoManager = null;
        private INews _newsDao = null;

        private NewsService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _newsDao = _daoManager.GetDao(typeof(INews)) as INews;
        }

        public static NewsService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new NewsService();
            }
            return _instance;
        }


        public IList<News> GetList()
        {
            return _newsDao.Getlist(new News());
        }


        public IList<News> GetHotNews(int cid,int count)
        {
            return _newsDao.GetHotNews(cid,count);
        }

        public IList<News> GetHotNews(int count)
        {
            return _newsDao.GetHotNews( count);
        }


        public int Save(News news)
        {
            if (news.id > 0)
                return _newsDao.Update(news);
            return _newsDao.Insert(news);
        }
        public int Remove(int id)
        {
            return _newsDao.Remove(new News() { id= id });
        }


        public News Get(int id)
        {
            return _newsDao.Get(new News() { id=id });
        }

        public News GetNewsCategory(int id)
        {
            return _newsDao.GetNewsCategoryId(id);
        }


        public IList<News> GetPage(Pager page)
        {
            return _newsDao.GetPageList(page, "news");
        }


        public IList<News> Search(string keyword)
        {
            return _newsDao.SearchNews(keyword);
        }


        public News PreNews(int cid,int id)
        {
            return _newsDao.GetPreNews(cid, id);
        }

        public News NextNews(int cid,int id)
        {
            return _newsDao.GetNextNews(cid, id);
        }
    }
}
