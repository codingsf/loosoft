using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.Tenghu.Service;

namespace Cn.Loosoft.Zhisou.Tenghu.Web.Controllers
{
    public class AboutController : Controller
    {
        //
        // GET: /About/

        public ActionResult Index()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(2).ChildCategory;
            ViewData["jianjie"] = CategoryService.GetInstance().Get(8);
            ViewData["wenhua"] = CategoryService.GetInstance().Get(9);
            ViewData["guanli"] = CategoryService.GetInstance().Get(10);
            return View();
        }




        public ActionResult More(string id)
        {
            int nid = 0;
            int.TryParse(id, out nid);
            ViewData["info"] = CategoryService.GetInstance().Get(nid);
            ViewData["childCat"] = CategoryService.GetInstance().Get(2).ChildCategory;
            return View();
        }




    }
}
