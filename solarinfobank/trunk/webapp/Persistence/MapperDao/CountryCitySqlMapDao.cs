using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class CountryCitySqlMapDao : BaseSqlDao<CountryCity>, ICountryCityDao
    {

        public IList<CountryCity> GetCities()
        {
            return ExecuteQueryForList<CountryCity>("cities_get_list", null);
        }



        public CountryCity GetCity(string city)
        {
            return ExecuteQueryForObject<CountryCity>("city_get", city);
        }

    }
}
