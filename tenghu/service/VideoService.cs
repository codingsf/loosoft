using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Persistence;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
   public class VideoService
    {
       private static VideoService _instance;
        private IDaoManager _daoManager = null;
        private IVideo _videoDao = null;

        private VideoService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _videoDao = _daoManager.GetDao(typeof(IVideo)) as IVideo;
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
            return _videoDao.Getlist(new Video());
        }

        public IList<Video> GetListCategory(int cid)
        {
            return _videoDao.GetVideoCategory(cid);
        }

        public int Save(Video video)
        {
            if (video.id > 0)
                return _videoDao.Update(video);
            return _videoDao.Insert(video);
        }

        public int Remove(int id)
        {
            return _videoDao.Remove(new Video() { id= id });
 
        }

        public Video Get(int id)
        {
            return _videoDao.Get(new Video() {  id=id});
        }
    }
}
