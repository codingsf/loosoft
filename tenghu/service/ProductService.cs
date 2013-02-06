using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using IBatisNet.DataAccess;
using LinqDAO;
using DataLinq;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class ProductService
    {

        private static ProductService _instance;
        //    private IDaoManager _daoManager = null;
        private ProductDAO _productDao = null;

        private ProductService()
        {
            //  _daoManager = ServiceConfig.GetInstance().DaoManager;
            // _productDao = _daoManager.GetDao(typeof(IProduct)) as IProduct;
            _productDao = new ProductDAO();
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
            return _productDao.GetList();
        }


        public void Save(Product product)
        {
            if (product.id > 0)
                _productDao.Update(product);
            _productDao.Insert(product);
        }
        public void Remove(int id)
        {
            _productDao.Remove(id);
        }


        public Product Get(int id)
        {
            return _productDao.Get(id);
        }

        public IList<Product> GetProductsCategory(int cid)
        {
            return _productDao.GetProductsCategory(cid);
        }

        public IList<Product> GetPage(Pager page)
        {
            return _productDao.GetPageList(page);
        }


    }
}
