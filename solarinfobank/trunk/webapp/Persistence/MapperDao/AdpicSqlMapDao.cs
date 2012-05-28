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
    /// 功能：宣传图片实现类
    /// 作者：张月
    /// 时间：2011年4月22日 
    /// </summary>
    public class AdpicSqlMapDao : BaseSqlDao<Adpic>, IAdpic
    {
        /// <summary>
        /// 获取所有的宣传图片
        /// </summary>
        /// <returns></returns>
        public IList<Adpic> GetAdpicPage(Pager page)
        {
            page.RecordCount = (int)ExecuteQueryForObject("loading_adpics_page_count", page);
            return ExecuteQueryForList<Adpic>("loading_adpics_page_list", page);
        }
        /// <summary>
        /// 根据语言获取所有图片
        /// </summary>
        /// <param name="adpic"></param>
        /// <returns></returns>
        public IList<Adpic> GetAdpicByLanguage(Adpic adpic)
        {
            return ExecuteQueryForList<Adpic>("adpic_get_by_language", adpic);

        }
    }
}
