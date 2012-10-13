using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{

    public class EnergyYearMonthForecastService
    {

        private static EnergyYearMonthForecastService _instance = new EnergyYearMonthForecastService();
        private IDaoManager _daoManager = null;
        private IEnergyYearMonthForecastDao _energyYearMonthForecastDao = null;

        private EnergyYearMonthForecastService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _energyYearMonthForecastDao = _daoManager.GetDao(typeof(IEnergyYearMonthForecastDao)) as IEnergyYearMonthForecastDao;
        }

        public static EnergyYearMonthForecastService GetInstance()
        {
            return _instance;
        }

        public int Save(EnergyYearMonthForecast forecast)
        {
            if (forecast.id > 0)
                return _energyYearMonthForecastDao.Update(forecast);
            return _energyYearMonthForecastDao.Insert(forecast);
        }

        public IList<EnergyYearMonthForecast> GetList(int plantid)
        {
            return _energyYearMonthForecastDao.Getlist(new EnergyYearMonthForecast { plantId = plantid });
        }


        public int Remove(int id)
        {
            return _energyYearMonthForecastDao.Remove(new EnergyYearMonthForecast { id = id });
        }

    }
}
