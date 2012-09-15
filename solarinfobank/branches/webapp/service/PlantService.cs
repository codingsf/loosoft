using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 功能：电站信息服务
    /// 作者：张月
    /// 时间：2011年2月16日 16:25:52
    /// </summary>
    public class PlantService
    {
        PlantUnitService plantUnitService = PlantUnitService.GetInstance();  //电站单元服务 
        private static PlantService _instance = new PlantService();
        private IDaoManager _daoManager = null;
        private IPlantDao _plantInfo = null;

        private PlantService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _plantInfo = _daoManager.GetDao(typeof(IPlantDao)) as IPlantDao;
        }

        public static PlantService GetInstance()
        {
            return _instance;
        }
        /// <summary>
        /// 功能：获取所有电站信息集合
        /// </summary>
        /// <returns>返回：电站信息集合</returns>
        public IList<Plant> GetPlantInfoList()
        {
            return _plantInfo.GetPlantInfoList();
        }

        /// <summary>
        /// 获取指定数量的电站
        /// </summary>
        /// <returns></returns>
        public IList<Plant> GetNewPlantInfoList(int top)
        {
            return _plantInfo.GetPlantInfoList(top, "id desc");
        }

        /// <summary>
        /// 功能：根据id获取电站信息
        /// </summary>
        /// <param name="id">电站Id</param>
        /// <returns>返回电站实体</returns>
        public Plant GetPlantInfoById(int id)
        {
            return _plantInfo.Get(new Plant { id = id });
        }

        /// <summary>
        /// 功能：添加一个电站
        /// 描述：采集器没有对应一个电站
        /// </summary>
        /// <param name="plantInfo">电站实体</param>
        /// <returns>返回添加id</returns>
        public int AddPlantInfo(Plant plantInfo)
        {
            int res = _plantInfo.Insert(plantInfo);
            if (res > 0)
            {//创建系统报表
                ReportService.GetInstance().batchCreateSysRunReport(0, plantInfo.id);
                //给用户的电站用户集合增加一个用户
            }
            return res;
        }

        /// <summary>
        /// 功能：修改电站信息
        /// 描述：根据PlantInfo信息修改电站信息
        /// </summary>
        /// <param name="plantInfo">电站实体</param>
        /// <returns>1成功0没成功</returns>
        public int UpdatePlantInfo(Plant plantInfo)
        {
            return _plantInfo.Update(plantInfo);
        }
        /// <summary>
        /// 功能：根据id删除电站
        /// 描述：把该电站下的电站单元删除，在删除该电站
        /// 作者：张月
        /// 时间：2011年3月12日 16:29:36
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns>c成功与否</returns>
        public int DeletePlantById(int id)
        {
            plantUnitService.DeletePlantUnitByPlant(id);//根据电站id删除电站单元
            PlantUserService.GetInstance().DelPlantUserByPlantID(id);// 删除电站对应用户
            return _plantInfo.Remove(new Plant { id = id });
        }

        /// <summary>
        /// 功能：获取电站的个数
        /// </summary>
        /// <returns></returns>
        public int GetPlantNum()
        {
            return _plantInfo.GetPlantNum();
        }
        /// <summary>
        /// 功能：修改电站图片
        /// </summary>
        /// <param name="plant">电站实体</param>
        /// <returns></returns>
        public int ModifyPlantPic(Plant plant)
        {
            return _plantInfo.ModifyPlantPic(plant);
        }

        public IList<Plant> GetPlantByPage(Pager page)
        {
            return _plantInfo.GetPlantsByPage(page);
        }
        public IList<Plant> QueryPagePlants(Hashtable table)
        {
            return _plantInfo.QueryPagePlants(table);
        }
        public IList<Plant> Getplantlikepname(string name)
        {
            return _plantInfo.Getplantlikepname(name);
        }

        /// <summary>
        /// 按照名称取得电站
        /// add by qhb in 20120831
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public Plant GetplantByName(string name)
        {
            return _plantInfo.Getplantbyname(name);
        }

        public int Remove(int id)
        {
            Plant p = new Plant();
            return _plantInfo.Remove(new Plant() { id = id });
        }

        public double GetEnergy(Plant plant, string startyyyyMMdd, string endyyyyMMdd)
        {
            double returnValue = 0;
            if (plant == null || plant.plantUnits == null || plant.plantUnits.Count.Equals(0))
                return 0;
            foreach (PlantUnit pu in plant.plantUnits)
            {
                returnValue += CollectorInfoService.GetInstance().GetEnergy(pu.id, startyyyyMMdd, endyyyyMMdd);
            }

            return returnValue;

        }


        public int UpdataWarningLastSendTime(int pid, DateTime updateTime)
        {
            return _plantInfo.UpdataWarningLastSendTime(pid, updateTime);
        }

        /// <summary>
        /// 所有电站的总装机容量
        /// </summary>
        /// <returns></returns>
        public double getTotalPower() {
            IList<Plant> plants =  _plantInfo.GetPlantInfoList();
            double totalPower = 0;
            foreach (Plant plant in plants) {
                //如果没有绑定采集器就就不算在安装功率中
                if (plant.plantUnits == null || plant.plantUnits.Count < 1) continue;
                totalPower += plant.design_power;
            }
            return totalPower;
        }


        /// <summary>
        /// 取得电站的某天的性能
        /// </summary>
        /// <param name="plant"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="day"></param>
        /// <param name="dayEnergy"></param>
        /// <returns>已经转化为百分率了</returns>
        public double getDayPr(Plant plant, int year, int month, int day, double dayEnergy)
        {
            Device device = plant.getDetectorWithRenderSunshine();
            if (device == null) return 0;
            DeviceMonthDayData deviceYearmonth = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(year, device.id, month);
            float monthsunlingt = deviceYearmonth.getDayData(day);
            if (monthsunlingt == 0) return 0;
            float dp = plant.design_power == 0 ? 1 : plant.design_power;
            return (dayEnergy / monthsunlingt * 1000 * dp) * 100;
        }


        /// <summary>
        /// 取得电站的某月的性能
        /// </summary>
        /// <param name="plant"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="monthEnergy"></param>
        /// <returns>已经转化为百分率了</returns>
        public double getMonthPr(Plant plant, int year, int month, double monthEnergy)
        {
            Device device = plant.getDetectorWithRenderSunshine();
            if (device == null) return 0;
            DeviceYearMonthData deviceYearmonth = DeviceYearMonthDataService.GetInstance().GetDeviceYearMonthData(device.id, year);
            float monthsunlingt = deviceYearmonth.getMonthData(month);
            if (monthsunlingt == 0) return 0;
            float dp = plant.design_power == 0 ? 1 : plant.design_power;
            return monthEnergy / monthsunlingt * 1000 * dp;
        }
        /// <summary>
        /// 取得电站的某年的性能
        /// </summary>
        /// <param name="plant"></param>
        /// <param name="year"></param>
        /// <param name="yearEnergy"></param>
        /// <returns>已经转化为百分率了</returns>
        public double getYearPr(Plant plant, int year, double yearEnergy)
        {
            Device device = plant.getDetectorWithRenderSunshine();
            if (device == null) return 0;
            DeviceYearData deviceYearmonth = DeviceYearDataService.GetInstance().GetDeviceYearData(device.id, year);
            float monthsunlingt = deviceYearmonth.dataValue;
            if (monthsunlingt == 0) return 0;
            float dp = plant.design_power == 0 ? 1 : plant.design_power;
            return yearEnergy / monthsunlingt * 1000 * dp;
        }
    }
}