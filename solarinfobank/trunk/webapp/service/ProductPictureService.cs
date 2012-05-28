using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 功能：产品图片服务
    /// 作者：张月
    /// 时间：2011年4月22日 
    /// </summary>
    public class ProductPictureService
    {
        ProductPictureService productPictureService = ProductPictureService.GetInstance();  //电站单元服务 
        private static ProductPictureService _instance = new ProductPictureService();
        private IDaoManager _daoManager = null;
        private IProductPictureDao _productpicture = null;

        private ProductPictureService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _productpicture = _daoManager.GetDao(typeof(IProductPictureDao)) as IProductPictureDao;
        }

        public static ProductPictureService GetInstance()
        {
            return _instance;
        }
        /// <summary>
        /// 根据id获取电站
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ProductPicture GetProductPicture(int id)
        {
            return _productpicture.Get(new ProductPicture {id=id });
        }
        /// <summary>
        /// 获取所有的产品图片
        /// </summary>
        /// <returns></returns>
        public IList<ProductPicture> GetProductPicturePage(Pager table)
        {
            return _productpicture.GetProductPicturePage(table);
        }
        /// <summary>
        /// 修改产品图片信息
        /// </summary>
        /// <param name="productPicture">产品图片实体</param>
        /// <returns></returns>
        public int ModifyProductPicture(ProductPicture productPicture)
        {
            return _productpicture.Update(productPicture);
        }
        /// <summary>
        /// 添加产品图片信息
        /// </summary>
        /// <param name="productPicture">产品图片实体</param>
        /// <returns></returns>
        public int AddProductPicture(ProductPicture productPicture)
        {
            return _productpicture.Insert(productPicture);
        }
        /// <summary>
        /// 删除产品图片
        /// </summary>
        /// <param name="productPicture">产品图片实体</param>
        /// <returns></returns>
        public int DelProductPicture(int id)
        {
            return _productpicture.Remove(new ProductPicture { id = id});
        }

        public IList<ProductPicture> GetAllProductPicture()
        {
            return _productpicture.GetAllProductPicture();
        }
    }
}
