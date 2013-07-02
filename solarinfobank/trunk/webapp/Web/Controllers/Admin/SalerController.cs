using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Dimac.JMail;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class SalerController : Controller
    {
        //
        // GET: /Saler/

        public ActionResult Plants(string install_start, string install_end, int? index, string uname, string plantname)
        {
            string uids = "0,";
            if (string.IsNullOrEmpty(uname) == false)
            {
                IList<User> users = UserService.GetInstance().GetUsersLikeuname(uname);
                foreach (User user in users)
                    uids += string.Format("{0},", user.id);
            }
            uids += "0";
            index = index == null ? 1 : index.Value;
            install_start = install_start == null ? string.Empty : install_start;
            install_end = install_end == null ? string.Empty : install_end;

            Hashtable table = new Hashtable();
            Plant plant = new Plant();
            plant.name = plantname;
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = (int)index };
            ViewData["page"] = page;
            table.Add("plant", plant);
            table.Add("install_start", install_start);
            table.Add("install_end", install_end);
            table.Add("uids", uids);
            table.Add("page", page);
            IList<Plant> plants = PlantService.GetInstance().QueryPagePlants(table);
            return View(plants);
        }

        public ActionResult Warningpayment()
        {
            IList<Plant> plants = PlantService.GetInstance().GetPaymentExpiredList();
            foreach (Plant plant in plants)
            {
                MailServerPoolObject obj = EmailConnectionPool.getMailServerPoolObject();

                try
                {
                    Message message = new Message();
                    message.BodyText = "这是一封续费邮件";
                    message.From.Email = obj.accountName;
                    message.To.Add("bochins@163.com");
                    message.Subject = "续费了";
                    obj.SendMail(message);
                    obj.close();
                    plant.LastEmailRemindDate = DateTime.Now;
                    PlantService.GetInstance().UpdateLastEmailRemindDate(plant);
                }
                catch
                {
                    obj.close();
                }
            }
            return Content("");
        }

        public ActionResult Plant_extend(string id)
        {
            Plant plant = null;
            int pid = 0;
            int.TryParse(id, out pid);
            if (pid > 0)
            {
                plant = PlantService.GetInstance().GetPlantInfoById(pid);
            }
            else
                return Content("电站id错误");
            return View(plant);
        }

        public ActionResult SavePayment(Plant plant)
        {
            PlantService.GetInstance().UpdatePaymentLimitDate(plant);
            return Redirect(string.Format("/saler/plant_extend/{0}", plant.id));
        }

        public ActionResult PaymentConfig()
        {
            ItemConfig config = ItemConfigService.GetInstance().GetItemConfigByName(ItemConfig.Payment);
            return View(config);
        }

        public ActionResult SavePaymentconfig(ItemConfig itemConfig)
        {
            ItemConfigService.GetInstance().UpdateValue(itemConfig);
            return Redirect("/saler/paymentconfig/");
        }
    }
}
