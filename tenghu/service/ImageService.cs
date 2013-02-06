using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using IBatisNet.DataAccess;
using DataLinq;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class ImageService
    {

        private static ImageService _instance;
        // private IDaoManager _daoManager = null;
        private LinqDAO.ImageDAO _imageDao = null;

        private ImageService()
        {
            _imageDao = new LinqDAO.ImageDAO();
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


        public void Save(Image image)
        {
            if (image.id > 0)
                _imageDao.Update(image);else
            _imageDao.Insert(image);
        }
        public void Remove(int id)
        {
            _imageDao.Remove(id);
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
