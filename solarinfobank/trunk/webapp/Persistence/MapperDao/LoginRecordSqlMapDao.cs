using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;

using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 功能：实现登录记录接口
    /// 作者：qianhb
    /// 时间：2011年09月19日 10:41:23
    /// </summary>
    public class LoginRecordSqlMapDao : BaseSqlDao<LoginRecord>, ILoginRecordDao
    {
        public IList<LoginRecord> GetRecordsByPage(Hashtable page)
        {
            Pager pg = page["page"] as Pager;
            pg.RecordCount = (int)ExecuteQueryForObject("loading_loginrecord_page_count", page);
            return ExecuteQueryForList<LoginRecord>("loading_loginrecord_page_list", page);
        }

    }
}
