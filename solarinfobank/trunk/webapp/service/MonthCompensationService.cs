using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class MonthCompensationService
    {
        private static MonthCompensationService _instance = new MonthCompensationService();
        private IDaoManager _daoManager = null;
        private IMonthCompensationDao _monthCompensationDao = null;

        private MonthCompensationService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _monthCompensationDao = _daoManager.GetDao(typeof(IMonthCompensationDao)) as IMonthCompensationDao;
        }

        public static MonthCompensationService GetInstance()
        {
            return _instance;
        }

        public int Save(MonthCompensation compensation)
        {
            if (compensation.id > 0)
                return _monthCompensationDao.Update(compensation);
            return _monthCompensationDao.Insert(compensation);
        }

    }
}
