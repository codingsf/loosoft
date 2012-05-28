using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 测点业务类
    /// 作者：houbing.qian
    /// </summary>
    public class MonitorItemService
    {
        private static MonitorItemService _instance = new MonitorItemService();
        private IDaoManager _daoManager = null;
        private IMonitorItemDao _monitorItemDao = null;

        private MonitorItemService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _monitorItemDao = _daoManager.GetDao(typeof(IMonitorItemDao)) as IMonitorItemDao;
        }

        public static MonitorItemService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new MonitorItemService();
            }
            return _instance;
        }

        public IList<MonitorItem> GetList()
        {
            return _monitorItemDao.Getlist(new MonitorItem());
        }

        public IList<int> GetlistStats()
        {
            return _monitorItemDao.GetlistStats();
        }

        public IList<MonitorItem> GetlistByHas(Hashtable has )
        {
            return _monitorItemDao.GetlistByHas(has);
        }

        public void Delete(string code)
        {
            _monitorItemDao.Remove(new MonitorItem() { code = code });
        }


        public MonitorItem Get(string code)
        {
            return _monitorItemDao.Get(new MonitorItem() { code = code });
        }

        /// <summary>
        /// 保存设备型号
        /// </summary>
        /// <param name="deviceModel"></param>
        /// <returns></returns>
        public int Save(MonitorItem monitorItem)
        {
            MonitorItem tmp = _monitorItemDao.Get(monitorItem);
            if (tmp != null)
            {
                return _monitorItemDao.Update(monitorItem);
            }
            else
                return _monitorItemDao.Insert(monitorItem);

        }


        public IList<MonitorItem> GetMonitorItemsByPage(Pager page)
        {
            return _monitorItemDao.GetMonitorItemsByPage(page);
        }
    }
}
