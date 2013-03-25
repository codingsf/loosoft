using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 角色
    /// 系统先约定义好
    /// Browse User 电站浏览着
    /// Power Station Maintenance User 电站一般维护人员
    /// System Administrator 电站管理员 能删除电站，添加人员等
    /// 用户创建电站后默认角色就是系统管理员
    /// </summary>
    [Serializable]
    public class Role
    {
        //角色预定义
        /// <summary>
        /// 系统管理员
        /// </summary>
        public static int ROLE_SYSMANAGER = 3;
        /// <summary>
        /// 电站维护人员
        /// </summary>
        public static int ROLE_MAINTAINER = 2;
        /// <summary>
        /// 电站浏览人员
        /// </summary>
        public static int ROLE_LOOKER = 1;
        private int _id;
        public int id
        {
            get { return _id; }
            set { _id = value; }
        }
        private string _name;
        /// <summary>
        /// 角色名称
        /// </summary>
        public string name
        {
            get { return _name; }
            set { _name = value; }
        }
        private string _descr;
        /// <summary>
        /// 角色名称
        /// </summary>
        public string descr
        {
            get { return _descr; }
            set { _descr = value; }
        }
        /// <summary>
        /// 角色显示名称，取自资源文件
        /// </summary>
        public string displayName
        {
            get
            {
                return LanguageUtil.getDesc(string.Format("USER_ROLE_{0}", id));
            }
        }
        /// <summary>
        /// 角色的创建者
        /// </summary>
        public int uid { get; set; }

        private IList<RoleFunction> _roleFunctions;
        /// <summary>
        /// 角色对应的功能
        /// </summary>
        public IList<RoleFunction> roleFunctions
        {
            set { _roleFunctions = value; }
            get { return _roleFunctions; }
        }
        /// <summary>
        /// 判断该角色是否允许功能码的操作
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public bool isDeny(int code)
        {
            if (roleFunctions == null)
            {
                return false;
            }
            else
            {
                foreach (RoleFunction function in roleFunctions)
                {
                    if (function.functionCode.Equals(code))
                        return true;
                }
                return false;
            }
        }

    }
}