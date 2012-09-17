using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class QAController : Controller
    {
        public ActionResult Ask(string page, string kw)
        {
            User user = UserUtil.getCurUser();
            string username = user == null ? string.Empty : user.username;
            int ipage = 0;
            int.TryParse(page, out ipage);
            ipage = ipage < 1 ? 1 : ipage;
            IList<QA> qalist = QAService.GetInstance().Search(kw, QA.VALIDATE, string.IsNullOrEmpty(kw) ? username : string.Empty);
            Pager pager = new Pager();
            ViewData["page"] = pager;
            pager.PageSize = 2;
            pager.PageIndex = ipage;
            pager.RecordCount = qalist.Count;
            qalist = qalist.Skip((ipage - 1) * pager.PageSize).Take(pager.PageSize).ToList<QA>();
            return View(qalist);
        }

        public ActionResult Search(string kw, string page)
        {
            User user = UserUtil.getCurUser();
            string username = user == null ? string.Empty : user.username;
            int ipage = 0;
            int.TryParse(page, out ipage);
            ipage = ipage < 1 ? 1 : ipage;
            IList<QA> qalist = QAService.GetInstance().Search(kw, QA.VALIDATE, string.IsNullOrEmpty(kw) ? username : string.Empty);
            Pager pager = new Pager();
            ViewData["page"] = pager;
            pager.PageSize = 10;
            pager.PageIndex = ipage;
            pager.RecordCount = qalist.Count;
            qalist = qalist.Skip((ipage - 1) * pager.PageSize).Take(pager.PageSize).ToList<QA>();
            return View("ask", qalist);
        }



        [HttpPost]
        public ActionResult PostAsk(QA qa)
        {
            User user = UserUtil.getCurUser();
            string username = user == null ? string.Empty : user.username;
            qa.createip = Request.UserHostAddress;
            qa.status = QA.NORMAL;
            qa.username = user == null ? "匿名" : user.username;
            qa.qid = 0;
            qa.pubdate = DateTime.Now;
            QAService.GetInstance().Save(qa);
            ViewData["message"] = "提问成功，请耐心等待管理员的解答！";
            return Redirect("/qa/ask");
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
