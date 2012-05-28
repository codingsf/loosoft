using System;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [Serializable]

    public class AdminControllerAction
    {

        public int id { get; set; }
        public string controllerName { get; set; }
        public string actionName { get; set; }
        public int typeId { get; set; }
        public string descr { get; set; }

        public string typeName
        {
            get
            {
                return AdminControllerActionType.TypeName(this.id);
            }
        }

        public bool isAutoRedirect { get; set; }

    }
}
