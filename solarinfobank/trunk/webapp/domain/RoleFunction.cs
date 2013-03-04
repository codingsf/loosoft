using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 角色权限功能，用带roleId外键代替用关系表做role和function的对应关系设置
    /// </summary>
    [Serializable]
    public class RoleFunction
    {
        private int _id;
        public int id
        {
            get { return _id; }
            set { _id = value; }
        }
        private int _roleId;
        /// <summary>
        /// 功能所属角色id
        /// </summary>
        public int roleId
        {
            get { return _roleId; }
            set { _roleId = value; }
        }
        private int _functionCode;
        /// <summary>
        /// 功能代码
        /// </summary>
        public int functionCode
        {
            get { return _functionCode; }
            set { _functionCode = value; }
        }
    }
}