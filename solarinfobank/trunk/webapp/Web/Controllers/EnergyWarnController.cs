using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class EnergyWarnController : Controller
    {
        /// <summary>
        /// 产生告警数据
        /// </summary>
        /// <returns></returns>
        public ActionResult gen()
        {
            EnergywarnService.GetInstance().GenerateEnergywarn();
            return Content("true");
        }
    }
}
