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
    /// 功能：产品图片接口
    /// 作者：张月
    /// 时间：2011年4月22日 
    /// </summary>
    public interface IProductPictureDao:IBaseDao<ProductPicture>
    {
        /// <summary>
        /// 获取所有的产品图片列表
        /// </summary>
        /// <returns></returns>
        IList<ProductPicture> GetProductPicturePage(Pager page);
        IList<ProductPicture> GetAllProductPicture();
    }
}
