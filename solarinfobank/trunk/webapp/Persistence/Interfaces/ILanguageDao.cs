using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 语言接口
    /// Author: 赵文辉
    /// Time: 2011年3月21日
    /// </summary>
    public interface ILanguageDao : IBaseDao<Language>
    {
        //查询所有语言信息
        IList<Language> GetList();
        IList<Language> GetAllList();

        Language GetNameByLanguageId(int languageId);

    }
}
