using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.Tenghu.Domain;
using IBatisNet.DataAccess;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
   public class ProductService
    {
       
        private static ProductService _instance;
        private IDaoManager _daoManager = null;
        private IProduct _productDao = null;

        private ProductService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _productDao = _daoManager.GetDao(typeof(IProduct)) as IProduct;
        }

        public static ProductService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new ProductService();
            }
            return _instance;
        }


        public IList<Product> GetList()
        {
            return _productDao.Getlist(new Product());
        }


        public int Save(Product product)
        {
            if (product.id > 0)
                return _productDao.Update(product);
            return _productDao.Insert(product);
        }
        public int Remove(int id)
        {
            return _productDao.Remove(new Product() { id= id });
        }


        public Product Get(int id)
        {
            return _productDao.Get(new Product() { id=id });
        }

        public IList<Product> GetProductsCategory(int cid)
        {
            return _productDao.GetProductsCategory(cid);
        }

        public IList<Product> GetPage(Pager page)
        {
            return _productDao.GetPageList(page, "product");
        }


    }
}
