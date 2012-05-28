using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
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
        public int roleId
        {
            get { return _roleId; }
            set { _roleId = value; }
        }
        private int _functionCode;

        public int functionCode
        {
            get { return _functionCode; }
            set { _functionCode = value; }
        }
    }
}
