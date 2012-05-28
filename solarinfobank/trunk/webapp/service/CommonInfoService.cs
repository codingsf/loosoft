using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class CommonInfoService
    {
        private static CommonInfoService _instance = new CommonInfoService();
        private IDaoManager _daoManager = null;
        private ICommonInfoDao _commonInfoDao = null;

        private CommonInfoService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _commonInfoDao = _daoManager.GetDao(typeof(ICommonInfoDao)) as ICommonInfoDao;
        }

        public static CommonInfoService GetInstance()
        {
            return _instance;
        }

        public int Save(CommonInfo info)
        {
            if (info.id > 0)
                return _commonInfoDao.Update(info);
            return _commonInfoDao.Insert(info);
        }

        public IList<CommonInfo> GetList(CommonInfo info)
        {
            return _commonInfoDao.Getlist(info);
        }

        public int Remove(int id)
        {
            return _commonInfoDao.Remove(new CommonInfo() {  id= id});
        }


        public CommonInfo Get(int id)
        {
            return _commonInfoDao.Get(new CommonInfo() { id = id });
        }


    }
}
