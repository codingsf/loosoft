using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{
    public class DbconfigController : BaseController
    {
        /// <summary>
        /// 电站数据分布测试
        /// Author: 赵文辉
        /// Time: 2011年2月24日
        /// </summary>
        /// <returns></returns>
        [HandleError]
        [IsLoginAttributeAdmin]
        public ActionResult Index()
        {
            DbConfigService dbconfigService = DbConfigService.GetInstance();
            IList<Dbconfig> dbconfigs = dbconfigService.GetDbcongifs();
            if (dbconfigs.Count > 0)
            {
                ViewData["dbconfigsService"] = dbconfigs;
            }
            else
            {
                return RedirectToAction("Success", "Home");
            }
            return View();
        }

        /// <summary>
        /// 添加电站数据分布
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult Dbconfig_Edit()
        {
            return View();
        }

        /// <summary>
        /// 添加电站数据分布
        /// </summary>
        /// <param name="collectorInfo">电站数据分布字段</param>
        /// <returns>添加成功 转到显示页面</returns>
        [HttpPost]
        [IsLoginAttributeAdmin]
        public ActionResult Add(Dbconfig dbconfig)
        {
            PlantService plantInfoService = PlantService.GetInstance();
            Plant plantInfo = plantInfoService.GetPlantInfoById(dbconfig.id);
            if (plantInfo == null)
            {
                ModelState.AddModelError("Error", "该电站不存在");
            }
            else
            {
                //if (string.IsNullOrEmpty(dbconfig.Id))
                //    ModelState.AddModelError("Code", "采集器编号不能为空");
                if (string.IsNullOrEmpty(dbconfig.year))
                    ModelState.AddModelError("Year", "年份不能为空");
                if (string.IsNullOrEmpty(dbconfig.url))
                    ModelState.AddModelError("地址", "地址不能为空");
                if (ModelState.IsValid)
                {
                    // 创建电站数据分布服务
                    DbConfigService dbconfigService = DbConfigService.GetInstance();
                    try
                    {
                        // 添加电站数据分布
                        dbconfigService.Add(dbconfig);
                    }
                    catch
                    {
                        ModelState.AddModelError("Error", "已存在该电站信息");
                    }
                }
            }
            return View(dbconfig);
        }


        /// <summary>
        /// 查询电站数据分布信息
        /// </summary>
        /// <param name="collectorInfo">电站数据字段</param>
        /// <returns>转到显示页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult Update(Dbconfig dbconfig)
        {
            DbConfigService dbconfigService = DbConfigService.GetInstance();
            dbconfig = dbconfigService.GetDbcongifById(dbconfig.id);
            return View(dbconfig);
        }

        /// <summary>
        /// 修改电站数据分布信息
        /// </summary>
        /// <param name="dbconfig">电站数据字段</param>
        /// <returns>修改成功后返回列表</returns>
        [IsLoginAttributeAdmin]
        public ActionResult UpdateDbconfig(Dbconfig dbconfig)
        {
            PlantService plantInfoService = PlantService.GetInstance();
            Plant plantInfo = plantInfoService.GetPlantInfoById(dbconfig.id);
            if (plantInfo == null)
            {
                ModelState.AddModelError("Error", "该电站不存在");
            }
            else
            {
                //if (string.IsNullOrEmpty(dbconfig.Id))
                //    ModelState.AddModelError("Code", "采集器编号不能为空");
                if (string.IsNullOrEmpty(dbconfig.year))
                    ModelState.AddModelError("Year", "年份不能为空");
                if (string.IsNullOrEmpty(dbconfig.url))
                    ModelState.AddModelError("地址", "地址不能为空");
                if (ModelState.IsValid)
                {
                    // 创建电站数据分布服务
                    DbConfigService dbconfigService = DbConfigService.GetInstance();
                    try
                    {
                        // 添加电站数据分布
                        dbconfigService.Update(dbconfig);
                    }
                    catch
                    {
                        ModelState.AddModelError("Error", "已存在该电站信息");
                    }
                }
            }
            return RedirectToAction("Index");
        }

        /// <summary>
        /// 跳转到详情页面
        /// </summary>
        /// <param name="collectorInfo">电站数据分布字段</param>
        /// <returns>详情页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult Detail(Dbconfig dbconfig)
        {
            string code = Request.QueryString["id"].ToString();
            DbConfigService dbconfigService = DbConfigService.GetInstance();
            dbconfig = dbconfigService.GetDbcongifById(dbconfig.id);
            return View(dbconfig);
        }

        /// <summary>
        /// 电站数据分布信息
        /// </summary>
        /// <returns>删除成功 转到显示页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult Delete()
        {
            int id = int.Parse(Request.QueryString["Id"].ToString());
            DbConfigService dbconfigService = DbConfigService.GetInstance();
            dbconfigService.Delete(id);
            return RedirectToAction("Index");
        }

    }
}
