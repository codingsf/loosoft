using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 功能：宣传图片服务
    /// 作者：张月
    /// 时间：2011年4月22日 
    /// </summary>
    public class MailCofnigService
    {
        private static MailCofnigService _instance = new MailCofnigService();
        private IDaoManager _daoManager = null;
        private IMailConfigDao _mailDao = null;

        private MailCofnigService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _mailDao = _daoManager.GetDao(typeof(IMailConfigDao)) as IMailConfigDao;
        }

        public static MailCofnigService GetInstance()
        {
            return _instance;
        }
        public int Save(MailConfig config)
        {
            if (config.id > 0)
                return _mailDao.Update(config);
            else
                return _mailDao.Insert(config);
        }

        public IList<MailConfig> GetList()
        {
            return _mailDao.Getlist(new MailConfig());
        }

        public int Remove(int id)
        {
            return _mailDao.Remove(new MailConfig() { id=id });
        }

    
    }
}
