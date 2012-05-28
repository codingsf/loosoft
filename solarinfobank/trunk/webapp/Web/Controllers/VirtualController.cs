using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Common;
using Dimac.JMail;
using EmailService;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    public class VirtualController : BaseController
    {
        /// <summary>
        /// 功能：电站概览
        /// 描述：大电站的概览，每个小电站的实时数据累加
        /// 作者：张月
        /// 时间：2011年3月10日 21:45:13
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns>电站概览页面</returns>
        [IsLoginAttribute]
        public ActionResult Overview(int id)
        {
            User curUser = UserUtil.getCurUser();
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            return View(plant);
        }
        /// <summary>
        /// 功能：电站概览
        /// 描述：大电站的概览，每个小电站的实时数据累加
        /// 作者：张月
        /// 时间：2011年3月10日 21:45:13
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns>电站概览页面</returns>
        [IsLoginAttribute]
        public ActionResult IncludeOverview(int id)
        {
            User curUser = UserUtil.getCurUser();
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            if (plant == null)
                return RedirectToAction("portal", "user");
            else if (!plant.isVirtualPlant && plant.allFactUnits.Count == 0)
                return RedirectToAction("bind", "unit", new { @id = id });

            string startYM = (DateTime.Now.Year - 1) + "" + DateTime.Now.Month.ToString("00");
            string endYM = DateTime.Now.Year + "" + DateTime.Now.Month.ToString("00");
            //int monitorCode = 0;//发电量测点
            //string reportCode = PlantChartService.GetInstance().YearMMChartBypList(base.getCurUser().plants, startYM, endYM, ChartType.line, "kWh", monitorCode);
            //ViewData[ComConst.ReportCode] = reportCode;

            ViewData[ComConst.PlantName] = plant.name;
            plant.currencies = curUser.currencies;
            ViewData["temp"] = Math.Round(plant.Temperature, 1);
            if (plant.Temperature == 0.0)
            {
                CityCodeService codeService = CityCodeService.GetInstance();
                ViewData["temp"] = codeService.GetTemperature(plant.city);
            }
            if (!double.IsNaN(((double)ViewData["temp"])))
            {
                User user = UserUtil.getCurUser();
                if (user != null && !user.TemperatureType.ToLower().Equals("c"))
                {
                    ViewData["temp"] = Math.Round(32 + ((double)ViewData["temp"] * 1.8), 1);
                }
            }
            else
                ViewData["temp"] = "";

            IList<int> yearList = collectorYearDataService.GetWorkYears(plant);

            IList<SelectListItem> plantYearsList = Currencies.FillYearItems(yearList);

            ViewData["plantYear"] = plantYearsList;

            return View(plant);

        }

        public ActionResult Plantrelationstruct(int id)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            return View(plant);
        }

        public ActionResult IncludePlantrelationstruct(int id)
        {
            User curUser = UserUtil.getCurUser();
            string width = "100"; string height = "30";
            RelationConfig config = curUser.configs.Where(m => m.relationType.Equals(RelationConfig.VirtualPlant) && m.relationId.Equals(id)).FirstOrDefault<Cn.Loosoft.Zhisou.SunPower.Domain.RelationConfig>();
            if (config == null) config = new RelationConfig { width = "100", height = "30", config3 = "20", config4 = "15" };
            width = config.width;
            height = config.height;
            ViewData["config"] = config;
            Plant plant = PlantService.GetInstance().GetPlantInfoById(id);
            string jsstr = base.createPlantContructTree(new List<Plant> { plant }, -1, width, height);
            TempData["jsstr"] = jsstr;
            TempData["iSubtreeSeparation"] = config.config3;
            TempData["iSiblingSeparation"] = config.config4;
            return View(plant);
        }
    }
}