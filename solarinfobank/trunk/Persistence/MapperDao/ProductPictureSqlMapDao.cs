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
    /// 功能：产品图片实现类
    /// 作者：张月
    /// 时间：2011年4月22日 
    /// </summary>
    public class ProductPictureSqlMapDao : BaseSqlDao<ProductPicture>, IProductPictureDao
    {
        /// <summary>
        /// 获取所有的产品图片
        /// </summary>
        /// <returns></returns>
        public IList<ProductPicture> GetProductPicturePage(Pager page)
        {
            page.RecordCount = (int)ExecuteQueryForObject("loading_productpictures_page_count", page);
            return ExecuteQueryForList<ProductPicture>("loading_productpictures_page_list", page);
        }


        #region IProductPictureDao 成员


        public IList<ProductPicture> GetAllProductPicture()
        {
            return ExecuteQueryForList<ProductPicture>("productpicture_get_list", null);
        }

        #endregion
    }
}
