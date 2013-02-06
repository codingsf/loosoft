using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.Tenghu.Service;
using Cn.Loosoft.Zhisou.Tenghu.Common;
using DataLinq;


namespace Web.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            LinqDAO.CategoryDAO dal = new LinqDAO.CategoryDAO();

            ViewData["images"] = ImageService.GetInstance().GetList();
            ViewData["jianjie"] = CategoryService.GetInstance().Get(8);
            ViewData["news"] = NewsService.GetInstance().GetHotNews(4);
            return View();
        }


        public ActionResult Search(string keyword)
        {
            Pager p = new Pager();
            p.PageSize = 20;
            int page = 0;
            int.TryParse(Request.QueryString["page"], out page);
            page = page < 1 ? 1 : page;
            p.PageIndex = page;
            IList<News> allNews = NewsService.GetInstance().Search(keyword);
            p.RecordCount = allNews.Count;
            allNews = allNews.Skip((page - 1) * p.PageSize).Take(p.PageSize).ToList<News>();
            ViewData["page"] = p;
            ViewData["recordCount"] = p.RecordCount;
            return View(allNews);
        }


        public ActionResult Header()
        {
            ViewData["categories"] = CategoryService.GetInstance().GetList(0);
            return PartialView();
        }


    }
}
