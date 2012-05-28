using System.Collections.Generic;
using System.Web.Mvc;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class TimeZone
    {

        static IDictionary<string, string> maps = new Dictionary<string, string>();
        static TimeZone()
        {
            maps.Add("0", "TIMEZONE_ITEM_0");
            maps.Add("-12", "TIMEZONE_ITEM_1");
            maps.Add("-11", "TIMEZONE_ITEM_2");
            maps.Add("-10", "TIMEZONE_ITEM_3");
            maps.Add("-9", "TIMEZONE_ITEM_4");
            maps.Add("-8", "TIMEZONE_ITEM_5");
            maps.Add("-7", "TIMEZONE_ITEM_6");
            maps.Add("-6", "TIMEZONE_ITEM_7");
            maps.Add("-5", "TIMEZONE_ITEM_8");
            maps.Add("-4", "TIMEZONE_ITEM_9");
            maps.Add("-3.5","TIMEZONE_ITEM_10");
            maps.Add("-3", "TIMEZONE_ITEM_11");
            maps.Add("-2", "TIMEZONE_ITEM_12");
            maps.Add("-1", "TIMEZONE_ITEM_13");
            maps.Add("1", "TIMEZONE_ITEM_14");
            maps.Add("2", "TIMEZONE_ITEM_15");
            maps.Add("3", "TIMEZONE_ITEM_16");
            maps.Add("3.5", "TIMEZONE_ITEM_17");
            maps.Add("4", "TIMEZONE_ITEM_18");
            maps.Add("4.5", "TIMEZONE_ITEM_19");
            maps.Add("5", "TIMEZONE_ITEM_20");
            maps.Add("5.75", "TIMEZONE_ITEM_21");
            maps.Add("6", "TIMEZONE_ITEM_22");
            maps.Add("6.75", "TIMEZONE_ITEM_23");
            maps.Add("7", "TIMEZONE_ITEM_24");
            maps.Add("8", "TIMEZONE_ITEM_25");
            maps.Add("9", "TIMEZONE_ITEM_26");
            maps.Add("9.5", "TIMEZONE_ITEM_27");
            maps.Add("10", "TIMEZONE_ITEM_28");
            maps.Add("11", "TIMEZONE_ITEM_29");
            maps.Add("12", "TIMEZONE_ITEM_30");
        }

        public static string GetText(float key)
        {
            return LanguageUtil.getDesc(maps[key.ToString()]);
        }

        public static IList<SelectListItem> Data
        {
            get
            { 
                IList<SelectListItem> selectItems = new List<SelectListItem>();
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_0"), Value = "0" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_1"), Value = "-12" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_2"), Value = "-11" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_3"), Value = "-10" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_4"), Value = "-9" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_5"), Value = "-8" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_6"), Value = "-7" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_7"), Value = "-6" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_8"), Value = "-5" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_9"), Value = "-4" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_10"), Value = "-3.5" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_11"), Value = "-3" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_12"), Value = "-2" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_13"), Value = "-1" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_14"), Value = "1" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_15"), Value = "2" });
                //selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_31"), Value = "2" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_16"), Value = "3" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_17"), Value = "3.5" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_18"), Value = "4" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_19"), Value = "4.5" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_20"), Value = "5" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_21"), Value = "5.75" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_22"), Value = "6" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_23"), Value = "6.75" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_24"), Value = "7" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_25"), Value = "8" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_26"), Value = "9" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_27"), Value = "9.5" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_28"), Value = "10" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_29"), Value = "11" });
                selectItems.Add(new SelectListItem() { Text = LanguageUtil.getDesc("TIMEZONE_ITEM_30"), Value = "12" });
                return selectItems;
            }
        }
    }
}
