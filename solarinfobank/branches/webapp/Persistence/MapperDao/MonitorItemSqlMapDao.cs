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
    /// <summary>
    /// 测点持久化ibatis实现类
    /// Author: 赵文辉
    /// Time: 2011年2月18日 15:00:37  第一次修改
    /// </summary>
    public class MonitorItemSqlMapDao : BaseSqlDao<MonitorItem>, IMonitorItemDao
    {
        #region IMonitorItemlDao 成员

        public IList<MonitorItem> GetlistByHas(Hashtable has)
        {
            return ExecuteQueryForList<MonitorItem>("GetMonitorItemsByHas", has);
        }



        public IList<int> GetlistStats()
        {
            return ExecuteQueryForList<int>("GetMonitorItemsStats", null);
        }


        #endregion

        #region IMonitorItemDao 成员


        public IList<MonitorItem> GetMonitorItemsByPage(Pager page)
        {
            page.RecordCount = (int)ExecuteQueryForObject("loading_monitoritem_page_count", page);
            return ExecuteQueryForList<MonitorItem>("loading_monitoritem_page_list", page);
        }

        #endregion
    }
}
