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
    /// 语言服务
    /// Author: 赵文辉
    /// Time: 2011年3月21日
    /// </summary>
    public class LanguageService
    {
        //创建一个语言服务
        private static LanguageService languageservice = new LanguageService();
        //定义一个内置接口
        private IDaoManager _daoManager = null;
        //定义一个语言接口
        private ILanguageDao _lanaguageDao = null;

        /// <summary>
        /// 创建一个不带参的构造函数
        /// </summary>
        private LanguageService()
        {
            //获取采集器接口
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _lanaguageDao = _daoManager.GetDao(typeof(ILanguageDao)) as ILanguageDao;
        }


        /// <summary>
        /// 创建一个语言服务
        /// </summary>
        /// <returns>采集器服务</returns>
        public static LanguageService GetInstance()
        {
            if (languageservice == null)
            {
                languageservice = new LanguageService();
            }
            return languageservice;
        }

        /// <summary>
        /// 查询所有语言信息
        /// </summary>
        /// <returns></returns>
        public IList<Language> GetList()
        {
            return _lanaguageDao.GetList();
        }

        public IList<Language> GetAllList()
        {
            return _lanaguageDao.GetAllList();
        }
        public Language Get(int id)
        {
            return _lanaguageDao.Get(new Language() { id = id });
        }
        public int Save(Language language)
        {
            if (language.id > 0)
                return _lanaguageDao.Update(language);
            else
                return _lanaguageDao.Insert(language);

        }

        /// <summary>
        /// 根据语言编号查询语言名称
        /// </summary>
        /// <param name="languageId">语言编号</param>
        /// <returns></returns>
        public Language GetNameByLanguageId(int languageId)
        {
            return _lanaguageDao.GetNameByLanguageId(languageId);
        }



    }
}
