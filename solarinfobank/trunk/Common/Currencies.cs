using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class Currencies
    {
        static IList<SelectListItem> items = null;
        static Currencies()
        {
            CreateMonthList();
            CreateHourList();
            CreateMinuteList();
            items = new List<SelectListItem>();
            items.Add(new SelectListItem() { Selected = false, Text = "$:USD", Value = "$" });
            items.Add(new SelectListItem() { Selected = false, Text = "¥:CNY", Value = "¥" });
            items.Add(new SelectListItem() { Selected = false, Text = "€:EUR", Value = "€" });
            items.Add(new SelectListItem() { Selected = false, Text = "р.:RUB", Value = "р." });
            items.Add(new SelectListItem() { Selected = false, Text = "£:GBP", Value = "£" });
            items.Add(new SelectListItem() { Selected = false, Text = "₩:WON", Value = "₩" });
            items.Add(new SelectListItem() { Selected = false, Text = "￥:JPY", Value = "￥" });
        }
        /// <summary>
        /// 按照币种格式化
        /// </summary>
        /// <param name="currency"></param>
        /// <param name="revenue"></param>
        /// <returns></returns>
        public static string format(string currency, double revenue)
        {
            if (!string.IsNullOrEmpty(currency) && currency.ToLower().Equals("￥"))
            {
                string revenueString = string.Empty;
                revenueString = revenue.ToString("####-####-####-####");
                revenueString = revenueString.Replace('-', ',');
                while (true)
                {
                    if (revenueString.StartsWith(","))
                        revenueString = revenueString.Substring(1);
                    else
                        break;
                }

                return string.IsNullOrEmpty(revenueString) ? "0" : revenueString;
            }

            return revenue.ToString("N0");
        }



        public static IList<SelectListItem> CurrentList
        {
            get
            {
                return items;
            }
        }
        static IList<SelectListItem> yearItems = new List<SelectListItem>();
        ///// <summary>
        ///// 这里不能用静态方法，需要修改
        ///// </summary>
        public static IList<SelectListItem> CurrentYearList
        {
            get
            {
                if (yearItems.Count() == 0)
                    yearItems.Add(new SelectListItem() { Selected = true, Text = DateTime.Now.ToString("yyyy"), Value = DateTime.Now.ToString("yyyy") });
                return yearItems;
            }
        }

        public static IList<SelectListItem> FillYearItems(IList<int> list)
        {
            IList<SelectListItem> yearItems = new List<SelectListItem>();

            if (list.Count != 0)
            {
                for (int i = 0; i < list.Count; i++)
                {

                    yearItems.Add(new SelectListItem() { Selected = true, Text = list[i].ToString(), Value = list[i].ToString() });
                }
            }
            else
            {
                yearItems.Add(new SelectListItem() { Selected = true, Text = DateTime.Now.ToString("yyyy"), Value = DateTime.Now.ToString("yyyy") });
            }
            return yearItems;
        }

        static IList<SelectListItem> monthItems = null;
        public static IList<SelectListItem> MonthList
        {
            get
            {
                return monthItems;
            }
        }
        public static void CreateMonthList()
        {
            monthItems = new List<SelectListItem>();
            for (int i = 1; i <= 12; i++)
            {
                monthItems.Add(new SelectListItem() { Selected = (i == DateTime.Now.Month), Text = i.ToString(), Value = i.ToString("00") });
            }
        }
        static IList<SelectListItem> hourItems = null;
        public static IList<SelectListItem> hourList
        {
            get
            {
                return hourItems;
            }
        }
        public static void CreateHourList()
        {
            hourItems = new List<SelectListItem>();
            for (int i = 0; i <= 23; i++)
            {
                hourItems.Add(new SelectListItem() { Selected = (i == 4), Text = i.ToString(), Value = i.ToString("00") });
            }
        }
        static IList<SelectListItem> minuteItems = null;
        public static IList<SelectListItem> minuteList
        {
            get
            {
                return minuteItems;
            }
        }
        public static void CreateMinuteList()
        {
            minuteItems = new List<SelectListItem>();
            for (int i = 0; i <= 59; i++)
            {
                minuteItems.Add(new SelectListItem() { Selected = (i == 0), Text = i.ToString(), Value = i.ToString("00") });
            }
        }
    }
}
