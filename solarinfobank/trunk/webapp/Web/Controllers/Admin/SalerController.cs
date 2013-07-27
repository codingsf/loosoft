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
using Common;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class SalerController : AdminBaseController
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



        public ActionResult Plants_Output(string install_start, string install_end, int? index, string uname, string plantname)
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


            IList<ExcelData> eDatas = new List<ExcelData>();
            ExcelData data = new ExcelData();
            IList<string> temp = new List<string>();
            temp.Add("电站名");
            temp.Add("用户名");
            temp.Add("安装日期");
            temp.Add("安装功率");
            temp.Add("国家");
            temp.Add("城市");
            temp.Add("付款到期");
            data.Rows.Add(temp);
            foreach (Plant item in plants)
            {
                temp = new List<string>();
                temp.Add(item.name);
                temp.Add(item.User.username);
                temp.Add(item.installdate.ToShortDateString());
                temp.Add(item.country);
                temp.Add(item.city);
                temp.Add(item.country);
                temp.Add(item.PaymentLimitDate.ToShortDateString());
                data.Rows.Add(temp);
            }
            eDatas.Add(data);
            ExcelStreamWriter writer = new ExcelStreamWriter(eDatas);
            writer.Save("电站列表");
            return File(writer.FullName, "text/xlsx; charset=UTF-8", urlcode(writer.FileName));

        }


    }
}
