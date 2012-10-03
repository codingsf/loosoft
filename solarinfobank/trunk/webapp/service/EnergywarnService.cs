using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using IBatisNet.DataAccess;
using System.Threading;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 生成发电量告警业务方法
    /// Author: 钱厚兵
    /// Time: 2012年09月29日
    /// </summary>
    public class EnergywarnService
    {
        //创建一个语言服务
        private static EnergywarnService energywarnService = new EnergywarnService();

        //定义一个内置接口
        private IDaoManager _daoManager = null;
        //定义一个语言接口
        private IEnergywarnDao _EnergywarnDao = null;

        /// <summary>
        /// 创建一个不带参的构造函数
        /// </summary>
        private EnergywarnService()
        {
            //获取采集器接口
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _EnergywarnDao = _daoManager.GetDao(typeof(IEnergywarnDao)) as IEnergywarnDao;
        }

        /// <summary>
        /// 创建一个语言服务
        /// </summary>
        /// <returns>采集器服务</returns>
        public static EnergywarnService GetInstance()
        {
            if (energywarnService == null)
            {
                energywarnService = new EnergywarnService();
            }
            return energywarnService;
        }

        /// <summary>
        /// 分页查找发电量告警
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        public IList<Energywarn> GetEnergywarnPage(Hashtable table)
        {
            return _EnergywarnDao.GetEnergywarnPage(table);
        }

        /// <summary>
        /// 生成发电量告警，每次只处理电站的设备上次处理日期的下一天的
        /// </summary>
        public void GenerateEnergywarn()
        {
            //先取出所有电站
            CacheService.GetInstance().flushCaches();
            IList<Plant> plants = PlantService.GetInstance().GetPlantInfoList();

            //循环灭个电站分别对其下面的逆变器设备进行处理
            int timezone = 0;//电站时区

            DeviceMonthDayData dmdd = null;
            foreach (Plant plant in plants)
            {
                timezone = plant.timezone;
                //如果该电站没有设置系数，那么不处理
                if (!plant.rateEnable)
                    continue;

                //找电站的发电量告警的最后处理日期，然后从其第二天进行处理
                DateTime waitHandleDate = DateTime.Now;
                if (plant.lastHandleDate.Year < 2012)
                { //表示以前没有处理过，那么处理时间从当当前电站时间的前一天
                    waitHandleDate = CalenderUtil.curBeforeDateWithTimeZone(plant.timezone);
                }
                else
                {
                    waitHandleDate = plant.lastHandleDate.AddDays(1);
                }

                //如果要处理的日期和电站时间比较，大于等于电站时间则不处理
                if (waitHandleDate >= CalenderUtil.curDateWithTimeZone(plant.timezone)) {
                    continue;
                }
                
                //找出电站非隐藏的逆变器
                IList<Device> devices = plant.typeDevices(DeviceData.INVERTER_CODE);

                //逐个判断逆变器设备是否有发电量比例告警，并将有告警的设备放入Hashtable中
                //首先取得电站设备的平均发电量
                double totalEnergy = 0;
                int deviceNum = 0;
                foreach (Device device in devices)
                {
                    try
                    {
                        dmdd = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(waitHandleDate.Year, device.id, waitHandleDate.Month);
                        totalEnergy += dmdd.getDayData(waitHandleDate.Day);
                        deviceNum++;
                    }
                    catch (Exception e) { 
                        
                    }
                }

                double aveageEnergy = 0;
                //有设备才计算平均值
                if (deviceNum > 0)
                {
                    aveageEnergy = totalEnergy / deviceNum;
                }

                //获取每个设备的发电量比率
                double rate = 0;
                Energywarn energywarn = null;
                foreach (Device device in devices)
                {
                    //
                    //并且设备的最后更新时间，小于要处理的日期，说明没有数据也无需处理
                    energywarn = new Energywarn();
                    energywarn.collectorId = device.collectorID;
                    energywarn.deviceId = device.id;

                    try
                    {
                        dmdd = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(waitHandleDate.Year, device.id, waitHandleDate.Month);
                        if (aveageEnergy == 0)
                            rate = 1;
                        else
                            rate = dmdd.getDayData(waitHandleDate.Day) / aveageEnergy;
                    }
                    catch (Exception e) {
                        continue;
                    }
                    //正常范围内不提示告警
                    if (Math.Abs(rate) > plant.energyRate && Math.Abs(rate) < plant.maxEnergyRate) continue;

                    rate = Math.Round(rate, 2);
                    if (Math.Abs(rate) <= plant.energyRate)
                        energywarn.factRate = rate + "/" + plant.energyRate;
                    else
                        energywarn.factRate = rate + "/" + plant.maxEnergyRate;

                    energywarn.factValue = Math.Round(dmdd.getDayData(waitHandleDate.Day), 2);
                    energywarn.downRate = plant.energyRate.Value;
                    energywarn.upRate = plant.maxEnergyRate.Value;
                    energywarn.warndate = waitHandleDate;
                    energywarn.averageValue = Math.Round(aveageEnergy,2);
                    //创建一笔告警日志，存库
                    _EnergywarnDao.Insert(energywarn);
                }
                //更新设备发电量告警日志随后处理时间为当前处理的日期
                plant.lastHandleDate = waitHandleDate;
                PlantService.GetInstance().Save(plant);
            }
        }
    }
}
