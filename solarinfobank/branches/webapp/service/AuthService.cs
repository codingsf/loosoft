using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class AuthService
    {
        public static bool isAllow(int code)
        {
            User user = UserUtil.getCurUser();
            if (user == null) return true;
            if (user.UserRole == null) return true;
            foreach (RoleFunction function in user.UserRole.RoleFunctions)
            {
                if (function.functionCode.Equals(code))
                {
                    return false;
                }
            }
            return true;
        }


        public static bool isAllow(string controller, string action)
        {
            if (System.Web.HttpContext.Current.Session[ComConst.Manager] == null)
                return false;
            Manager m = System.Web.HttpContext.Current.Session[ComConst.Manager] as Manager;
            if (m.username.Equals("admin"))
                return true;
            if (m.roles == null || m.roles.Count == 0)
                return false;
            //foreach (AdminUserRole userRole in m.roles)
            //{
            //    if (userRole.role != null)
            //        if (userRole.role.actions != null)
            //        {
            //            foreach (AdminControllerAction aca in userRole.role.actions)
            //                if (controller.ToLower().Equals(aca.controllerName.ToLower()) && action.ToLower().Equals(aca.actionName.ToLower()))
            //                    return false;
            //        }
            //}
            //return true;
            IList<AdminControllerAction> allActions = AdminControllerActionServices.GetInstance().GetList();

            IList<AdminControllerAction> allallows = new List<AdminControllerAction>();
            foreach (AdminUserRole userRole in m.roles)
            {
                if (userRole.role != null)
                {
                    IList<AdminControllerAction> roleAllows = AdminRole.AllowActionsList(allActions, userRole.role.actions);
                    foreach (AdminControllerAction aca in roleAllows)
                        allallows.Add(aca);
                }
            }
            
            IList<AdminControllerAction> alldenies = AdminRole.AllowActionsList(allActions, allallows);

            foreach (AdminControllerAction aca in alldenies)
            {
                if (controller.ToLower().Equals(aca.controllerName.ToLower()) && action.ToLower().Equals(aca.actionName.ToLower()))
                    return false;
            }
            return true;


        }
    }
}
