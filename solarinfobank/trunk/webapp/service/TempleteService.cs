using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{

    public class TempleteService
    {

        private static TempleteService _instance = new TempleteService();
        private IDaoManager _daoManager = null;
        private ITempleteDao _templeteDao = null;

        private TempleteService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _templeteDao = _daoManager.GetDao(typeof(ITempleteDao)) as ITempleteDao;
        }

        public static TempleteService GetInstance()
        {
            return _instance;
        }


        public int Save(Templete templete)
        {
            if (templete.id > 0)
                return _templeteDao.Update(templete);
            return _templeteDao.Insert(templete);
        }

        public IList<Templete> getList()
        {
            return _templeteDao.Getlist(new Templete());
        }

        public Templete getDefault()
        {
            return _templeteDao.getDefault();
        }

    }
}
