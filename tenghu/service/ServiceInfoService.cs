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
    public class ServiceInfoService
    {
        private static ServiceInfoService _instance;
        // private IDaoManager _daoManager = null;
        private ServiceInfoDAO _serviceDao = null;

        private ServiceInfoService()
        {
            // _daoManager = ServiceConfig.GetInstance().DaoManager;
            _serviceDao = new ServiceInfoDAO();
            // _daoManager.GetDao(typeof(IServiceInfo)) as IServiceInfo;
        }

        public static ServiceInfoService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new ServiceInfoService();
            }
            return _instance;
        }

        public ServiceInfo Get(int id)
        {
            return _serviceDao.Get(id);
        }

        public IList<ServiceInfo> GetList(int id)
        {
            return _serviceDao.GetList(id);
        }

        public IList<ServiceInfo> GetList(int aid, int tid)
        {
            return _serviceDao.GetList(aid, tid);
        }

        public IList<ServiceInfo> GetList(string kw)
        {
            return _serviceDao.GetList(kw);
        }

        public void Save(ServiceInfo info)
        {
            if (info.id > 0)
                _serviceDao.Update(info);else
            _serviceDao.Insert(info);
        }

        public void Remove(int id)
        {
            _serviceDao.Remove(id);
        }

        public IList<ServiceInfo> GetPage(Pager page)
        {
            return _serviceDao.GetPage(page);
        }

    }
}
