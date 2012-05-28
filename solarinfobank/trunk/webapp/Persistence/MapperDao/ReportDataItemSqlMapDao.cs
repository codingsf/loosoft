using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class ReportDataItemSqlMapDao : BaseSqlDao<ReportDataItem>, IReportDataItemDao
    {

        #region IDataItemDao 成员

        public IList<ReportDataItem> GetDataItemList(Pager page)
        {
            page.RecordCount = (int)ExecuteQueryForObject("loading_dataitem_page_count", page);
            return ExecuteQueryForList<ReportDataItem>("loading_dataitem_page_list", page);
        }
        public int UpdateItemEnabled(string id,int enabled)
        {
            Hashtable table = new Hashtable();
            table.Add("code", id);
            table.Add("enabled", enabled);

            return ExecuteUpdate("dataitem_update",table);
        }
        #endregion

        #region IDataItemDao 成员


        public IList<ReportDataItem> GetEnabledDataItemList()
        {
            return ExecuteQueryForList<ReportDataItem>("get_enabled_dataitem_list",null);
        }

        public IList<ReportDataItem> GetUnEnabledDataItemList()
        {
            return ExecuteQueryForList<ReportDataItem>("get_unenabled_dataitem_list", null);
        }

        #endregion
    }
}
