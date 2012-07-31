using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.Tenghu.Service;
using Cn.Loosoft.Zhisou.Tenghu.Domain;
using System.IO;

namespace Cn.Loosoft.Zhisou.Tenghu.Web.Controllers
{
    public class ServiceController : Controller
    {
        //
        // GET: /Service/

        public ActionResult Index()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(6).ChildCategory;
            return View();
        }


        public ActionResult Download(string id)
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(6).ChildCategory;

            Pager p = new Pager();
            p.PageSize = 20;
            int page = 0;
            int cid = 0;
            int.TryParse(id, out cid);
            int.TryParse(Request.QueryString["page"], out page);
            page = page < 1 ? 1 : page;
            p.PageIndex = page;
            IList<Video> allVideos = VideoService.GetInstance().GetListCategory(24);
            p.RecordCount = allVideos.Count;
            allVideos = allVideos.Skip((page - 1) * p.PageSize).Take(p.PageSize).ToList<Video>();
            ViewData["page"] = p;
            return View(allVideos);
        }

        public ActionResult Video(string id)
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(6).ChildCategory;
            ViewData["nav"] = "服务";
            Pager p = new Pager();
            p.PageSize = 8;
            int page = 0;
            int cid = 0;
            int.TryParse(id, out cid);
            int.TryParse(Request.QueryString["page"], out page);
            page = page < 1 ? 1 : page;
            p.PageIndex = page;
            IList<Video> allVideos = VideoService.GetInstance().GetListCategory(23);
            p.RecordCount = allVideos.Count;
            allVideos = allVideos.Skip((page - 1) * p.PageSize).Take(p.PageSize).ToList<Video>();
            ViewData["page"] = p;
            ViewData["video"] = allVideos;
            return View();
        }
        public ActionResult DownFile(int id)
        {
            Video video=VideoService.GetInstance().Get(id);
            if (string.IsNullOrEmpty(video.path))
                return Content("无资料下载");
            string path = Path.Combine(Server.MapPath("/video/file/"), video.path);
            return File(path, "text/pdf; charset=UTF-8", video.path);
        }


        public ActionResult Sale()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(6).ChildCategory;
            return View();
        }

        public ActionResult Network()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(6).ChildCategory;
            return View();
        }

        public ActionResult Support()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(6).ChildCategory;
            return View();
        }

        public ActionResult Load(string id, string type, string keyword,bool issale)
        {
            if (string.IsNullOrEmpty(keyword))
            {
                if (string.IsNullOrEmpty(type) || type.Equals("-1"))
                    ViewData["data"] = ServiceInfoService.GetInstance().GetList(int.Parse(id));
                else
                    ViewData["data"] = ServiceInfoService.GetInstance().GetList(id, type);
            }
            else
                ViewData["data"] = ServiceInfoService.GetInstance().GetList(keyword);
            ViewData["issale"] = issale;
            return PartialView("servicecontrol");

        }


        public ActionResult Info(int id)
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(6).ChildCategory;
            ViewData["info"] = CategoryService.GetInstance().Get(id);
            return View();
        }

        public ActionResult Videoinfo(string id)
        {
            int vid = 0;
            int.TryParse(id, out vid);
            ViewData["childCat"] = CategoryService.GetInstance().Get(6).ChildCategory;
            return View(VideoService.GetInstance().Get(vid));
        }


    }
}
