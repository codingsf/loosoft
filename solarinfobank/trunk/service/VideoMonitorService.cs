using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao;

using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class VideoMonitorService
    {
        private static VideoMonitorService _instance = new VideoMonitorService();
        private IDaoManager _daoManager = null;
        private IVideoMonitorDao _monitorDao = null;

        private VideoMonitorService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _monitorDao = _daoManager.GetDao(typeof(IVideoMonitorDao)) as IVideoMonitorDao;
        }

        public static VideoMonitorService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new VideoMonitorService();
            }
            return _instance;
        }

        public VideoMonitor Get(int id)
        {
            return _monitorDao.Get(new VideoMonitor() { id = id });
        }
        public IList<VideoMonitor> GetList( VideoMonitor monitor)
        {
            return _monitorDao.Getlist(monitor);
        }

        public void Delete(int key)
        {
            _monitorDao.Remove(new VideoMonitor() { id = key });
        }

        public void Save(VideoMonitor monitor)
        {
            if (monitor.id > 0)
                _monitorDao.Update(monitor);
            else
                _monitorDao.Insert(monitor);
        }

    }
}
