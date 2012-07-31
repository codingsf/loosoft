using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.Tenghu.Service;

namespace Cn.Loosoft.Zhisou.Tenghu.Web.Controllers
{
    public class ContactController : Controller
    {
        //
        // GET: /Contact/

        public ActionResult Index()
        {
            var category = CategoryService.GetInstance().Get(7);
            ViewData["childCat"] = category.ChildCategory;
            ViewData["contactUs"] = category;
            return View(JobService.GetInstance().GetJobs());
        }

        public ActionResult Info()
        {
            var category = CategoryService.GetInstance().Get(7);
            ViewData["contactUs"] = category;
            ViewData["childCat"] = category.ChildCategory;
            return View();
        }

        public ActionResult Job()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(7).ChildCategory;
            return View(JobService.GetInstance().GetJobs());
        }

        public ActionResult jobinfo(string id)
        {
            int jid = 0;
            int.TryParse(id, out jid);
            ViewData["childCat"] = CategoryService.GetInstance().Get(7).ChildCategory;
            return View(JobService.GetInstance().Get(jid));
        }



    }
}
