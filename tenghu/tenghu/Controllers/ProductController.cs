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
    public class ProductController : Controller
    {
        //
        // GET: /Product/

        public ActionResult Index()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(4).ChildCategory;
            return View();
        }

        public ActionResult List(int id)
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(4).ChildCategory;
            ViewData["descr"] = CategoryService.GetInstance().Get(id);
            Pager p = new Pager();
            p.PageSize = 20;
            int page = 0;
            int.TryParse(Request.QueryString["page"], out page);
            page = page < 1 ? 1 : page;
            p.PageIndex = page;
            IList<Product> allProducts = ProductService.GetInstance().GetProductsCategory(id);
            p.RecordCount = allProducts.Count;
            allProducts = allProducts.Skip((page - 1) * p.PageSize).Take(p.PageSize).ToList<Product>();
            ViewData["page"] = p;
            ViewData["products"] = allProducts;
            return View();
        }

        public ActionResult View(int id)
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(4).ChildCategory;
            return View(ProductService.GetInstance().Get(id));
        }

        public ActionResult File(int id)
        {
            Product product=ProductService.GetInstance().Get(id);
            if (string.IsNullOrEmpty(product.pdfpath))
                return Content("无下载文件");
            string path=Path.Combine(Server.MapPath("/pdf/"), product.pdfpath);
            return File(path, "text/pdf; charset=UTF-8", product.pdfpath);
        }


        public ActionResult Buy(int id)
        {
            Product product = ProductService.GetInstance().Get(id);
            ViewData["childCat"] = CategoryService.GetInstance().Get(4).ChildCategory;
            return View(product);
        }


        [HttpPost]
        public ActionResult Buy(OrderInfo order)
        {
            OrderService.GetInstance().Save(order);
            return Redirect("/product/success");
        }

        public ActionResult Info(int id)
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(4).ChildCategory;
            ViewData["info"] = CategoryService.GetInstance().Get(id);
            return View();
        }

        public ActionResult LoadModel(int id)
        {
            return Json(ProductService.GetInstance().GetProductsCategory(id),JsonRequestBehavior.AllowGet);
        }

        public ActionResult Success()
        {
            ViewData["childCat"] = CategoryService.GetInstance().Get(4).ChildCategory;
            return View(); 
        }
    }
}
