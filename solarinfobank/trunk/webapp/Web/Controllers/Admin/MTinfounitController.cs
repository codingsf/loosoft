using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers.Admin
{
    public class MTinfounitController : Controller
    {
        //
        // GET: /UnitAddress/

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult List(string pn)
        {
            IList<MTinfounit> mtInfoUnitList = MTinfounitService.GetInstance().GetList();
            Pager page = new Pager() { PageIndex = 1, PageSize = ComConst.PageSize, RecordCount = mtInfoUnitList.Count };
            int pageNo = 0;
            int.TryParse(pn, out pageNo);
            page.PageIndex = pageNo < 1 ? 1 : pageNo; ;
            page.RecordCount = mtInfoUnitList.Count;
            mtInfoUnitList = mtInfoUnitList.Skip((pageNo - 1) * page.PageSize).Take(page.PageSize).ToList<MTinfounit>();
            ViewData["page"] = page;
            return View(mtInfoUnitList);
        }

        public ActionResult Delete(string id)
        {
            int iid = 0; int.TryParse(id, out iid);
            if (iid > 0)
                MTinfounitService.GetInstance().Delete(iid);
            return Redirect("/mtinfounit/list/");
        }

        public ActionResult Save(MTinfounit mtInfoUnit)
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
            mtInfoUnit.name = name;
            MTinfounitService.GetInstance().Save(mtInfoUnit);
            return Redirect("/mtinfounit/list/");
        }

        public ActionResult edit(string id)
        {
            int iid = 0;
            int.TryParse(id, out iid);
            MTinfounit mtinfoUnit = MTinfounitService.GetInstance().Get(iid);

            List<SelectListItem> typeItems = new List<SelectListItem>();
            foreach (var item in DeviceData.deviceTypeMap)
                typeItems.Add(new SelectListItem() { Text = item.Value.name, Value = item.Value.code.ToString() });
            ViewData["mtTypeItems"] = typeItems;
            ViewData["mtUnit"] = ConvertToSelectListItem(MTUnit.AllUnits);
            ViewData["mtMonitorType"] = ConvertToSelectListItem(MTMonitorType.AllMonitorTypes);
            ViewData["mtDataType"] = ConvertToSelectListItem(MTDataType.AllDataTypes);

            IList<Language> langs = LanguageService.GetInstance().GetList();
            IList<Hashtable> tables = new List<Hashtable>();
            Hashtable table = null;
            foreach (Language language in langs)
            {
                table = new Hashtable();
                table["langcode"] = language.codename;
                table["langName"] = language.displayName;
                table["langValue"] = mtinfoUnit == null ? string.Empty :
                    mtinfoUnit.getCodeName(language.codename);
                tables.Add(table);
            }
            ViewData["list"] = tables;

            return View(mtinfoUnit);
        }

        private List<SelectListItem> ConvertToSelectListItem(List<KeyValuePair<string, string>> pair)
        {

            List<SelectListItem> items = new List<SelectListItem>();
            if (pair == null || pair.Count == 0)
                return items;
            foreach (var item in pair)
                items.Add(new SelectListItem() { Text = item.Value, Value = item.Key });
            return items;
        }
    }
}
