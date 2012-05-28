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
    /// <summary>
    /// 电站数据分布服务
    /// Author: 赵文辉
    /// Time: 2011年2月24日
    /// </summary>
    public class DbConfigService
    {
        //新创建一个电站数据分布服务
        private static DbConfigService _instance = new DbConfigService();
        //定义一个内置接口
        private IDaoManager _daoManager = null;
        //定义一个电站数据分布接口
        private IDbConfigDao _dbconfigDao = null;

        /// <summary>
        /// 创建一个不带参的构造函数
        /// </summary>
        private DbConfigService()
        {
            //获取采集器接口
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _dbconfigDao = _daoManager.GetDao(typeof(IDbConfigDao)) as IDbConfigDao;
        }

        /// <summary>
        /// 创建电站数据分布服务
        /// </summary>
        /// <returns>服务对象</returns>
        public static DbConfigService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new DbConfigService();
            }
            return _instance;
        }

        /// <summary>
        /// 添加一条电站数据分布信息
        /// </summary>
        /// <param name="dbconfig">电站数据分布服务字段</param>
        public void Add(Dbconfig dbconfig)
        {
            _dbconfigDao.Insert(dbconfig);
        }

        /// <summary>
        /// 根据条件删除电站数据分布
        /// </summary>
        /// <param name="dbconfig">删除条件</param>
        /// <returns>是否删除成功</returns>
        public int Delete(Dbconfig dbconfig)
        {
            return _dbconfigDao.Remove(dbconfig);
        }

        /// <summary>
        /// 根据条件修改电站数据分布
        /// </summary>
        /// <param name="dbconfig">修改条件</param>
        public void Update(Dbconfig dbconfig)
        {
            _dbconfigDao.Update(dbconfig);
        }

        public Dbconfig GetDbcongifById(int Id)
        {
            return _dbconfigDao.GetDbconfigById(Id);
        }

        /// <summary>
        /// 查询所有电站数据分布信息
        /// </summary>
        /// <returns>所有电站数据分布信息</returns>
        public IList<Dbconfig> GetDbcongifs()
        {
            return _dbconfigDao.GetDbconfigs();
        }

        public void Delete(int id)
        {
            _dbconfigDao.Delete(id);
        }

        public Dbconfig Get(Dbconfig config)
        {
            return _dbconfigDao.Get(config);
        }

        public int Save(Dbconfig config)
        {
            if (config.id > 0)
                return _dbconfigDao.Update(config);
            else
                return _dbconfigDao.Insert(config);
        }
    }
}
