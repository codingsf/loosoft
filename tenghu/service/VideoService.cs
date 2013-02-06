using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;


using LinqDAO;
using DataLinq;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class VideoService
    {
        private static VideoService _instance;
        //private IDaoManager _daoManager = null;
        private VideoDAO _videoDao = null;

        private VideoService()
        {
            //_daoManager = ServiceConfig.GetInstance().DaoManager;
            _videoDao = new VideoDAO();
            //_daoManager.GetDao(typeof(IVideo)) as IVideo;
        }

        public static VideoService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new VideoService();
            }
            return _instance;
        }

        public IList<Video> GetList()
        {
            return _videoDao.GetList();
        }

        public IList<Video> GetListCategory(int cid)
        {
            return _videoDao.GetListCategory(cid);
        }

        public void Save(Video video)
        {
            if (video.id > 0)
                 _videoDao.Update(video);else
             _videoDao.Insert(video);
        }

        public void Remove(int id)
        {
             _videoDao.Remove(id);

        }

        public Video Get(int id)
        {
            return _videoDao.Get(id);
        }
    }
}
