using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Service;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{
    public class CollectorController : BaseController
    {
        PlantUnitService plantUnieService = PlantUnitService.GetInstance();//电站单元的服务
        /// <summary>
        /// 采集器信息测试
        /// Author: 赵文辉
        /// Time: 2011年2月18日 19:05:14
        /// Author: 张月修改
        /// Time:2011年4月20日 
        /// </summary>
        /// <returns></returns>
        [HandleError]
        [IsLoginAttributeAdmin]
        public ActionResult Index()
        {
            CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();
            IList<Collector> collectorInfos = collectorInfoService.GetColloectorInfos();
            foreach (Collector collector in collectorInfos)
            {
                PlantUnit plantunit = plantUnieService.GetPlantUnitByCollectorId(collector.id);//查找在单元表里是否绑定了该采集器
                if (plantunit != null)
                    collector.isUsed = true;//如果采集器已经和单元绑定了就为已用状态
                else
                    collector.isUsed = false;
            }
            return View(collectorInfos);
        }



        /// <summary>
        /// 跳转到详情页面
        /// </summary>
        /// <param name="collectorInfo">采集器字段</param>
        /// <returns>详情页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult Detail(Collector collectorInfo)
        {
            int id = int.Parse(Request.QueryString["id"]);
            CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();
            collectorInfo = collectorInfoService.GetCollectorById(id);
            return View(collectorInfo);
        }

        /// <summary>
        /// 删除采集器信息
        /// </summary>
        /// <returns>删除成功 转到显示页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult Delete()
        {
            //string id = Request.QueryString["Id"].ToString();
            //CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();
            //collectorInfoService.Delete(id);
            return RedirectToAction("Index");
        }
        [IsLoginAttributeAdmin]
        public ActionResult Upload()
        {
            return View();
        }
        [AcceptVerbs(HttpVerbs.Post)]
        [IsLoginAttributeAdmin]
        public ActionResult Excel(HttpPostedFileBase uploadFile)
        {
            StringBuilder strValidations = new StringBuilder(string.Empty);
            try
            {
                string filePath = Path.Combine(HttpContext.Server.MapPath("../ufile"), Path.GetFileName(uploadFile.FileName));
                if (uploadFile.ContentLength > 0)
                {
                    Path.GetFileName(uploadFile.FileName);
                    uploadFile.SaveAs(filePath);
                    string ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("../files/") + uploadFile.FileName.Split('\\')[3].ToString() + ";Extended Properties=Excel 12.0;";
                    using (OleDbConnection conn = new System.Data.OleDb.OleDbConnection(ConnectionString))
                    {
                        conn.Open();
                        using (DataTable dtExcelSchema = conn.GetSchema("Tables"))
                        {
                            string sheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
                            string query = "SELECT * FROM [" + sheetName + "]";
                            OleDbDataAdapter adapter = new OleDbDataAdapter(query, conn);
                            DataSet ds = new DataSet();
                            adapter.Fill(ds, "Items");
                            if (ds.Tables.Count > 0)
                            {
                                if (ds.Tables[0].Rows.Count > 0)
                                {
                                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                                    {
                                        //这里添加到数据库操作
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch
            { }
            return View();

        }
    }
}