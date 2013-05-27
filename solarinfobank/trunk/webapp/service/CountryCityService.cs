using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class CountryCityService
    {
        private static CountryCityService _instance = new CountryCityService();
        private IDaoManager _daoManager = null;
        private ICountryCityDao _countryCityDao = null;
        private CountryCityService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _countryCityDao = _daoManager.GetDao(typeof(ICountryCityDao)) as ICountryCityDao;
        }

        public static CountryCityService GetInstance()
        {
            return _instance;
        }

        public int Save(CountryCity city)
        {
            int res=0;
            if (city.id > 0)
                res =  _countryCityDao.Update(city);
            else
                res =  _countryCityDao.Insert(city);

            //add by hbqian in 201305012 for修改城市后天气服务的静态城市列表能重新生效
            CityCodeService.codes = this.GetCities();
            //重新取天气
            if (!string.IsNullOrEmpty(city.name))
            {
                if (CityCodeService.plantTemp.ContainsKey(city.name))
                {
                    CityCodeService.plantTemp.Remove(city.name);
                }
            }
            return res;
        }

        public IList<CountryCity> GetList()
        {
            return _countryCityDao.Getlist(new CountryCity());
        }

        public IList<CountryCity> GetCities()
        {
            return _countryCityDao.GetCities();
        }

        public CountryCity Get(CountryCity cc)
        {
            return _countryCityDao.Get(cc);
        }

        public int Remove(int id)
        {
            return _countryCityDao.Remove(new CountryCity() { id = id });
        }

        public CountryCity GetCity(string city)
        {
            return _countryCityDao.GetCity(city);
        }

    }
}
