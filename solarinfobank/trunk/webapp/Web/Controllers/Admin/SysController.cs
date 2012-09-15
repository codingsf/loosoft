using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Drawing;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{
    public class SysController : Controller
    {
        //
        // GET: /Sys/

        public ActionResult Logo()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Logo(HttpPostedFileBase logopic)
        {
            try
            {
                if (logopic.ContentLength > 0)
                {
                    string extensionName = logopic.FileName.Substring(logopic.FileName.LastIndexOf('.'));
                    if (extensionName.ToLower().Equals(".jpg"))
                    {
                        Bitmap myImage = new Bitmap(logopic.InputStream);
                        if (myImage.Width > 140)
                        {
                            ViewData["error"] = "图片宽度不能大于169px";
                        }
                        else if (myImage.Height > 40)
                            ViewData["error"] = "图片高度不能大于40px";
                        else
                        {
                            string filePath = Path.Combine(HttpContext.Server.MapPath("/images/"), "logo.jpg");
                            logopic.SaveAs(filePath);
                        }
                    }
                    else
                        ViewData["error"] = "请选择一个jpg扩展名的logo图片";
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return Content(e.Message);
            }
            return View();
        }

        public ActionResult Name()
        {
            string sysName = Common.ComConst.defaultSysName;
            string path = Server.MapPath("~");
            path = string.Format("{0}sys.txt", path);
            if (System.IO.File.Exists(path))
            {
                sysName = System.IO.File.ReadAllText(path);
            }
            ViewData[Common.ComConst.defaultSysName] = sysName;
            return View();
        }
        [HttpPost]
        public ActionResult Name(string sysname)
        {
            string path = Server.MapPath("~");
            path = string.Format("{0}sys.txt", path);
            System.IO.File.WriteAllText(path, sysname);
            ViewData[Common.ComConst.defaultSysName] = sysname;
            return View();
        }

    }
}
