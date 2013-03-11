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
        /// <summary>
        /// 判断是否具体某项功能操作权限，和具体电站无关
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static bool isAllow(int code)
        {
            return isAllow(code, 0);
        }

        /// <summary>
        /// 判断是否有某个电站的操作权限
        /// </summary>
        /// <param name="code"></param>
        /// <param name="pid"></param>
        /// <param name="ptype"></param>
        /// <returns></returns>
        public static bool isAllow(int code, int pid)
        {
            User user = UserUtil.getCurUser();
            if (user == null) return false;
            //示例电站无权限
            if(user.username.Equals(UserUtil.demousername))return false;

            if (pid == 0) return true;

            PlantUser plantUser = PlantUserService.GetInstance().GetPlantUserByPlantIDUserID(new PlantUser { userID = user.id, plantID = pid });
            //根据对关联的电站指定的权限
            //是自己创建的电站，则具体权限，只对被分配的电站才需要判断权限。因为权限指定也都是针对分配电站而言。
            if (!plantUser.shared)
                return true;

            Role role = RoleService.GetInstance().Get(plantUser.roleId);
            if (role == null) return false;
            return role.isDeny(code);
        }

        /// <summary>
        /// 判断管理员权限
        /// </summary>
        /// <param name="controller"></param>
        /// <param name="action"></param>
        /// <returns></returns>
        public static bool isAllow(string controller, string action)
        {
            if (System.Web.HttpContext.Current.Session[ComConst.Manager] == null)
                return false;
            Manager m = System.Web.HttpContext.Current.Session[ComConst.Manager] as Manager;
            if (m.username.Equals("admin"))
                return true;
            if (m.roles == null || m.roles.Count == 0)
                return false;
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
