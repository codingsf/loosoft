using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using IBatisNet.Common.Pagination;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class ReportConfigService
    {
        private static ReportConfigService _instance = new ReportConfigService();
        private IDaoManager _daoManager = null;
        private IReportConfigDao _reportConfigDao = null;

        private ReportConfigService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _reportConfigDao = _daoManager.GetDao(typeof(IReportConfigDao)) as IReportConfigDao;
        }

        public static ReportConfigService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new ReportConfigService();
            }
            return _instance;
        }

      
        public void SendEventReport(ReportConfig config)
        {
            _reportConfigDao.SendEventReport(config);
        }

        public ReportConfig GetReportConfigByReportId(int id)
        {
            return _reportConfigDao.GetReportConfigByReportId(id);
        }
        public void UpdateReportConfig(ReportConfig config)
        {
             _reportConfigDao.UPdateReportConfig(config);
        }

        public IList<ReportConfig> GetEventReportConfigs()
        {
            return _reportConfigDao.GetEventReportConfigs();
        }
        public void DeleteReportConfigByReportId(int id)
        {
            _reportConfigDao.DeleteReportConfig(id);
        }
        public void UpdateEventReport(ReportConfig config)
        {
          _reportConfigDao.UpdateEventReport(config);
        }
        /// <summary>
        /// 根据报告配置报表Id和报表Id获取事件报表对象
        /// </summary>
        /// <param name="id">报告配置报表Id</param>
        /// <returns></returns>
        public ReportConfig GetEventReportConfigByIdAndReportId(int id)
        {
            return _reportConfigDao.GetEventReportByReportIdAndId(id);
        }

    }
}
