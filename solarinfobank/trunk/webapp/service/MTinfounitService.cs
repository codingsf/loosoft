using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class MTinfounitService
    {
        private static MTinfounitService _instance = new MTinfounitService();
        private IDaoManager _daoManager = null;
        private IMTinfounitDao _mtinfoUnitDao = null;

        private MTinfounitService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _mtinfoUnitDao = _daoManager.GetDao(typeof(IMTinfounitDao)) as IMTinfounitDao;
        }

        public static MTinfounitService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new MTinfounitService();
            }
            return _instance;
        }

        public int Save(MTinfounit entity)
        {
            if (entity.id > 0)
                return _mtinfoUnitDao.Update(entity);
            return _mtinfoUnitDao.Insert(entity);
        }

        public IList<MTinfounit> GetList()
        {
            return _mtinfoUnitDao.Getlist(new MTinfounit());
        }


        public MTinfounit Get(int id)
        {
            return _mtinfoUnitDao.Get(new MTinfounit { id = id });
        }


        public int Delete(int id)
        {
            return _mtinfoUnitDao.Remove(new MTinfounit { id = id });
        }
    }
}
