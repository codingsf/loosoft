using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;

using LinqDAO;
using DataLinq;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class LinkService
    {
        private static LinkService _instance;
        // private IDaoManager _daoManager = null;
        private LinkDAO _linkDao = null;

        private LinkService()
        {
            //   _daoManager = ServiceConfig.GetInstance().DaoManager;
            //  _linkDao = _daoManager.GetDao(typeof(ILink)) as ILink;
            _linkDao = new LinkDAO();
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
            return _linkDao.GetList();
        }

        public void Save(Link link)
        {
            if (link.id > 0)
                _linkDao.Update(link);else
            _linkDao.Insert(link);
        }

        public void Remove(int id)
        {
            _linkDao.Remove(id);
        }

        public Link Get(int id)
        {
            return _linkDao.Get(id);
        }
    }
}
