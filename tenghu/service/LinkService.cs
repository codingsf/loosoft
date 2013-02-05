using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
   public class LinkService
    {
        private static LinkService _instance;
        private IDaoManager _daoManager = null;
        private ILink _linkDao = null;

        private LinkService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _linkDao = _daoManager.GetDao(typeof(ILink)) as ILink;
        }

        public static LinkService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new LinkService();
            }
            return _instance;
        }

        public IList<Link> GetLinks()
        {
            return _linkDao.Getlist(new Link());
        }

        public int Save(Link link)
        {
            if (link.id > 0)
                return _linkDao.Update(link);
            return _linkDao.Insert(link);
        }

        public int Remove(int id)
        {
            return _linkDao.Remove(new Link() {   id=id});
        }

        public Link Get(int id)
        {
            return _linkDao.Get(new Link() {  id=id});
        }
    }
}
