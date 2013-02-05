using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Persistence;
using DataLinq;
using Cn.Loosoft.Zhisou.Tenghu.Common;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class JobService
    {
        private static JobService _instance;
        //   private IDaoManager _daoManager = null;
        // private IJob _jobDao = null;
        LinqDAO.JobDAL _jobDao = null;
        private JobService()
        {
            _jobDao = new LinqDAO.JobDAL();
            //  _daoManager = ServiceConfig.GetInstance().DaoManager;
            //  _jobDao = _daoManager.GetDao(typeof(IJob)) as IJob;
        }

        public static JobService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new JobService();
            }
            return _instance;
        }

        public IList<Job> GetJobs()
        {
            return _jobDao.GetList();
        }
        public Job Get(int id)
        {
            return _jobDao.Get(id);
        }


        public void Save(Job job)
        {
            if (job.id > 0)
                 _jobDao.Update(job);
            else
                 _jobDao.Insert(job);
        }

        public void Remove(int id)
        {
             _jobDao.Remove(id);
        }
        public IList<Job> GetPage(Pager page)
        {
            return _jobDao.GetPage(page);
        }
    }
}
