﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.Tenghu.Domain;
namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class CategoryService
    {
        private static CategoryService _instance;
        private IDaoManager _daoManager = null;
        private ICategory _categoryDao = null;

        private CategoryService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _categoryDao = _daoManager.GetDao(typeof(ICategory)) as ICategory;
        }

        public static CategoryService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new CategoryService();
            }
            return _instance;
        }


        public IList<Category> GetList()
        {
            return _categoryDao.Getlist(new Category());
        }

        public Category Get(int id)
        {
            return _categoryDao.Get(new Category() {  id=id});
        }

        public IList<Category> GetList(string  cid)
        {
            return _categoryDao.GetList(cid);
        }

        public int Save(Category category)
        {
            if (category.id > 0)
                return _categoryDao.Update(category);
            else
                return _categoryDao.Insert(category);
        }

        public int Remove(int id)
        {
            return _categoryDao.Remove(new Category() { id=id });
        }

    }
}