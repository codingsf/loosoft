using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 网站管理员接口实现
    /// Author: 陈波
    /// Time: 2011年2月25日 
    /// </summary>
    public class ManagerSqlMapDao : BaseSqlDao<Manager> , IManagerDao
    {
        /// <summary>
        /// 根据用户名取得管理员
        /// </summary>
        /// <param name="username"></param>
        /// <returns>管理员</returns>
        public Manager GetManagerByUsername(string username)
        {
            return ExecuteQueryForObject<Manager>("manager_get_byusername", username);
        }

        /// <summary>
        /// 判断管理员是否锁定
        /// </summary>
        /// <returns>管理员信息</returns>
        public Manager GetManagerByLocked(string username)
        {
            return ExecuteQueryForObject<Manager>("manager_get_bylocked", username);
        }

        #region IManagerDao 成员


        public IList<Manager> GetManagersByPara(Hashtable table)
        {
            return ExecuteQueryForList<Manager>("manager_get_list_para", table);
        }

        #endregion
    }
}
