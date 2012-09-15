using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class CompensationService
    {
        private static CompensationService _instance = new CompensationService();
        private IDaoManager _daoManager = null;
        private ICompensationDao _compensationDao = null;

        private CompensationService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _compensationDao = _daoManager.GetDao(typeof(ICompensationDao)) as ICompensationDao;
        }

        public static CompensationService GetInstance()
        {
            return _instance;
        }

        public int Save(Compensation compensation)
        {
            if (compensation.id > 0)
                return _compensationDao.Update(compensation);
            return _compensationDao.Insert(compensation);
        }

        public IList<Compensation> getList()
        {
            return _compensationDao.Getlist(new Compensation());
        }

        public IList<Compensation> searchCompensation(Hashtable table)
        {
            return _compensationDao.searchCompensation(table);
        }

        public int Remove(int id)
        {
            return _compensationDao.Remove(new Compensation { id = id });
        }
    }
}
