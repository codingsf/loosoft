using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 登录记录业务类
    /// </summary>
    public class LoginRecordService
    {
        private static LoginRecordService _instance;
        private IDaoManager _daoManager = null;
        private ILoginRecordDao _loginRecordDao = null;
        private static Hashtable loginRecordCodeIdHash = new Hashtable();
        private LoginRecordService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _loginRecordDao = _daoManager.GetDao(typeof(ILoginRecordDao)) as ILoginRecordDao;
        }

        public static LoginRecordService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new LoginRecordService();
            }
            return _instance;
        }

        /// <summary>
        /// 保持登录记录
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="username"></param>
        /// <param name="ip"></param>
        /// <returns></returns>
        public int Save(int userId, string username, string ip, float localZone)
        {
            return this.Save(new LoginRecord() { ip = ip, userId = userId, username = username, loginTime = DateTime.Now, localZone = localZone });
        }

        /// <summary>
        /// 保持登录记录
        /// </summary>
        /// <param name="loginRecord"></param>
        /// <returns></returns>
        public int Save(LoginRecord loginRecord)
        {
            //LoginRecord tmp = _loginRecordDao.Get(loginRecord);
            //if (tmp != null)
            //{
            // return _loginRecordDao.Update(loginRecord);
            //}
            // else
            return _loginRecordDao.Insert(loginRecord);
        }

        public IList<LoginRecord> LoginRecords(int uid)
        {
            return _loginRecordDao.Getlist(new LoginRecord() { userId = uid });
        }


        public IList<LoginRecord> GetRecordsByPage(Hashtable page)
        {
            return _loginRecordDao.GetRecordsByPage(page);
        }
    }
}
