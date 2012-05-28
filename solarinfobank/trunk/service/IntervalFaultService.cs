using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 告警日志服务
    /// Author: 陈波
    /// Time: 2011年2月17日 15:48:19
    /// </summary>
    public class IntervalFaultService
    {
        private static IntervalFaultService _faultService = new IntervalFaultService();
        private IDaoManager _daoManager = null;
        private IFaultDao _faultDao = null;

        private IntervalFaultService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _faultDao = _daoManager.GetDao(typeof(IFaultDao)) as IFaultDao;
        }

        public static IntervalFaultService GetInstance()
        {
            return _faultService;
        }

        public IList<Fault> GetEventReportLogs(string cids, DateTime lastModified)
        {
            Hashtable table = new Hashtable();
            table.Add("year", DateTime.Now.Year);
            table.Add("cids", cids);
            table.Add("lastModified", lastModified);
            return _faultDao.GetEventReportLogs(table);
        }


        public IList<Fault> GetPlantLoglist(Hashtable page)
        {
            _faultDao.LoadingPageCount(page);
            return _faultDao.Getlist(page);
        }




    }
}
