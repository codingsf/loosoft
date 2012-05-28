using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class ProtalService
    {
        private static ProtalService _instance = new ProtalService();
        private IDaoManager _daoManager = null;
        private IProtalDao _protalDao = null;

        private ProtalService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _protalDao = _daoManager.GetDao(typeof(IProtalDao)) as IProtalDao;
        }

        public static ProtalService GetInstance()
        {
            return _instance;
        }

        public int Save(Protal protal)
        {
            if (protal.id > 0)
                return _protalDao.Update(protal);
            return _protalDao.Insert(protal);
        }

        /// <summary>
        /// 取得某个用户的创建的门户
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public Protal GetByUser(int uid)
        {
            return _protalDao.Get(new Protal { uid = uid });
        }

    }
}
