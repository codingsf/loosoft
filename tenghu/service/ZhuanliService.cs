using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;

using DataLinq;
using Cn.Loosoft.Zhisou.Tenghu.Common;
using LinqDAO;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
   public class ZhuanliService
    {
       private static ZhuanliService _instance;
        //private IDaoManager _daoManager = null;
        private ZhuanliDAO _zhuanliDao = null;

        private ZhuanliService()
        {
           // _daoManager = ServiceConfig.GetInstance().DaoManager;
          //  _zhuanliDao = _daoManager.GetDao(typeof(IZhuanli)) as IZhuanli;
            _zhuanliDao = new ZhuanliDAO();
        }

        public static ZhuanliService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new ZhuanliService();
            }
            return _instance;
        }

        public IList<Zhuanli> GetZhuanlis()
        {
            return _zhuanliDao.GetList();
        }

        public void Save(Zhuanli  zhuanli)
        {
            if (zhuanli.id > 0)
                 _zhuanliDao.Update(zhuanli);else
             _zhuanliDao.Insert(zhuanli);
        }

        public void Remove(int id)
        {
             _zhuanliDao.Remove(id);
        }
        public IList<Zhuanli> GetPage(Pager page)
        {
            return _zhuanliDao.GetPage(page);//, "zhuanli");
        }

        public Zhuanli Get(int id)
        {
            return _zhuanliDao.Get(id);
        }


    }
}
