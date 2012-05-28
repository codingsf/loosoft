
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class CountryController : Controller
    {
        //
        // GET: /Country/

        public ActionResult City()
        {
            IList<CountryCity> countries= CountryCityService.GetInstance().GetList();
            ViewData["countries"] = countries;
            return View();
        }

    }
}
