using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.OleDb;
using System.Data;
using System.Text;
using System.IO;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using Common;
using System.Threading;


namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{
    public partial class AdminController : AdminBaseController
    {
        DeviceService deviceService = DeviceService.GetInstance();
        LanguageService languageService = LanguageService.GetInstance();
        DbConfigService dbconfigService = DbConfigService.GetInstance();
        CollectorInfoService collectorInfoservice = CollectorInfoService.GetInstance();
        ManagerService managerService = ManagerService.GetInstance();
        ProductPictureService productPictureService = ProductPictureService.GetInstance();
        AdpicService adpicService = AdpicService.GetInstance();
        PlantUserService plantUserService = PlantUserService.GetInstance();
        UserService userService = UserService.GetInstance();
        PlantService plantService = PlantService.GetInstance();
        [IsLoginAttributeAdmin]
        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// 添加产品图片
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult UploadProductPic()
        {
            return View(@"product/UploadProPic");
        }
        /// <summary>
        /// 修改产品图片
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult EditProductPic(int id)
        {
            ProductPicture productPicture = productPictureService.GetProductPicture(id);
            return View(@"product/EditProductPic", productPicture);
        }
        /// <summary>
        /// 功能：上传产品图片
        /// 作者：张月
        /// 时间：2011年3月29日
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post)]
        [IsLoginAttributeAdmin]
        public ActionResult UploadProductPic(HttpPostedFileBase PicName, ProductPicture pro)
        {
            try
            {
                if (!Directory.Exists(Server.MapPath("/ProductPic/")))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("/ProductPic/"));
                }
                //图片保存的地址和名称
                Random random = new Random(DateTime.Now.Millisecond);
                string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + random.Next(10000) + PicName.FileName.Substring(PicName.FileName.LastIndexOf('\\') + 1);
                string filePath = Path.Combine(HttpContext.Server.MapPath("../ProductPic/"), filename);
                if (PicName.ContentLength > 0)
                {
                    Path.GetFileName(PicName.FileName);
                    PicName.SaveAs(filePath);
                    pro.picName = filename;
                    productPictureService.AddProductPicture(pro);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return RedirectToAction(@"ProductPicList", "admin");
        }
        /// <summary>
        /// 修改产品信息
        /// </summary>
        /// <param name="pro"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult EditProductPic(ProductPicture pro)
        {
            productPictureService.ModifyProductPicture(pro);
            return RedirectToAction(@"ProductPicList", "admin");
        }
        /// <summary>
        /// 功能：产品图片列表
        /// 作者：张月
        /// 时间：2011年3月29日
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult ProductPicList(string id)
        {
            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageIndex = no, PageSize = ComConst.PageSize };
            ViewData["page"] = page;
            IList<ProductPicture> list = productPictureService.GetProductPicturePage(page);
            ViewData["list"] = list;
            return View(@"product/ProductPicList");
        }

        /// <summary>
        /// 添加宣传图片
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult UploadAdpic()
        {
            ViewData["langs"] = Cn.Loosoft.Zhisou.SunPower.Service.LanguageService.GetInstance().GetList();
            return View(@"Department/UploadAdpic");
        }
        /// <summary>
        /// 修改宣传图片
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult EditAdpic(int id)
        {
            Adpic adpic = adpicService.GetAdpic(id);
            return View(@"Department/EditAdpic", adpic);
        }
        /// <summary>
        /// 修改宣传图片
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        [HttpPost]
        public ActionResult EditAdpic(Adpic adpic)
        {
            adpicService.ModifyAdpic(adpic);
            return RedirectToAction(@"DepartmentList", "admin");
        }
        /// <summary>
        /// 功能：上传宣传图片
        /// 作者：张月
        /// 时间：2011年3月29日
        /// </summary>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        [IsLoginAttributeAdmin]
        public ActionResult UploadDepartmentPic(Adpic adpic, HttpPostedFileBase picName)
        {
            try
            {
                if (!Directory.Exists(Server.MapPath("/DepartmentPic/" + adpic.language)))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("/DepartmentPic/" + adpic.language));
                }
                //图片保存的地址和名称
                Random random = new Random(DateTime.Now.Millisecond);
                string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + random.Next(10000) + picName.FileName.Substring(picName.FileName.LastIndexOf('\\') + 1);
                string filePath = Path.Combine(HttpContext.Server.MapPath("../DepartmentPic/" + adpic.language), filename);
                if (picName.ContentLength > 0)
                {
                    Path.GetFileName(picName.FileName);
                    picName.SaveAs(filePath);
                    adpic.picName = filename;
                    adpicService.AddAdpic(adpic);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return Content(e.Message);
            }
            return RedirectToAction(@"DepartmentList", "admin");
        }
        /// <summary>
        /// 功能：宣传图片列表
        /// 作者：张月
        /// 时间：2011年3月29日
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult DepartmentList(string id)
        {

            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageIndex = no, PageSize = ComConst.PageSize };
            ViewData["page"] = page;
            IList<Adpic> list = adpicService.GetAdpicPage(page);
            ViewData["list"] = list;
            ViewData["page"] = page;
            return View(@"Department/list");
        }

        /// <summary>
        /// 功能：删除宣传图片
        /// 作者：张月
        /// 时间：2011年3月29日
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult DelDepartmentPic(int id)
        {
            Adpic adpic = adpicService.GetAdpic(id);
            if (!string.IsNullOrEmpty(adpic.picName))
            {
                try
                {
                    adpicService.DelAdpic(id);
                    System.IO.File.Delete(HttpContext.Server.MapPath("/DepartmentPic/" + adpic.language + "/" + adpic.picName));
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }

            return RedirectToAction(@"DepartmentList", "admin");
        }
        /// <summary>
        /// 功能：删除产品图片
        /// 作者：张月
        /// 时间：2011年3月29日
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        public ActionResult DelProductPic(int id, string picName)
        {

            if (!string.IsNullOrEmpty(picName))
            {
                try
                {
                    productPictureService.DelProductPicture(id);
                    System.IO.File.Delete(HttpContext.Server.MapPath("../ProductPic/" + picName));
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }

            return RedirectToAction(@"ProductPicList", "admin");
        }


        public ActionResult Collector_Excel()
        {
            return View(@"collector/excel");
        }

        /// <summary>
        /// 上传EXCEL文件action
        /// </summary>
        /// <param name="uploadFile">post数据对象</param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]

        public ActionResult Collector_Excel(HttpPostedFileBase uploadFile)
        {
            int index = 0;
            IList<Collector> failedCollectors = new List<Collector>();
            try
            {
                string folderPath = HttpContext.Server.MapPath("/mfile/");
                if (System.IO.Directory.Exists(folderPath) == false)
                    System.IO.Directory.CreateDirectory(folderPath);

                //保留文件  加上时间防止重名覆盖
                string filePath = Path.Combine(folderPath, Path.GetFileName(uploadFile.FileName));

                uploadFile.SaveAs(filePath);
                string ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + folderPath + uploadFile.FileName.Substring(uploadFile.FileName.LastIndexOf('\\') + 1) + ";Extended Properties=Excel 12.0;";
                using (OleDbConnection conn = new OleDbConnection(ConnectionString))
                {
                    conn.Open();
                    using (DataTable dtExcelSchema = conn.GetSchema("Tables"))
                    {
                        string sheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
                        string query = "select sn,pass,mac,pno,encryption,date,description,key from [" + sheetName + "]";
                        OleDbDataAdapter adapter = new OleDbDataAdapter(query, conn);
                        DataSet ds = new DataSet();
                        adapter.Fill(ds, "Items");
                        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            IList<Collector> collectors = CollectorInfoService.GetInstance().GetList();
                            bool isExist = false;
                            Collector temp = null;
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                string dtStr = ds.Tables[0].Rows[i][5].ToString();
                                if (string.IsNullOrEmpty(dtStr) == false)
                                {
                                    DateTime dt;
                                    DateTime.TryParse(dtStr, out dt);
                                    if (dt.Equals(DateTime.MinValue))
                                        dt = DateTime.Now;
                                    dtStr = dt.ToString("yyyy-MM-dd");
                                }
                                temp = new Collector
                                {
                                    code = ds.Tables[0].Rows[i][0].ToString(),
                                    Descr = ds.Tables[0].Rows[i][6].ToString(),
                                    MAC = ds.Tables[0].Rows[i][2].ToString(),
                                    password = ds.Tables[0].Rows[i][1].ToString(),
                                    PNO = ds.Tables[0].Rows[i][3].ToString(),
                                    Encryption = ds.Tables[0].Rows[i][4].ToString(),
                                    importDate = DateTime.Now,
                                    Date = string.IsNullOrEmpty(dtStr) ? string.Empty : dtStr,
                                    Key = ds.Tables[0].Rows[i][7].ToString()
                                };
                                string r = CheckDataValidate(temp);
                                if (string.IsNullOrEmpty(r) == false)
                                {
                                    temp.Descr = r;
                                    failedCollectors.Add(temp);
                                    continue;
                                }

                                isExist = false;
                                isExist = collectors.Where(m => m.code.ToLower().Equals(temp.code.ToLower())).Count() > 0;
                                if (isExist)
                                {
                                    temp.Descr = "此 SN 已存在数据库";
                                    failedCollectors.Add(temp);
                                    continue;
                                }
                                CollectorInfoService.GetInstance().Add(temp);
                                index++;
                            }
                        }
                    }
                }
            }
            catch (Exception e)
            {
                ViewData["result"] = string.Format("导入失败{0}", e.Message);
                return View(@"collector/excel");
            }
            ViewData["faildRecord"] = failedCollectors;
            ViewData["result"] = string.Format("总记录数:{0} 条, 导入成功:{1} 条, 导入失败:{2} 条", index + failedCollectors.Count, index, failedCollectors.Count);
            return View(@"collector/excel");

        }


        private string CheckDataValidate(Collector collector)
        {
            if (collector.code.Length < 9 || collector.code.Length > 16)
                return "SN 位数错误";
            if (collector.password.Length < 6 || collector.password.Length > 32)
                return "PASS 位数错误";
            if (collector.MAC.Length < 12 || collector.MAC.Length > 16)
                return "MAC 位数错误";
            if (!(collector.PNO.Length == 20))
                return "PNO 位数错误";
            if (collector.Encryption.Length < 3 || collector.Encryption.Length > 32)
                return "ENCRYPTION 位数错误";
            //if (collector.Key.Length < 32)
            //    return "加密密匙最少需要32位";
            return string.Empty;
        }

        /// <summary>
        /// 获取用户列表
        /// </summary>
        /// <returns>获取用户信息后返回页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult Users(string id)
        {

            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = no };
            UserService userInfoService = UserService.GetInstance();
            IList<User> users = userInfoService.GetUsersByPage(page);
            ViewData["page"] = page;
            return View(@"user/list", users);
        }

        public ActionResult Userdel(int id)
        {
            User user = userService.Get(id);
            IList<PlantUser> childuser = user.plantUsers;
            foreach (PlantUser pu in childuser)
                userService.Delete(pu.userID);//删除当前用户子用户
            userService.Delete(id);
            if (user.ParentUserId == 0)
            {
                IList<PlantUnit> punits = user.plantUnits();
                foreach (Plant p in user.displayPlants)
                    plantService.Remove(p.id);// 删除电站表
                foreach (PlantUnit unit in punits)
                    PlantUnitService.GetInstance().DeletePlantUnitByPlant(unit.plantID);//删除电站 单元关系表
            }
            if (user.UserRole != null && user.UserRole.id > 0)
                UserRoleService.GetInstance().Remove(user.UserRole.id);
            return Redirect("/admin/users");
        }


        [IsLoginAttributeAdmin]
        public ActionResult Users_Output(string id)
        {

            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = no };
            UserService userInfoService = UserService.GetInstance();
            IList<User> users = userInfoService.GetUsersByPage(page);


            IList<ExcelData> eDatas = new List<ExcelData>();
            ExcelData data = new ExcelData();
            IList<string> temp = new List<string>();
            temp.Add("用户名");
            temp.Add("国家");
            temp.Add("性别");
            data.Rows.Add(temp);
            foreach (User user in users)
            {
                temp = new List<string>();
                temp.Add(user.username);
                temp.Add(user.country);
                temp.Add(user.sex.Equals("0") ? "男" : "女");
                data.Rows.Add(temp);
            }
            eDatas.Add(data);
            ExcelStreamWriter writer = new ExcelStreamWriter(eDatas);
            writer.Save("用户列表");
            return File(writer.FullName, "text/xlsx; charset=UTF-8", urlcode(writer.FileName));

        }

        /// <summary>
        /// 获取管理员列表
        /// 陈波
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]

        public ActionResult Managers(string sd, string ed, string type)
        {

            Hashtable table = new Hashtable();
            table["sd"] = sd;
            table["ed"] = ed;
            table["type"] = type;
            IList<Manager> managers = managerService.GetManagersByPara(table);
            if (managers != null)
                foreach (Manager m in managers)
                    m.username = m.username.Replace(".sun.sungrowpower.com", string.Empty);
            return View(@"manager/list", managers);
        }

        /// <summary>
        /// 管理员编辑 接收页面POST提交
        /// </summary>
        /// <param name="manage">管理员对象</param>
        /// <returns></returns>
        [HttpPost]
        [IsLoginAttributeAdmin]

        public ActionResult Manager_Edit(Manager manage)
        {
            int uid = 0;
            string rids = Request.Form["role"];
            rids = string.IsNullOrEmpty(rids) ? "," : rids;
            ManagerService service = ManagerService.GetInstance();
            manage.create_date = DateTime.Now;
            uid = service.Save(manage);
            if (manage.id > 0)
                uid = (int)manage.id;
            AdminUserRoleServices.GetInstance().Remove(uid);
            string[] ridArray = rids.Split(',');
            foreach (string item in ridArray)
                if (string.IsNullOrEmpty(item) == false)
                    AdminUserRoleServices.GetInstance().Save(new AdminUserRole { userId = uid, roleId = int.Parse(item) });
            return RedirectToAction("Managers");

        }

        [HttpPost]
        [IsLoginAttributeAdmin]

        public ActionResult Manager_Add(Manager manage)
        {
            return Manager_Edit(manage);
        }
        /// <summary>
        /// 管理员更新
        /// </summary>
        /// <param name="id">管理员编号</param>
        /// <returns></returns>
        [IsLoginAttributeAdmin]

        public ActionResult Manager_Edit(string id)
        {
            IList<AdminRole> roles = AdminRoleServices.GetInstance().GetList();
            ViewData["roles"] = roles;
            if (string.IsNullOrEmpty(id))
                return View("manager/edit");
            int mid = 0;
            int.TryParse(id, out mid);
            return View(@"manager/edit", managerService.Get(mid));
        }


        [IsLoginAttributeAdmin]

        public ActionResult Manager_Add(string id)
        {
            return Manager_Edit(id);
        }


        /// <summary>
        /// 删除管理员
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [IsLoginAttributeAdmin]

        public ActionResult Manager_Delete(int id)
        {
            ManagerService service = ManagerService.GetInstance();
            service.Remove(id);
            return RedirectToAction("Managers");
        }

        /// <summary>
        /// 管理员所见的所有电站信息
        /// 陈波整理
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]

        public ActionResult Plants(string id)
        {
            int no;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = no };
            PlantService service = PlantService.GetInstance();
            ViewData["page"] = page;
            return View(@"plant/list", service.GetPlantByPage(page));
        }


        [IsLoginAttributeAdmin]

        public ActionResult Plants_Output(string id)
        {
            int no;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = no };
            PlantService service = PlantService.GetInstance();
            IList<Plant> plants = service.GetPlantByPage(page);
            IList<ExcelData> eDatas = new List<ExcelData>();
            ExcelData data = new ExcelData();
            IList<string> temp = new List<string>();
            temp.Add("名称");
            temp.Add("国家");
            temp.Add("城市");
            temp.Add("电话");
            temp.Add("制造商");
            temp.Add("型号类型");
            data.Rows.Add(temp);
            foreach (Plant plant in plants)
            {
                temp = new List<string>();
                temp.Add(plant.name);
                temp.Add(plant.country);
                temp.Add(plant.city);
                temp.Add(plant.phone);
                temp.Add(plant.manufacturer);
                temp.Add(plant.module_type);
                data.Rows.Add(temp);
            }
            eDatas.Add(data);
            ExcelStreamWriter writer = new ExcelStreamWriter(eDatas);
            writer.Save("电站列表");
            return File(writer.FullName, "text/xlsx; charset=UTF-8", urlcode(writer.FileName));


        }

        /// <summary>
        /// 电站数据分布测试
        /// Author: 赵文辉
        /// Time: 2011年2月24日
        /// 修改：陈波
        /// </summary>
        /// <returns></returns>
        [HandleError]
        [IsLoginAttributeAdmin]

        public ActionResult DbConfig()
        {
            return View(@"dbconfig/list", dbconfigService.GetDbcongifs());
        }

        /// <summary>
        /// 采集器信息测试
        /// Author: 赵文辉
        /// Time: 2011年2月18日 19:05:14
        /// </summary>
        /// <returns></returns>
        [IsLoginAttributeAdmin]

        public ActionResult Collectors(string id, string sd, string ed)
        {
            int no = 0;
            int.TryParse(id, out no);
            Hashtable hashpara = new Hashtable();
            hashpara["sd"] = sd;
            hashpara["ed"] = ed;
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = no };
            hashpara["page"] = page;

            CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();
            IList<Collector> collectorInfos = collectorInfoService.GetCollectorsByPage(hashpara);
            foreach (Collector item in collectorInfos)
                if (item.plantID.Equals(0) == false)
                    item.plant = plantService.GetPlantInfoById(item.plantID);
                else
                    item.plant = null;
            ViewData["page"] = page;
            return View(@"collector/list", collectorInfos);
        }


        public ActionResult Collector_Output(string id, string sd, string ed)
        {
            Hashtable hashpara = new Hashtable();
            hashpara["sd"] = sd;
            hashpara["ed"] = ed;
            int no = 0;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = no };
            hashpara["page"] = page;

            CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();
            IList<Collector> collectorInfos = collectorInfoService.GetCollectorsByPage(hashpara);
            IList<ExcelData> eDatas = new List<ExcelData>();
            ExcelData data = new ExcelData();
            IList<string> temp = new List<string>();
            temp.Add("采集器编号");
            temp.Add("密码");
            temp.Add("分配电站");
            temp.Add("电站时间");
            temp.Add("导入时间");
            temp.Add("是否启用");
            temp.Add("工作状态");
            data.Rows.Add(temp);
            foreach (Collector collector in collectorInfos)
            {
                if (collector.plantID.Equals(0) == false)
                    collector.plant = plantService.GetPlantInfoById(collector.plantID);
                else
                    collector.plant = null;
                temp = new List<string>();
                temp.Add(collector.code);
                temp.Add(collector.password);
                temp.Add(collector.plant == null ? "未分配电站" : collector.plant.name);
                temp.Add(collector.plant == null ? "未分配电站" : DateTime.Now.AddHours(collector.plant.timezone).ToString("yy/MM/dd HH:mm"));
                temp.Add(collector.importDate.ToString("yy/MM/dd HH:mm"));

                temp.Add(collector.isUsed.Equals(true) ? "yes" : "no");
                temp.Add(collector.plant == null ? "停止" : (collector.plant.isWork ? "工作" : "停止"));
                data.Rows.Add(temp);
            }
            eDatas.Add(data);
            ExcelStreamWriter writer = new ExcelStreamWriter(eDatas);
            writer.Save("采集器列表");
            return File(writer.FullName, "text/xlsx; charset=UTF-8", urlcode(writer.FileName));

        }


        /// <summary>
        /// 修改采集器信息
        /// </summary>
        /// <param name="collectorInfo">采集器字段</param>
        /// <returns>修改成功 转到显示页面(Code和UserName不能修改)</returns>
        [IsLoginAttributeAdmin]

        public ActionResult Update(Collector collectorInfo)
        {
            int id = int.Parse(Request.QueryString["id"]);
            CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();
            collectorInfo = collectorInfoService.GetCollectorById(id);
            return View(collectorInfo);
        }

        [HttpPost]
        [IsLoginAttributeAdmin]

        public ActionResult Collector_Edit(Collector collector)
        {
            collectorInfoservice = CollectorInfoService.GetInstance();
            collectorInfoservice.Save(collector);
            return RedirectToAction("Collectors");
        }
        [IsLoginAttributeAdmin]
        public ActionResult Collector_Edit(string id)
        {
            if (string.IsNullOrEmpty(id))
                return View(@"collector/edit");
            int cid = 0;
            int.TryParse(id, out cid);
            return View(@"collector/edit", collectorInfoservice.Get(cid));
        }

        [IsLoginAttributeAdmin]
        public ActionResult Collector_Add(string id)
        {
            return Collector_Edit(id);
        }


        [HttpPost]
        [IsLoginAttributeAdmin]
        public ActionResult Collector_Save(Collector collector)
        {
            collector.importDate = DateTime.Now;
            if (collector.id.Equals(0))
            {
                int id = collectorInfoservice.CheckCollectorExists(collector.code);
                if (id > 0)
                {
                    ViewData["error"] = "此采集器已经存在";
                    return View(@"collector/edit");
                }
            }
            collectorInfoservice.Save(collector);
            return RedirectToAction("collectors", "admin");
        }
        [IsLoginAttributeAdmin]
        public ActionResult Collector_Delete(string Id)
        {
            int id = 0;
            int.TryParse(Id, out id);
            CollectorInfoService service = CollectorInfoService.GetInstance();
            if (service.Delete(id) > 0)
                return RedirectToAction("collectors");
            else
                return RedirectToAction("collectors");
        }


        /// <summary>
        /// 查询电站数据分布信息
        /// 陈波修改
        /// </summary>
        /// <param name="collectorInfo">电站数据字段</param>
        /// <returns>转到显示页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult Dbconfig_Edit(string Id)
        {
            if (string.IsNullOrEmpty(Id))
                return View(@"dbconfig/edit");
            int id = 0;
            int.TryParse(Id, out id);
            DbConfigService service = DbConfigService.GetInstance();
            return View(@"dbconfig/edit", service.Get(new Dbconfig() { id = id }));
        }

        /// <summary>
        /// 修改电站数据分布信息
        /// </summary>
        /// <param name="dbconfig">电站数据字段</param>
        /// <returns>修改成功后返回列表</returns>
        [IsLoginAttributeAdmin]
        public ActionResult Dbconfig_Save(Dbconfig dbconfig)
        {
            dbconfigService.Save(dbconfig);
            return RedirectToAction("dbconfig/list");
        }


        /// <summary>
        /// 电站数据分布信息
        /// </summary>
        /// <returns>删除成功 转到显示页面</returns>
        [IsLoginAttributeAdmin]
        public ActionResult Dbconfig_Delete(int id)
        {
            DbConfigService dbconfigService = DbConfigService.GetInstance();
            dbconfigService.Delete(id);
            return RedirectToAction("dbconfig");
        }
        [IsLoginAttributeAdmin]
        public ActionResult Devices()
        {
            IList<ManagerMonitorCode> mmcs = ManagerMonitorCodeService.GetInstance().GetList();
            mmcs = mmcs.Where(model => model.type.Equals(DeviceData.INVERTER_CODE) && model.display == true).ToList<ManagerMonitorCode>();
            ViewData["mmcs"] = mmcs;
            return View(@"device/list");
        }

        [IsLoginAttributeAdmin]
        public ActionResult DeviceModel(int id)
        {
            StringBuilder sbuilder = new StringBuilder();
            sbuilder.AppendFormat("<select name=\"deviceModelId\" id=\"deviceModelId\" class=\"textsy02\">");
            sbuilder.Append("<option value=\"-1\">设备型号</option>");
            DeviceType type = DeviceData.getDeviceTypeByCode(id);
            IList<DeviceModel> models = DeviceModelService.GetInstance().getXhbyDeviceType(id);
            foreach (DeviceModel model in models)
            {
                sbuilder.AppendFormat(" <option value=\"{0}\">{1}</option>", model.code, model.name);
            }
            sbuilder.AppendFormat("</select>");
            return Content(sbuilder.ToString());

        }
        [HttpPost]
        public ActionResult LoadDevice(int plantId, int modelCode, int typeCode, int index)
        {
            Hashtable table = new Hashtable();
            Device device = new Device();
            device.deviceTypeCode = typeCode;
            device.deviceModel = new DeviceModel() { code = modelCode };
            table.Add("device", device);
            table.Add("page", new Pager() { PageSize = ComConst.PageSize, PageIndex = index });
            IList<Device> devices = deviceService.GetDevicesListPage(table);
            ViewData["page"] = table["page"];
            return View("BackDeviceAjax", devices);
        }






        [IsLoginAttributeAdmin]
        public ActionResult Language()
        {
            return View(@"language/index", languageService.GetAllList());
        }
        [IsLoginAttributeAdmin]
        public ActionResult Language_Edit(string id)
        {
            int lid = 0;
            int.TryParse(id, out lid);
            return View(@"language/edit", languageService.Get(lid));
        }
        [HttpPost]
        [IsLoginAttributeAdmin]
        public ActionResult Language_Edit(Language language)
        {
            languageService.Save(language);
            return View(@"language/index", languageService.GetAllList());
        }
        public ActionResult Language_Delete(int id)
        {
            Language language = languageService.Get(id);
            if (language != null && language.isEdited)
            {
                languageService.Save(new Language() { id = id });
            }
            return RedirectToAction(@"language/index", languageService.GetList());
        }
        [IsLoginAttributeAdmin]
        public ActionResult Language_Upload()
        {
            return View(@"language/upload", languageService.GetList());
        }

        [HttpPost]
        [IsLoginAttributeAdmin]
        public ActionResult Language_Upload(string language, HttpPostedFileBase uploadFile)
        {
            int id = 0;
            int.TryParse(language, out id);
            Language lang = languageService.Get(id);
            string filePath = Path.Combine(HttpContext.Server.MapPath("/App_GlobalResources"), string.Format("SunResource.{0}.resx", lang.codename));
            uploadFile.SaveAs(filePath);
            lang.packagename = lang.codename;
            languageService.Save(lang);
            System.IO.Directory.CreateDirectory(Server.MapPath("/DepartmentPic/" + language));//在DepartmentPic下创建这个语言的文件夹存放宣传图片
            return View(@"language/index", languageService.GetList());
        }


        [IsLoginAttributeAdmin]
        public ActionResult Language_delpackage(string id, string language)
        {
            int lid = 0;
            int.TryParse(id, out lid);
            Language lang = languageService.Get(lid);
            string filePath = Path.Combine(HttpContext.Server.MapPath("/App_GlobalResources"), string.Format("SunResource.{0}.resx", lang.codename));
            if (System.IO.File.Exists(filePath))
                System.IO.File.Delete(filePath);
            lang.packagename = string.Empty;
            languageService.Save(lang);
            System.IO.Directory.Delete(HttpContext.Server.MapPath("../DepartmentPic/" + language), true);//删除DepartmentPic文件加下的这个语言的文件夹
            return View(@"language/index", languageService.GetList());
        }
        /// <summary>
        /// 功能：将电站推荐为示例电站
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns></returns>
        [IsLoginAttributeAdmin]
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Recommend(int id)
        {
            Plant plantInfo = plantService.GetPlantInfoById(id);
            User user = userService.GetUserByName(UserUtil.demousername);
            PlantUser plantUser = new PlantUser();
            plantUser.userID = user.id;
            plantUser.plantID = id;
            PlantUser plant = plantUserService.GetPlantUserByPlantIDUserID(plantUser);//判断电站是否是示例电站
            if (plant == null)
            {
                plantInfo.example_plant = true;//将电站标记为示例电站
                plantService.UpdatePlantInfo(plantInfo);
                plantUserService.AddPlantUser(plantUser);
            }
            else
                ViewData["error"] = "This plant is exampleplant!";

            return RedirectToAction(@"plants", "admin");
        }
        /// <summary>
        /// 取消示例电站
        /// </summary>
        /// <param name="id">电站id</param>
        /// <returns></returns>
        public ActionResult DelRecommend(int id)
        {
            Plant plantInfo = plantService.GetPlantInfoById(id);
            User user = userService.GetUserByName(UserUtil.demousername);
            PlantUser plantUser = new PlantUser();
            plantUser.userID = user.id;
            plantUser.plantID = id;
            plantInfo.example_plant = false;
            plantService.UpdatePlantInfo(plantInfo);
            plantUserService.ClosePlant(id, user.id);
            return RedirectToAction(@"plants", "admin");
        }

        public ActionResult CheckAdminuser(string uname)
        {
            if (string.IsNullOrEmpty(uname))
                return Content("true");
            IList<Manager> managers = managerService.Getlist(new Manager());
            return Content((managers.Where(m => m.username.Equals(uname)).ToList<Manager>().Count <= 0).ToString().ToLower());
        }

        public ActionResult Admin(string id)
        {
            if (Session["collectorAddedEnable"] != null && (bool)Session["collectorAddedEnable"])
            {
                Hashtable hashPara = new Hashtable();
                hashPara["sd"] = DateTime.Now.AddYears(-5).ToString("yyyy-MM-dd");
                hashPara["ed"] = DateTime.Now.ToString("yyyy-MM-dd");
                int no = 0;
                int.TryParse(id, out no);
                Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = no };
                hashPara["page"] = page;
                CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();
                IList<Collector> collectorInfos = collectorInfoService.GetCollectorsByPage(hashPara);
                ViewData["page"] = page;
                ViewData["data"] = collectorInfos;
                return View();
            }
            return RedirectToAction("index", "home");

        }


        [HttpPost]
        public ActionResult Admin(Collector collector)
        {
            try
            {
                collectorInfoservice.Save(collector);
            }
            catch
            {
                ViewData["error"] = "The DataLogger already exist!";
            }
            Hashtable hashPara = new Hashtable();
            hashPara["sd"] = DateTime.Now.AddYears(-5).ToString("yyyy-MM-dd");
            hashPara["ed"] = DateTime.Now.ToString("yyyy-MM-dd");
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = 1 };
            hashPara["page"] = page;
            CollectorInfoService collectorInfoService = CollectorInfoService.GetInstance();
            IList<Collector> collectorInfos = collectorInfoService.GetCollectorsByPage(hashPara);
            ViewData["page"] = page;
            ViewData["data"] = collectorInfos;
            return View();

        }


        public ActionResult DelCollector(string Id)
        {
            int id = 0;
            int.TryParse(Id, out id);
            CollectorInfoService service = CollectorInfoService.GetInstance();
            service.Delete(id);
            return Content("success");
        }


        public ActionResult Home()
        {
            Session.Clear();
            return RedirectToAction("index", "home");
        }

        public ActionResult Download()
        {
            return File("/Recource/template.xlsx", "application/ms-excel", "Logger-SN Ipmort Bank PXXX.xlsx");
        }

        public ActionResult MailConfig()
        {
            IList<MailConfig> configs = MailCofnigService.GetInstance().GetList();
            return View(@"mailconfig/config", configs);
        }

        public ActionResult AddMail(MailConfig config)
        {
            MailCofnigService.GetInstance().Save(config);
            IList<MailConfig> configs = MailCofnigService.GetInstance().GetList();
            return View(@"mailconfig/config", configs);
        }


        public ActionResult RemoveMail(string id)
        {
            int index = 0;
            int.TryParse(id, out index);
            MailCofnigService.GetInstance().Remove(index);
            IList<MailConfig> configs = MailCofnigService.GetInstance().GetList();
            return View(@"mailconfig/config", configs);
        }

        public ActionResult DataItems(string id)
        {
            return View(@"DataItem/List");
        }


        public ActionResult ItemsConfig(int code)
        {
            Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("zh-cn");
            StringBuilder htmlBuilder = new StringBuilder();
            IList<DataItem> dataItems = ReportDataItemService.GetInstance().GetDataItemListByCode(code);
            bool flag = false;
            ReportDataItem ditem = ReportDataItemService.GetInstance().Get(new ReportDataItem() { id = code });
            string filterStr = string.Empty;
            filterStr = ditem == null ? "," : ditem.name;
            string[] filt = filterStr.Split(',');
            foreach (var item in dataItems)
            {
                flag = false;
                foreach (string s in filt)
                {
                    if (s.Trim().Equals(item.code.ToString()))
                    {
                        htmlBuilder.AppendFormat("<li style='width: 150px; float: left; list-style: none; line-height: 25px; margin-left: 0px;'><input name='items' checked='checked' type='checkbox' ref='{0}'/><span> {1}</span></li>", item.code, DataItem.getNameByCode(item.code));
                        flag = true;
                        break;
                    }

                }
                if (!flag)
                    htmlBuilder.AppendFormat("<li style='width: 150px; float: left; list-style: none; line-height: 25px; margin-left: 0px;'><input name='items' type='checkbox' ref='{0}'/><span> {1}</span></li>", item.code, DataItem.getNameByCode(item.code));
            }

            return Content(htmlBuilder.ToString());
        }

        public ActionResult SaveItemsConfig(int code, string items)
        {
            ReportDataItem item = new ReportDataItem() { id = code, name = items };
            ReportDataItemService service = ReportDataItemService.GetInstance();
            service.Remove(item);
            service.Insert(item);
            return Content("修改成功");
        }

        public ActionResult updateEnabled(string id, string flag, string pageNo)
        {
            int enabled = 0;
            if (flag == "True")
                enabled = 0;
            else
                enabled = 1;
            ReportDataItemService dataItemService = ReportDataItemService.GetInstance();
            int count = dataItemService.UpdateItemEnabled(id, enabled);

            return RedirectToAction(pageNo, @"admin/dataItems");
        }


        public ActionResult Delnewplant(int id)
        {
            Plant plant = plantService.GetPlantInfoById(id);
            plant.isNewPlant = false;
            plantService.UpdatePlantInfo(plant);
            return Redirect("/admin/plants");
        }

        public ActionResult Newplant(int id)
        {
            Plant plant = plantService.GetPlantInfoById(id);
            plant.isNewPlant = true;
            plantService.UpdatePlantInfo(plant);
            return Redirect("/admin/plants");
        }

        public ActionResult Delplant(int id)
        {
            Plant plant = plantService.GetPlantInfoById(id);
            if (plant.allFactUnits != null)
                foreach (var item in plant.allFactUnits)
                {
                    PlantUnitService.GetInstance().DeletePlantUnit(item.plantID, item.collectorID);
                    var collector = item.collector;
                    if (collector == null)
                        continue;
                    collector.isUsed = false;
                    collectorInfoservice.Update(collector);
                }
            plantService.Remove(id);
            return Content("删除成功");
        }


        public ActionResult Countries(string pid)
        {
            IList<CountryCity> countries = CountryCityService.GetInstance().GetList();

            Pager page = new Pager();
            page.PageSize = ComConst.PageSize;
            int pno = 0;
            int.TryParse(pid, out pno);
            pno = pno < 1 ? 1 : pno;
            page.PageIndex = pno;
            page.RecordCount = countries.Count;
            countries = countries.Skip((pno - 1) * page.PageSize).Take(page.PageSize).ToList<CountryCity>();
            ViewData["page"] = page;
            ViewData["cities"] = countries;
            return View(@"countrycity/countries");
        }

        public ActionResult Country_Add(string id)
        {
            return Country_edit(id);
        }

        public ActionResult Country_edit(string id)
        {
            int cid = 0;
            int.TryParse(id, out cid);
            CountryCity country = CountryCityService.GetInstance().Get(new CountryCity() { id = cid });
            if (country == null)
                country = new CountryCity { weather_code = string.Empty };
            if (country.weather_code == null)
                country.weather_code = string.Empty;

            return View(@"countrycity/country_edit", country);
        }

        [HttpPost]
        public ActionResult Country_Add(CountryCity cc)
        {
            string start = Request.Form["start"];
            string end = Request.Form["end"];
            string days = Request.Form["hours"];
            cc.code = string.Format("{0}&{1}&{2}", start, end, days);
            CountryCityService.GetInstance().Save(cc);
            return Redirect("/admin/countries");
        }


        [HttpPost]
        public ActionResult Country_edit(CountryCity cc)
        {
            string start = Request.Form["start"];
            string end = Request.Form["end"];
            string days = Request.Form["hours"];
            cc.code = string.Format("{0}&{1}&{2}", start, end, days);
            CountryCityService.GetInstance().Save(cc);
            return Redirect("/admin/countries");
        }

        public ActionResult Country_del(string id)
        {
            int cid = 0;
            int.TryParse(id, out cid);
            CountryCityService.GetInstance().Remove(cid);
            return Countries("0");
        }

        public ActionResult Cities(string id)
        {
            int cid = 0;
            int.TryParse(id, out cid);
            CountryCity country = CountryCityService.GetInstance().Get(new CountryCity() { id = cid });
            IList<CountryCity> countries = CountryCityService.GetInstance().GetList();
            ViewData["countries"] = countries;
            return View(@"countrycity/cities", country);
        }

        public ActionResult City_del(string id)
        {
            int cid = 0;
            int.TryParse(id, out cid);
            CountryCityService.GetInstance().Remove(cid);
            return Redirect("/admin/cities/" + Request.QueryString["cid"]);
        }

        public ActionResult City_Add(string id)
        {
            return City_edit(id);
        }


        public ActionResult City_edit(string id)
        {
            int cid = 0;
            int.TryParse(id, out cid);
            CountryCity city = CountryCityService.GetInstance().Get(new CountryCity() { id = cid });
            ViewData["countries"] = CountryCityService.GetInstance().GetList();
            return View(@"countrycity/city_edit", city);
        }

        [HttpPost]
        public ActionResult City_Add(CountryCity cc)
        {
            string lat = Request.Form["lat"];
            string lon = Request.Form["lon"];
            cc.latlon = string.Format("{0},{1}", lat, lon);

            CountryCityService.GetInstance().Save(cc);
            return Redirect("/admin/cities/" + cc.pid);
        }

        [HttpPost]
        public ActionResult City_edit(CountryCity cc)
        {
            string lat = Request.Form["lat"];
            string lon = Request.Form["lon"];
            cc.latlon = string.Format("{0},{1}", lat, lon);
            CountryCityService.GetInstance().Save(cc);
            return Redirect("/admin/cities/" + cc.pid);
        }

        /// <summary>
        /// 设置测点
        /// </summary>
        /// <param name="ProIdType"></param>
        private void SetMI(string ProIdType)
        {
            Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("zh-cn");
            List<SelectListItem> listmi = new List<SelectListItem>();
            int deviceTypeCode = DeviceData.PLANT_CODE;
            if (!string.IsNullOrEmpty(ProIdType))
            {
                string[] strvalue = ProIdType.Split('&');
                deviceTypeCode = int.Parse(strvalue[1].Trim());
            }
            Hashtable has = new Hashtable();
            IList<MonitorType> mts = MonitorType.getFilterMonitorTypesByTypeCode(deviceTypeCode);
            if (mts != null)
            {
                foreach (MonitorType item in mts)
                {
                    listmi.Add(new SelectListItem() { Text = item.name, Value = item.code.ToString() });
                }
            }

            ViewData["MonitorItems"] = listmi;

        }

        public ActionResult Monitorconfig()
        {
            return View(@"monitorconfig/config");
        }

        [HttpPost]
        public ActionResult MonitorItems(int code)
        {
            string cstr = string.Empty;
            MonitorConfig config = MonitorConfigService.GetInstance().Get(code);
            string[] itm = new string[] { };
            if (config != null)
                itm = config.items.Split(',');
            StringBuilder html = new StringBuilder();
            cstr = string.Format("&{0}", code);
            SetMI(cstr);
            bool flag = false;
            foreach (var item in ViewData["MonitorItems"] as List<SelectListItem>)
            {
                flag = false;
                foreach (string s in itm)
                {

                    if (s.Trim().Equals(item.Value.Trim()))
                    {
                        html.AppendFormat("<li style='width: 150px; float: left; list-style: none; line-height: 25px; margin-left: 0px;'><input name='items' checked='checked' type='checkbox' ref='{0}'/><span> {1}</span></li>", item.Value, item.Text);
                        flag = true;
                        break;
                    }

                }
                if (!flag && string.IsNullOrEmpty(item.Text) == false)
                    html.AppendFormat("<li style='width: 150px; float: left; list-style: none; line-height: 25px; margin-left: 0px;'><input name='items' type='checkbox' ref='{0}'/><span> {1}</span></li>", item.Value, item.Text);
            }
            return Content(html.ToString());

        }

        public ActionResult SaveMonitorItems(MonitorConfig config)
        {
            MonitorConfigService service = MonitorConfigService.GetInstance();
            try
            {
                service.Remove(config);
                service.Save(config);
            }
            catch
            {
                throw;
                return Content("修改失败");
            }
            return Content("修改成功");
        }

        public ActionResult Currencies()
        {
            IList<CommonInfo> currencies = CommonInfoService.GetInstance().GetList(new CommonInfo() { pid = CommonInfo.Currency });
            return View("currencies/currencies", currencies);
        }

        public ActionResult Currency_del(string id)
        {
            int cid = 0;
            int.TryParse(id, out cid);
            CommonInfoService.GetInstance().Remove(cid);
            return Redirect("/admin/currencies/");
        }

        public ActionResult Currency_Edit(string id)
        {
            int cid = 0;
            int.TryParse(id, out cid);
            CommonInfo info = CommonInfoService.GetInstance().Get(cid);
            return View(@"currencies/currency_edit", info);
        }

        public ActionResult Currency_Add(string id)
        {
            return Currency_Edit(id);
        }

        [HttpPost]
        public ActionResult Currency_Add(CommonInfo info)
        {
            CommonInfoService.GetInstance().Save(info);
            return Redirect("/admin/currencies");
        }


        [HttpPost]
        public ActionResult Currency_Edit(CommonInfo info)
        {
            CommonInfoService.GetInstance().Save(info);
            return Redirect("/admin/currencies");
        }

        public ActionResult AllPlants(string id)
        {
            IList<SelectListItem> countryItems = new List<SelectListItem>();
            IList<CountryCity> countries = CountryCityService.GetInstance().GetList();
            countryItems.Add(new SelectListItem() { Text = "全部", Value = "" });
            foreach (CountryCity country in countries)
                countryItems.Add(new SelectListItem() { Text = country.name, Value = country.name });
            ViewData["countries"] = countryItems;
            IList<ManagerMonitorCode> mmcs = ManagerMonitorCodeService.GetInstance().GetList();
            mmcs = mmcs.Where(model => model.type.Equals(DeviceData.PLANT_CODE) && model.display == true).ToList<ManagerMonitorCode>();
            ViewData["mmcs"] = mmcs;
            int no;
            int.TryParse(id, out no);
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = no };
            PlantService service = PlantService.GetInstance();
            ViewData["page"] = page;
            return View(@"plant/allplant", service.GetPlantByPage(page));
        }
        public ActionResult AreaCountries(string area)
        {
            IList<CountryCity> countries = CountryCityService.GetInstance().GetList();
            countries = countries.Where(m => m.weather_code != null && m.weather_code.Equals(area)).ToList<CountryCity>();
            StringBuilder sb = new StringBuilder("<select id=\"country\" name=\"country\" onchange=\"getcountries();\"><option value=\"\">全部</option>");
            foreach (CountryCity country in countries)
            {
                sb.AppendFormat("<option value=\"{0}\">{0}</option>", country.name);
            }
            sb.Append("</select>");
            return Content(sb.ToString());
        }

        public ActionResult AllCities(string name)
        {
            IList<CountryCity> countries = CountryCityService.GetInstance().GetList();
            IList<CountryCity> cities = null;
            IList<SelectListItem> cityItems = new List<SelectListItem>();
            foreach (CountryCity country in countries)
            {
                if (name.Equals(country.name))
                {
                    cities = country.Cities;
                    break;
                }
            }
            StringBuilder builder = new StringBuilder();
            builder.Append("<select id=\"city\" name=\"city\">");
            builder.AppendFormat("<option value=\"{0}\">{1}</option>", "", "全部");
            if (cities != null)
                foreach (CountryCity city in cities)
                {
                    builder.AppendFormat("<option value=\"{0}\">{1}</option>", city.name, city.name);
                }
            builder.Append("</select>");
            return Content(builder.ToString());
        }

        [HttpPost]
        public ActionResult AllPlants(string country, string city, string items, string design_power_start, string design_power_end, int? index, string area, string estartdate, string eenddate, string uname)
        {
            string uids = "0,";
            if (string.IsNullOrEmpty(uname) == false)
            {
                IList<User> users = userService.GetUsersLikeuname(uname);
                foreach (User user in users)
                {
                    uids += string.Format("{0},", user.id);
                }
            }
            uids += "0";
            index = index == null ? 1 : index;
            design_power_start = design_power_start == null ? string.Empty : design_power_start;
            design_power_end = design_power_end == null ? string.Empty : design_power_end;
            Hashtable table = new Hashtable();
            Plant plant = new Plant();
            plant.area = area;
            plant.country = country;
            plant.city = city;
            Pager page = new Pager() { PageSize = 10, PageIndex = (int)index };
            ViewData["page"] = page;
            table.Add("plant", plant);
            table.Add("design_power_start", design_power_start);
            table.Add("design_power_end", design_power_end);
            table.Add("uids", uids);
            table.Add("page", page);
            IList<Plant> plants = plantService.QueryPagePlants(table);
            plants = plants.OrderByDescending(m => m.example_plant == true).ToList<Plant>();
            ExcelData eData = BuildPlantDetails(plants, items, estartdate, eenddate);
            return View(@"plant/allplants_details", eData);
        }

        [HttpPost]
        public ActionResult AllPlants_Counter(string country, string city, string items, string design_power_start, string design_power_end, int? index, string area, string estartdate, string eenddate, string uname)
        {
            string uids = "0,";
            if (string.IsNullOrEmpty(uname) == false)
            {
                IList<User> users = userService.GetUsersLikeuname(uname);
                foreach (User user in users)
                {
                    uids += string.Format("{0},", user.id);
                }
            }
            uids += "0";
            index = index == null ? 1 : index;
            design_power_start = design_power_start == null ? string.Empty : design_power_start;
            design_power_end = design_power_end == null ? string.Empty : design_power_end;
            Hashtable table = new Hashtable();
            Plant plant = new Plant();
            plant.area = area;
            plant.country = country;
            plant.city = city;
            Pager page = new Pager() { PageSize = int.MaxValue, PageIndex = (int)index };
            table.Add("plant", plant);
            table.Add("design_power_start", design_power_start);
            table.Add("uids", uids);
            table.Add("design_power_end", design_power_end);
            table.Add("page", page);
            IList<Plant> plants = plantService.QueryPagePlants(table);
            ExcelData eData = BuildPlantDetails(plants, items, estartdate, eenddate);
            return View(@"plant/allplants_counter", eData);
        }



        public ActionResult AllPlants_Excel(string country, string city, string items, string design_power_start, string design_power_end, string area, string estartdate, string eenddate, string uname)
        {
            string uids = "0,";
            if (string.IsNullOrEmpty(uname) == false)
            {
                IList<User> users = userService.GetUsersLikeuname(uname);
                foreach (User user in users)
                {
                    uids += string.Format("{0},", user.id);
                }
            }
            uids += "0";

            IList<string> rowData = new List<string>();
            Hashtable table = new Hashtable();
            Plant pnt = new Plant();
            pnt.area = area;
            pnt.country = country;
            pnt.city = city;
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = 1 };
            ViewData["page"] = page;
            table.Add("plant", pnt);
            table.Add("design_power_start", design_power_start);
            table.Add("design_power_end", design_power_end);
            table.Add("page", page);
            table.Add("uids", uids);
            IList<Plant> plants = plantService.QueryPagePlants(table);
            ViewData["items"] = items;
            ExcelData eData = BuildPlantDetails(plants, items, estartdate, eenddate);
            IList<ExcelData> eDatas = new List<ExcelData>();
            for (int x = 0; x < eData.Rows.Count - 1; x++)
                eData.Rows[x].RemoveAt(eData.Rows[x].Count - 1);
            for (int i = 0; i < eData.Rows[eData.Rows.Count - 1].Count; i++)
                eData.Rows[eData.Rows.Count - 1][i] = eData.Rows[eData.Rows.Count - 1][i].Replace("<br />", string.Empty);
            eDatas.Add(eData);
            ExcelStreamWriter exlWriter = new ExcelStreamWriter(eDatas);
            exlWriter.Save("查询电站列表");

            return File(exlWriter.FullName, "text/xlsx; charset=UTF-8", urlcode(exlWriter.FileName));

        }

        private ExcelData BuildPlantDetails(IList<Plant> plants, string items, string estartdate, string eenddate)
        {
            ExcelData eData = new ExcelData();

            IList<string> rowData = new List<string>();
            double reductionRate = ItemConfigService.GetInstance().getCO2Config();
            double dayEnergySum = 0;
            double totalEnergySum = 0;
            double dayPowerSum = 0;
            double installPowerSum = 0;
            double todayCo2Sum = 0;
            double totalCo2Sum = 0;
            double todayRevenuesum = 0;
            string[] strArray = null;
            if (items.Contains(','))
                strArray = items.Split(',');
            else
                strArray = new string[] { };
            rowData.Add("名称");
            rowData.Add("国家");
            rowData.Add("城市");

            #region Excel列名
            foreach (string s in strArray)
            {
                switch (s)
                {
                    case "1"://日发电量
                        rowData.Add("日发电量");
                        break;
                    case "46"://累计发电量
                        rowData.Add("累计发电量" + estartdate + "/" + eenddate + " (kWh)");
                        break;
                    case "2"://总发电量
                        rowData.Add("总发电量(kWh)");
                        break;
                    case "3"://日功率
                        rowData.Add("日功率(kW)");
                        break;
                    case "4"://总功率
                        rowData.Add("总功率(kW)");
                        break;
                    case "5"://安装功率
                        rowData.Add("安装功率(kW)");
                        break;
                    case "6"://今日CO2减排
                        rowData.Add("今日CO2减排(kg)");
                        break;
                    case "7"://累计CO2减排
                        rowData.Add("累计CO2减排(kg)");
                        break;
                    case "8"://今日收益
                        rowData.Add("今日收益");
                        break;
                    case "9"://温度
                        rowData.Add("温度 (℃) ");
                        break;
                    case "10"://日照强度
                        rowData.Add("日照强度 (W/m2)");
                        break;
                    case "44"://总每KWP发电量
                        rowData.Add("总每KWP发电量 (kWh/kWp)");
                        break;
                    case "45"://日每KWP发电量
                        rowData.Add("日每KWP发电量 (kWh/kWp)");
                        break;
                    default:
                        break;
                }
            }
            rowData.Add("编号:是否实例电站:是否推荐电站");//最后一列显示编号  后面删除电站使用
            #endregion
            eData.Rows.Add(rowData);
            foreach (Plant plant in plants)
            {
                rowData = new List<string>();
                dayEnergySum += (plant.TotalDayEnergy);
                dayPowerSum += plant.TodayTotalPower;
                installPowerSum += plant.design_power;
                todayCo2Sum += (plant.TotalDayEnergy * reductionRate);
                totalCo2Sum += (plant.TotalEnergy * reductionRate);
                todayRevenuesum += (plant.TotalDayEnergy * plant.revenueRate);
                User user = UserService.GetInstance().Get((int)plant.userID);
                plant.currencies = user == null ? "$" : user.currencies;
                rowData.Add(plant.name);
                rowData.Add(plant.country);
                rowData.Add(plant.city);

                foreach (string s in strArray)
                {
                    switch (s)
                    {
                        case "1"://日发电量

                            rowData.Add(string.Format("{0}", plant.TotalDayEnergy));
                            break;
                        case "46"://累计发电量
                            double value = plantService.GetEnergy(plant, estartdate, eenddate);
                            rowData.Add(string.Format("{0:0.00}", value));
                            totalEnergySum += value;

                            break;
                        case "2"://总发电量
                            rowData.Add(string.Format("{0:0.00}", plant.TotalEnergy));
                            break;
                        case "3"://日功率
                            rowData.Add(string.Format("{0}", plant.TodayTotalPower));

                            break;
                        case "4"://总功率
                            rowData.Add(string.Format("{0}", plant.TodayTotalPower));

                            break;
                        case "5"://安装功率
                            rowData.Add(string.Format("{0}", plant.design_power));

                            break;
                        case "6"://今日CO2减排
                            rowData.Add(string.Format("{0}", plant.TodayReductiong));

                            break;
                        case "7"://累计CO2减排
                            rowData.Add(string.Format("{0:0} ", plant.TotalEnergy * reductionRate));
                            break;
                        case "8"://今日收益

                            rowData.Add(string.Format("{0} {1}", plant.DisplayTodayRevenue, plant.currencies));
                            break;

                        case "9"://温度
                            rowData.Add(plant.Temperature.ToString("0"));

                            break;

                        case "10"://日照强度
                            rowData.Add(plant.Sunstrength == null ? "0" : ((double)plant.Sunstrength).ToString("0.00"));
                            break;
                        case "44"://每KWP发电量
                            if (plant.design_power.Equals(0))
                                rowData.Add("0.00");
                            else
                                rowData.Add((plant.TotalEnergy / plant.design_power).ToString("0.00"));
                            break;
                        case "45"://日每KWP发电量
                            if (plant.design_power.Equals(0))
                                rowData.Add("0.00");
                            else
                                rowData.Add((plant.TotalDayEnergy / plant.design_power).ToString("0.00"));
                            break;
                        default:
                            break;
                    }
                }
                rowData.Add(string.Format("{0}:{1}:{2}", plant.id, plant.example_plant, plant.isNewPlant));
                eData.Rows.Add(rowData);
            }

            rowData = new List<string>();
            rowData.Add(string.Empty);
            rowData.Add(string.Empty);
            rowData.Add("电站总数:<br /> ∑ " + plants.Count);
            foreach (string s in strArray)
            {
                switch (s)
                {
                    case "1"://日发电量汇总
                        rowData.Add("日发电量统计:<br /> ∑ " + computeEnergyUnit(dayEnergySum));
                        break;
                    case "2"://总发电量汇总
                        rowData.Add("总发电量统计:<br /> ∑ " + computeEnergyUnit(plants.Sum(m => m.TotalEnergy)));
                        break;
                    case "44"://总每KWP发电量

                        double totalPlantEnergy = plants.Sum(m => m.TotalEnergy);
                        double totalPlantDesignPower = plants.Sum(m => m.design_power);
                        if (totalPlantEnergy == 0 || totalPlantDesignPower == 0)
                            rowData.Add("总每KWP发电量:<br /> ∑ " + "0.00 kWh/kWp");
                        else
                            rowData.Add("总每KWP发电量:<br /> ∑ " + (totalPlantEnergy / totalPlantDesignPower).ToString("0.00") + "kWh/kWp");
                        break;
                    case "45"://日每KWP发电量
                        double totalDayEnergy = plants.Sum(m => m.TotalDayEnergy);
                        double totalDesignPower = plants.Sum(m => m.design_power);
                        if (totalDayEnergy == 0 || totalDesignPower == 0)
                            rowData.Add("日每KWP发电量:<br /> ∑ " + " 0.00 kWh/kWp");
                        else
                            rowData.Add("日每KWP发电量:<br /> ∑ " + (totalDayEnergy / totalDesignPower).ToString("0.00") + "kWh/kWp");
                        break;
                    case "5"://安装功率汇总
                        rowData.Add("总安装功率:<br /> ∑ " + computeEnergyUnit(plants.Sum(m => m.design_power)));

                        break;
                    case "6"://今日CO2减排汇总
                        rowData.Add("今日CO2减排统计:<br /> ∑ " + computeReduceUnit(todayCo2Sum));
                        break;
                    case "7"://累计CO2减排汇总
                        rowData.Add("累计CO2减排统计:<br /> ∑ " + computeReduceUnit(totalCo2Sum));
                        break;
                    case "46"://累计发电量
                        rowData.Add(string.Format("累计发电量 :{0}-{1}<br />∑ {2}", estartdate, eenddate, computeEnergyUnit(totalEnergySum)));

                        break;

                    default:
                        break;
                }
            }
            eData.Rows.Add(rowData);

            return eData;
        }


        private string computeReduceUnit(double reduce)
        {
            double res = reduce;
            if (res >= 1000000000000)
            {
                res = res / 1000000000000;
                return string.Format("{0} Gt", res.ToString("0.00"));
            }
            if (res >= 1000000000)
            {
                res = res / 1000000000;
                return string.Format("{0} Mt", res.ToString("0.00"));
            }
            if (res >= 1000000)
            {
                res = res / 1000000;
                return string.Format("{0} kt", res.ToString("0.00"));
            }
            if (res >= 1000)
            {
                res = res / 1000;
                return string.Format("{0} t", res.ToString("0.00"));
            }
            return string.Format("{0} kg", res.ToString("0.00"));

        }

        private string computeEnergyUnit(double energy)
        {

            if (energy >= 1000000)
            {
                energy = energy / 1000000;
                return string.Format("{0} GWh", energy.ToString("0.00"));
            }
            else
                if (energy >= 1000)
                {
                    energy = energy / 1000;
                    return string.Format("{0} MWh", energy.ToString("0.00"));
                }
                else
                    return string.Format("{0} kWh", energy.ToString("0.00"));

        }

        private IList<Device> load_device(int tp, int page)
        {
            Hashtable table = new Hashtable();
            Device device = new Device();
            device.deviceModel = new DeviceModel() { modelTypeCode = -1 };
            device.deviceTypeCode = tp;
            table.Add("device", device);
            table.Add("page", new Pager() { PageSize = ComConst.PageSize, PageIndex = page });
            ViewData["page"] = table["page"];
            IList<Device> devices = deviceService.GetDevicesListPage(table);
            foreach (Device de in devices)
            {
                if (de.collectorID > 0)
                {
                    Collector collector = CollectorInfoService.GetInstance().Get(de.collectorID);
                    if (collector != null && collector.plantID > 0)
                        de.plant = plantService.GetPlantInfoById(collector.plantID);
                }
            }
            return devices;
        }

        public ActionResult Device_hlx(string id)
        {
            int index = 0;
            int.TryParse(id, out index);
            return View(@"device/hlx", load_device(string.Empty, "-1", "1", DeviceData.HUILIUXIANG_CODE, true, string.Empty));

        }

        public ActionResult Down_Device_HLX(string pname, string mname, string orderby)
        {
            IList<ExcelData> eDatas = new List<ExcelData>();
            ExcelData eData = new ExcelData();
            IList<string> rowData = null;
            rowData = new List<string>();
            rowData.Add("所属电站");
            rowData.Add("名称");
            rowData.Add("设备型号");
            rowData.Add("国家");
            rowData.Add("城市");
            rowData.Add("接入传感器路数");
            rowData.Add("直流母线电压	");
            rowData.Add("总电流");
            eData.Rows.Add(rowData);
            IList<Device> devices = load_device(pname, mname, string.Empty, DeviceData.HUILIUXIANG_CODE, false, orderby);
            foreach (Device d in devices)
            {
                rowData = new List<string>();
                rowData.Add(d.plant.name);
                rowData.Add(string.IsNullOrEmpty(d.name) ? d.fullName : d.name);
                rowData.Add(d.xinhaoName);
                rowData.Add(d.plant.country);
                rowData.Add(d.plant.city);
                rowData.Add(d.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM));
                rowData.Add(d.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT));
                rowData.Add(d.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT));
                eData.Rows.Add(rowData);
            }
            eDatas.Add(eData);
            ExcelStreamWriter writer = new ExcelStreamWriter(eDatas);
            writer.Save("汇流箱列表");
            return File(writer.FullName, "text/xlsx; charset=UTF-8", urlcode(writer.FileName));

        }

        public ActionResult Device_em(string id, string orderby)
        {
            int index = 0;
            int.TryParse(id, out index);
            return View(@"device/em", load_device(string.Empty, "-1", "1", DeviceData.ENVRIOMENTMONITOR_CODE, true, orderby));

        }

        public ActionResult Down_Device_EM(string pname, string mname, string orderby)
        {
            IList<ExcelData> eDatas = new List<ExcelData>();
            ExcelData eData = new ExcelData();
            IList<string> rowData = null;
            rowData = new List<string>();
            rowData.Add("所属电站");
            rowData.Add("名称");
            rowData.Add("设备型号");
            rowData.Add("国家");
            rowData.Add("城市");
            rowData.Add("当前日照");
            rowData.Add("当前风速");
            eData.Rows.Add(rowData);
            IList<Device> devices = load_device(pname, mname, string.Empty, DeviceData.ENVRIOMENTMONITOR_CODE, false, orderby);
            foreach (Device d in devices)
            {
                rowData = new List<string>();
                rowData.Add(d.plant.name);
                rowData.Add(string.IsNullOrEmpty(d.name) ? d.fullName : d.name);
                rowData.Add(d.xinhaoName);
                rowData.Add(d.plant.country);
                rowData.Add(d.plant.city);
                rowData.Add(d.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT));
                rowData.Add(d.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED));
                eData.Rows.Add(rowData);
            }
            eDatas.Add(eData);
            ExcelStreamWriter writer = new ExcelStreamWriter(eDatas);
            writer.Save("环境检测仪列表");
            return File(writer.FullName, "text/xlsx; charset=UTF-8", urlcode(writer.FileName));

        }


        public ActionResult Down_Device_Ammeter(string pname, string mname, string orderby)
        {
            IList<ExcelData> eDatas = new List<ExcelData>();
            ExcelData eData = new ExcelData();
            IList<string> rowData = null;
            rowData = new List<string>();
            rowData.Add("所属电站");
            rowData.Add("名称");
            rowData.Add("设备型号");
            rowData.Add("国家");
            rowData.Add("城市");
            rowData.Add("正向有功电度");
            eData.Rows.Add(rowData);
            IList<Device> devices = load_device(pname, mname, string.Empty, DeviceData.AMMETER_CODE, false, orderby);
            foreach (Device d in devices)
            {
                rowData = new List<string>();
                rowData.Add(d.plant.name);
                rowData.Add(string.IsNullOrEmpty(d.name) ? d.fullName : d.name);
                rowData.Add(d.xinhaoName);
                rowData.Add(d.plant.country);
                rowData.Add(d.plant.city);
                rowData.Add(d.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE));
                eData.Rows.Add(rowData);
            }
            eDatas.Add(eData);
            ExcelStreamWriter writer = new ExcelStreamWriter(eDatas);
            writer.Save("电表列表");
            return File(writer.FullName, "text/xlsx; charset=UTF-8", urlcode(writer.FileName));

        }


        public ActionResult Device_cabinet(string id, string orderby)
        {
            int index = 0;
            int.TryParse(id, out index);
            return View(@"device/cabinet", load_device(string.Empty, "-1", "1", DeviceData.CABINET_CODE, true, orderby));

        }
        public ActionResult Device_ammeter(string id, string orderby)
        {
            int index = 0;
            int.TryParse(id, out index);
            return View(@"device/ammeter", load_device(string.Empty, "-1", "1", DeviceData.AMMETER_CODE, true, orderby));
        }

        public ActionResult Down_Device_Cabinet(string pname, string mname, string orderby)
        {
            IList<ExcelData> eDatas = new List<ExcelData>();
            ExcelData eData = new ExcelData();
            IList<string> rowData = null;
            rowData = new List<string>();
            rowData.Add("所属电站");
            rowData.Add("名称");
            rowData.Add("设备型号");
            rowData.Add("国家");
            rowData.Add("城市");
            rowData.Add("直流母线电压	");
            rowData.Add("总电流	");
            rowData.Add("机内温度");
            eData.Rows.Add(rowData);
            IList<Device> devices = load_device(pname, mname, string.Empty, DeviceData.CABINET_CODE, false, orderby);
            foreach (Device d in devices)
            {
                rowData = new List<string>();
                rowData.Add(d.plant.name);
                rowData.Add(string.IsNullOrEmpty(d.name) ? d.fullName : d.name);
                rowData.Add(d.xinhaoName);
                rowData.Add(d.plant.country);
                rowData.Add(d.plant.city);
                rowData.Add(d.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT));
                rowData.Add(d.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT));
                rowData.Add(d.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE));
                eData.Rows.Add(rowData);
            }
            eDatas.Add(eData);
            ExcelStreamWriter writer = new ExcelStreamWriter(eDatas);
            writer.Save("配电柜列表");
            return File(writer.FullName, "text/xlsx; charset=UTF-8", urlcode(writer.FileName));

        }

        public ActionResult load_device_em(string pname, string mname, string psize, string orderby)
        {
            ViewData["isclick"] = true;
            return View(@"device/em", load_device(pname, mname, psize, DeviceData.ENVRIOMENTMONITOR_CODE, true, orderby));
        }

        public ActionResult load_device_hlx(string pname, string mname, string psize, string orderby)
        {
            ViewData["isclick"] = true;
            return View(@"device/hlx", load_device(pname, mname, psize, DeviceData.HUILIUXIANG_CODE, true, orderby));
        }

        public ActionResult load_device_cabinet(string pname, string mname, string psize, string orderby)
        {
            ViewData["isclick"] = true;
            return View(@"device/cabinet", load_device(pname, mname, psize, DeviceData.CABINET_CODE, true, orderby));
        }
        public ActionResult load_device_ammeter(string pname, string mname, string psize, string orderby)
        {
            ViewData["isclick"] = true;
            return View(@"device/ammeter", load_device(pname, mname, psize, DeviceData.AMMETER_CODE, true, orderby));
        }

        private IList<Device> load_device(string pname, string mtcode, string pindex, int tpcode, bool isallowpage, string orderby)
        {
            int mCode = 0;
            int.TryParse(mtcode, out mCode);
            IList<Device> devices = new List<Device>();
            IList<Plant> plants = plantService.Getplantlikepname(pname);
            foreach (Plant plant in plants)
            {
                foreach (Device d in plant.deviceList())
                {
                    if (d.deviceTypeCode.Equals(tpcode) && (d.deviceModelCode.Equals(mCode) || mCode.Equals(-1)))
                    {
                        d.plant = plant;
                        devices.Add(d);
                    }
                }
            }

            int.TryParse(pindex, out mCode);
            Pager page = new Pager();
            page.PageSize = ComConst.PageSize;
            page.PageIndex = mCode;
            page.RecordCount = devices.Count;
            ViewData["page"] = page;
            if (isallowpage)
                devices = devices.Skip((mCode - 1) * page.PageSize).Take(page.PageSize).ToList<Device>();
            switch (orderby)
            {
                case "pltname":
                    devices = devices.OrderBy(m => m.plant.name).ToList<Device>();
                    break;
                case "dtype":
                    devices = devices.OrderBy(m => m.xinhaoName).ToList<Device>();
                    break;
                default:
                    break;
            }
            return devices;
        }

        public ActionResult Load_Device_inv(string pname, string mcode, string showitems, string design_power_start, string design_power_end, string pagesize, string orderby, string estartdate, string eenddate)
        {
            IList<Device> devicesList = GetDevices(pname, mcode, showitems, design_power_start, design_power_end, pagesize, orderby);

            Pager page = new Pager();
            page.PageSize = 10;
            page.RecordCount = devicesList.Count;
            page.PageIndex = int.Parse(pagesize);
            ViewData["page"] = page;
            devicesList = devicesList.Skip((page.PageIndex - 1) * page.PageSize).Take(page.PageSize).ToList<Device>();
            return View(@"device/inv_Details", BuildInvDetails(devicesList, showitems, estartdate, eenddate));
        }

        public ActionResult Load_Device_Counter(string pname, string mcode, string showitems, string design_power_start, string design_power_end, string pagesize, string orderby, string estartdate, string eenddate)
        {
            IList<Device> devicesList = GetDevices(pname, mcode, showitems, design_power_start, design_power_end, pagesize, orderby);
            return View(@"device/inv_Counter", BuildInvDetails(devicesList, showitems, estartdate, eenddate));
        }


        private IList<Device> GetDevices(string pname, string mcode, string showitems, string design_power_start, string design_power_end, string pagesize, string orderby)
        {
            double design_start = 0;
            double design_end = 0;
            double.TryParse(design_power_start, out design_start);
            double.TryParse(design_power_end, out design_end);
            IList<Device> devices = load_device(pname, mcode, pagesize, DeviceData.INVERTER_CODE, false, orderby);
            if (!(design_end == 0 && design_start == 0))
                devices = devices.Where(model => model.designPower >= design_start && model.designPower <= design_end).ToList<Device>();

            return devices;
        }


        public ActionResult Down_Device_inv(string pname, string mcode, string showitems, string design_power_start, string design_power_end, string orderby, string estartdate, string eenddate)
        {
            double design_start = 0;
            double design_end = 0;
            double.TryParse(design_power_start, out design_start);
            double.TryParse(design_power_end, out design_end);
            IList<Device> devices = load_device(pname, mcode, "1", DeviceData.INVERTER_CODE, false, orderby);
            if (!(design_end == 0 && design_start == 0))
                devices = devices.Where(model => model.designPower >= design_start && model.designPower <= design_end).ToList<Device>();

            IList<ExcelData> eDatas = new List<ExcelData>();
            ExcelData eData = BuildInvDetails(devices, showitems, estartdate, eenddate);
            for (int i = 0; i < eData.Rows[eData.Rows.Count - 1].Count; i++)
                eData.Rows[eData.Rows.Count - 1][i] = eData.Rows[eData.Rows.Count - 1][i].Replace("<br />", string.Empty);
            eDatas.Add(eData);
            ExcelStreamWriter writer = new ExcelStreamWriter(eDatas);
            writer.Save("逆变器列表");
            return File(writer.FullName, "text/xlsx; charset=UTF-8", urlcode(writer.FileName));

        }

        private ExcelData BuildInvDetails(IList<Device> devices, string items, string estartdate, string eenddate)
        {
            ExcelData eData = new ExcelData();
            double totalEnergy = 0;
            IList<string> rowData = new List<string>();
            string[] strArray = null;
            if (items.Contains(','))
                strArray = items.Split(',');
            else
                strArray = new string[] { };
            rowData.Add("所属电站");
            rowData.Add("设备名称");
            rowData.Add("设备型号");

            #region Excel列名
            foreach (string s in strArray)
            {
                switch (s)
                {

                    #region 标题

                    case "43"://累计发电量
                        rowData.Add(string.Format("累计发电量 {1}/{2}({0})", "kWh", estartdate, eenddate));
                        break;
                    case "14"://机内空气温度
                        rowData.Add(string.Format("机内空气温度 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_JNKQTEMPRATURE).unit));
                        break;
                    case "15"://机内变压器温度
                        rowData.Add(string.Format("机内变压器温度 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_JNBYQTEMPRATURE).unit));

                        break;
                    case "16"://机内散热器温度
                        rowData.Add(string.Format("机内散热器温度 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_JNSRQTEMPRATURE).unit));
                        break;
                    case "17"://直流电压1
                        rowData.Add(string.Format("直流电压1 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_DV1).unit));
                        break;
                    case "18"://直流电流1
                        rowData.Add(string.Format("直流电流1 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_DC1).unit));
                        break;
                    case "19"://直流电压2
                        rowData.Add(string.Format("直流电压2 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_DV2).unit));
                        break;
                    case "20"://直流电流2
                        rowData.Add(string.Format("直流电流2 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_DC2).unit));
                        break;
                    case "21"://直流电压3
                        rowData.Add(string.Format("直流电压3 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_DV3).unit));
                        break;
                    case "22"://直流电流3
                        rowData.Add(string.Format("直流电流3 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_DC3).unit));
                        break;
                    case "23"://总直流功率
                        rowData.Add(string.Format("总直流功率 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TOTALDPOWER).unit));
                        break;

                    case "24"://A相电压
                        rowData.Add(string.Format("A相电压 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_ADIRECTVOLT).unit));
                        break;

                    case "25"://相电压
                        rowData.Add(string.Format("B相电压 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_BDIRECTVOLT).unit));
                        break;

                    case "26"://C相电压
                        rowData.Add(string.Format("C相电压 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_CDIRECTVOLT).unit));
                        break;

                    case "27"://A相电流
                        rowData.Add(string.Format("A相电流 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_ADIRECTCURRENT).unit)); ;
                        break;

                    case "28"://B相电流
                        rowData.Add(string.Format("B相电流 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_BDIRECTCURRENT).unit));
                        break;

                    case "29"://C相电流
                        rowData.Add(string.Format("C相电流 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_CDIRECTCURRENT).unit));
                        break;

                    case "30"://A相有功功率
                        rowData.Add(string.Format("A相有功功率 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_ADIRECTPOWER).unit));
                        break;

                    case "31"://B相有功功率
                        rowData.Add(string.Format("B相有功功率 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_BDIRECTPOWER).unit));
                        break;

                    case "32":// C相有功功率
                        rowData.Add(string.Format("C相有功功率 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_CDIRECTPOWER).unit));
                        break;

                    case "33"://总有功功率
                        rowData.Add(string.Format("总有功功率 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TOTALYGPOWER).unit));
                        break;

                    case "34"://总无功功率
                        rowData.Add(string.Format("总无功功率 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TOTALWGPOWER).unit));
                        break;

                    case "35"://总功率因数
                        rowData.Add(string.Format("总功率因数 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_TOTALPOWERFACTOR).unit));
                        break;

                    case "36"://电网频率
                        rowData.Add(string.Format("电网频率 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_DWPL).unit));
                        break;

                    case "37"://逆变器效率
                        rowData.Add(string.Format("逆变器效率 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_INVERTERXL).unit));
                        break;

                    case "38"://安装功率
                        rowData.Add(string.Format("安装功率 ({0})", "kW"));
                        break;

                    case "39"://逆变器效率
                        rowData.Add(string.Format("逆变器效率 ({0})", MonitorType.getMonitorTypeByCode(MonitorType.MIC_INVERTER_INVERTERXL).unit));
                        break;

                    case "40"://今日发电量
                        rowData.Add(string.Format("今日发电量 ({0})", "kWh"));
                        break;

                    case "41"://本月发电量
                        rowData.Add(string.Format("本月发电量 ({0})", "kWh"));
                        break;

                    case "42"://本月每KWP发电量 
                        rowData.Add(string.Format("本月每KWP发电量 ({0})", "kWh/kWp"));
                        break;

                    case "13"://总发电量 
                        rowData.Add(string.Format("总发电量 ({0})", "kWh"));
                        break;
                    default:
                        break;
                    #endregion

                }
            }
            #endregion

            #region  内容
            eData.Rows.Add(rowData);
            float curMonthEnergyTotal = 0;
            foreach (Device d in devices)
            {
                float curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, d.id, DateTime.Now.Month).count();
                curMonthEnergyTotal += curMonthEnergy;
                rowData = new List<string>();
                rowData.Add(d.plant.name);
                rowData.Add(d.fullName);
                rowData.Add(d.xinhaoName);

                foreach (string s in strArray)
                {
                    switch (s)
                    {
                        case "43"://累计发电量
                            double value = deviceService.GetEnergy(d.id, estartdate, eenddate);
                            totalEnergy += value;
                            rowData.Add(value.ToString("0.00"));
                            break;
                        case "14"://机内空气温度
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_JNKQTEMPRATURE));
                            break;
                        case "15"://机内变压器温度
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_JNBYQTEMPRATURE));

                            break;
                        case "16"://机内散热器温度
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_JNSRQTEMPRATURE));

                            break;
                        case "17"://直流电压1
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DV1));

                            break;
                        case "18"://直流电流1
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DC1));

                            break;
                        case "19"://直流电压2
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DV2));

                            break;
                        case "20"://直流电流2
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DC2));

                            break;
                        case "21"://直流电压3
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DV3));

                            break;
                        case "22"://直流电流3
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DC3));
                            break;

                        case "23"://总直流功率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_TOTALDPOWER));

                            break;

                        case "24"://A相电压
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_ADIRECTVOLT));

                            break;

                        case "25"://相电压
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_BDIRECTVOLT));

                            break;

                        case "26"://C相电压
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_CDIRECTVOLT));

                            break;

                        case "27"://A相电流
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_ADIRECTCURRENT));

                            break;

                        case "28"://B相电流
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_BDIRECTCURRENT));

                            break;

                        case "29"://C相电流
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_CDIRECTCURRENT));

                            break;

                        case "30"://A相有功功率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_ADIRECTPOWER));

                            break;

                        case "31"://B相有功功率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_BDIRECTPOWER));

                            break;

                        case "32":// C相有功功率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_CDIRECTPOWER));

                            break;

                        case "33"://总有功功率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_TOTALYGPOWER));

                            break;

                        case "34"://总无功功率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_TOTALWGPOWER));

                            break;

                        case "35"://总功率因数
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_TOTALPOWERFACTOR));

                            break;

                        case "36"://电网频率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DWPL));

                            break;

                        case "37"://逆变器效率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_INVERTERXL));

                            break;

                        case "38"://安装功率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.designPower.ToString("0.00"));
                            break;

                        case "39"://逆变器效率
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_INVERTERXL));
                            break;

                        case "40"://今日发电量

                            //object data = ReflectionUtil.getProperty(DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, d.id, DateTime.Now.Month), string.Format("d_{0}", DateTime.Now.Day));
                            //rowData.Add(data == null ? "0" : data.ToString());
                            if (d.runData == null)
                                rowData.Add("0");
                            else
                                rowData.Add(d.runData.todayEnergy.ToString("0.0"));

                            break;

                        case "41"://本月发电量                      
                            rowData.Add(curMonthEnergy.ToString("0.00"));
                            break;

                        case "42"://本月每KWP发电量 
                            rowData.Add(Math.Round(curMonthEnergy / d.chartPower, 2).ToString("0.00"));
                            break;

                        case "13"://总发电量 
                            rowData.Add(d.TotalEnergy.ToString("0.00"));
                            break;


                        default:
                            break;
                    }
                }
                eData.Rows.Add(rowData);
            }
            #endregion


            #region 统计
            rowData = new List<string>();
            rowData.Add(string.Empty);
            rowData.Add(string.Empty);
            rowData.Add(string.Format("{0}:<br /> ∑{1}", "总设备数", devices.Count));
            foreach (string s in strArray)
            {
                switch (s)
                {
                    case "40"://今日发电量

                        rowData.Add(string.Format("{0}:<br />∑{1}", "今日发电量统计", computeEnergyUnit(devices.Where(m => m.runData != null).Sum(m => m.runData.todayEnergy))));
                        break;

                    case "41"://本月发电量
                        rowData.Add(string.Format("{0}:<br />∑{1}", "本月发电量统计", computeEnergyUnit(curMonthEnergyTotal)));
                        break;

                    case "13"://总发电量 
                        rowData.Add(string.Format("{0}:<br />∑{1}", "总发电量统计", computeEnergyUnit(devices.Sum(m => m.TotalEnergy))));

                        break;
                    case "43"://累计发电量
                        rowData.Add(string.Format("{0}:{2}-{3}<br />∑{1}", "累计发电量", computeEnergyUnit(totalEnergy), estartdate, eenddate));
                        break;
                    default:
                        break;
                }
            }
            eData.Rows.Add(rowData);
            #endregion


            return eData;
        }

        public ActionResult Anonymous(int id)
        {
            Plant plant = plantService.GetPlantInfoById(id);
            int uid = 0;

            //实际电站被组合后，就没有分配关系了，所以去分配的用户作为登录用户就会取不到，就用器创建者作为登录用户
            //IList<PlantUser> pusers = plantUserService.GetOpenPlant(plant.id);
            //if (pusers.Count > 0)
            //uid = pusers[0].userID;
            uid = int.Parse(plant.userID.ToString());
            User user = userService.Get(uid);
            UserUtil.login(user);
            if (plant != null)
                return RedirectToAction("overview", "plant", new { @id = id });
            else
                return RedirectToAction("overview", "user");
        }


        public ActionResult config_mge_items()
        {
            return View(@"itemsconfig/config");
        }

        public ActionResult load_enable_items(int t)
        {
            StringBuilder html = new StringBuilder();
            IList<ManagerMonitorCode> mmcs = ManagerMonitorCodeService.GetInstance().GetList();
            foreach (var item in mmcs)
            {
                switch (t)
                {
                    case 0://电站显示项
                        if (item.id.Equals(46))//电站累计发电量
                            continue;
                        break;
                    case 1://逆变器显示项
                        if (item.id.Equals(43))//逆变器累计发电量
                            continue;
                        break;
                }
                if (item.type.Equals(t) == false)
                    continue;
                if (item.display)
                {
                    html.AppendFormat("<li style='width: 150px; float: left; list-style: none; line-height: 25px; margin-left: 0px;'><input name='items' checked='checked' type='checkbox' ref='{0}'/><span> {1}</span></li>", item.id, item.name);
                }
                else
                    html.AppendFormat("<li style='width: 150px; float: left; list-style: none; line-height: 25px; margin-left: 0px;'><input name='items' type='checkbox' ref='{0}'/><span> {1}</span></li>", item.id, item.name);

            }
            return Content(html.ToString());

        }

        public ActionResult save_mge_items(string t, string items)
        {
            ManagerMonitorCodeService.GetInstance().HideItemByTid(t);
            string[] itms = items.Split(',');
            foreach (string iid in itms)
            {
                int tid = 0;
                int.TryParse(iid, out tid);
                if (tid > 0)
                    ManagerMonitorCodeService.GetInstance().SetEnable(tid);
            }
            return Content("修改成功");
        }


        public ActionResult Role(string id)
        {
            if (string.IsNullOrEmpty(id) == false)
            {
                AdminRole role = AdminRoleServices.GetInstance().Get(int.Parse(id));
                ViewData["role"] = role;
            }

            Hashtable allControllerActionstable = new Hashtable();
            IList<AdminControllerAction> allControllerActionsList = null;
            allControllerActionsList = AdminControllerActionServices.GetInstance().GetList();
            IList<string> list = new List<string>();
            foreach (var item in AdminControllerActionType.dictionaries)
            {
                list.Add(AdminControllerActionType.TypeName(item.Key));
                allControllerActionstable.Add(AdminControllerActionType.TypeName(item.Key), allControllerActionsList.Where(m => m.typeId == item.Key).ToList<AdminControllerAction>());
            }
            ViewData["keys"] = list;
            return View(@"authority/role", allControllerActionstable);

        }

        public ActionResult Role_Edit(string id)
        {
            return Role(id);

        }

        public ActionResult Roles()
        {
            IList<AdminRole> allAdminRoles = AdminRoleServices.GetInstance().GetList();
            return View(@"authority/roles", allAdminRoles);
        }

        public ActionResult DelRole(int id)
        {
            AdminRoleServices.GetInstance().Remove(id);
            return Redirect("/admin/roles");
        }

        public ActionResult SaveRole(string rid, string name, string caids)
        {
            int roleId = AdminRoleServices.GetInstance().Save(new AdminRole { name = name, id = int.Parse(rid) });
            roleId = rid.Equals("0") == false ? int.Parse(rid) : roleId;
            AdminControllerActionRoleServices.GetInstance().Remove(roleId);
            string[] caidArray = caids.Split(',');
            foreach (string caid in caidArray)
            {
                if (string.IsNullOrEmpty(caid) == false)
                    AdminControllerActionRoleServices.GetInstance().Save(new AdminControllerActionRole { roleId = roleId, controllerActionId = int.Parse(caid) });
            }
            return Redirect("/admin/roles");
        }

        public ActionResult CheckRoleName(string name)
        {
            if (string.IsNullOrEmpty(name))
                return Content("true");
            IList<AdminRole> roles = AdminRoleServices.GetInstance().GetList();
            return Content((roles.Where(m => m.name.Equals(name)).ToList<AdminRole>().Count <= 0).ToString().ToLower());

        }
        public ActionResult UserRecords()
        {
            Pager page = new Pager() { PageSize = 1, PageIndex = 1 };
            Hashtable table = new Hashtable();
            table.Add("page", page);
            table.Add("uname", string.Empty);
            IList<LoginRecord> records = LoginRecordService.GetInstance().GetRecordsByPage(table);
            ViewData["RecordCount"] = page.RecordCount;
            return View(@"record/index");
        }


        public ActionResult RecordList(string localZone, string pageIndex, string uname)
        {
            float index = 0;
            float.TryParse(pageIndex, out index);
            Pager page = new Pager() { PageSize = ComConst.PageSize, PageIndex = (int)index };
            Hashtable table = new Hashtable();
            table.Add("page", page);
            table.Add("uname", uname);
            IList<LoginRecord> records = LoginRecordService.GetInstance().GetRecordsByPage(table);
            float.TryParse(localZone, out index);

            records = records.OrderByDescending(d => d.loginTime.AddHours(d.localZone)).ToList<LoginRecord>();
            foreach (var item in records)
                item.loginTime = item.loginTime.AddHours(item.localZone).AddHours(index);
            ViewData["page"] = page;
            return View(@"record/list", records);
        }

        public ActionResult InfoCenter(string id)
        {
            int uid = 0;
            int.TryParse(id, out uid);
            User loginUser = userService.Get(uid);
            UserUtil.login(loginUser);
            if (loginUser.ParentUserId == 0)
            {
                if (loginUser.plantUsers.Count == 1)
                {
                    return RedirectToAction("overview", "plant", new { @id = base.FirstPlant.id });
                }
                else
                {
                    if (loginUser.plantUsers.Count > 0)
                    {
                        //用户登陆默认显示选中左边导航栏中的"所有电站"，右边窗口打开"电站列表"页面。 
                        //Session["firstLogin"] = true;
                        return RedirectToAction("allplants", "user");
                    }
                    else
                    {
                        return RedirectToAction("addoneplant", "user");
                    }
                }
            }
            else
            {
                ///判断是否有电站
                if (loginUser.assignedPlants == null || loginUser.assignedPlants.Count.Equals(0))
                {
                    ModelState.AddModelError("Error", "您的账户中无电站,暂时不能登录");
                    return View(loginUser);
                }
                if (loginUser.plantUsers.Count == 1)
                {
                    return RedirectToAction("virtual", "portal", new { @id = loginUser.plantUsers[0].plantID });
                }
                else
                    return RedirectToAction("index", "portal");
            }
        }


        public ActionResult Bitcustomer(string id)
        {
            int uid = 0;
            int.TryParse(id, out uid);
            User user = userService.Get(uid);
            userService.UpdateBigCustomer(uid, !user.isBigCustomer);
            return Redirect("/admin/users");
        }

        /// <summary>
        /// 故障码语言拼接
        /// </summary>
        /// <param name="pn"></param>
        /// <returns></returns>
        public ActionResult Errorcode(string pn)
        {
            IList<Errorcode> errorList = ErrorcodeService.GetInstance().GetList();

            Pager page = new Pager() { PageIndex = 1, PageSize = ComConst.PageSize, RecordCount = errorList.Count };
            int pageNo = 0;
            int.TryParse(pn, out pageNo);
            page.PageIndex = pageNo < 1 ? 1 : pageNo; ;
            page.RecordCount = errorList.Count;
            errorList = errorList.Skip((pageNo - 1) * page.PageSize).Take(page.PageSize).ToList<Errorcode>();
            ViewData["page"] = page;
            return View(@"Errorcode/list", errorList);
        }
        /// <summary>
        /// 故障码删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Errorcode_delete(int id)
        {
            ErrorcodeService.GetInstance().Remove(id);
            return Errorcode(string.Empty);
        }
        /// <summary>
        /// 故障码编辑
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Errorcode_edit(int id)
        {
            IList<Language> langs = LanguageService.GetInstance().GetList();
            Errorcode errorCode = ErrorcodeService.GetInstance().Get(id);
            IList<Hashtable> tables = new List<Hashtable>();
            Hashtable table = null;
            foreach (Language language in langs)
            {
                table = new Hashtable();
                table["langcode"] = language.codename;
                table["langName"] = language.displayName;
                table["langValue"] = errorCode == null ? string.Empty :
                    errorCode.getCodeName(language.codename);
                tables.Add(table);
            }
            ViewData["list"] = tables;

            ViewData["selectDeviceTypes"] = convertDomainListToSelectList(errorCode == null ? 0 : int.Parse(errorCode.code));

            return View(@"Errorcode/edit", errorCode);
        }
        /// <summary>
        /// 故障码类型下拉框
        /// </summary>
        /// <param name="selectedCode"></param>
        /// <returns></returns>
        private IList<SelectListItem> convertDomainListToSelectList(int? selectedCode)
        {
            IList<SelectListItem> selectDeviceTypes = new List<SelectListItem>();
            bool isSelected = false;

            if (selectedCode != null && selectedCode == ErrorType.ERROR_TYPE_ERROR)
            {
                isSelected = true;
            }
            selectDeviceTypes.Add(new SelectListItem { Text = ErrorType.getErrortypeByCode(ErrorType.ERROR_TYPE_ERROR).name, Value = ErrorType.ERROR_TYPE_ERROR.ToString(), Selected = isSelected });

            if (selectedCode != null && selectedCode == ErrorType.ERROR_TYPE_FAULT)
            {
                isSelected = true;
            }
            selectDeviceTypes.Add(new SelectListItem { Text = ErrorType.getErrortypeByCode(ErrorType.ERROR_TYPE_FAULT).name, Value = ErrorType.ERROR_TYPE_FAULT.ToString(), Selected = isSelected });


            if (selectedCode != null && selectedCode == ErrorType.ERROR_TYPE_WARN)
            {
                isSelected = true;
            }
            selectDeviceTypes.Add(new SelectListItem { Text = ErrorType.getErrortypeByCode(ErrorType.ERROR_TYPE_WARN).name, Value = ErrorType.ERROR_TYPE_WARN.ToString(), Selected = isSelected });


            if (selectedCode != null && selectedCode == ErrorType.ERROR_TYPE_INFORMATRION)
            {
                isSelected = true;
            }
            selectDeviceTypes.Add(new SelectListItem { Text = ErrorType.getErrortypeByCode(ErrorType.ERROR_TYPE_INFORMATRION).name, Value = ErrorType.ERROR_TYPE_INFORMATRION.ToString(), Selected = isSelected });

            return selectDeviceTypes;
        }

        /// <summary>
        /// 故障码保存
        /// </summary>
        /// <param name="errorcode"></param>
        /// <returns></returns>
        public ActionResult Errorcode_save(Errorcode errorcode)
        {
            string lang = Request.Form["lang"];
            string langValue = Request.Form["langValue"];
            List<string> array = lang.Split(',').ToList<string>();
            List<string> arrayValue = langValue.Split(',').ToList<string>();
            string name = string.Empty;
            for (int x = 0; x < array.Count; x++)
            {
                name += string.Format("{0}:{1},", array[x], arrayValue[x]);
            }
            if (name.LastIndexOf(',') > 0) name = name.Substring(0, name.Length - 1);
            errorcode.name = name;
            ErrorcodeService.GetInstance().Save(errorcode);
            return Errorcode(string.Empty);
        }

        public ActionResult CheckErrorcode(string code)
        {
            if (string.IsNullOrEmpty(code)) return Content("true");
            return Content(ErrorcodeService.GetInstance().GetList().Where(m => m.code.Equals(code.Trim())).Count() == 0 ? "true" : "false");
        }

        /// <summary>
        /// 加载清理条件页面
        /// add by qhb in 20120827 for 手工清理sn数据
        /// </summary>
        /// <returns></returns>
        public ActionResult clearpage()
        {
            return View();
        }

        /// <summary>
        /// 按照输入条件对数据进行清理
        /// 清理逻辑
        /// 用ajax方式调用
        /// add by qhb in 20120827 for 手工清理sn数据
        /// </summary>
        /// <returns></returns>
        public ActionResult clearhandle()
        {
            MemcachedClientSatat mcs = MemcachedClientSatat.getInstance();
            //找出sn对应的采集器
            string sn = Request.Params["sn"];
            int collectorId = CollectorInfoService.GetInstance().getCollectorIdbyCode(sn);
            if (collectorId == 0)
            {
                return Content("sn不存在！");
            }
            Collector collector = CollectorInfoService.GetInstance().Get(collectorId);
            //清理采集器实时数据的总发电量
            CollectorRunData collectorRunData = CollectorRunDataService.GetInstance().Get(collectorId);
            if (collectorRunData != null)
            {
                collectorRunData.totalEnergy = 0;
                //先持久化数据
                CollectorRunDataService.GetInstance().save(collectorRunData);
                //再删除缓存
                string key = CacheKeyUtil.buildCollectorRunDataKey(collectorId);
                mcs.Delete(key);
            }

            //清理的日期段
            DateTime startDate = DateTime.Parse(Request.Params["startDate"]);//开始实际
            DateTime endDate = DateTime.Parse(Request.Params["endDate"]);//结束时间

            //清理采集器天数据,并累计要清理的月发电量
            DateTime tempStartDate = startDate.AddDays(-1);
            //存储月度发电量
            IDictionary<string, float> monthEnergyMap = new Dictionary<string, float>();

            while (endDate.CompareTo(tempStartDate) > 0)
            {
                tempStartDate = tempStartDate.AddDays(1);
                string yyyyMM = CalenderUtil.formatDate(tempStartDate, "yyyyMM");
                //删除该采集器天历史数据
                CollectorDayDataService.GetInstance().Delete(new CollectorDayData() { collectorID = collectorId, yearmonth = yyyyMM, sendDay = tempStartDate.Day });
                //清理采集器天数据缓存
                mcs.Delete(CacheKeyUtil.buildCollectorDayDataKey(collectorId, yyyyMM, tempStartDate.Day, MonitorType.PLANT_MONITORITEM_ENERGY_CODE));
                mcs.Delete(CacheKeyUtil.buildCollectorDayDataKey(collectorId, yyyyMM, tempStartDate.Day, MonitorType.PLANT_MONITORITEM_LINGT_CODE));
                //取得当日发电量数据
                CollectorMonthDayData collectorMonthDayData = CollectorMonthDayDataService.GetInstance().GetCollectorMonthDayData(tempStartDate.Year, collectorId, tempStartDate.Month);
                float? dayEnergy = 0;
                if (collectorMonthDayData != null)
                {
                    dayEnergy = (float?)ReflectionUtil.getProperty(collectorMonthDayData, "d_" + tempStartDate.Day);
                    if (dayEnergy == null) dayEnergy = 0;
                }

                if (monthEnergyMap.ContainsKey(yyyyMM))
                {
                    monthEnergyMap[yyyyMM] = monthEnergyMap[yyyyMM] + dayEnergy.Value;
                }
                else
                {
                    monthEnergyMap[yyyyMM] = dayEnergy.Value;
                }

                //将今日发电量清零
                ReflectionUtil.setProperty(collectorMonthDayData, "d_" + tempStartDate.Day, 0);

                //set cache
                mcs.Set(CacheKeyUtil.buildCollectorEnergyMonthCountKey(collectorId, tempStartDate.Year, tempStartDate.Month), collectorMonthDayData);
            }

            //将年月发电量重新计算
            //存储年度发电量
            IDictionary<int, float> yearEnergyMap = new Dictionary<int, float>();
            float energy = 0;
            CollectorYearMonthData collectorYearMonthData = null;
            int year, month;
            foreach (string key in monthEnergyMap.Keys)
            {
                year = int.Parse(key.Substring(0, 4));
                month = int.Parse(key.Substring(4, 2));
                energy = monthEnergyMap[key];
                collectorYearMonthData = CollectorYearMonthDataService.GetInstance().GetCollectorYearMonthData(collectorId, year);
                float? monthEnergy = 0;//原来发电量
                if (collectorYearMonthData != null)
                {
                    monthEnergy = (float?)ReflectionUtil.getProperty(collectorYearMonthData, "m_" + month);
                    if (monthEnergy == null) monthEnergy = 0;
                }
                if (yearEnergyMap.ContainsKey(year))
                {
                    yearEnergyMap[year] = yearEnergyMap[year] + energy;
                }
                else
                {
                    yearEnergyMap[year] = energy;
                }

                //将今日发电量减去天累计的
                float newEnergy = monthEnergy.Value - energy;
                ReflectionUtil.setProperty(collectorYearMonthData, "m_" + month, newEnergy < 0 ? 0 : newEnergy);
                //set cache
                mcs.Set(CacheKeyUtil.buildCollectorEnergyYearCountKey(collectorId, year), collectorYearMonthData);

            }

            //重新计算采集器年度发电量
            CollectorYearData collectorYearData = null;
            foreach (int key in yearEnergyMap.Keys)
            {
                collectorYearData = CollectorYearDataService.GetInstance().GetCollectorYearData(collectorId, key);
                if (collectorYearData != null)
                {
                    float? oyearEnergy = (float?)ReflectionUtil.getProperty(collectorYearData, "dataValue");
                    if (oyearEnergy == null) oyearEnergy = 0;
                    //将当年发电量减去天累计的要减少的
                    float newEnergy = oyearEnergy.Value - yearEnergyMap[key];
                    ReflectionUtil.setProperty(collectorYearData, "dataValue", newEnergy < 0 ? 0 : newEnergy);
                }
                //set cache
                mcs.Set(CacheKeyUtil.buildCollectorEnergyTotalCountKey(collectorId, key), collectorYearData);
            }

            //循环清理采集器下面设备数据
            foreach (Device device in collector.devices)
            {
                //清理采集器实时数据的总发电量
                //DeviceRunData deviceRunData = device.runData;
                //if (deviceRunData != null)
                //{
                //deviceRunData.rundatastr = "";
                //先持久化数据
                //DeviceRunDataService.GetInstance().save(deviceRunData);
                //再删除缓存
                //string key = CacheKeyUtil.buildDeviceRunDataKey(device.id);
                //mcs.Delete(key);
                //}

                //清理设备天数据,并累计要清理的月发电量
                tempStartDate = startDate.AddDays(-1);
                //存储月度发电量
                IDictionary<string, float> deviceMonthEnergyMap = new Dictionary<string, float>();

                while (endDate.CompareTo(tempStartDate) > 0)
                {
                    tempStartDate = tempStartDate.AddDays(1);
                    string yyyyMM = CalenderUtil.formatDate(tempStartDate, "yyyyMM");
                    //删除该采集器天历史数据
                    DeviceDayDataService.GetInstance().Delete(new DeviceDayData() { deviceType = TableUtil.getTableNamebyDeviceType(device.deviceTypeCode), deviceID = device.id, yearmonth = yyyyMM, sendDay = tempStartDate.Day });

                    if (device.deviceTypeCode == DeviceData.INVERTER_CODE)
                    {
                        //取得当日发电量数据
                        DeviceMonthDayData deviceMonthDayData = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(tempStartDate.Year, device.id, tempStartDate.Month);
                        float? dayEnergy = 0;
                        if (deviceMonthDayData != null)
                        {
                            dayEnergy = (float?)ReflectionUtil.getProperty(deviceMonthDayData, "d_" + tempStartDate.Day);
                            if (dayEnergy == null) dayEnergy = 0;
                        }
                        if (deviceMonthEnergyMap.ContainsKey(yyyyMM))
                        {
                            deviceMonthEnergyMap[yyyyMM] = deviceMonthEnergyMap[yyyyMM] + dayEnergy.Value;
                        }
                        else
                        {
                            deviceMonthEnergyMap[yyyyMM] = dayEnergy.Value;
                        }
                        //将今日发电量清零
                        ReflectionUtil.setProperty(deviceMonthDayData, "d_" + tempStartDate.Day, 0);
                        //set cache
                        mcs.Set(CacheKeyUtil.buildDeviceEnergyMonthCountKey(device.id, tempStartDate.Year, tempStartDate.Month), deviceMonthDayData);
                    }
                }

                if (device.deviceTypeCode == DeviceData.INVERTER_CODE)
                {
                    //将年月发电量重新计算
                    //存储年度发电量
                    yearEnergyMap = new Dictionary<int, float>();
                    energy = 0;
                    DeviceYearMonthData deviceYearMonthData = null;
                    foreach (string key in deviceMonthEnergyMap.Keys)
                    {
                        year = int.Parse(key.Substring(0, 4));
                        month = int.Parse(key.Substring(4, 2));
                        energy = monthEnergyMap[key];
                        deviceYearMonthData = DeviceYearMonthDataService.GetInstance().GetDeviceYearMonthData(device.id, year);
                        float? monthEnergy = 0;//原来发电量
                        if (deviceYearMonthData != null)
                        {
                            monthEnergy = (float?)ReflectionUtil.getProperty(deviceYearMonthData, "m_" + month);
                            if (monthEnergy == null) monthEnergy = 0;
                        }
                        if (yearEnergyMap.ContainsKey(year))
                        {
                            yearEnergyMap[year] = yearEnergyMap[year] + energy;
                        }
                        else
                        {
                            yearEnergyMap[year] = energy;
                        }

                        //将今日发电量减去天累计的
                        float newEnergy = monthEnergy.Value - energy;
                        ReflectionUtil.setProperty(deviceYearMonthData, "m_" + month, newEnergy < 0 ? 0 : newEnergy);

                        //set cache
                        mcs.Set(CacheKeyUtil.buildDeviceEnergyYearCountKey(device.id, year), deviceYearMonthData);
                    }

                    //重新计算采集器年度发电量
                    DeviceYearData deviceYearData = null;
                    foreach (int key in yearEnergyMap.Keys)
                    {
                        deviceYearData = DeviceYearDataService.GetInstance().GetDeviceYearData(device.id, key);
                        if (deviceYearData != null)
                        {
                            float? oyearEnergy = (float?)ReflectionUtil.getProperty(deviceYearData, "dataValue");
                            if (oyearEnergy == null) oyearEnergy = 0;
                            //将当年发电量减去天累计的要减少的
                            float newEnergy = oyearEnergy.Value - yearEnergyMap[key];
                            ReflectionUtil.setProperty(deviceYearData, "dataValue", newEnergy < 0 ? 0 : newEnergy);
                        }
                        //set cache
                        mcs.Set(CacheKeyUtil.buildDeviceEnergyTotalCountKey(device.id, key), deviceYearData);
                    }
                }
            }

            //更新缓存
            CacheService.GetInstance().flushCaches();
            return Content("清理完成!");
        }

        public ActionResult Answer(string id)
        {
            int page = 0;
            int.TryParse(id, out page);
            page = page < 1 ? 1 : page;
            IList<QA> qalist = QAService.GetInstance().Search(string.Empty, -1, string.Empty);
            Pager pager = new Pager();
            ViewData["page"] = pager;
            pager.PageSize = ComConst.PageSize ;
            pager.PageIndex = page;
            pager.RecordCount = qalist.Count;
            qalist = qalist.Skip((page - 1) * pager.PageSize).Take(pager.PageSize).ToList<QA>();
            return View(@"qa/list", qalist);
        }

        public ActionResult PostAnswer(string id)
        {
            int iid = 0;
            int.TryParse(id, out iid);
            return View(@"qa/post", QAService.GetInstance().Get(iid));
        }

        [HttpPost]
        public ActionResult PostAnswer(QA qa)
        {
    
            User user = UserUtil.getCurUser();
            qa.pubdate = DateTime.Now;
            qa.status = QA.VALIDATE;
            qa.username = user == null ? "admin" : user.username;
            QAService.GetInstance().Save(qa);
            QAService.GetInstance().UpdateStatus(qa.qid, QA.VALIDATE);
            return Redirect("/admin/answer");
        }


        public ActionResult RecommendAnswer(int id)
        {
            QA qa= QAService.GetInstance().Get(id);
            QAService.GetInstance().Recommend(id, !qa.isRecommend);
            return Content("ok");
        }
    }
}