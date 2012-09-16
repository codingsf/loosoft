using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class QAController : Controller
    {
        public ActionResult Ask()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Ask(QA qa)
        {
            User user = UserUtil.getCurUser();
            qa.createip = Request.UserHostAddress;
            qa.status = QA.NORMAL;
            qa.username = user == null ? "匿名" : user.username;
            qa.qid = 0;
            qa.pubdate = DateTime.Now;
            QAService.GetInstance().Save(qa);
            ViewData["message"] = "提问成功，请耐心等待管理员的解答！";
            return View();
        }

        public ActionResult Search(string kw)
        {
            return View("ask", QAService.GetInstance().Search(kw,QA.VALIDATE));
        }

        public ActionResult ShowAsk(string id)
        {
            int iid = 0;
            int.TryParse(id, out iid);
            QA qa = QAService.GetInstance().Get(iid);
            return View(qa);
        }

    }
}
