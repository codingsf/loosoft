using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 功能：宣传图片接口
    /// 作者：张月
    /// 时间：2011年4月22日 
    /// </summary>
    public interface IAdpic : IBaseDao<Adpic>
    {
        /// <summary>
        /// 获取所有的宣传图片列表
        /// </summary>
        /// <returns></returns>
        IList<Adpic> GetAdpicPage(Pager page);
        /// <summary>
        /// 根据语言获取所有图片
        /// </summary>
        /// <param name="adpic"></param>
        /// <returns></returns>
        IList<Adpic> GetAdpicByLanguage(Adpic adpic);
    }
}
