using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Data.OleDb;
using System.Data;
using System.Text;
using System.IO;
using System.Web.UI.WebControls;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{
    /// <summary>
    /// 功能:设备型号控制器
    /// 作者：张月
    /// 时间：2011年2月26日 10:55:39
    /// </summary>
    [HandleError]
    [IsLoginAttributeAdmin]
    public class DeviceModelController:BaseController
    {
        DeviceModelService deviceModelService = DeviceModelService.GetInstance();//设备型号业务实例

        /// <summary>
        /// 显示设备型号列表，翻页待补充
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult List(string id)
        {
            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() {  PageIndex=no, PageSize=ComConst.PageSize};
            ViewData["page"] = page;
            IList<DeviceModel> dvList = deviceModelService.GetDevicemodelsByPage(page);
            return View(dvList);
        }

        /// <summary>
        /// 新增设备型号
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult Add() {
            //取得大类型
            ICollection<DeviceType> deviceTypes = DeviceData.getDeviceTypeList();
            ViewData["selectDeviceTypes"] = convertDomainListToSelectList(deviceTypes, null);
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

            int cid = 0;
            int.TryParse(id, out cid);
            DeviceModel dm = deviceModelService.Get(cid);
            //取得大类型
            ICollection<DeviceType> deviceTypes = DeviceData.getDeviceTypeList();
            ViewData["selectDeviceTypes"] = convertDomainListToSelectList(deviceTypes,dm.code);

            return View(@"edit", dm);
        }
        [IsLoginAttributeAdmin]
        private IList<SelectListItem> convertDomainListToSelectList(ICollection<DeviceType> deviceTypes,int? selectedCode)
        {
            IList<SelectListItem> selectDeviceTypes = new List<SelectListItem>();
            bool isSelected = false;

            foreach (DeviceType deviceType in deviceTypes) {
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
        /// <param name="deviceModel"></param>
        /// <returns></returns>
        [HttpPost]
        [IsLoginAttributeAdmin]
        public ActionResult Save(DeviceModel deviceModel)
        {
            deviceModelService.Save(deviceModel);
            return RedirectToAction("list", "devicemodel");
        }

        /// <summary>
        /// 删除设备型号
        /// </summary>
        /// <param name="code">型号代码</param>
        /// <returns></returns>
        [HttpGet]
        [IsLoginAttributeAdmin]
        public ActionResult Delete(string id)
        {
            DeviceModel model = deviceModelService.Get(Convert.ToInt32(id));
            if (model.isUsed == 0)
            {
                deviceModelService.Delete(model.code);
            }
            return RedirectToAction("list", "devicemodel");

        }
    }   
}
