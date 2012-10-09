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

    public class TemplateService
    {

        private static TemplateService _instance = new TemplateService();
        private IDaoManager _daoManager = null;
        private ITemplateDao _templateDao = null;

        private TemplateService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _templateDao = _daoManager.GetDao(typeof(ITemplateDao)) as ITemplateDao;
        }

        public static TemplateService GetInstance()
        {
            return _instance;
        }


        public int Save(Template template)
        {
            if (template.id > 0)
                return _templateDao.Update(template);
            return _templateDao.Insert(template);
        }

        public IList<Template> getList()
        {
            return _templateDao.Getlist(new Template());
        }

        public Template getDefault()
        {
            return _templateDao.getDefault();
        }

    }
}
