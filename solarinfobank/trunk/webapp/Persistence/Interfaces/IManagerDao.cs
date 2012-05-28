using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 网站管理员接口
    /// Author: 陈波
    /// Time: 2011年2月25日 
    /// </summary>
    public interface IManagerDao : IBaseDao<Manager>
    {
        /// <summary>
        /// 根据用户名和密码查询用户是否存在
        /// </summary>
        /// <param name="manager">管理员字段</param>
        /// <returns>管理员对象</returns>
        Manager GetManagerByUsername(string username);

        /// <summary>
        /// 判断管理员是否锁定
        /// </summary>
        /// <returns>管理员信息</returns>
        Manager GetManagerByLocked(string username);


        IList<Manager> GetManagersByPara(Hashtable table);
    }
}
