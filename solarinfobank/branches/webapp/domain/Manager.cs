using System;
using System.Collections.Generic;
using Cn.Loosoft.Zhisou.SunPower.Common;
namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：网站管理员实体类型
    /// 作者：陈波
    /// 时间：2011-2-25
    /// </summary>
    /// 
    [Serializable]
    public class Manager
    {
        public const int COLLECTOR_USER = 1;//采集器生成人员
        public const int COLLECTOR_ADMIN = 0;//管理员
        public Manager() { }
        public Manager(int id)
        {
            this.id = id;
        }
        public int id { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public string fullname { get; set; }
        public string department { get; set; }
        public string email { get; set; }
        public bool locked { get; set; }
        public int type { get; set; }
        public DateTime create_date { get; set; }
        public IList<AdminUserRole> roles { get; set; }
        /// <summary>
        /// 解密后的密码
        /// </summary>
        public string depassword
        {
            get
            {
                return EncryptUtil.DecryptDES(this.password, EncryptUtil.defaultKey);
            }
        }

        public IList<AdminControllerAction> denyActions
        {
            get
            {
                IList<AdminControllerAction> deny = new List<AdminControllerAction>();
                if (roles != null)
                {
                    foreach (AdminUserRole userrole in roles)
                    {
                        if (userrole.role != null && userrole.role.actions != null)
                        {
                            foreach (AdminControllerAction aca in userrole.role.actions)
                                deny.Add(aca);
                        }
                    }
                }
                return deny;
            }
        }
    }
}
