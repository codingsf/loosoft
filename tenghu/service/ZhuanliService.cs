using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
   public class ZhuanliService
    {
       private static ZhuanliService _instance;
        private IDaoManager _daoManager = null;
        private IZhuanli _zhuanliDao = null;

        private ZhuanliService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _zhuanliDao = _daoManager.GetDao(typeof(IZhuanli)) as IZhuanli;
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
            return _zhuanliDao.Getlist(new Zhuanli());
        }

        public int Save(Zhuanli  zhuanli)
        {
            if (zhuanli.id > 0)
                return _zhuanliDao.Update(zhuanli);
            return _zhuanliDao.Insert(zhuanli);
        }

        public int Remove(int id)
        {
            return _zhuanliDao.Remove(new Zhuanli () { id = id });
        }
        public IList<Zhuanli> GetPage(Pager page)
        {
            return _zhuanliDao.GetPageList(page, "zhuanli");
        }

        public Zhuanli Get(int id)
        {
            return _zhuanliDao.Get(new Zhuanli() { id = id });
        }


    }
}
