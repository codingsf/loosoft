using System.Collections.Generic;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{
    /// <summary>
    /// 功能:协议测点控制器
    /// 作者：张月
    /// 时间：2011年2月26日 10:55:39
    /// </summary>
    [HandleError]
    [IsLoginAttributeAdmin]
    public class MonitorItemController:BaseController
    {
        MonitorItemService monitorItemService = MonitorItemService.GetInstance();//设备型号业务实例

        /// <summary>
        /// 显示测点列表，翻页待补充
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult List(string id)
        {
            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageIndex = no, PageSize = ComConst.PageSize };
            ViewData["page"] = page;
            IList<MonitorItem> miList = monitorItemService.GetMonitorItemsByPage(page);
            return View(miList);
        }

        /// <summary>
        /// 新增设备型号
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult Add() {
            //取得大类型
            ICollection<ProtocolType> protocolTypes = DeviceData.getProtocolTypeList();
            ViewData["selectProtocolTypes"] = convertDomainListToSelectList(protocolTypes, null);
            return View(@"edit");
        }

        /// <summary>
        /// 编辑设备型号
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult Edit(string id)
        {
            if (string.IsNullOrEmpty(id))
                return View();
            MonitorItem dm = monitorItemService.Get(id);
            //取得大类型
            ICollection<ProtocolType> protocolTypes = DeviceData.getProtocolTypeList();
            ViewData["selectProtocolTypes"] = convertDomainListToSelectList(protocolTypes, dm.protocolTypeCode);

            return View(@"edit", dm);
        }
        [IsLoginAttributeAdmin]
        private IList<SelectListItem> convertDomainListToSelectList(ICollection<ProtocolType> deviceTypes, int? selectedCode)
        {
            IList<SelectListItem> selectDeviceTypes = new List<SelectListItem>();
            bool isSelected = false;

            foreach (ProtocolType deviceType in deviceTypes)
            {
                if (selectedCode != null && selectedCode == deviceType.code)
                {
                    isSelected = true;
                }
                selectDeviceTypes.Add(new SelectListItem { Text = deviceType.name, Value = deviceType.code.ToString(), Selected = isSelected });
            }
            return selectDeviceTypes;
        }

        /// <summary>
        /// 保存设备型号
        /// </summary>
        /// <param name="MonitorItem"></param>
        /// <returns></returns>
        [HttpPost]
        [IsLoginAttributeAdmin]
        public ActionResult Save(MonitorItem MonitorItem)
        {
            monitorItemService.Save(MonitorItem);
            return RedirectToAction("list", "MonitorItem");
        }
        
        /// <summary>
        /// 删除测点
        /// </summary>
        /// <param name="id">测点代码</param>
        /// <returns></returns>
        [HttpGet]
        [IsLoginAttributeAdmin]
        public ActionResult Delete(string id)
        {
            monitorItemService.Delete(id);
            return RedirectToAction("list", "MonitorItem");
        }
    }   
}
