using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common.vo;
using System.Threading;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 将数据同步的memcached
    /// </summary>
    public class SynDataService
    {
        private static SynDataService _instance = new SynDataService();

        private SynDataService()
        {
        }

        public static SynDataService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 启动时开始同步工作，用于bankweb程序
        /// </summary>
        public void startupforWeb() {
            //首先同步所有电站
            synPlant();
        }

        /// <summary>
        /// 启动时开始同步工作，用于bank解析程序
        /// </summary>
        public void startupforAnalyze()
        {
            //首先同步所有电站
            synPlant();
            synRunData();
        }

        /// <summary>
        /// 同步实时数据工作
        /// </summary>
        public void synRunData()
        {
            //定时实时数据
            synPlantRunData();
        }

        /// <summary>
        /// 将bank所有电站同步到缓存
        /// 1、启动系统时同步一次
        /// 2、每次有电站新增，修改、和删除时需要再同步一次
        /// </summary>
        public void synPlant()
        {
            IList<Plant> plants = PlantService.GetInstance().GetPlantInfoList();
            IList<SimplePlantVO> plantVoList = new List<SimplePlantVO>();
            SimplePlantVO vo = null;
            foreach (Plant plant in plants) {
                vo = new SimplePlantVO();
                vo.plantId = plant.id;
                vo.plantName = plant.name;
                plantVoList.Add(vo);
            }

            MemcachedClientSatat.getInstance().Set(SynCacheKeyUtil.buildPlantListKey(), plantVoList);
        }

        /// <summary>
        /// 将bank所有电站实时数据同步到缓存
        /// 1、定时同步
        /// </summary>
        public void synPlantRunData()
        {
            IList<Plant> plants = PlantService.GetInstance().GetPlantInfoList();
            IList<PlantVO> plantVoList = new List<PlantVO>();
            PlantVO vo = null;
            foreach (Plant plant in plants)
            {
                vo = new PlantVO();
                vo.CQ2reduce = plant.Reductiong.ToString();
                vo.CQ2reduceUnit = plant.ReductiongUnit;
                vo.curPower = plant.TodayTotalPower.ToString();
                vo.curPowerUnit = "kW";
                vo.dayEnergy = plant.DisplayTotalDayEnergy.ToString();
                vo.dayEnergyUnit = plant.TotalDayEnergyUnit;
                IList<int> workYears = CollectorYearDataService.GetInstance().GetWorkYears(new List<Plant>() { plant });
                vo.logCount = FaultService.GetInstance().getNewLogNums(new List<Plant>() { plant }, workYears);
                vo.plantId = plant.id;
                vo.plantName = plant.name;
                vo.solarIntensity = plant.Sunstrength.ToString();
                vo.solarIntensityUnit = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_LINGT_CODE).unit;

                double t = plant.Temperature;
                User user = UserService.GetInstance().Get((int)plant.userID);
                if (t == 0)
                {
                    CityCodeService codeService = CityCodeService.GetInstance();
                    t = codeService.GetTemperature(plant.city);
                    if (double.IsNaN(t))
                    {
                        t = 0;
                    }
                }
                if (user != null && user.TemperatureType!=null && !user.TemperatureType.ToLower().Equals("c"))
                {
                    t = (32 + (t * 1.8));
                }
                vo.temprature = t.ToString();
                vo.tempratureUnit = user.TemperatureType==null?"c".ToUpper():user.TemperatureType.ToUpper();
                vo.totalEnergy = plant.DisplayTotalEnergy.ToString();
                vo.totalEnergyUnit = plant.TotalEnergyUnit.ToString();
                //vo.imageArray = "http://" + Request.Url.Authority + "/ufile/" + (string.IsNullOrEmpty(plant.onePic) ? "Nopic/nopico02.gif" : plant.onePic);
                vo.DesignPower = plant.design_power + " kWp";
                vo.Country = plant.country;
                vo.City = plant.city;
                vo.organize = user.organize;
                vo.installDate = plant.installdate.ToString("yyyy-MM-dd");

                MemcachedClientSatat.getInstance().Set(SynCacheKeyUtil.buildPlantRunDataKey(vo.plantId), vo);
            }
        }
    }
}
