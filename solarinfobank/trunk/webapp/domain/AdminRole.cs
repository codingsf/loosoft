using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    [Serializable]

    public class AdminRole
    {
        public int id { get; set; }
        public string name { get; set; }
        public string descr { get; set; }
        public IList<AdminControllerAction> actions { get; set; }

        public string AllowActions(IList<AdminControllerAction> allActions, IList<AdminControllerAction> denyActions)
        {
            int i = 0;
            string roleNames = string.Empty;
            if (denyActions != null && denyActions.Count > 0)
            {
                foreach (var cur in allActions)
                {
                    bool isExist = false;
                    foreach (var deny in denyActions)
                    {
                        if (deny.controllerName.ToLower() == cur.controllerName.ToLower() && deny.actionName.ToLower() == cur.actionName.ToLower())
                        {
                            isExist = true;
                            break;
                        }
                    }
                    if (isExist == false)
                    {
                        i++;
                        roleNames += cur.descr + ",";
                    }
                    if (i > 5)
                        break;
                }
            }
            else
            {
                foreach (var cur in allActions)
                {
                    i++;
                    roleNames += cur.descr + ",";
                    if (i > 5)
                        break;
                }
            }
            return roleNames;
        }


        public static IList<AdminControllerAction> AllowActionsList(IList<AdminControllerAction> allActions, IList<AdminControllerAction> denyActions)
        {
            IList<AdminControllerAction> allowActions = new List<AdminControllerAction>();
            if (denyActions != null && denyActions.Count > 0)
            {
                foreach (var cur in allActions)
                {
                    bool isExist = false;
                    foreach (var deny in denyActions)
                    {
                        if (deny.controllerName.ToLower() == cur.controllerName.ToLower() && deny.actionName.ToLower() == cur.actionName.ToLower())
                        {
                            isExist = true;
                            break;
                        }
                    }
                    if (isExist == false)
                    {
                        allowActions.Add(cur);
                    }
                }
            }
            else
            {
                allowActions = allActions;
            }
            return allowActions;
        }


    }

}
