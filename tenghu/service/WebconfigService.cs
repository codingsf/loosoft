using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
   public class WebconfigService
    {
          private static WebconfigService _instance;
        private IDaoManager _daoManager = null;
        private IWebconfig _webconfigDao = null;

        private WebconfigService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _webconfigDao = _daoManager.GetDao(typeof(IWebconfig)) as IWebconfig;
        }

        public static WebconfigService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new WebconfigService();
            }
            return _instance;
        }



        public IList<Webconfig> GetList()
        {
            return _webconfigDao.Getlist(new Webconfig());
        }
        public Webconfig Get()
        {
            return _webconfigDao.Get(new Webconfig());
        }


        public int Save(Webconfig webconfig)
        {
            if (webconfig.id > 0)
                return _webconfigDao.Update(webconfig);
            return _webconfigDao.Insert(webconfig);
        }
        public int Remove(int id)
        {
            return _webconfigDao.Remove(new Webconfig() {   id = id });
        }

        public  Webconfig Config
        {
            get
            {
                if (System.Web.HttpContext.Current.Application["webconfig"] == null)
                {
                    System.Web.HttpContext.Current.Application["webconfig"] = Get();
                }
                return System.Web.HttpContext.Current.Application["webconfig"] as Webconfig;
            }
        }
    }
}
