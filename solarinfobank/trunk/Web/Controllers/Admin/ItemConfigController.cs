using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{
    /// <summary>
    /// 系统设置
    /// </summary>
    public class ItemConfigController : BaseController
    {
        ItemConfigService itemConfigService = ItemConfigService.GetInstance();
        //
        // GET: /ItemConfig/
        //
        [HandleError]
        [IsLoginAttributeAdmin]
        public ActionResult Index()
        {
            ItemConfigService itemconfigService = ItemConfigService.GetInstance();
            IList<ItemConfig> itemconfigs = itemconfigService.GetItemConfigList();
            return View(itemconfigs);
        }

        /// <summary>
        /// 添加系统设置信息
        /// </summary>
        /// <returns>添加界面</returns>
        [HttpGet]
        [IsLoginAttributeAdmin]
        public ActionResult Create()
        {
            return View();
        }

        /// <summary>
        /// 添加系统设置信息
        /// </summary>
        /// <param name="itemConfig">系统设置字段</param>
        /// <returns>添加成功 返回该页</returns>
        [HttpPost]
        [IsLoginAttributeAdmin]
        public ActionResult Create(ItemConfig itemConfig)
        {
            ItemConfigService itemConfigService = ItemConfigService.GetInstance();
            if (string.IsNullOrEmpty(itemConfig.name))
            {
                ModelState.AddModelError("Name", "相关设置名称不能为空！");
            }
            //if (itemConfig.value==null)
            //{
            //    ModelState.AddModelError("Value", "相关设置值不能为空！");
            //}
            if (itemConfigService.Exists(itemConfig.name))//如果存在不能添加
            {
                ModelState.AddModelError("Exist", "相关设置名称已存在");
            }
            if (ModelState.IsValid)
            {
                int flag = itemConfigService.AddItemConfig(itemConfig);
                if (flag > 0)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("Fails", "相关配置创建失败！");
                    return View();
                }
            }
            else
            {
                return View();
            }
        }

        /// <summary>
        /// 系统配置详细
        /// </summary>
        /// <param name="id">配置Id</param>
        /// <returns>配置信息</returns>
        [HttpGet]
        [IsLoginAttributeAdmin]
        public ActionResult Details(int id)
        {
            ItemConfigService itemConfigService = ItemConfigService.GetInstance();
            ItemConfig itemConfig = itemConfigService.GetItemConfig(id);
            return View(itemConfig);
        }

        /// <summary>
        /// 删除系统配置
        /// </summary>
        /// <param name="id">配置Id</param>
        /// <returns>系统配置列表</returns>
        [HttpGet]
        [IsLoginAttributeAdmin]
        public ActionResult Delete(int id)
        {
            ItemConfigService itemConfigService = ItemConfigService.GetInstance();
            int flag = itemConfigService.DeleteItemConfig(id);
            if (flag > 0)
            {
                return RedirectToAction("Index");
            }
            else
            {
                ModelState.AddModelError("Fails", "相关配置删除失败！");
                return RedirectToAction("Error");
            }
        }

        /// <summary>
        /// 获得所有系统配置信息
        /// </summary>
        /// <param name="id">配置Id</param>
        /// <returns>系统配置信息</returns>
        [HttpGet]
        [IsLoginAttributeAdmin]
        public ActionResult Edit()
        {
            ItemConfig itemConfig = itemConfigService.GetItemConfigByName(ItemConfig.CO2);
            return View(itemConfig);
        }

        [HttpGet]
        [IsLoginAttributeAdmin]
        public ActionResult Tree()
        {
            ItemConfig itemConfig = itemConfigService.GetItemConfigByName(ItemConfig.Tree);
            return View(itemConfig);
        }


        /// <summary>
        /// 修改系统配置信息
        /// </summary>
        /// <param name="itemConfig">系统配置字段</param>
        /// <returns>系统配置列表</returns>
        [HttpPost]
        [IsLoginAttributeAdmin]
        public ActionResult Edit(ItemConfig itemConfig)
        {
            itemConfigService.Update(itemConfig);
            return View();
        }
        [HttpPost]
        [IsLoginAttributeAdmin]
        public ActionResult Tree(ItemConfig itemConfig)
        {
            itemConfigService.Update(itemConfig);
            ItemConfig.treeConvert = itemConfig.value;
            return View();
        }

        public ActionResult reg_collector()
        {
            ItemConfig config = itemConfigService.GetItemConfig(ItemConfig.maxexpiredDaysId);
            ViewData["days"] = config.value;
            config = itemConfigService.GetItemConfig(ItemConfig.maxCollectorCountId);
            ViewData["count"] = config.value;
            return View();
        }

        [HttpPost]
        public ActionResult reg_collector(string days, string count)
        {
           
            int tid = 0;
            int.TryParse(count, out tid);
            ItemConfig config = new ItemConfig();
            config.id = ItemConfig.maxCollectorCountId;
            config.type = 1;
            config.value = tid;
            itemConfigService.UpdateValue(config);//更新数量

            config.id = ItemConfig.maxexpiredDaysId;//更新天数
            int.TryParse(days, out tid);
            config.value = tid;
            itemConfigService.UpdateValue(config);//更新天数
            TempData["return"] = "修改成功";
            return Redirect("/itemconfig/reg_collector");
        }




    }
}
