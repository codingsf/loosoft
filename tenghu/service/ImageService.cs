using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using IBatisNet.DataAccess;
using DataLinq;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
  public class ImageService
    {
      
        private static ImageService _instance;
        private IDaoManager _daoManager = null;
        private LinqDAO.ImageDAL _imageDao = null;

        private ImageService()
        {
            _imageDao = new LinqDAO.ImageDAL();
            //_daoManager = ServiceConfig.GetInstance().DaoManager;
           // _productDao = _daoManager.GetDao(typeof(IImage)) as IImage;
        }

        public static ImageService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new ImageService();
            }
            return _instance;
        }


        public IList<Image> GetList()
        {
            return _imageDao.GetList();
        }


        public int Save(Image image)
        {
            if (image.id > 0)
                return _imageDao.Update(image);
            return _imageDao.Insert(image);
        }
        public int Remove(int id)
        {
            return _imageDao.Remove(id);
        }


        public Image Get(int id)
        {
            return _imageDao.Get(id);
        }

        //public IList<Image> GetPage(Pager page)
        //{
        //    return _productDao.GetPageList(page, "image");
        //}

    }
}
