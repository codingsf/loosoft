using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Common;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    /// <summary>
    /// 功能：电站单元操作
    /// 描述：对电站的单元操作
    /// 作者：张月
    /// 时间：2011年3月10日
    /// </summary>
    public class UnitController : BaseController
    {
        PlantUnitService plantUnitService = PlantUnitService.GetInstance();//电站单元服务
        CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();//采集器服务
        /// <summary>
        /// 功能：电站单元列表
        /// 描述：根据电站Id查询该电站的单元
        /// 作者：张月
        /// 时间：2011年3月11日 16:10:15
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns>电站单元页面</returns>
        [HttpGet]
        public ActionResult List(int id)
        {
            Plant plant = FindPlant(id);
            ViewData["plantid"] = id;
            IList<PlantUnit> plantUnits = PlantUnitService.GetInstance().GetAllPlantUnitsByPlantId(id);
            User user = UserService.GetInstance().Get(int.Parse(plant.userID.ToString()));
            if (plantUnits.Count == 0 && user.username != UserUtil.demousername)
                return RedirectToAction("bind", "unit", new { @id = id });
            ViewData["plantUnits"] = plantUnits;
            return View(plant);
        }


        public ActionResult Units_Output(int id)
        {
            Plant plant = FindPlant(id);
            IList<PlantUnit> plantUnits = PlantUnitService.GetInstance().GetAllPlantUnitsByPlantId(id);
            CsvStreamWriter writer = new CsvStreamWriter();
            IList<string> listData = new List<string>();

            listData.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},", Resources.SunResource.PLANT_UNIT_LIST_STATUS, Resources.SunResource.PLANT_UNIT_DATA_SOURCE_CODE
                , Resources.SunResource.PLANT_UNIT_LIST_UNIT_NAME,
                Resources.SunResource.PLANT_UNIT_LIST_POWER + "(kW)",
                Resources.SunResource.PLANT_UNIT_LIST_YEAR_ENERGY + "(kWh)",
                Resources.SunResource.PLANT_UNIT_LIST_ENERGY + "(kWh)",
                Resources.SunResource.PLANT_UNIT_LIST_MONTH_ENERGY + "(kWh)",
                Resources.SunResource.PLANT_UNIT_LIST_MONTH_ENERGY_KWP + "(kWh/kWp)",
                Resources.SunResource.PLANT_UNIT_LIST_YEAR_ENERGY_KWP + "(kWh/kWp)"
                ));

            CollectorMonthDayData cmData = null;
            CollectorYearData cyData = null;
            foreach (PlantUnit unit in plantUnits)
            {

                float currentMonthEnergy = 0;
                float currentYearEnergy = 0;
                cmData = CollectorMonthDayDataService.GetInstance().GetCollectorMonthDayData(DateTime.Now.Year, unit.collector.id, DateTime.Now.Month);
                currentMonthEnergy = cmData == null ? 0 : cmData.count();
                cyData = CollectorYearDataService.GetInstance().GetCollectorYearData(unit.collector.id, DateTime.Now.Year);
                currentYearEnergy = cyData == null ? 0 : cyData.dataValue;
                listData.Add(string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},", unit.isWork(plant.timezone) ? Resources.SunResource.MONITORITEM_WORKING : Resources.SunResource.MONITORITEM_STOPPED, string.Format("\t{0}", unit.collector.code)
               , string.Format("\t{0}", unit.displayname),
               unit.TodayPower(plant.timezone).ToString(),
               currentYearEnergy.ToString(),
               unit.displayTotalEnergy.ToString(),
               currentMonthEnergy.ToString(),
               Math.Round(currentMonthEnergy / unit.chartPower, 2).Equals(double.NaN) ? "0" : Math.Round(currentMonthEnergy / unit.chartPower, 2).ToString(),
               Math.Round(currentYearEnergy / unit.chartPower, 2).Equals(double.NaN) ? "0" : Math.Round(currentYearEnergy / unit.chartPower, 2).ToString()
               ));

            }

            writer.AddStrDataList(listData);


            string fullFile = Server.MapPath("/") + "tempexportfile\\" + Resources.SunResource.PLANT_UNIT_LIST_FILENAME + ".csv";
            writer.Save(fullFile);
            //转化为csv格式的字符串
            ActionResult tmp = File(fullFile, "text/csv; charset=UTF-8", urlcode(Resources.SunResource.PLANT_UNIT_LIST_FILENAME) + ".csv");
            return tmp;
        }



        [HttpGet]
        public ActionResult Detail(int id)
        {
            Plant plant = FindPlant(id);
            ViewData["plantid"] = id;
            IList<PlantUnit> plantUnits = PlantUnitService.GetInstance().GetAllPlantUnitsByPlantId(id);
            User user = UserService.GetInstance().Get(int.Parse(plant.userID.ToString()));
            if (plantUnits.Count == 0 && user.username != UserUtil.demousername)
                return RedirectToAction("bind", "unit", new { @id = id });
            ViewData["plantUnits"] = plantUnits;
            return View(plant);
        }

        /// <summary>
        /// 功能：删除单元
        /// 描述：根据电站Id和单元Id
        /// </summary>
        /// <param name="id">电站id</param>
        /// <param name="x">单元id集合</param>
        /// <returns>电站单元页面</returns>
        [IsLoginAttribute]
        public ActionResult DeleteList(string plantId, string unitId)
        {
            try
            {
                string[] s = unitId.Split(',');
                for (int i = 0; i < s.Length; i++)
                {
                    //根据电站id和电站单元Id查询该电站是否有该单元
                    PlantUnit plantUnit = plantUnitService.GetPlantUnitByPlantIdPlantUnitId(int.Parse(plantId), Convert.ToInt32(s[i]));
                    if (plantUnit == null)
                        return RedirectToAction("list", "unit", new { @id = plantId });
                    else
                    {
                        plantUnitService.DeletePlantUnit(int.Parse(plantId), Convert.ToInt32(s[i]));//根据电站Id和电站单元Id删除电站单元
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return RedirectToAction("list", "unit", new { @id = plantId });
        }
        /// <summary>
        /// 功能：删除单元
        /// 描述：根据电站Id和单元Id
        /// </summary>
        /// <param name="id">电站id</param>
        /// <param name="x">单元id集合</param>
        /// <returns>电站单元页面</returns>
        [IsLoginAttribute]
        public ActionResult DeleteUnit(string plantId, string unitId)
        {
            try
            {
                //根据电站id和电站单元Id查询该电站是否有该单元
                PlantUnit plantUnit = plantUnitService.GetPlantUnitByPlantIdPlantUnitId(int.Parse(plantId), Convert.ToInt32(unitId));
                if (plantUnit == null)
                    return RedirectToAction("list", "unit", new { @id = plantId });
                else
                {
                    plantUnitService.DeletePlantUnit(int.Parse(plantId), int.Parse(unitId));//根据电站Id和电站单元Id删除电站单元
                    Collector collector = collectorInfoService.GetClollectorByCodePass(plantUnit.collector.code, plantUnit.collector.password);
                    PlantUnit plantunit = plantUnitService.GetPlantUnitByCollectorId(collector.id);//查找在单元表里是否绑定了该采集器
                    if (plantunit != null)
                        collector.isUsed = true;//如果采集器已经和单元绑定了就为已用状态
                    else
                        collector.isUsed = false;
                    collectorInfoService.Save(collector);
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return RedirectToAction("list", "unit", new { @id = plantId });
        }
        /// <summary>
        /// 功能：跳转到添加页面
        /// </summary>
        /// <returns>添加页面</returns>
        public ActionResult Bind(int id, string name, string code)
        {
            if (TempData["error"] != null)
            {
                ModelState.AddModelError("Error", TempData["error"] as string);
            }
            PlantUnit plantUnit = new PlantUnit();
            plantUnit.displayname = name;
            plantUnit.collector = new Collector();
            plantUnit.collector.code = code;
            ViewData["unit"] = plantUnit;
            UserUtil.ResetLogin(UserUtil.getCurUser());
            return View(FindPlant(id));
        }

        /// <summary>
        /// 功能：添加单元
        /// 描述：根据采集器名称，密码，批量添加电站单元
        /// 作者：张月
        /// 时间：2011年3月12日 10:54:03
        /// </summary>
        /// <param name="id">电站ID</param>
        /// <param name="conllector">采集器集合</param>
        /// <param name="displayname">电站单元名称集合</param>
        /// <returns>成功返回单元列表页面</returns>
        [IsLoginAttribute]
        public ActionResult Save(int plantid, PlantUnit plantunit)
        {

            //foreach (PlantUnit plantunit in plantunits)
            //{  //根据采集器名称和密码判断该采集器设否存在
            Collector collector = collectorInfoService.GetClollectorByCodePass(plantunit.collector.code, plantunit.collector.password);
            if (collector != null && (collector.userId == 0 || collector.userId == UserUtil.getCurUser().id))
            {
                PlantUnit plantUnit = plantUnitService.GetPlantUnitByCollectorId(collector.id);//根据collectorID去查询，该采集器是否已经绑定了电站
                if (plantUnit == null)
                {
                    plantunit.collector.id = collector.id;
                    plantunit.collectorID = collector.id;
                    plantunit.collector = collector;
                    plantUnitService.AddPlantUnit(plantunit);//添加电站单元
                    collector.isUsed = true;//如果采集器已经和单元绑定了就为已用状态
                    collectorInfoService.Save(collector);
                    if (Request["fromurl"] == null || Request["fromurl"].Equals(""))
                        return RedirectToAction("list", "unit", new { @id = plantid });
                    else
                        return Redirect(Request["fromurl"]);
                }
                else
                {
                    collector.isUsed = true;//如果采集器已经和单元绑定了就为已用状态
                    collectorInfoService.Save(collector);
                    TempData["error"] = Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_BINDED;
                    return RedirectToAction("bind", "unit", new { @id = plantid, @name = plantunit.displayname, @code = plantunit.collector.code, @fromurl = Request["fromurl"] });

                }

            }
            else
            {
                TempData["error"] = Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_ERROR + "！";
                return RedirectToAction("bind", "unit", new { @id = plantid, @name = plantunit.displayname, @code = plantunit.collector.code, @fromurl = Request["fromurl"] });
            }
            //}
        }
        /// <summary>
        /// 功能：根据id跳转到编辑页面
        /// 作者：张月
        /// 时间：2011年3月12日 13:16:57
        /// </summary>
        /// <returns>编辑页面</returns>
        public ActionResult Edit(int unitId, int plantId)
        {
            ViewData["unit"] = plantUnitService.GetPlantUnitById(unitId);
            ViewData["plantid"] = plantId;
            return View(FindPlant(plantId));
        }
        /// <summary>
        /// 功能：编辑单元
        /// 作者：张月
        /// 时间：2011年3月13日 19:34:59
        /// </summary>
        /// <param name="plantunit">单元实体</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Edit(int plantid, PlantUnit plantunit)
        {
            plantUnitService.EditPlantUnit(plantunit);//修改电站单元
            return RedirectToAction("list", "unit", new { @id = plantid });
        }

        [HttpPost]
        public ActionResult Check(string pid, string uname, string uid)
        {
            int _pid = 0;
            int _uid = 0;
            int.TryParse(pid, out _pid);
            int.TryParse(uid, out _uid);

            Plant plant = FindPlant(_pid);
            foreach (PlantUnit unit in plant.plantUnits)
            {
                if (unit.displayname.Equals(uname.Trim()) && (unit.id.Equals(_uid) == false))
                {
                    return Content("false");
                }
            }
            return Content("true");
        }
    }
}
