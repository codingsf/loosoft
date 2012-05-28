using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 登录记录dao接口
    /// author: qianhb
    /// since 20110919
    /// </summary>
    public interface ILoginRecordDao : IBaseDao<LoginRecord>
    {
        IList<LoginRecord> GetRecordsByPage(Hashtable page);
    }
}
