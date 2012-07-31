using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.Tenghu.Service;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Web.Controllers
{
    public class PatentController : Controller
    {
        //
        // GET: /Patent/

        public ActionResult Index(string id)
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(5).ChildCategory;
            ViewData["info"] = CategoryService.GetInstance().Get(18);
            Pager p = new Pager();
            p.PageSize = 20;
            int page = 0;
            int cid = 0;
            int.TryParse(id, out cid);
            int.TryParse(Request.QueryString["page"], out page);
            page = page < 1 ? 1 : page;
            p.PageIndex = page;
            IList<Zhuanli> allZhuanlis = ZhuanliService.GetInstance().GetZhuanlis();
            p.RecordCount = allZhuanlis.Count;
            allZhuanlis = allZhuanlis.Skip((page - 1) * p.PageSize).Take(p.PageSize).ToList<Zhuanli>();
            ViewData["page"] = p;
            return View(allZhuanlis);
        }


        public ActionResult Filter(string id)
        {
            Pager p = new Pager();
            p.PageSize = 20;
            int page = 0;
            int cid = 0;
            int.TryParse(id, out cid);
            int.TryParse(Request.QueryString["page"], out page);
            page = page < 1 ? 1 : page;
            p.PageIndex = page;
            ViewData["category"] = CategoryService.GetInstance().Get(int.Parse(id));
            ViewData["childCat"] = CategoryService.GetInstance().Get(5).ChildCategory;
            IList<Zhuanli> allZhuanlis = ZhuanliService.GetInstance().GetZhuanlis();
            allZhuanlis = allZhuanlis.Where(m => m.type.Equals(cid)).ToList<Zhuanli>();
            p.RecordCount = allZhuanlis.Count;
            allZhuanlis = allZhuanlis.Skip((page - 1) * p.PageSize).Take(p.PageSize).ToList<Zhuanli>();
            ViewData["page"] = p;
            return View(allZhuanlis);
        }

        public ActionResult Info()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(5).ChildCategory;
            ViewData["info"] = CategoryService.GetInstance().Get(18);
            ViewData["videos"] = VideoService.GetInstance().GetListCategory(39);
            return View();
        }
        public ActionResult Videoinfo(string id)
        {
            int vid = 0;
            int.TryParse(id, out vid);
            ViewData["childCat"] = CategoryService.GetInstance().Get(5).ChildCategory;
            return View(VideoService.GetInstance().Get(vid));
        }
    }
}
