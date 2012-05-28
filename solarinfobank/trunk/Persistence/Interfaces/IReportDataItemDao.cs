using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface IReportDataItemDao : IBaseDao<ReportDataItem>
    {
        IList<ReportDataItem> GetDataItemList(Pager page);
        int UpdateItemEnabled(string id, int enabled);
        IList<ReportDataItem> GetEnabledDataItemList();
        IList<ReportDataItem> GetUnEnabledDataItemList();
    }
}
