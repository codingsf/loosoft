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
        public void generateEnergywarn()
        {
            //先取出所有电站
            IList<Plant> plants = PlantService.GetInstance().GetPlantInfoList();
            generateEnergywarn(plants);
        }

        public void generateEnergywarn(IList<Plant> plants)
        {

            //循环每个电站分别对其下面的逆变器设备进行处理
            foreach (Plant plant in plants)
            {
                generateEnergywarn(plant);
            }
        }

        public void generateEnergywarn(Plant plant)
        {
            int timezone = plant.timezone;
            //如果该电站没有设置系数，那么不处理
            if (!plant.rateEnable)
                return;

            DeviceMonthDayData dmdd = null;
            //找电站的发电量告警的最后处理日期，然后从其第二天进行处理
            DateTime waitHandleDate = plant.lastHandleDate;
            DateTime plantTime = CalenderUtil.curDateWithTimeZone(plant.timezone);
            //如果上一次处理的时间和电站是同一天那么就要小时来间隔处理了
            if (waitHandleDate.Year == plantTime.Year && waitHandleDate.Month == plantTime.Month && waitHandleDate.Day == plantTime.Day)
            {
                waitHandleDate = plantTime;
            }
            else
            {
                //上次处理时间和电站时间比较，如果不是昨天就置为昨天，就是只计算最近两天的
                if (!plantTime.AddDays(-1).ToString("yyyyMMdd").Equals(waitHandleDate.ToString("yyyyMMdd")))
                {
                    waitHandleDate = plantTime.AddDays(-1);
                }else{
                    waitHandleDate = waitHandleDate.AddDays(1);
                }
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
                catch (Exception e)
                {

                }
            }

            //电站平均kwp发电量
            double avgRate = plant.design_power == 0 ? 0 : totalEnergy / plant.design_power;

            if (avgRate > 0)
            {
                //获取每个设备的发电量比率
                double rate = 0;
                double bizhi = 1;
                Energywarn energywarn = null;
                string warndate = waitHandleDate.ToString("yyyy-MM-dd");
                foreach (Device device in devices)
                {
                    energywarn = _EnergywarnDao.get(device.id, warndate);
                    if (energywarn == null)
                        energywarn = new Energywarn();

                    energywarn.deviceId = device.id;
                    try
                    {
                        dmdd = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(waitHandleDate.Year, device.id, waitHandleDate.Month);
                        ///rate = dmdd.getDayData(waitHandleDate.Day) / aveageEnergy;
                        rate = device.designPower == 0 ? 0 : dmdd.getDayData(waitHandleDate.Day) / device.designPower;
                    }
                    catch (Exception e)
                    {
                        continue;
                    }

                    bizhi = avgRate == 0 ? 0 : rate / avgRate;
                    //正常范围内不提示告警
                    if (bizhi < plant.maxEnergyRate && bizhi > plant.energyRate)
                    {
                        //上传当前设备已经生成过的发电量告警
                        if (energywarn.id > 0)
                            _EnergywarnDao.Remove(energywarn);
                        continue;
                    }

                    if (Math.Abs(rate) > plant.energyRate && Math.Abs(rate) < plant.maxEnergyRate) continue;

                    bizhi = Math.Round(bizhi, 2);
                    if (bizhi <= plant.energyRate)
                        energywarn.factRate = bizhi + "/" + plant.energyRate;
                    else
                        energywarn.factRate = bizhi + "/" + plant.maxEnergyRate;

                    energywarn.factValue = Math.Round(rate, 2);
                    energywarn.downRate = plant.energyRate.Value;
                    energywarn.upRate = plant.maxEnergyRate.Value;
                    energywarn.warndate = warndate;
                    energywarn.averageValue = Math.Round(avgRate, 2);
                    //创建一笔告警日志，存库
                    if (energywarn.id > 0)
                        _EnergywarnDao.Update(energywarn);
                    else
                        _EnergywarnDao.Insert(energywarn);
                }
            }
            //更新设备发电量告警日志随后处理时间为当前处理的日期
            plant.lastHandleDate = waitHandleDate;
            PlantService.GetInstance().Save(plant);
        }
    }
}
