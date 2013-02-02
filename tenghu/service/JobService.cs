using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Persistence;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
   public class JobService
    {
         private static JobService _instance;
        private IDaoManager _daoManager = null;
        private IJob _jobDao = null;

        private JobService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _jobDao = _daoManager.GetDao(typeof(IJob)) as IJob;
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
            return _jobDao.Getlist(new Job());
        }
        public Job Get(int id)
        {
            return _jobDao.Get(new Job() {  id=id});
        }


        public int Save(Job job)
        {
            if (job.id > 0)
                return _jobDao.Update(job);
            else
                return _jobDao.Insert(job);
        }

        public int Remove(int id)
        {
            return _jobDao.Remove(new Job() { id = id });
        }
        public IList<Job> GetPage(Pager page)
        {
            return _jobDao.GetPageList(page,"job");
        }
    }
}
