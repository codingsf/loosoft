using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class RelationConfigService
    {
        private static RelationConfigService _instance = new RelationConfigService();
        private IDaoManager _daoManager = null;
        private IRelationConfigDao _relationConfigDao = null;


        private RelationConfigService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _relationConfigDao = _daoManager.GetDao(typeof(IRelationConfigDao)) as IRelationConfigDao;
        }

        public static RelationConfigService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new RelationConfigService();
            }

            return _instance;
        }

        public int Save(RelationConfig config)
        {
            if (config.id > 0)
                return _relationConfigDao.Update(config);
            if (string.IsNullOrEmpty(config.config5))
                config.config5 = string.Empty;
            return _relationConfigDao.Insert(config);
        }

        public RelationConfig GetConfig(int uid, int relationId, int relationType, string name)
        {
            return _relationConfigDao.GetConfig(new RelationConfig { uid = uid, relationId = relationId, relationType = relationType, config5 = name });
        }
    }
}
