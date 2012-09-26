using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class QAService
    {
        private static QAService _instance = new QAService();
        private IDaoManager _daoManager = null;
        private IQADao _qaDao = null;

        private QAService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _qaDao = _daoManager.GetDao(typeof(IQADao)) as IQADao;
        }

        public static QAService GetInstance()
        {
            return _instance;
        }

        public int Save(QA qa)
        {
            if (qa.id > 0)
                return _qaDao.Update(qa);
            return _qaDao.Insert(qa);
        }

        public IList<QA> Search(string kw, int status, string username)
        {
            return _qaDao.Getlist(new QA { title = kw, descr = kw, status = status, username = username });
        }

        public QA Get(int id)
        {
            return _qaDao.Get(new QA { id = id });
        }

        public int UpdateStatus(int id, int status)
        {
            return _qaDao.UpdateStatus(id, status);
        }
        public int Recommend(int id, bool isrecommend)
        {
            return _qaDao.Recommend(id, isrecommend);
        }

        public IList<QA> GetRecommendList()
        {
            return _qaDao.GetRecommendList();
        }
    }
}
