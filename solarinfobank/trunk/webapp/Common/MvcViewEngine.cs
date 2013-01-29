using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 作者：houbing.qian
    /// 功能：self-defined View Engine
    /// 创建时间：2011-2-25
    /// </summary>
    public class MvcViewEngine : VirtualPathProviderViewEngine
    {
        public MvcViewEngine()
        {
            MasterLocationFormats = new[] {
                "~/{1}View/{0}.master",
                "~/SharedView/{0}.master"
            };

            AreaMasterLocationFormats = new[] {
                "~/Areas/{2}/Pages/{1}/{0}.master",
                "~/Areas/{2}/Pages/Shared/{0}.master",
            };

            ViewLocationFormats = new[] {
                "~/Pages/{1}/{0}.aspx",
                "~/Pages/{1}/{0}.ascx",
                "~/Pages/plant/{1}/{0}.aspx",
                "~/Pages/user/{1}/{0}.aspx",
                "~/Pages/admin/{1}/{0}.aspx",
               //"~/Pages/admin/itemconfig/{0}.aspx",
                "~/Pages/report/{1}/{0}.aspx",
                "~/Pages/Shared/{0}.aspx",
                "~/Pages/Shared/{0}.ascx"
            };

            AreaViewLocationFormats = new[] {
                "~/Areas/{2}/Pages/{1}/{0}.aspx",
                "~/Areas/{2}/Pages/{1}/{0}.ascx",
                "~/Areas/{2}/Pages/Shared/{0}.aspx",
                "~/Areas/{2}/Pages/Shared/{0}.ascx",
            };

            PartialViewLocationFormats = ViewLocationFormats;
            AreaPartialViewLocationFormats = AreaViewLocationFormats;
        }

        protected override IView CreatePartialView(ControllerContext controllerContext, string partialPath)
        {
            return new WebFormView(partialPath, null);
        }

        protected override IView CreateView(ControllerContext controllerContext, string viewPath, string masterPath)
        {
            return new WebFormView(viewPath, masterPath);
        }

    }
}