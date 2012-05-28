using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [Serializable]
    public class Role
    {
        private int _id;
        public int id
        {
            get { return _id; }
            set { _id = value; }
        }
        private string _name;
        public string name
        {
            get { return _name; }
            set { _name = value; }
        }
        private string _descr;
        public string descr
        {
            get { return _descr; }
            set { _descr = value; }
        }

        public string displayName
        {
            get
            {
                return LanguageUtil.getDesc(string.Format("USER_ROLE_{0}", id));
            }
        }

        public int uid { get; set; }

        private IList<RoleFunction> _roleFunctions;
        public IList<RoleFunction> RoleFunctions
        {
            set { _roleFunctions = value; }
            get { return _roleFunctions; }
        }
        public bool isDeny(int code)
        {
            foreach (RoleFunction function in RoleFunctions)
            {
                if (function.functionCode.Equals(code))
                    return true;
            }
            return false;
        }

    }
}
