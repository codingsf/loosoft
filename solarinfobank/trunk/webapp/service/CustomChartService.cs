/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月11日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common; 

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class CustomChartService
    {

        private static CustomChartService _instance;
        private IDaoManager _daoManager = null;
        private ICustomChartDao _CustomReportDao = null;

        private CustomChartService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _CustomReportDao = _daoManager.GetDao(typeof(ICustomChartDao)) as ICustomChartDao;
        }

        public static CustomChartService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new CustomChartService();
            }
            return _instance;
        }

        /// <summary>
        /// 插入自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public int Insert(CustomChart customReport)
        {
            return _CustomReportDao.Insert(customReport);

        }

        /// <summary>
        /// 插入自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public int Remove(CustomChart customReport)
        {
            return _CustomReportDao.Remove(customReport);

        }



        /// <summary>
        /// 修改自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public int Update(CustomChart customReport)
        {
            return _CustomReportDao.Update(customReport);
        }

        /// <summary>
        /// 取得用户的所有配置
        /// </summary>
        /// <returns>设备表ID</returns>
        public IList<CustomChart> Getlist(int userId, int groupid)
        {
            CustomChart CustomChart = new CustomChart();
            CustomChart.userId = userId;
            CustomChart.groupId = groupid;
            return _CustomReportDao.Getlist(CustomChart);
        }
      /// <summary>
        /// 取得用户的所有配置
        /// </summary>
        /// <returns>设备表ID</returns>
        public IList<CustomChart> GetListOutGroup(int userId)
        {
            return _CustomReportDao.GetListOutGroup(userId);
        }
        
            /// <summary>
        /// 取得用户的所有配置
        /// </summary>
        /// <returns>设备表ID</returns>
        public IList<CustomChart> GetListByGroup(int userId,int Groupid)
        {
            return _CustomReportDao.GetListByGroup(userId,Groupid);
        }


        /// <summary>
        /// 取得用户的所有配置
        /// </summary>
        /// <returns>设备表ID</returns>
        public IList<CustomChart> GetListByPlant(int plantID)
        {
            return _CustomReportDao.GetListByPlant(plantID);
        }
        /// <summary>
        /// 取得用户的所有配置
        /// </summary>
        /// <returns>设备表ID</returns>
        public void Delete(int groupid)
        {
            _CustomReportDao.Delete(groupid);
        }

        /// <summary>
        /// 修改自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public CustomChart Get(CustomChart customReport)
        {
                return _CustomReportDao.Get(customReport);
        }
        


        //public string GetCustomChart(CustomReport crt)
        //{
        //    string ret;

        //    if (crt != null)
        //    {
        //        if (crt.productType.Trim().ToLower().Equals("plant"))//电站
        //        {
        //            if (crt.valueType.Trim().Equals(ComConst.Monitor_Energy))//电量
        //            {
        //                if (crt.timeInterval.Equals("YEAR"))///年年数据
        //                {
        //                    ret = PlantChartService.GetInstance().TotalEnergyChartByPlant(plant, crt.subType);
        //                }
        //                else if (crt.timeInterval.Equals("MONTH"))///年数据
        //                {
        //                    ret = PlantChartService.GetInstance().YearMMEnergyChartByPlant(plant, DateTime.Now.AddYears(-crt.tcounter).Year, crt.subType);
        //                }
        //                else if (crt.timeInterval.Equals("DAY"))///月数据
        //                {
        //                    ret = PlantChartService.GetInstance().MMDDEnergyChartByPlant(plant, DateTime.Now.AddYears(-crt.tcounter).Year, DateTime.Now.AddYears(-crt.tcounter).Month, crt.subType);
        //                }
        //                else if (crt.timeInterval.Equals("HOUR"))///月数据
        //                {
        //                    DateTime dt0 = DateTime.Now;
        //                    DateTime dt = DateTime.Now.AddDays(-crt.tcounter);
        //                    ret = PlantChartService.GetInstance().PlantPowerChart(plant, dt.Year.ToString("0000") + dt.Month.ToString("00") + dt.Day.ToString("00"), dt0.Year.ToString("0000") + dt0.Month.ToString("00") + dt0.Day.ToString("00"), crt.subType);
        //                }
        //            }
        //            else if (crt.valueType.Trim().Equals(ComConst.Monitor_Power))//功率
        //            {
        //                DateTime dt0 = DateTime.Now;
        //                DateTime dt = new DateTime();

        //                if (crt.timeSlot.Equals("YEAR"))///年年数据
        //                {
        //                    dt = DateTime.Now.AddYears(-crt.tcounter);
        //                }
        //                else if (crt.timeSlot.Equals("MONTH"))///年数据
        //                {
        //                    dt = DateTime.Now.AddMonths(-crt.tcounter);
        //                }
        //                else if (crt.timeSlot.Equals("DAY"))///月数据
        //                {
        //                    dt = DateTime.Now.AddDays(-crt.tcounter);
        //                }
        //                else if (crt.timeSlot.Equals("HOUR"))///月数据
        //                {
        //                    dt = DateTime.Now.AddHours(-crt.tcounter);
        //                }
        //                ret = PlantChartService.GetInstance().PlantPowerChart(plant, dt.Year.ToString("0000") + dt.Month.ToString("00") + dt.Day.ToString("00"), dt0.Year.ToString("0000") + dt0.Month.ToString("00") + dt0.Day.ToString("00"), crt.subType);
        //            }
        //        }
        //        else
        //            if (crt.productType.Trim().ToLower().Equals("plant"))//电站
        //            {
        //                if (crt.valueType.Trim().Equals(ComConst.Monitor_Energy))//电量
        //                {
        //                    if (crt.timeInterval.Equals("YEAR"))///年年数据
        //                    {
        //                        ret = PlantChartService.GetInstance().TotalEnergyChartByPlant(plant, crt.subType);
        //                    }
        //                    else if (crt.timeInterval.Equals("MONTH"))///年数据
        //                    {
        //                        ret = PlantChartService.GetInstance().YearMMEnergyChartByPlant(plant, DateTime.Now.AddYears(-crt.tcounter).Year, crt.subType);
        //                    }
        //                    else if (crt.timeInterval.Equals("DAY"))///月数据
        //                    {
        //                        ret = PlantChartService.GetInstance().MMDDEnergyChartByPlant(plant, DateTime.Now.AddYears(-crt.tcounter).Year, DateTime.Now.AddYears(-crt.tcounter).Month, crt.subType);
        //                    }
        //                    else if (crt.timeInterval.Equals("HOUR"))///月数据
        //                    {
        //                        DateTime dt0 = DateTime.Now;
        //                        DateTime dt = DateTime.Now.AddDays(-crt.tcounter);
        //                        ret = PlantChartService.GetInstance().PlantPowerChart(plant, dt.Year.ToString("0000") + dt.Month.ToString("00") + dt.Day.ToString("00"), dt0.Year.ToString("0000") + dt0.Month.ToString("00") + dt0.Day.ToString("00"), crt.subType);
        //                    }
        //                }
        //                else if (crt.valueType.Trim().Equals(ComConst.Monitor_Power))//功率
        //                {
        //                    DateTime dt0 = DateTime.Now;
        //                    DateTime dt = new DateTime();

        //                    if (crt.timeSlot.Equals("YEAR"))///年年数据
        //                    {
        //                        dt = DateTime.Now.AddYears(-crt.tcounter);
        //                    }
        //                    else if (crt.timeSlot.Equals("MONTH"))///年数据
        //                    {
        //                        dt = DateTime.Now.AddMonths(-crt.tcounter);
        //                    }
        //                    else if (crt.timeSlot.Equals("DAY"))///月数据
        //                    {
        //                        dt = DateTime.Now.AddDays(-crt.tcounter);
        //                    }
        //                    else if (crt.timeSlot.Equals("HOUR"))///月数据
        //                    {
        //                        dt = DateTime.Now.AddHours(-crt.tcounter);
        //                    }
        //                    ret = PlantChartService.GetInstance().PlantPowerChart(plant, dt.Year.ToString("0000") + dt.Month.ToString("00") + dt.Day.ToString("00"), dt0.Year.ToString("0000") + dt0.Month.ToString("00") + dt0.Day.ToString("00"), crt.subType);
        //                }
        //            }
        //    }
        
        
        
        //}

    }
}
