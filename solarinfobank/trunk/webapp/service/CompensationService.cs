﻿
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 发电量补偿设置业务类
    /// author:chenbo
    /// since:20120920
    /// </summary>
    public class CompensationService
    {
        private static CompensationService _instance = new CompensationService();
        private IDaoManager _daoManager = null;
        private ICompensationDao _compensationDao = null;

        private CompensationService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _compensationDao = _daoManager.GetDao(typeof(ICompensationDao)) as ICompensationDao;
        }

        public static CompensationService GetInstance()
        {
            return _instance;
        }

        public int Save(Compensation compensation)
        {
            if (compensation.id > 0)
                return _compensationDao.Update(compensation);

            IList<Compensation> compensations = _compensationDao.getCompensations(compensation.plantid, compensation.isplant, compensation.type, compensation.year.ToString(), compensation.month.ToString());

            if (compensation.day > 0 && compensations.Count > 0)
            {
                var compen = compensations.Where(m => m.day.Equals(compensation.day)).FirstOrDefault<Compensation>();
                if (compen != null)
                    _compensationDao.Remove(compen);
            }
            if (compensations.Count > 0 && compensation.day == 0)
                foreach (Compensation comp in compensations)
                    _compensationDao.Remove(comp);
            return _compensationDao.Insert(compensation);
        }

        /// <summary>
        /// 设置发电量补偿效果，将设置的发电量添加补偿对象中
        /// 给具体补偿对象根据补偿类型进行发电量补偿
        /// </summary>
        private void addEnergy(Compensation compensation)
        {
            //取得补偿对象
            if (compensation.isplant)//电站补偿对象
            {

            }
            else
            {

            }
        }

        /// <summary>
        /// 设置发电量补偿效果，将设置的发电量从补偿对象剔除
        /// 给具体补偿对象根据补偿类型进行发电量补偿
        /// </summary>
        private void reduceEnergy(Compensation compensation)
        {

        }

        public IList<Compensation> getList()
        {
            return _compensationDao.Getlist(new Compensation());
        }

        public IList<Compensation> searchCompensation(Hashtable table)
        {
            return _compensationDao.searchCompensation(table);
        }

        public int Remove(int id)
        {
            return _compensationDao.Remove(new Compensation { id = id });
        }

        /// <summary>
        /// 取得电站某个月份天发电量补偿
        /// </summary>
        /// <param name="plant"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public IList<Compensation> getPlantDayCompensations(int plantId, string year, string month)
        {
            return _compensationDao.getCompensations(plantId, true, Compensation.TYPE_DAY, year, month);
        }

        /// <summary>
        /// 取得电站某个年份所有月度天发电量补偿
        /// </summary>
        /// <param name="plant"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public IList<Compensation> getPlantMonthCompensations(int plantId, string year)
        {
            return _compensationDao.getCompensations(plantId, true, Compensation.TYPE_MONTH, year, null);
        }

        /// <summary>
        /// 取得电站某个所有年份发电量补偿
        /// </summary>
        /// <param name="plant"></param>
        /// <returns></returns>
        public IList<Compensation> getPlantYearCompensations(int plantId)
        {
            return _compensationDao.getCompensations(plantId, true, Compensation.TYPE_YEAR, null, null);
        }

        /// <summary>
        /// 取得电站某个所有年份发电量补偿
        /// </summary>
        /// <param name="plant"></param>
        /// <returns></returns>
        public double getPlantTotalCompensations(int plantId)
        {
            double total = 0;
            foreach (Compensation com in _compensationDao.getCompensations(plantId, true, Compensation.TYPE_TOTAL, null, null))
            {
                total += com.dataValue;
            }
            return total;
        }


        /// <summary>
        /// 取得设备某个月份天发电量补偿
        /// </summary>
        /// <param name="device"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public IList<Compensation> getDeviceDayCompensations(int deviceId, string year, string month)
        {
            return _compensationDao.getCompensations(deviceId, true, Compensation.TYPE_DAY, year, month);
        }

        /// <summary>
        /// 取得设备某个年份所有月度天发电量补偿
        /// </summary>
        /// <param name="device"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public IList<Compensation> getDeviceMonthCompensations(int deviceId, string year)
        {
            return _compensationDao.getCompensations(deviceId, true, Compensation.TYPE_MONTH, year, null);
        }

        /// <summary>
        /// 取得设备某个所有年份发电量补偿
        /// </summary>
        /// <param name="plant"></param>
        /// <returns></returns>
        public IList<Compensation> getDeviceYearCompensations(int deviceId)
        {
            return _compensationDao.getCompensations(deviceId, true, Compensation.TYPE_YEAR, null, null);
        }
    }
}