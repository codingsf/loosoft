using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
  public class ImageService
    {
      
        private static ImageService _instance;
        private IDaoManager _daoManager = null;
        private IImage _productDao = null;

        private ImageService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _productDao = _daoManager.GetDao(typeof(IImage)) as IImage;
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
            return _productDao.Getlist(new Image());
        }


        public int Save(Image image)
        {
            if (image.id > 0)
                return _productDao.Update(image);
            return _productDao.Insert(image);
        }
        public int Remove(int id)
        {
            return _productDao.Remove(new Image() { id = id });
        }


        public Image Get(int id)
        {
            return _productDao.Get(new Image() { id = id });
        }

        public IList<Image> GetPage(Pager page)
        {
            return _productDao.GetPageList(page, "image");
        }

    }
}
