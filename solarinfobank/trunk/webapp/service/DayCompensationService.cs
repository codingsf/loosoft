using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class DayCompensationService
    {
        private static DayCompensationService _instance = new DayCompensationService();
        private IDaoManager _daoManager = null;
        private IDayCompensationDao _dayCompensationDao = null;

        private DayCompensationService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _dayCompensationDao = _daoManager.GetDao(typeof(IDayCompensationDao)) as IDayCompensationDao;
        }

        public static DayCompensationService GetInstance()
        {
            return _instance;
        }

        public int Save(DayCompensation compensation)
        {
            if (compensation.id > 0)
                return _dayCompensationDao.Update(compensation);
            return _dayCompensationDao.Insert(compensation);
        }

    }
}
