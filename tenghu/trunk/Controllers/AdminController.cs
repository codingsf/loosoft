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
    public class IsLoginAttributeAdmin : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session["alogin"] == null)
                filterContext.HttpContext.Response.Redirect("/auth/login");
        }
    }

    [IsLoginAttributeAdmin]
    public class AdminController : Controller
    {
        public ActionResult Index()
        {
            IList<News> news = NewsService.GetInstance().GetHotNews(10);
            ViewData["news"] = news;
            return View();
        }

        public ActionResult Category(string id,string cname)
        {
            Category category = new Category();
            category.pid = int.Parse(id);
            category.name = cname;
            CategoryService.GetInstance().Save(category);
            return Content("添加成功");
        }

        public ActionResult ChildCategory(string id)
        {
            int cid = 0;
            int.TryParse(id, out cid);
            Category category = CategoryService.GetInstance().Get(cid);
            ViewData["category"] = category;
            return View();
        }

        public ActionResult LoadChildCategory(string id)
        {
            return Json(CategoryService.GetInstance().GetList(id),JsonRequestBehavior.AllowGet);
        }

        public ActionResult Delcategory(int id)
        {
            int cid = 0;
            int.TryParse(Request.QueryString["cid"].ToString(), out cid);
            CategoryService.GetInstance().Remove(cid);
            return Redirect(string.Format("/admin/categories?id={0}", id));
        }

        public ActionResult WebConfig()
        {
            return View(WebconfigService.GetInstance().Get());
        }

        public ActionResult UpdateConfig(Webconfig config)
        {
            WebconfigService.GetInstance().Save(config);
            HttpContext.Application.Clear();
            return View("webconfig", WebconfigService.GetInstance().Get());
        }

        public ActionResult News(string id)
        {
            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageIndex = no, PageSize = 15 };
            IList<News> news = NewsService.GetInstance().GetPage(page);
            ViewData["page"] = page;
            ViewData["news"] = news;
            return View();
        }


        public ActionResult ZhuanliList(string id)
        {
            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageIndex = no, PageSize = 15 };
            IList<Zhuanli> news = ZhuanliService.GetInstance().GetPage(page);
            ViewData["page"] = page;
            ViewData["zhuanli"] = news;
            return View();
        }



        public ActionResult Jobs(string id)
        {
            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageIndex = no, PageSize = 15 };
            IList<Job> jobs = JobService.GetInstance().GetPage(page);
            ViewData["page"] = page;
            ViewData["job"] = jobs;
            return View();
        }


        public ActionResult AddNew(string id)
        {
            int nid = 0;
            int.TryParse(id, out nid);
            return View(NewsService.GetInstance().Get(nid));
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult AddNew(News news)
        {
            news.publictime = DateTime.Now;
            NewsService.GetInstance().Save(news);
            return RedirectToAction("news");
        }


        public ActionResult DelNew(int id)
        {
            NewsService.GetInstance().Remove(id);
            return RedirectToAction("index");
        }

        public ActionResult Job()
        {
            return View();
        }
        public ActionResult Addjob(string id)
        {
            int jid = 0;
            int.TryParse(id, out jid);
            return View(JobService.GetInstance().Get(jid));
        }

        [ValidateInput(false)]
        [HttpPost]
        public ActionResult Addjob(Job job)
        {
            JobService.GetInstance().Save(job);
            return RedirectToAction("jobs");
        }

        public ActionResult DelJob(int id)
        {
            JobService.GetInstance().Remove(id);
            return RedirectToAction("jobs");
        }

        public ActionResult Delzl(int id)
        {
            ZhuanliService.GetInstance().Remove(id);
            return RedirectToAction("zhuanlilist");
        }

        public ActionResult Zhuanli(string id)
        {
            int zid = 0;
            int.TryParse(id, out zid);
            return View(ZhuanliService.GetInstance().Get(zid));
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Zhuanli(Zhuanli zhuanli)
        {
            ZhuanliService.GetInstance().Save(zhuanli);
            return RedirectToAction("zhuanlilist");
        }


        public ActionResult ZhuanliDel(int id)
        {
            return View();
        }


        public ActionResult AddProduct(string id)
        {
            int pid = 0;
            int.TryParse(id, out pid);
            ViewData["selectlist"] = BuildSelectList(4);
            return View(ProductService.GetInstance().Get(pid));
        }

        private IList< SelectListItem> BuildSelectList(int id)
        {
            IList<SelectListItem> items = null;
            items = new List<SelectListItem>();
            foreach (Category category in CategoryService.GetInstance().Get(id).ChildCategory)
            {
                items.Add(new SelectListItem() { Text = category.name, Value = category.id.ToString() });
            }
            return items;
        }

        public ActionResult DelProduct(int id)
        {
            ProductService.GetInstance().Remove(id);
            return RedirectToAction("products");
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult AddProduct(Product product,HttpPostedFileBase pdf)
        {
            try
            {
                if (!Directory.Exists(Server.MapPath("/pdf/")))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("/pdf/"));
                }
                //图片保存的地址和名称
                Random random = new Random(DateTime.Now.Millisecond);
                string filename = DateTime.Now.ToString("yyyyMMddhhmmss.") + pdf.FileName.Substring(pdf.FileName.LastIndexOf('.') + 1);
                string filePath = Path.Combine(HttpContext.Server.MapPath("../pdf/"), filename);
                if (pdf.ContentLength > 0)
                {
                    pdf.SaveAs(filePath);
                    product.pdfpath= filename;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            if (product.id <= 0)
                product.createtime = DateTime.Now;
            ProductService.GetInstance().Save(product);
            return RedirectToAction("products");
        }


        public ActionResult Products(string id)
        {
            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageIndex = no, PageSize = 15 };
            IList<Product> jobs = ProductService.GetInstance().GetPage(page);
            ViewData["page"] = page;
            ViewData["products"] = jobs;
            return View();
        }



        public ActionResult My()
        {
            return View(Session["alogin"]);
        }

        [HttpPost]
        public ActionResult My(Manager manager)
        {
            ManagerService.GetInstance().Save(manager);
            return View(manager);
        }


        public ActionResult AddUser(string id)
        {
            int mid = 0;
            int.TryParse(id, out mid);
            ViewData["user"] = ManagerService.GetInstance().GetList();
            return View(ManagerService.GetInstance().Get(mid));
        }

        [HttpPost]
        public ActionResult AddUser(Manager manager)
        {
            ManagerService.GetInstance().Save(manager);
            ViewData["user"] = ManagerService.GetInstance().GetList();
            return View();
        }

        public ActionResult DelUser(int id)
        {
            ManagerService.GetInstance().Remove(id);
            ViewData["user"] = ManagerService.GetInstance().GetList();
            return RedirectToAction("adduser");
        }

        public ActionResult Links(string id)
        {
            int lid = 0;
            int.TryParse(id, out lid);
            ViewData["links"] = LinkService.GetInstance().GetLinks();
            return View(LinkService.GetInstance().Get(lid));
        }

        public ActionResult Categories(string id)
        {
            int cid = 0;
            ViewData["categories"] = CategoryService.GetInstance().GetList(id);
            int.TryParse(Request.QueryString["cid"] == null ? "0" : Request.QueryString["cid"].ToString(), out cid);
            return View(CategoryService.GetInstance().Get(cid));
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Categories(Category category)
        {
            int iid = 0;
            int.TryParse(Request.Form["iid"] == null ? "0" : Request.Form["iid"].ToString(), out iid);
            category.id = iid;
            CategoryService.GetInstance().Save(category);
            return Redirect("/admin/categories?id=4");
        }


        public ActionResult AddLink(Link link)
        {
            LinkService.GetInstance().Save(link);
            return RedirectToAction("links");
        }

        public ActionResult DelLink(int id)
        {
            LinkService.GetInstance().Remove(id);
            return RedirectToAction("links");
        }

        public ActionResult Image()
        {
            ViewData["images"] = ImageService.GetInstance().GetList();
            return View();
        }


        [AcceptVerbs(HttpVerbs.Post)]
        [IsLoginAttributeAdmin]
        public ActionResult Upload(Image image, HttpPostedFileBase picName)
        {
            try
            {
                if (!Directory.Exists(Server.MapPath("../upload")))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("../upload"));
                }
                //图片保存的地址和名称
                string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + picName.FileName.Substring(picName.FileName.LastIndexOf('\\') + 1);
                string filePath = Path.Combine(HttpContext.Server.MapPath("../upload/"), filename);
                if (picName.ContentLength > 0)
                {
                    Path.GetFileName(picName.FileName);
                    picName.SaveAs(filePath);
                    image.pic = filename;
                    ImageService.GetInstance().Save(image);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return RedirectToAction(@"image", "admin");
        }

        [IsLoginAttributeAdmin]
        public ActionResult DelImg(int id)
        {
            ImageService.GetInstance().Remove(id);
            return RedirectToAction("image");
        }

        public ActionResult Qiye(string cid)
        {
            int id = 0;
            int.TryParse(cid, out id);
            return View(CategoryService.GetInstance().Get(id));
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Qiye(Category category)
        {
            CategoryService.GetInstance().Save(category);
            return Redirect("/admin/qiye?cid="+category.id);
        }

        public ActionResult Order()
        {
            ViewData["orders"] = OrderService.GetInstance().GetList();
            return View();
        }

        public ActionResult DelOrder(int id)
        {
            OrderService.GetInstance().Remove(id);
            return RedirectToAction("order");
        }
     
        public ActionResult Video(string id)
        {
            int vid = 0;
            int.TryParse(id, out vid);
            return View(VideoService.GetInstance().Get(vid));
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Video(Video video,HttpPostedFileBase image)
        {
            try
            {
                if (!Directory.Exists(Server.MapPath("/video/file/")))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("/video/file/"));
                }
                //图片保存的地址和名称
                Random random = new Random(DateTime.Now.Millisecond);
                string filename = DateTime.Now.ToString("yyyyMMddhhmmss.") + image.FileName.Substring(image.FileName.LastIndexOf('.') + 1);
                string filePath = Path.Combine(HttpContext.Server.MapPath("../video/file/"), filename);
                if (image.ContentLength > 0)
                {
                    image.SaveAs(filePath);
                    if (video.category.id.Equals(24) == false)
                        video.img = filename;
                    else
                        video.path = filename;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            VideoService.GetInstance().Save(video);
            return RedirectToAction("Videos");
        }

        public ActionResult Videos(string id)
        {
            Pager p = new Pager();
            p.PageSize = 20;
            int page = 0;
            int.TryParse(id, out page);
            page = page < 1 ? 1 : page;
            p.PageIndex = page;
            IList<Video> allVideos = VideoService.GetInstance().GetList();
            p.RecordCount = allVideos.Count;
            allVideos = allVideos.Skip((page - 1) * p.PageSize).Take(p.PageSize).ToList<Video>();
            ViewData["page"] = p;
            ViewData["videos"] = allVideos;

            return View();


        }

        public ActionResult DelVideo(int id)
        {
            VideoService.GetInstance().Remove(id);
            return RedirectToAction("Videos");
        }

        public ActionResult Service()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Service(ServiceInfo info)
        {
            ServiceInfoService.GetInstance().Save(info);
            return RedirectToAction("servicelist");
        }

        public ActionResult ServiceList(string id)
        {
            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageIndex = no, PageSize = 15 };
            IList<ServiceInfo> jobs = ServiceInfoService.GetInstance().GetPage(page);
            ViewData["page"] = page;
            ViewData["services"] = jobs;
            return View();
        }

        public ActionResult DelService(int id)
        {
            ServiceInfoService.GetInstance().Remove(id);
            return Redirect("/admin/servicelist");
        }

        public ActionResult OrderView(int id)
        {
            return View(OrderService.GetInstance().Get(id));
        }

        public ActionResult Banner()
        {
            IList<SelectListItem> items = new List<SelectListItem>();
            IList<Category> categories = CategoryService.GetInstance().GetList();
            if (categories != null)
                foreach (Category category in categories)
                {
                    items.Add(new SelectListItem() { Text = category.name, Value = category.id.ToString() });
                    if (category.ChildCategory != null)
                    {
                        foreach (Category cate in category.ChildCategory)
                        {
                            items.Add(new SelectListItem() { Text = "--" + cate.name, Value = cate.id.ToString() });
                            if (cate.ChildCategory != null)
                            {
                                foreach (Category cate1 in cate.ChildCategory)
                                {
                                    items.Add(new SelectListItem() { Text = "----" + cate1.name, Value = cate1.id.ToString() });
                                }
                            }
                        }
                    }
                }
            items.RemoveAt(0);
            ViewData["items"] = items;
            return View();
        }

        [HttpPost]
        public ActionResult Banner(HttpPostedFileBase image,string pid)
        {
            pid=Request.Form["pid"];
            ViewData["result"] = "添加成功";
            try
            {
                if (!Directory.Exists(Server.MapPath("../img/banner")))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("../img/banner"));
                }
                //图片保存的地址和名称
                string filename = string.Format("banner_{0}.{1}", pid, image.FileName.Substring(image.FileName.LastIndexOf('.') + 1));
                string filePath = Path.Combine(HttpContext.Server.MapPath("../img/banner/"), filename);
                if (image.ContentLength > 0)
                {
                    image.SaveAs(filePath);
                }
            }
            catch (Exception e)
            {
                ViewData["result"] = "添加失败";
                
            }

            return Banner();
        }
    }
}
