using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class ReportConfigSqlMapDao : BaseSqlDao<ReportConfig>, IReportConfigDao
    {

        #region IReportConfigDao 成员

        public void SendEventReport(ReportConfig report)
        {
             ExecuteInsert("reportconfig_insert",report);
        }
        public ReportConfig GetReportConfigByReportId(int rid)
        {
         return  (ReportConfig) ExecuteQueryForObject("reportconfig_get", rid);
         
        }
        #endregion

        #region IReportConfigDao 成员


        public void UPdateReportConfig(ReportConfig config)
        {
             ExecuteUpdate("reportconfig_update",config);
        }

        #endregion

        #region IReportConfigDao 成员


        public IList<ReportConfig> GetEventReportConfigs()
        {
            return ExecuteQueryForList<ReportConfig>("get_event_report_configs", null);
        }

        #endregion

        #region IReportConfigDao 成员


        public void DeleteReportConfig(int id)
        {
            ExecuteDelete("delete_event_report_by_reportId",id);
        }

        #endregion

        #region IReportConfigDao 成员


        public void UpdateEventReport(ReportConfig config)
        {
            if (config.id > 0)
                ExecuteUpdate("update_event_report", config);
            else
                ExecuteInsert("insert_event_report",config);
        }

        #endregion

        #region IReportConfigDao 成员


        public ReportConfig GetEventReportByReportIdAndId(int id)
        {
            return (ReportConfig)ExecuteQueryForObject("get_event_report_config_by_id",id);
        }

        #endregion
    }
}
