using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 语言实现
    /// Author: 赵文辉
    /// Time: 2011年3月21日
    /// </summary>
    public class LanguageSqlMapDao : BaseSqlDao<Language>, ILanguageDao
    {
        //查询所有语言信息
        public IList<Language> GetList()
        {
            return ExecuteQueryForList<Language>("language_get_list", null);
        }

        #region ILanguageDao 成员


        public IList<Language> GetAllList()
        {
            return ExecuteQueryForList<Language>("language_get_all_list", null);
            
        }

        #endregion

        //根据语言编号查询语言名称
        public Language GetNameByLanguageId(int languageId)
        {
            return (Language)ExecuteQueryForObject("language_get_by_id", languageId);
        }
    }
}
