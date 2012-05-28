using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
   public class EmailQueueService
    {
       
        private static EmailQueueService _instance;
        private IDaoManager _daoManager = null;
        private IEmailQueueDao _emailQueueDao = null;

        private EmailQueueService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _emailQueueDao = _daoManager.GetDao(typeof(IEmailQueueDao)) as IEmailQueueDao;
        }

        public static EmailQueueService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new EmailQueueService();
            }
            return _instance;
        }
        public bool Save(EmailQueue email)
        {
            if (email.id > 0)
                return _emailQueueDao.Update(email) > 0;
            else
                return _emailQueueDao.Insert(email) > 0;
        }
    }
}
