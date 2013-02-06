using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using IBatisNet.DataAccess;
using DataLinq;
using LinqDAO;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class WebconfigService
    {
        private static WebconfigService _instance;
        //private IDaoManager _daoManager = null;
        private WebconfigDAO _webconfigDao = null;

        private WebconfigService()
        {
            // _daoManager = ServiceConfig.GetInstance().DaoManager;
            // _webconfigDao = _daoManager.GetDao(typeof(IWebconfig)) as IWebconfig;
            _webconfigDao = new WebconfigDAO();
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
            return _webconfigDao.GetList();
        }
        public Webconfig Get()
        {
            IList<Webconfig> webConfigList = GetList();
            if (webConfigList.Count >= 1)
                return webConfigList[0];
            return new Webconfig();
        }


        public void Save(Webconfig webconfig)
        {
            if (webconfig.id > 0)
                _webconfigDao.Update(webconfig);
            else
            _webconfigDao.Insert(webconfig);
        }
        public void Remove(int id)
        {
            _webconfigDao.Remove(id);
        }

        public Webconfig Config
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
