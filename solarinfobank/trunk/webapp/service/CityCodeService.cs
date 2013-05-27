using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Configuration;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class CityCodeService
    {
        private const string URL = "http://weather.yahooapis.com/forecastrss?w={0}&u=c";

        private static CityCodeService _instance;
        public static IList<CountryCity> codes = new List<CountryCity>();
        public static IDictionary<string, string> plantTemp = new Dictionary<string, string>();

        static CityCodeService()
        {
            codes = CountryCityService.GetInstance().GetCities();
        }

        public static CityCodeService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new CityCodeService();
            }
            return _instance;
        }

        public void SetCitiesCode(string fileName, List<CityCode> citiesCode)
        {
            XmlHelper.SerializerXML(fileName, citiesCode);
        }

        public static void GetCitiesCode(string fileName, ref List<CityCode> citiesCode)
        {
            XmlHelper.DeserializerXML(fileName, ref citiesCode);
        }

        public double GetTemperature(string city)
        {
            double temperature = double.NaN;
            if (city == null) return temperature;
            string mapValue = "";
            bool newget = false;
            if (plantTemp.ContainsKey(city))
            {
                mapValue = plantTemp[city];
                if (mapValue == null)
                {
                    newget = true;
                }
                else
                {
                    string[] arr = mapValue.Split(':');
                    if (arr[0].Equals(DateTime.Now.ToString("yyyyMMddHH")))
                    {
                        double t = double.NaN;
                        if(!"NaN".Equals(arr[1]))
                            double.TryParse(arr[1], out t);
                        temperature = t;
                    }
                    else
                    {
                        newget = true;
                    }
                }
            }
            else
            {
                newget = true;
            }

            if (newget)
            {
                try
                {
                    foreach (CountryCity code in codes)
                    {
                        if (code.name.Equals(city))
                        {
                            string temp = "";
                            if (!string.IsNullOrEmpty(code.weather_code))
                            {
                                temp = LoadingHtml(string.Format(URL, code.weather_code));
                                temp = Regex.Match(temp, "<yweather:condition  text=\".*?\"  code=\".*?\"  temp=\"(\\d+)\"  date=\".*?\" />").Groups[1].Value;
                            }
                            if (string.IsNullOrEmpty(temp))
                            {
                                temperature = double.NaN;
                            }
                            else
                            {
                                double.TryParse(temp, out temperature);

                            }
                            break;
                        }
                    }
                }
                catch
                {
                    temperature = double.NaN;
                }
                if (double.IsNaN(temperature))
                {
                    plantTemp[city] = DateTime.Now.ToString("yyyyMMddHH") + ":NaN";
                }
                else {
                    plantTemp[city] = DateTime.Now.ToString("yyyyMMddHH") + ":" + temperature;
                }
            }
            return temperature;
        }

        private static string LoadingHtml(string url)
        {
            HttpWebRequest defaultRequest = null;

            HttpWebResponse defaultResponse = null;
            StreamReader reader = null;

            defaultRequest = (HttpWebRequest)WebRequest.Create(url);
            defaultRequest.UserAgent = "Mozilla/5.0 (compatible)";
            defaultResponse = (HttpWebResponse)defaultRequest.GetResponse();
            string html = string.Empty;
            if (defaultResponse.StatusCode == HttpStatusCode.OK)
            {
                reader = new StreamReader(defaultResponse.GetResponseStream(), Encoding.Default);
                html = reader.ReadToEnd();
                reader.Dispose();
            }
            defaultResponse.Close();
            return html;
        }

    }
}
