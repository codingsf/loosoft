using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 用户角色,用用户角色实体代替用户和角色的关联关系表
    /// </summary>
    [Serializable]
    public class UserRole
    {
        public int id { get; set; }
        public int userId { get; set; }
        /// <summary>
        /// 用户对应的角色id
        /// </summary>
        public int roleId { get; set; }
        /// <summary>
        /// 用户对应的角色对象
        /// </summary>
        public Role role { get; set; }

        /// <summary>
        /// 用户角色对应的角色权限，从role对象里面取得
        /// </summary>
        public IList<RoleFunction> roleFunctions
        {
            get
            {
                return this.role.roleFunctions;
            }
        }

        /// <summary>
        /// 判断用户对应角色是否运行功能代码操作，调用角色对象方法返回
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public bool isDeny(int code)
        {
            return role.isDeny(code);
        }
    }
}