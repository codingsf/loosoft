using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{
    /// <summary>
    /// 功能:设备信息控制器
    /// 作者：张月
    /// 时间：2011年2月26日 10:55:39
    /// </summary>
    [HandleError]
    [IsLoginAttributeAdmin]
    public class InverterController:BaseController
    {
      
        User user = new User();          //用户实体
        Plant plantInfo = new Plant();   //电站信息实体
        PlantService plantInfoService = PlantService.GetInstance();          //电站信息服务
        //InverterService inverterService = InverterService.GetInstance();//设备信息
        DeviceRunDataService deviceRunDataService = DeviceRunDataService.GetInstance();//设备实时数据
        /// <summary>
        /// 根据电站Id获取设备
        /// </summary>
        /// <returns>页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult InverterTree(string id)
        {
            return View();
           
        }
        /// <summary>
        /// 点击设备显示设备状态
        /// </summary>
        /// <param name="id">设备Id</param>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult DeviceInfo(string id,string device)
        {
        
            return View();
        }
        /// <summary>
        /// 设备类型树
        /// </summary>
        /// <returns>页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult TreeView(string id)
        {
            return View();
        }
    }
}
