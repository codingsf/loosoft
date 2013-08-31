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
using Cn.Loosoft.Zhisou.SunPower.Common.vo;

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

        public class PlantUserIdComparer : IEqualityComparer<Plant>
        {
            public bool Equals(Plant x, Plant y)
            {
                if (x == null)
                    return y == null;
                return x.userID == y.userID;
            }

            public int GetHashCode(Plant obj)
            {
                if (obj == null)
                    return 0;
                return obj.userID.GetHashCode();
            }
        }

        public ActionResult Warningpayment()
        {
            #region 获取配置电站付费提醒天数
            int limitDays = 30;
            ItemConfig config = ItemConfigService.GetInstance().GetItemConfigByName(ItemConfig.Payment);
            if (config != null && config.value > 0) limitDays = (int)config.value;
            #endregion

            //过滤相同的用户ID  Userid
            IList<Plant> plants = PlantService.GetInstance().GetPaymentExpiredList();
            plants = plants.Distinct(new PlantUserIdComparer()).ToList<Plant>();

            User user = null;
            foreach (Plant plant in plants)
            {
                if (plant.userID.Equals(0)) continue;
                user = UserService.GetInstance().Get(plant.userID);//根据电站取用户
                if (string.IsNullOrEmpty(user.email))//邮箱不对跳过
                    continue;

                IList<Plant> expiredPlants = user.ExpiredPlants;
                string msg = string.Empty;
                foreach (Plant vo in expiredPlants)
                    msg += string.Format(Resources.SunResource.FEE_EMAILTIPS_DONE_FOMART, vo.name, vo.PaymentLimitDate.ToString("yyyy-MM-dd"));
                MailServerPoolObject obj = EmailConnectionPool.getMailServerPoolObject();
                Message message = null;
                try
                {

                    message = new Message();
                    message.BodyHtml = string.Format(Resources.SunResource.FEE_EMAILTIPS_DONE, user.username, msg);
                    message.From.Email = obj.accountName;
                    message.To.Add(user.email);
                    message.Subject = "SolarInfoBank";
                    if (expiredPlants.Count > 0)
                    {
                        obj.SendMail(message);
                        //更新电站邮件最后发送时间
                        foreach (Plant vo in expiredPlants)
                        {
                            vo.LastEmailRemindDate = DateTime.Now;
                            PlantService.GetInstance().UpdateLastEmailRemindDate(vo);
                        }
                    }
                    obj.close();

                    expiredPlants = user.ExpireSoonPlants(limitDays);
                    if (expiredPlants.Count.Equals(0))
                        continue;
                    msg = string.Empty;
                    foreach (Plant vo in expiredPlants)
                        msg += string.Format(Resources.SunResource.FEE_EMAILTIPS_WILL_FOMART, vo.name, vo.PaymentLimitDate.ToString("yyyy-MM-dd"));
                    //下面发送即将到期电站邮件
                    obj = EmailConnectionPool.getMailServerPoolObject();
                    message.BodyHtml = string.Format(Resources.SunResource.FEE_EMAILTIPS_WILL, user.username, msg);
                    obj.SendMail(message);
                    obj.close();
                    //更新电站邮件最后发送时间
                    foreach (Plant vo in expiredPlants)
                    {
                        vo.LastEmailRemindDate = DateTime.Now;
                        PlantService.GetInstance().UpdateLastEmailRemindDate(vo);
                    }
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
            TempData["msg"] = "延期成功!";
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
                temp.Add(item.design_power.ToString("0 kWp"));
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
