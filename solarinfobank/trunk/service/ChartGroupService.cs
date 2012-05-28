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
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class ChartGroupService
    {

        private static ChartGroupService _instance;
        private IDaoManager _daoManager = null;
        private IChartGroupDao _ReportGroupDao = null;

        private ChartGroupService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _ReportGroupDao = _daoManager.GetDao(typeof(IChartGroupDao)) as IChartGroupDao;
        }

        public static ChartGroupService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new ChartGroupService();
            }
            return _instance;
        }

        /// <summary>
        /// 插入自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public int Insert(ChartGroup customReport)
        {
            return _ReportGroupDao.Insert(customReport);

        }

        /// <summary>
        /// 插入自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public int Remove(ChartGroup customReport)
        {
            return _ReportGroupDao.Remove(customReport);
        }



        /// <summary>
        /// 修改自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public int Update(ChartGroup customReport)
        {
            return _ReportGroupDao.Update(customReport);

        }

        /// <summary>
        /// 修改自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public ChartGroup Get(ChartGroup customReport)
        {
            return _ReportGroupDao.Get(customReport);
        }
        /// <summary>
        /// 修改自定义报表
        /// </summary>
        /// <returns>设备表ID</returns>
        public IList<ChartGroup> GetReportGroupList(int userId)
        {
            Hashtable has = new Hashtable();
            has.Add("userId", userId);
            return _ReportGroupDao.GetReportGroupList(has);
        }
    }
}
