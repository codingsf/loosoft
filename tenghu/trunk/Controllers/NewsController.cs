using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.Tenghu.Service;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Web.Controllers
{
    [HandleError]
    public class NewsController : Controller
    {
        public ActionResult Index()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(3).ChildCategory;
            ViewData["qiye"] = NewsService.GetInstance().GetHotNews(11,5);
            ViewData["chanpin"] = NewsService.GetInstance().GetHotNews(12,5);
            ViewData["video"] = VideoService.GetInstance().GetListCategory(13);

            return View();
        }


        public ActionResult More(string id)
        {
            Pager p = new Pager();
            p.PageSize = 20;
            int page = 0;
            int cid=0;
            int.TryParse(id,out cid);
            int.TryParse(Request.QueryString["page"], out page);
            page = page < 1 ? 1 : page;
            p.PageIndex = page;
            ViewData["category"] = CategoryService.GetInstance().Get(int.Parse(id));
            ViewData["childCat"] = CategoryService.GetInstance().Get(3).ChildCategory;
            IList<News> allNews = NewsService.GetInstance().GetList();
            allNews = allNews.Where(m => m.categoryid.Equals(cid)).ToList<News>();
            p.RecordCount = allNews.Count;
            allNews = allNews.Skip((page - 1) * p.PageSize).Take(p.PageSize).ToList<News>();
            ViewData["page"] = p;
            return View(allNews);
        }

        public ActionResult Info(string id)
        {
            News model = null;
            ViewData["childCat"] = CategoryService.GetInstance().Get(3).ChildCategory;
            int nid = 0;
            int.TryParse(id, out nid);
            model = NewsService.GetInstance().Get(nid);
            model.nextnews = NewsService.GetInstance().NextNews(model.categoryid, model.id);
            model.prenews = NewsService.GetInstance().PreNews(model.categoryid, model.id);
            return View(model);
        }

        public ActionResult Video(string id)
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(3).ChildCategory;
            ViewData["nav"] = "视频新闻";
            Pager p = new Pager();
            p.PageSize = 8;
            int page = 0;
            int cid = 0;
            int.TryParse(id, out cid);
            int.TryParse(Request.QueryString["page"], out page);
            page = page < 1 ? 1 : page;
            p.PageIndex = page;
            IList<Video> allVideos = VideoService.GetInstance().GetListCategory(13);
            p.RecordCount = allVideos.Count;
            allVideos = allVideos.Skip((page - 1) * p.PageSize).Take(p.PageSize).ToList<Video>();
            ViewData["page"] = p;
            ViewData["video"] = allVideos;
            return View();
        }

        public ActionResult Videoinfo(string id)
        {
            int vid = 0;
            int.TryParse(id, out vid);
            ViewData["childCat"] = CategoryService.GetInstance().Get(3).ChildCategory;
            return View(VideoService.GetInstance().Get(vid));
        }
    }
}
