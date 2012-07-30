using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class ErrorcodeService
    {
        private static ErrorcodeService _instance = new ErrorcodeService();
        private IDaoManager _daoManager = null;
        private IErrorcodeDao _errorcodeDao = null;

        private ErrorcodeService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _errorcodeDao = _daoManager.GetDao(typeof(IErrorcodeDao)) as IErrorcodeDao;
        }

        public static ErrorcodeService GetInstance()
        {
            return _instance;
        }

        public IList<Errorcode> GetList()
        {
            return _errorcodeDao.Getlist(new Errorcode());
        }

        public int Remove(int id)
        {
            return _errorcodeDao.Remove(new Errorcode { id = id });
        }

        public Errorcode Get(int id)
        {
            return _errorcodeDao.Get(new Errorcode { id = id });
        }

        public int Save(Errorcode errorCode)
        {
            if (errorCode.id > 0)
                return _errorcodeDao.Update(errorCode);
            return _errorcodeDao.Insert(errorCode);
        }

    }
}
