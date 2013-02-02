using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
  public  class ServiceInfoService
    {
      private static ServiceInfoService _instance;
        private IDaoManager _daoManager = null;
        private IServiceInfo _serviceDao = null;

        private ServiceInfoService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _serviceDao = _daoManager.GetDao(typeof(IServiceInfo)) as IServiceInfo;
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
            return _serviceDao.Get(new ServiceInfo() { id= id });
        }

        public IList<ServiceInfo> GetList(int id)
        {
            return _serviceDao.Getlist(new ServiceInfo() {  areaid=id});
        }

        public IList<ServiceInfo> GetList(string aid,string tid)
        {
            return _serviceDao.GetList(aid, tid); 
        }

        public IList<ServiceInfo> GetList(string kw)
        {
            return _serviceDao.GetList(kw);
        }
        public int Save(ServiceInfo info)
        {
            if (info.id > 0)
                return _serviceDao.Update(info);
            return _serviceDao.Insert(info);
        }

        public int Remove(int id)
        {
            return _serviceDao.Remove(new ServiceInfo() {  id= id});
        }

        public IList<ServiceInfo> GetPage(Pager page)
        {
            return _serviceDao.GetPageList(page, "serviceinfo");
        }

    }
}
