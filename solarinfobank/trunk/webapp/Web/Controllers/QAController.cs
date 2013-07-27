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
        public ActionResult Ask(string page, string kw, string aid)
        {
            User user = UserUtil.getCurUser();
            int tid = 0;
            int.TryParse(aid, out tid);
            QA qa = QAService.GetInstance().Get(tid);
            if (qa != null && user != null && qa.username.Equals(user.username) && qa.status != QA.VALIDATE)
                ViewData["qa"] = qa;
            string username = user == null ? string.Empty : user.username;
            int ipage = 0;
            int.TryParse(page, out ipage);
            ipage = ipage < 1 ? 1 : ipage;
            IList<QA> qalist = QAService.GetInstance().Search(kw, QA.VALIDATE, string.IsNullOrEmpty(kw) ? username : string.Empty);
            if (string.IsNullOrEmpty(username))
                qalist = qalist.Where(m => m.isRecommend).ToList<QA>();
            Pager pager = new Pager();
            ViewData["page"] = pager;
            pager.PageSize = 10;
            pager.PageIndex = ipage;
            pager.RecordCount = qalist.Count;
            qalist = qalist.Skip((ipage - 1) * pager.PageSize).Take(pager.PageSize).ToList<QA>();
            return View(qalist);
        }

        [HttpPost]
        public ActionResult PostAsk(QA qa)
        {
            string validatecode = Request["validatecode"];
            if (ValidateCodeUtil.Validated(validatecode))
            {
                User user = UserUtil.getCurUser();
                string username = user == null ? string.Empty : user.username;
                qa.createip = Request.UserHostAddress;
                qa.status = QA.NORMAL;
                qa.username = user == null ? "匿名" : user.username;
                qa.qid = 0;
                qa.pubdate = DateTime.Now;
                QAService.GetInstance().Save(qa);
                TempData["message"] = "提问成功，请耐心等待管理员的解答！";
            }
            else
                TempData["message"] = "验证码输入错误!";
            return Redirect("/qa/ask#ask");
        }


        /// <summary>
        /// 如果当前用户的提问未审核可以重新编辑
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult ShowAsk(string id)
        {
            User user = UserUtil.getCurUser();
            int iid = 0;
            int.TryParse(id, out iid);
            QA qa = QAService.GetInstance().Get(iid);
            if (qa != null && user != null && qa.username.Equals(user.username) && qa.status != QA.VALIDATE)
                return Redirect("/qa/ask/?aid=" + qa.id);
            return View(qa);
        }
    }
}
