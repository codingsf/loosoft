using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;

using LinqDAO;
using DataLinq;
using Cn.Loosoft.Zhisou.Tenghu.Common;
namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class NewsService
    {
        private static NewsService _instance;
        // private IDaoManager _daoManager = null;
        private NewsDAO _newsDao = null;

        private NewsService()
        {
            // _daoManager = ServiceConfig.GetInstance().DaoManager;
            //_newsDao = _daoManager.GetDao(typeof(INews)) as INews;
            _newsDao = new NewsDAO();
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
            return _newsDao.GetList();// (new News());
        }

        public void Save(News news)
        {
            if (news.id > 0)
                _newsDao.Update(news);
            _newsDao.Insert(news);
        }
        public void Remove(int id)
        {
            _newsDao.Remove(id);
        }


        public News Get(int id)
        {
            return _newsDao.Get(id);
        }

        public News GetNewsCategory(int id)
        {
            return _newsDao.GetNewsCategory(id);
        }


        public IList<News> GetPage(Pager page)
        {
            return _newsDao.GetPage(page);
        }


        public IList<News> Search(string keyword)
        {
            return _newsDao.Search(keyword);
        }


        public News PreNews(int cid, int id)
        {
            return _newsDao.PreNews(cid, id);
        }

        public News NextNews(int cid, int id)
        {
            return _newsDao.NextNews(cid, id);
        }

          public IList<News> GetHotNews(int cid, int count)
        {
            return _newsDao.GetHotNews(cid, count);
        }

        public IList<News> GetHotNews(int count)
        {
            return _newsDao.GetHotNews(count);
        }
    }
}
