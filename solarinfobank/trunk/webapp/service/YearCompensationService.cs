using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class YearCompensationService
    {
        private static YearCompensationService _instance = new YearCompensationService();
        private IDaoManager _daoManager = null;
        private IYearCompensationDao _yearCompensationDao = null;

        private YearCompensationService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _yearCompensationDao = _daoManager.GetDao(typeof(IYearCompensationDao)) as IYearCompensationDao;
        }

        public static YearCompensationService GetInstance()
        {
            return _instance;
        }

        public int Save(YearCompensation compensation)
        {
            if (compensation.id > 0)
                return _yearCompensationDao.Update(compensation);
            return _yearCompensationDao.Insert(compensation);
        }

    }
}
