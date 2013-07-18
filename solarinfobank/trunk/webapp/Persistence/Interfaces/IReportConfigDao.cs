using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface IReportConfigDao : IBaseDao<ReportConfig>
    {
        void SendEventReport(ReportConfig report);
        ReportConfig GetReportConfigByReportId(int id);
        void UPdateReportConfig(ReportConfig config);
        void UPdateReportLastSendTime(ReportConfig config);
        IList<ReportConfig> GetEventReportConfigs();
        void DeleteReportConfig(int id);
        void UpdateEventReport(ReportConfig config);
        ReportConfig GetEventReportByReportIdAndId(int id);

    }
}
