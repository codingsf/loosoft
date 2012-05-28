using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class ElecPriceService
    {
        private static ElecPriceService _instance = new ElecPriceService();
        private IDaoManager _daoManager = null;
        private IElecPriceDao _elecPriceDao = null;

        private ElecPriceService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _elecPriceDao = _daoManager.GetDao(typeof(IElecPriceDao)) as IElecPriceDao;
        }

        public static ElecPriceService GetInstance()
        {
            return _instance;
        }

        public int Insert(ElecPrice eprice)
        {
            return _elecPriceDao.Insert(eprice);
        }

    }
}
