using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;

using DataLinq;
using LinqDAO;
namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class CategoryService
    {
        private static CategoryService _instance;
        //private IDaoManager _daoManager = null;
        // private ICategory _categoryDao = null;

        private CategoryService()
        {
            // _daoManager = ServiceConfig.GetInstance().DaoManager;
            // _categoryDao = _daoManager.GetDao(typeof(ICategory)) as ICategory;
        }

        public static CategoryService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new CategoryService();
            }
            return _instance;
        }

        CategoryDAO _categoryDao = new CategoryDAO();
        public IList<Category> GetList()
        {
            return _categoryDao.GetList().Where(m => m.pid == null).ToList<Category>() ;
        }

        public Category Get(int id)
        {
           return _categoryDao.Get(id);
        }

        public IList<Category> GetList(int  cid)
        {
            return _categoryDao.GetList(cid);
        }

        public void Save(Category category)
        {
            if (category.id > 0)
                _categoryDao.Update(category);
            else
                _categoryDao.Insert(category);
        }

        public void Remove(int id)
        {
            _categoryDao.Remove(id);
        }

    }
}
