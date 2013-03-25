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
        /// 判断用户菜单是否具体某项功能操作权限，和具体电站无关
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static bool isAllow(int code)
        {
            return isAllow(code, 0);
        }

        /// <summary>
        /// 判断是否有某个电站的操作权限
        /// 对应默认是否有权限应该按照对某个电站的具体角色来判断，但是因为现在电站一般用户只有一个角色，而且别人创建的，不是注册用户，所有目前业务中用
        /// 上面的不带电站id的判断也是可以的
        /// </summary>
        /// <param name="code"></param>
        /// <param name="pid"></param>
        /// <param name="ptype"></param>
        /// <returns></returns>
        public static bool isAllow(int code, int pid)
        {
            User user = UserUtil.getCurUser();
            if (user == null) return false;

            //if (pid == 0) return true;

            //PlantUser plantUser = PlantUserService.GetInstance().GetPlantUserByPlantIDUserID(new PlantUser { userID = user.id, plantID = pid });
            ////根据对关联的电站指定的权限
            ////是自己创建的电站，则具体权限，只对被分配的电站才需要判断权限。因为权限指定也都是针对分配电站而言。
            //if (!plantUser.shared)
            //{
            //    return true;
            //}
            //else {
            //    Role role = RoleService.GetInstance().Get(plantUser.roleId);
            //    if (role == null) return false;
            //    return role.isDeny(code);
            //}

            //改为只用用户的角色判断，而不是用和分配的电站的角色处理，因为，目前某个电站用户对所有电站只会是一种角色，后期改进为上面，组合电站
            if (user.userRole == null) return false;
            return user.userRole.isDeny(code);
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
